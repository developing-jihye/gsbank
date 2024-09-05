package kcg.system.enroll.ctl;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import common.utils.common.CmmnMap;
import kcg.common.svc.CommonSvc;
import kcg.system.enroll.svc.enrollService;
import kcg.system.prod_mng.svc.ProdMngSvc;





@RequestMapping("/enroll")
@Controller
public class enrollController {
	
	@SuppressWarnings("unused")
	private final Logger log = LoggerFactory.getLogger(getClass());

	@Autowired
	enrollService es;
	
	@Autowired
	CommonSvc commonSvc;
	
	
	@RequestMapping("/getList")
	public List<CmmnMap> getList(CmmnMap params) {
		
		log.info("ProdMngCtl.getList >>>>>>>>>>");
		
		log.info("ProdMngCtl.getList >>>>> " + params.getString("params"));
		
		return es.getList(params);
	}
	
	
	
	

}
