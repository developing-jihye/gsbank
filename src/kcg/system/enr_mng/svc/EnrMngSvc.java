package kcg.system.enr_mng.svc;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import common.dao.CmmnDao;
import common.utils.common.CmmnMap;
import kcg.common.svc.CommonSvc;

@Service
public class EnrMngSvc {

	@SuppressWarnings("unused")
	private final Logger log = LoggerFactory.getLogger(getClass());

	@Autowired
	HttpServletRequest request;

	@Autowired
	CommonSvc commonSvc;

	@Autowired
	CmmnDao cmmnDao;

	/*
	 * public List<CmmnMap> getList(CmmnMap params) {
	 * log.info("Fetching list with params: {}", params); log.info("집가고싶다"); return
	 * cmmnDao.selectList("system.enrmng.getList", params); }
	 */
	
	   public List<CmmnMap> getList(CmmnMap params) {
	        log.info("Fetching list with params: {}", params);
	        try {
	            // 로그 추가: 파라미터와 매퍼 ID
	            log.info("Calling cmmnDao.selectList with mapper ID: system.enrmng.getList");
	            List<CmmnMap> result = cmmnDao.selectList("system.enroll.getList2", params);
	            log.info("Result from selectList: {}", result);
	            return result;
	        } catch (Exception e) {
	            log.error("Error during selectList call", e);
	            throw e;  // 예외를 다시 던져서 호출자에게 알림
	        }
	    }
	   
	   public List<CmmnMap> getCust(CmmnMap params) {
	        log.info("Fetching list with params cust: {}", params);
	        try {
	            // 로그 추가: 파라미터와 매퍼 ID
	            log.info("Calling cmmnDao.selectList with mapper ID: system.enrmng.getCust");
	            List<CmmnMap> result = cmmnDao.selectList("system.enroll.custList", params);
	            log.info("Result from selectList: {}", result);
	            return result;
	        } catch (Exception e) {
	            log.error("Error during selectList call", e);
	            throw e;  // 예외를 다시 던져서 호출자에게 알림
	        }
	    }
	   
	   public int deleteEvents(CmmnMap params) {
		    // 실제 삭제 로직 (예: 삭제된 행 수 반환)
		    return cmmnDao.delete("system.enroll.delproBatch", params);
		}
		    
		    // 삭제된 결과를 CmmnMap으로 감싸고 List로 반환
		    //CmmnMap resultMap = new CmmnMap();
		    //resultMap.put("deletedCount", deletedCount);

		   // List<CmmnMap> result = new ArrayList<>();
		    //result.add(resultMap);

		    //return deletedCount;
		}
		    //cmmnDao.delete("system.enroll.delproBatch", Collections.singletonMap("list", enrlIds));
		//}
	  

