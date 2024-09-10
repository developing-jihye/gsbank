package kcg.system.enr_mng.ctl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import common.dao.CmmnDao;
import common.utils.common.CmmnMap;
import kcg.common.svc.CommonSvc;
import kcg.system.enr_mng.svc.EnrMngSvc;
import kcg.system.enroll.svc.enrollService;



@RequestMapping("/enr_mngg")
@Controller
public class EnrMngCtl {
	
	@SuppressWarnings("unused")
	private final Logger log = LoggerFactory.getLogger(getClass());

	@Autowired
	EnrMngSvc es;
	
	@Autowired
	CommonSvc commonSvc;
	
	 @Autowired
	 CmmnDao cmmnDao;
	
	@RequestMapping("/list")
	public String openPageList(Model model) {
		return "kcg/system/enr_mng/EnrMnngList2";
	}
	
	
	@RequestMapping("/getlist")
	public List<CmmnMap> getList(CmmnMap params) {
		
		log.info("ProdMngCtl.getList >>>>>>>>>>");
		
		log.info("ProdMngCtl.getList >>>>> " + params.getString("params"));
		
		return es.getList(params);
	}
	
	@RequestMapping("/custlist")
	public List<CmmnMap> custList(CmmnMap params) {
		
		log.info("ProdMngCtl.getList >>>>>>>>>>");
		
		log.info("ProdMngCtl.getList >>>>> " + params.getString("params"));
		
		return es.getCust(params);
	}
	
	  @PostMapping("/delete")
	    @ResponseBody
	    public CmmnMap deleteEvent(@RequestBody CmmnMap params) {
	        System.out.println("Deleting events with params: " + params);

	        // 데이터를 리스트로 추출
	        List<Long> enrlIds = new ArrayList<>();
	        Object ids = params.get("enrl_ids");

	        if (ids instanceof List<?>) {
	            for (Object id : (List<?>) ids) {
	                if (id instanceof Number) {
	                    enrlIds.add(((Number) id).longValue());
	                } else {
	                    System.out.println("Unexpected type in enrl_ids: " + id.getClass());
	                }
	            }
	        } else {
	            System.out.println("enrl_ids is not a List");
	        }

	        System.out.println("Extracted enrl_ids: " + enrlIds);

	        if (!enrlIds.isEmpty()) {
	            es.deleteEvents(enrlIds);
	        }

	        return new CmmnMap().put("status", "OK");
	    }
}
