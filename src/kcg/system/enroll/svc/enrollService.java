package kcg.system.enroll.svc;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import common.dao.CmmnDao;
import common.utils.common.CmmnMap;
import kcg.common.svc.CommonSvc;
import kcg.login.vo.UserInfoVO;


@Service
public class enrollService {
	
	@SuppressWarnings("unused")
	private final Logger log = LoggerFactory.getLogger(getClass());

	@Autowired
	HttpServletRequest request;
	
	@Autowired
	CommonSvc commonSvc;
	
	@Autowired	
	CmmnDao cmmnDao;
	
	
	
	public List<CmmnMap> getList(CmmnMap params) {
		log.info("일하는중입니다!!");
		List<CmmnMap> rslt = cmmnDao.selectList("system.enroll.getList", params);
		return rslt;
	}
	
	
	public void save(CmmnMap params) {
		
				
	    cmmnDao.insert("system.enroll.insertInfo", params);
	
			
	}
	
}
