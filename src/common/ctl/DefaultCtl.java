package common.ctl;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 
* @packageName    : common.ctl
* @fileName       : DefaultCtl.java
* @author         : 이의찬/매니저
* @date           : 2024.07.22
* @description    : 서버(톰캣) 실행시 /로 진입시 login 화면으로 잡아주는 기본 컨트롤러
* ===========================================================
* DATE                        AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.07.22    			이의찬/매니저       	기능 분석
 */
@Controller
public class DefaultCtl {

	@RequestMapping("/")
	public String home() {
		return "kcg/login/login";
	}
	
}
