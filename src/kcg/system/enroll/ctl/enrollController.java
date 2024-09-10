package kcg.system.enroll.ctl;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import common.utils.common.CmmnMap;
import kcg.common.svc.CommonSvc;
import kcg.system.enroll.svc.enrollService;





@RequestMapping("/enr_mng")
@Controller
public class enrollController {
	
	@SuppressWarnings("unused")
	private final Logger log = LoggerFactory.getLogger(getClass());

	@Autowired
	enrollService es;
	
	@Autowired
	CommonSvc commonSvc;
	
		
	@RequestMapping("/list")
	public String openPageList(Model model) {
		return "kcg/system/enr_mng/EnrMngList";
	}
	
	
	@RequestMapping("/getlist")
	public List<CmmnMap> getList(CmmnMap params) {
		
		log.info("ProdMngCtl.getList >>>>>>>>>>");
		
		log.info("ProdMngCtl.getList >>>>> " + params.getString("params"));
		
		return es.getList(params);
	}
	
	
	
	@RequestMapping("/getTelephone")
	public List<CmmnMap> getListTelephone(CmmnMap payload1) {
		

		
		log.info("Telephone:" + payload1);
		
		  List<CmmnMap> result = (List<CmmnMap>) es.getListTelephone(payload1);
	        log.info("Result from es.getListTelephone111: {}", result);

	        // Return the result
	        return result;
	}
	

	@RequestMapping("/getProductId")
	public List<CmmnMap> getProductId(CmmnMap payload2) {
		

		
		log.info("ProductId:" + payload2);
		
		  List<CmmnMap> result1 = (List<CmmnMap>) es.getProductId(payload2);
	        log.info("Result from es.getProductId: {}", result1);

	        // Return the result
	        return result1;
	}
	
	
	
	
	
	@PostMapping("/save")
	public void save(CmmnMap payload) {
		log.info("Saved");
		log.info("Saving parameters111:" + payload);
		es.save(payload);
	}
	

	@PostMapping("/save1")
	public void save1(CmmnMap payload) {
		log.info("Saved");
		log.info("Saving parameters222:" + payload);
		es.save(payload);
	}
	
	
	
		
	
	
	
	
}
