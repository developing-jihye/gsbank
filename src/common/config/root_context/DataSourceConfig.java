package common.config.root_context;

import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.aspectj.lang.annotation.Aspect;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.aop.Advisor;
import org.springframework.aop.aspectj.AspectJExpressionPointcut;
import org.springframework.aop.support.DefaultPointcutAdvisor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.core.env.Environment;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.transaction.interceptor.RollbackRuleAttribute;
import org.springframework.transaction.interceptor.RuleBasedTransactionAttribute;
import org.springframework.transaction.interceptor.TransactionInterceptor;

import net.sf.log4jdbc.Log4jdbcProxyDataSource;
import net.sf.log4jdbc.tools.Log4JdbcCustomFormatter;
import net.sf.log4jdbc.tools.LoggingType;

@Aspect
@EnableAspectJAutoProxy(proxyTargetClass = true)
@Configuration
@EnableTransactionManagement // 어노테이션기반의 트랜잭션이 가능하도록 하는 설정 <tx:annotation-driven>
public class DataSourceConfig {
	
	@Autowired
	Environment environment;
	
	@Autowired
	ApplicationContext applicationContext;
	
	private static final String AOP_POINTCUT_EXPRESSION = "execution(* *..*.*Svc.*(..))";
	
	@Bean(name = "cmmnDataSource")
	public DataSource cmmnDataSource() {
		
//		String runEnv = environment.getProperty("run.env");
//		if("prod".equals(runEnv) || "dev".equals(runEnv)) {
//			String jndiName = environment.getProperty("jndi.name");
//			JndiDataSourceLookup dataSourceLookup = new JndiDataSourceLookup();
//		    DataSource ds = dataSourceLookup.getDataSource(jndiName);
//		    
//
//	        
//			Log4jdbcProxyDataSource log4jdbcProxyDataSource = new Log4jdbcProxyDataSource(ds);
//			
//			log4jdbcProxyDataSource.setLogFormatter(
//					new Log4JdbcCustomFormatter() {{
//						setLoggingType(LoggingType.MULTI_LINE);
//						setSqlPrefix(" SQL ===> \n");
//					}});
//			
//	        return log4jdbcProxyDataSource;
//		} else {
			
			
			DriverManagerDataSource dataSource = new DriverManagerDataSource();
			dataSource.setDriverClassName(environment.getProperty("datasource.driverClassName"));
			dataSource.setUrl(environment.getProperty("datasource.url"));
			dataSource.setUsername(environment.getProperty("datasource.username"));
			dataSource.setPassword(environment.getProperty("datasource.password"));
			
			Log4jdbcProxyDataSource log4jdbcProxyDataSource = new Log4jdbcProxyDataSource(dataSource);
			
			log4jdbcProxyDataSource.setLogFormatter(
					new Log4JdbcCustomFormatter() {{
						setLoggingType(LoggingType.MULTI_LINE);
						setSqlPrefix(" SQL ===> \n");
					}});
			
	        return log4jdbcProxyDataSource;
//		}
	}
	
    @Bean(name = "cmmnSqlSession")
    public SqlSessionFactory cmmnSqlSessionFactory() throws Exception{
        SqlSessionFactoryBean sqlSessionFactoryBean = new SqlSessionFactoryBean();
        sqlSessionFactoryBean.setDataSource(cmmnDataSource());
        sqlSessionFactoryBean.setMapperLocations(applicationContext.getResources("classpath*:/**/*_SQL.xml")); // 이러식의 패턴형의 설정경우 엔진에 따라 classpath* 라고 표기하지 않으면 인식을 못한다.
        sqlSessionFactoryBean.setConfigLocation(applicationContext.getResource("classpath:/common/config/mybatis/mybatis-config.xml"));
        return sqlSessionFactoryBean.getObject();
    }
    
    @Bean
    public SqlSessionTemplate cmmnSqlSessionTemplate() throws Exception {
    	return new SqlSessionTemplate(cmmnSqlSessionFactory());
    }
    
	@Bean(name = "cmmnTx")
	public TransactionInterceptor cmmnTransactionInterceptor() {
		TransactionInterceptor transactionInterceptor = new TransactionInterceptor();
		Properties properties = new Properties();
		
		List<RollbackRuleAttribute> rollbackRules = new ArrayList<RollbackRuleAttribute>();
		rollbackRules.add(new RollbackRuleAttribute(Exception.class));
		
		RuleBasedTransactionAttribute ruleBasedTransactionAttribute = 
				new RuleBasedTransactionAttribute(TransactionDefinition.PROPAGATION_REQUIRED, rollbackRules);
		String writeTransactionAttributesDefinition = ruleBasedTransactionAttribute.toString();
		properties.setProperty("*", writeTransactionAttributesDefinition);
		
		transactionInterceptor.setTransactionAttributes(properties);
		transactionInterceptor.setTransactionManager(cmmnDataSourceTransactionManager());
		
		return transactionInterceptor;
	}

	@Bean(name = "cmmnTransactionManager")
	public DataSourceTransactionManager cmmnDataSourceTransactionManager() {
		return new DataSourceTransactionManager(cmmnDataSource());
	}
	
	@Bean(name = "cmmnAdvisor")
	public Advisor cmmnAdvisor() {
		AspectJExpressionPointcut aspectJExpressionPointcut = new AspectJExpressionPointcut();
		aspectJExpressionPointcut.setExpression(AOP_POINTCUT_EXPRESSION);
		return new DefaultPointcutAdvisor(aspectJExpressionPointcut, cmmnTransactionInterceptor());
	}


}
