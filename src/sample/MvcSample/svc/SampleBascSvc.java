package sample.MvcSample.svc;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import common.dao.CmmnDao;
import common.utils.common.CmmnMap;
import common.utils.common.CmmnUtil;
import common.utils.common.PagingConfig;
import common.utils.mybatis_paginator.domain.PageList;

@Service
public class SampleBascSvc {

	
private final Logger log = LoggerFactory.getLogger(getClass());
	
	@Autowired
	CmmnDao cmmnDao;

	
	public void test() {
		log.info("SampleBascSvc.test() >>>>>>");
	}
	
	public PageList<CmmnMap> getAllList(CmmnMap params, PagingConfig pagingConfig) {
		return cmmnDao.selectListPage("sample.MvcSample.getAllList", params, pagingConfig);
	}
	
	public PageList<CmmnMap> getList(CmmnMap params, PagingConfig pagingConfig) {
		return cmmnDao.selectListPage("sample.MvcSample.getList", params, pagingConfig);
	}
	
}
