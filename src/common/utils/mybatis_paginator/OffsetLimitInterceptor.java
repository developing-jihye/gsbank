package common.utils.mybatis_paginator;


import java.io.IOException;
import java.lang.reflect.Constructor;
import java.util.List;
import java.util.Properties;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;
import java.util.concurrent.FutureTask;

import org.apache.ibatis.cache.Cache;
import org.apache.ibatis.cache.CacheKey;
import org.apache.ibatis.executor.Executor;
import org.apache.ibatis.mapping.BoundSql;
import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.mapping.MappedStatement.Builder;
import org.apache.ibatis.mapping.ParameterMapping;
import org.apache.ibatis.mapping.SqlSource;
import org.apache.ibatis.plugin.Interceptor;
import org.apache.ibatis.plugin.Intercepts;
import org.apache.ibatis.plugin.Invocation;
import org.apache.ibatis.plugin.Plugin;
import org.apache.ibatis.plugin.Signature;
import org.apache.ibatis.session.ResultHandler;
import org.apache.ibatis.session.RowBounds;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import common.utils.mybatis_paginator.dialect.Dialect;
import common.utils.mybatis_paginator.domain.PageBounds;
import common.utils.mybatis_paginator.domain.PageList;
import common.utils.mybatis_paginator.domain.Paginator;
import common.utils.mybatis_paginator.support.PropertiesHelper;
import common.utils.mybatis_paginator.support.SQLHelp;


/**
 * MyBatis 용 Dialect 기반 Dialect 쿼리 용 플러그인
 * 
 * Executor.query () 메소드는 페이징 Dialect의 삽입을 구현하기 위해 인터셉트 될 것이다. *
 */
@Intercepts({@Signature(
		type= Executor.class,
		method = "query",
		args = {MappedStatement.class, Object.class, RowBounds.class, ResultHandler.class})})
public class OffsetLimitInterceptor implements Interceptor{
	
	private final Logger log = LoggerFactory.getLogger(getClass());
	
	static int MAPPED_STATEMENT_INDEX = 0;
	static int PARAMETER_INDEX = 1;
	static int ROWBOUNDS_INDEX = 2;
	static int RESULT_HANDLER_INDEX = 3;

    static ExecutorService Pool;
    String dialectClass;
    boolean asyncTotalCount = false;
	
	@SuppressWarnings("unchecked")
	public Object intercept(final Invocation invocation) throws Throwable {
        final Executor executor = (Executor) invocation.getTarget();
        final Object[] queryArgs = invocation.getArgs();
        final MappedStatement ms = (MappedStatement)queryArgs[MAPPED_STATEMENT_INDEX];
        final Object parameter = queryArgs[PARAMETER_INDEX];
        final RowBounds rowBounds = (RowBounds)queryArgs[ROWBOUNDS_INDEX];
        final PageBounds pageBounds = new PageBounds(rowBounds);

        if(pageBounds.getOffset() == RowBounds.NO_ROW_OFFSET
                && pageBounds.getLimit() == RowBounds.NO_ROW_LIMIT
                && pageBounds.getOrders().isEmpty()){
            return invocation.proceed();
        }

        final Dialect dialect;
        Class<?> clazz = Class.forName(dialectClass);
        Constructor<?> constructor = clazz.getConstructor(MappedStatement.class, Object.class, PageBounds.class);
        dialect = (Dialect)constructor.newInstance(new Object[]{ms, parameter, pageBounds});

        final BoundSql boundSql = ms.getBoundSql(parameter);

        queryArgs[MAPPED_STATEMENT_INDEX] = copyFromNewSql(ms,boundSql,dialect.getPageSQL(), dialect.getParameterMappings(), dialect.getParameterObject());
        queryArgs[PARAMETER_INDEX] = dialect.getParameterObject();
        queryArgs[ROWBOUNDS_INDEX] = new RowBounds(RowBounds.NO_ROW_OFFSET,RowBounds.NO_ROW_LIMIT);

        Boolean async = pageBounds.getAsyncTotalCount() == null ? asyncTotalCount : pageBounds.getAsyncTotalCount();
        @SuppressWarnings("rawtypes")
		Future<List> listFuture = call(new Callable<List>() {
            public List call() throws Exception {
                return (List)invocation.proceed();
            }
        }, async);


        if(pageBounds.isContainsTotalCount()){
            @SuppressWarnings({ "rawtypes" })
			Callable<Paginator> countTask = new Callable() {
                public Object call() throws Exception {
                    Integer count;
                    Cache cache = ms.getCache();
                    if(cache != null && ms.isUseCache() && ms.getConfiguration().isCacheEnabled()){
                        CacheKey cacheKey = executor.createCacheKey(ms,parameter,new PageBounds(),copyFromBoundSql(ms,boundSql,dialect.getCountSQL(), boundSql.getParameterMappings(), boundSql.getParameterObject()));
                        count = (Integer)cache.getObject(cacheKey);
                        if(count == null){
                            count = SQLHelp.getCount(ms,executor.getTransaction(),parameter,boundSql,dialect);
                            cache.putObject(cacheKey, count);
                        }
                    }else{
                        count = SQLHelp.getCount(ms,executor.getTransaction(),parameter,boundSql,dialect);
                    }
                    return new Paginator(pageBounds.getPage(), pageBounds.getLimit(), count, pageBounds.getSliderCount());
                }
            };
            Future<Paginator> countFutrue = call(countTask, async);
            return new PageList<Object>(listFuture.get(),countFutrue.get());
        }

        return listFuture.get();
	}

    private <T> Future<T> call(Callable<T> callable, boolean async){
        if(async){
             return Pool.submit(callable);
        }else{
            FutureTask<T> future = new FutureTask<T>(callable);
            future.run();
            return future;
        }
    }

    private MappedStatement copyFromNewSql(MappedStatement ms, BoundSql boundSql,
                                           String sql, List<ParameterMapping> parameterMappings, Object parameter){
        BoundSql newBoundSql = copyFromBoundSql(ms, boundSql, sql, parameterMappings, parameter);
        return copyFromMappedStatement(ms, new BoundSqlSqlSource(newBoundSql));
    }

	private BoundSql copyFromBoundSql(MappedStatement ms, BoundSql boundSql,
			String sql, List<ParameterMapping> parameterMappings,Object parameter) {
		BoundSql newBoundSql = new BoundSql(ms.getConfiguration(),sql, parameterMappings, parameter);
		for (ParameterMapping mapping : boundSql.getParameterMappings()) {
		    String prop = mapping.getProperty();
		    if (boundSql.hasAdditionalParameter(prop)) {
		        newBoundSql.setAdditionalParameter(prop, boundSql.getAdditionalParameter(prop));
		    }
		}
		return newBoundSql;
	}
	
	//see: MapperBuilderAssistant
	private MappedStatement copyFromMappedStatement(MappedStatement ms,SqlSource newSqlSource) {
		Builder builder = new Builder(ms.getConfiguration(),ms.getId(),newSqlSource,ms.getSqlCommandType());
		
		builder.resource(ms.getResource());
		builder.fetchSize(ms.getFetchSize());
		builder.statementType(ms.getStatementType());
		builder.keyGenerator(ms.getKeyGenerator());
		if(ms.getKeyProperties() != null && ms.getKeyProperties().length !=0){
            StringBuffer keyProperties = new StringBuffer();
            for(String keyProperty : ms.getKeyProperties()){
                keyProperties.append(keyProperty);
                keyProperties.append(',');
            }
            keyProperties.delete(keyProperties.length()-1, keyProperties.length());
			builder.keyProperty(keyProperties.toString());
		}
		
		//setStatementTimeout()
		builder.timeout(ms.getTimeout());
		
		//setStatementResultMap()
		builder.parameterMap(ms.getParameterMap());
		
		//setStatementResultMap()
        builder.resultMaps(ms.getResultMaps());
		builder.resultSetType(ms.getResultSetType());
	    
		//setStatementCache()
		builder.cache(ms.getCache());
		builder.flushCacheRequired(ms.isFlushCacheRequired());
		builder.useCache(ms.isUseCache());
		
		return builder.build();
	}

	public Object plugin(Object target) {
		return Plugin.wrap(target, this);
	}

	public void setProperties(Properties properties) {
        PropertiesHelper propertiesHelper = new PropertiesHelper(properties);
		String dialectClass = propertiesHelper.getRequiredString("dialectClass");
		setDialectClass(dialectClass);

        setAsyncTotalCount(propertiesHelper.getBoolean("asyncTotalCount",false));

        setPoolMaxSize(propertiesHelper.getInt("poolMaxSize",0));

	}
	
	public static class BoundSqlSqlSource implements SqlSource {
		BoundSql boundSql;
		public BoundSqlSqlSource(BoundSql boundSql) {
			this.boundSql = boundSql;
		}
		public BoundSql getBoundSql(Object parameterObject) {
			return boundSql;
		}
	}

    public void setDialectClass(String dialectClass) {
        log.debug("dialectClass: {} ", dialectClass);
        this.dialectClass = dialectClass;
    }

    public void setAsyncTotalCount(boolean asyncTotalCount) {
        log.debug("asyncTotalCount: {} ", asyncTotalCount);
        this.asyncTotalCount = asyncTotalCount;
    }

    public void setPoolMaxSize(int poolMaxSize) {

        if(poolMaxSize > 0){
            log.debug("poolMaxSize: {} ", poolMaxSize);
            Pool = Executors.newFixedThreadPool(poolMaxSize);
        }else{
            Pool = Executors.newCachedThreadPool();
        }


    }
}
