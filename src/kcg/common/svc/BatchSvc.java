package kcg.common.svc;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import common.config.properties.SettingProperties;
import common.dao.CmmnDao;

@Service
public class BatchSvc {
	
	private final Logger log = LoggerFactory.getLogger(getClass());
	
	@Autowired
	CmmnDao cmmnDao;

	@Autowired
	SettingProperties settingProperties;
	

	

	
}
