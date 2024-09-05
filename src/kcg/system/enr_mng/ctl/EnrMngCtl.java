package kcg.system.enr_mng.ctl;

import java.util.List;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;



@RequestMapping("/enr_mng")
@Controller
public class EnrMngCtl {

	
	@RequestMapping("/list")
	public String openPageList(Model model) {
		return "kcg/system/enr_mng/EnrMngList";
	}
	
	
	
	
}
