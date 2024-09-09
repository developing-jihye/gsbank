package kcg.system.enr_mng.ctl;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

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
	
}
