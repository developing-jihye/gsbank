package kcg.login.ctl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.FlashMap;

import common.config.properties.SettingProperties;
import common.exception.NeedAuthrizationException;
import common.utils.common.CmmnMap;
import common.utils.crypt.CryptUtil;
import common.utils.kdtfilemng.KdtFileMng;
import common.utils.string.StringUtil;
import kcg.common.svc.CommonCacheSvc;
import kcg.common.svc.CommonSvc;
import kcg.common.util.KcgConstants;
import kcg.login.svc.LoginSvc;
import kcg.login.vo.MenuVO;
import kcg.login.vo.UserInfoVO;

@RequestMapping("/login")
@Controller
public class LoginCtl {

	private final Logger log = LoggerFactory.getLogger(getClass());

	@Autowired
	SettingProperties settingProperties;

	@Autowired
	CommonSvc commonSvc;

	@Autowired
	LoginSvc loginSvc;

	@Autowired
	CommonCacheSvc commonCacheSvc;
	
	@Autowired
	KdtFileMng kdtFileMng;

	@RequestMapping("")
	public String openPage(ModelMap model, HttpServletRequest request) {

		// 로그인페이지 접근시 로그인 무효처리
		request.getSession().removeAttribute("userInfoVO");

		log.debug(">>> LoginCtl openPage session id : " + request.getSession().getId());

		return "kcg/login/login";
	}

	@RequestMapping("/loginByIam")
	public String openPageLoginByIam(ModelMap model, HttpServletRequest request) {

		String ubi_ori = StringUtil.defaultString(request.getParameter("ubi"));
		model.addAttribute("ubi_ori", ubi_ori);

		return "kcg/login/loginByIam";
	}

	@RequestMapping("/retryLogin")
	public String retryLogin(ModelMap model) {

		return "kcg/login/retryLogin";
	}

	@RequestMapping("/proc")
	public CmmnMap proc(CmmnMap params, HttpServletRequest request, HttpSession session, ModelMap model)
			throws Exception {

		String rslt = loginSvc.proc(request, params);

		List<MenuVO> auth_menulist;
		UserInfoVO userInfoVO = (UserInfoVO) request.getSession().getAttribute("userInfoVO");

		if (userInfoVO != null) {
			auth_menulist = userInfoVO.getMenuList();
			// log.debug("getName = " + userInfoVO.getName());
			session.setAttribute("userName", userInfoVO.getName());
			session.setAttribute("userId", userInfoVO.getUserId());
			session.setAttribute("jikgubCd", userInfoVO.getJikgubCd());
			log.info("아이디 =====>" + userInfoVO.getUserId());
			log.info("직업 =====>" + userInfoVO.getJikgubCd());
		} else {
			auth_menulist = new ArrayList<MenuVO>();
		}

		return new CmmnMap().put("rslt", rslt).put("auth_menulist", auth_menulist);
	}

	@RequestMapping("/afterProc")
	public String afterProc(HttpSession session, HttpServletRequest request, FlashMap flashMap) {

System.out.println("====================================================>>> line 104");		
		commonCacheSvc.clearAllCmmnCdCach();

		log.debug(">>> LoginCtl afterProc session id : " + request.getSession().getId());

//		UserInfoVO userInfoVO = (UserInfoVO) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserInfoVO userInfoVO = (UserInfoVO) session.getAttribute("userInfoVO");
		if (userInfoVO == null) {
			return "redirect:/login/retryLogin";
		}

		log.debug(">>> Enter to '/login/afterProc");
		String auth = userInfoVO.getAuth();
		if ("iamLoginFail".equals(auth)) {
			throw new NeedAuthrizationException();
		}

		// 현재 DB에 등록된 비밀번호
		String usr_pw = userInfoVO.getUserPw();
		// 로그인시도시 입력한 비밀번호
		String usr_pw_input = userInfoVO.getUserPwInput();

		// 비밀번호가 일치하지 않을경우
		log.debug(">>> Check user password.");
		if (!StringUtil.equals(usr_pw, usr_pw_input)) {
			flashMap.put("errMsg", "FAIL_PW_ERR");
			return "redirect:/login";
		}

		// 사용자권한별 메뉴정보 셋팅
		log.debug(">>> Set user auth menu.");
		userInfoVO.setMenuList(loginSvc.getAuthMenuList(userInfoVO.getAuth(), userInfoVO.getAdminYn())); 

		// 세션에 로그인정보 셋팅
		log.debug(">>> Set user login Info to Session.");
		session.setAttribute("userInfoVO", userInfoVO);

		if ("Y".equals(userInfoVO.getFirstYn())) {
			// 등록횟수 카운트업
			log.debug(">>> Count up Register Count.");
			commonSvc.addStatisticCnt(KcgConstants.STATISTIC_REG_CNT);
		}

		// 접속횟수 카운트업
		log.debug(">>> Count up Access Count.");
		commonSvc.addStatisticCnt(KcgConstants.STATISTIC_VISIT_CNT);

//		// 중복로그인 방지를 위해
//		commonSvc.setLoginSessionId(userInfoVO.getUserid(), session.getId());

		String runEnv = settingProperties.getRunEnv();

		log.debug(">>> Go to login Success Page. runEnv==================================>>>["+runEnv+"]");
		if ("Y".equals(userInfoVO.getAdminYn())) {
			return "redirect:/system";
		} else {
			if ("temp_dev".equals(runEnv)) {
				return "redirect:/portal";
			} else {
				return "redirect:/";
			}
		}

	}

	@RequestMapping(value = "/fail")
	public String loginFail(FlashMap flashMap, HttpServletRequest request, HttpSession session) {

		session.removeAttribute("userInfoVO");
		SecurityContextHolder.clearContext();

		flashMap.put("errMsg", "FAIL_ID_ERR");
		return "redirect:/login";
	}

	@RequestMapping(value = "/logout")
	public String logout(HttpSession session) {

		session.removeAttribute("userInfoVO");
		SecurityContextHolder.clearContext();

		return "redirect:/login";
	}

	@GetMapping(value = "/ajaxFindUserIdProc")
	@ResponseBody // @RestController --> 사용하면 @ResponseBody가 자동으로 붙는것과 같은 효과를 가집니다.
	public String ajaxFindUserIdProc(HttpServletRequest request) {
		// 클라이언트로 응답할 데이터를 생성 또는 가공
		log.info("::: ajaxFindUserIdProc called :::");

		CmmnMap params = new CmmnMap();
		// TODO 파라미터와 일치하는 이메일 주소를 반환
		// 파라미터 사용자명, 연락처, 입사일자

		log.info("userNm :::::: " + request.getParameter("userNm"));
		log.info("mblTelno :::::: " + request.getParameter("mblTelno"));
		log.info("jncmpYmd :::::: " + request.getParameter("jncmpYmd"));

		String responseData;

		params.put("userNm", request.getParameter("userNm"));
		params.put("mblTelno", request.getParameter("mblTelno"));
		params.put("jncmpYmd", request.getParameter("jncmpYmd"));

		responseData = loginSvc.ajaxFindUserIdProc(params);

		if (responseData == null) {
			responseData = "해당사용자 없음";
		}

		return "{\"message\": \"" + responseData + "\"}";
	}

	/**
	 * 비밀번호 찾기 AJAX
	 */
	@GetMapping(value = "/ajaxFindUserPwProc")
	@ResponseBody
	public String ajaxFindUserPwProc(HttpServletRequest request) {
		// 클라이언트로 응답할 데이터를 생성 또는 가공
		log.info("::: ajaxFindUserPwProc called :::");

		CmmnMap params = new CmmnMap();
		// TODO 파라미터와 일치하는 이메일 주소를 반환
		// 파라미터 사용자명, 연락처, 입사일자

		log.info("userNm :::::: " + request.getParameter("userNm"));
		log.info("mblTelno :::::: " + request.getParameter("mblTelno"));
		log.info("jncmpYmd :::::: " + request.getParameter("jncmpYmd"));

		String responseData;

		params.put("userNm", request.getParameter("userNm"));
		params.put("mblTelno", request.getParameter("mblTelno"));
		params.put("jncmpYmd", request.getParameter("jncmpYmd"));

		responseData = loginSvc.ajaxFindUserPwProc(params);

		if (responseData == null) {
			responseData = "해당사용자 없음";
		}

		return "{\"message\": \"" + responseData + "\"}";
	}

    @GetMapping(value = "/ajaxGetCodeJbpsTyCdList")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> ajaxGetCodeJbpsTyCdList() {
        // 클라이언트로 응답할 데이터를 생성 또는 가공
        log.info("::: ajaxGetCodeJbpsTyCdList called :::");

        List<?> list = loginSvc.selectCodeJbpsTyCdList();
        
		/* List<?> list3 = loginSvc.selectCodeJbpsTyCdList2(); */
        

        for (Object data : list) {
            System.out.println(data); // 콘솔 출력
        }

        // 데이터를 맵에 담아서 반환
        Map<String, Object> response = new HashMap<>();
        
        response.put("list", list);   
		/* response.put("list3", list3); */

        return ResponseEntity.ok(response); // ResponseEntity를 사용하여 JSON 응답 반환
    }

	/**
	 * 사용자 등록
	 * 
	 * @return
	 */
	@RequestMapping(value = "/getRegistUserForm")
	public String getRegistUserForm(Model model) {
		log.info(">>>LoginCtl.getRegistUserForm called :::");

		// TODO 부서명 코드 조회
		// List<?>
		/* List<?> list = loginSvc.selectCodeJbpsTyCdList(); */

		// TODO 직위 코드 조회
		List<?> list = loginSvc.selectCodeJbpsTyCdList();
		List<?> list2 = loginSvc.selectCodeJbpsTyCdList2();

        //콘솔	진행 하기위해서 for문이용함	
		for (Object data : list) {
			System.out.println(data); // 콘솔 출력
		}

		// view로 넘주기 위헤 model에 담기
		model.addAttribute("list", list);
		model.addAttribute("list2", list2);
		
		return "kcg/login/userRegistForm";
	}

	/**
	 * Description :: 회원정보 등록
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/userRegistProc", method = RequestMethod.POST)
	public String userRegistProc(
	        CmmnMap params,
	        HttpServletRequest request,
	        HttpSession session,
	        ModelMap model,
	        MultipartHttpServletRequest fileRequest)
	        throws Exception {

	    log.info(">>>LoginCtl.userRegistProc START ::::");

	    // 파일 업로드 정보 로깅
	    log.info("파일전송 경로  = " + kdtFileMng.singFileMng(fileRequest));

	    // 폼 파라미터를 가져와서 로깅
	    
	    String userId = request.getParameter("userId");
	    String userPswd = request.getParameter("userPswd");
	    String userNm = request.getParameter("userNm");
	    String picMblTelno = request.getParameter("picMblTelno");
	    String jncmpYmd = request.getParameter("jncmpYmd");
	    String jbpsNm = request.getParameter("jbpsNm");
	    String tdeptNm = request.getParameter("tdeptNm");
	    String picEmlAddr = request.getParameter("picEmlAddr");
	    String etcTskCn = request.getParameter("etcTskCn");

	    log.info("photoNm = " + request.getParameter("photoNm"));
	    log.info("userId = " + userId);
	    log.info("userNm = " + userNm);
	    log.info("tdeptNm = " + tdeptNm);
	    log.info("jbpsNm = " + jbpsNm);
	    log.info("picMblTelno = " + picMblTelno);
	    log.info("picEmlAddr = " + picEmlAddr);
	    log.info("jncmpYmd = " + jncmpYmd);
	    log.info("etcTskCn = " + etcTskCn);
	    log.info("userPswd = " + userPswd);
	    // 패스워드 해싱
	    String hashedUserPswd = CryptUtil.hashSHA512HexString(userPswd);
	    log.info(">>>userPswd = " + hashedUserPswd);

	    // 파라미터를 설정
	    params.put("userId", userId); // ID
	    params.put("userNm", userNm); // 이름   
	    params.put("tdeptNm", tdeptNm); // 부서
	    params.put("jbpsNm", jbpsNm); // 직위
	    params.put("picMblTelno", picMblTelno); // 연락처
	    params.put("picEmlAddr", picEmlAddr); // 이메일id
	    params.put("jncmpYmd", jncmpYmd); // 입사년도
	    params.put("etcTskCn", etcTskCn); // 기타
	    params.put("userPswd", hashedUserPswd); // PW 암호화
	   

	    // 등록 서비스 호출
	    int rslt = loginSvc.registUserInfo(params);
	    log.info(">>> rslt = " + rslt);

	    // 등록 성공 또는 실패 확인
	    if (rslt > 0) {
	        log.info("회원 등록 성공");
	    } else {
	        log.error("회원 등록 실패");
	    }

	    // 로그인 페이지로 리다이렉트
	    return "redirect:/login";
	}

}
