package kcg.system.main.ctl;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import common.externalApi.HnpWeather;
import common.utils.common.CmmnMap;
import kcg.common.svc.CommonSvc;
import kcg.login.vo.UserInfoVO;
import kcg.system.main.svc.SystemMainSvc;

@RequestMapping("/system")
@Controller
public class SystemMainCtl {

	private final Logger log = LoggerFactory.getLogger(getClass());

	@Autowired
	SystemMainSvc systemMainSvc;

	@Autowired
	CommonSvc commonSvc;

	@RequestMapping("")
	public String openPage(ModelMap model, HttpServletRequest request) {

		// 세션에서 로그인한 마케터의 userId를 추출
		HttpSession session = request.getSession();
		String userId = (String) session.getAttribute("userId");
		model.addAttribute("userId", userId);
		
		// DB에서 가져온 정보를 세션에 추가로 저장
		List<CmmnMap> userInfoCmmnMaps = systemMainSvc.getUserInfoFromDB(userId);
		System.out.println("유저정보맵" + userInfoCmmnMaps);
		session.setAttribute("userName", userInfoCmmnMaps.get(0).get("name"));
		session.setAttribute("profileImage", userInfoCmmnMaps.get(0).get("profile_image"));

		// 담당 고객 나이 분포
		List<CmmnMap> ageDistr = systemMainSvc.getAgeDistr(userId);
		System.out.println("나이 분포 데이터: " + ageDistr);
		model.addAttribute("ageDistr", ageDistr);

		// 담당 고객 성별 분포
		List<CmmnMap> genderDistr = systemMainSvc.getGenderDistr(userId);
		System.out.println("성별 분포 데이터: " + genderDistr);
		model.addAttribute("genderDistr", genderDistr);
		
		// 담당 고객 직업 분포
		List<CmmnMap> jobDistr = systemMainSvc.getJobDistr(userId);
		System.out.println("직업 분포 데이터: " + jobDistr);
		model.addAttribute("jobDistr", jobDistr);

		// 나의 판매량
		List<CmmnMap> mySales = systemMainSvc.getMysales(userId);
		System.out.println("나의 판매량: " + mySales);
		model.addAttribute("mySales", mySales);

		// 종류별 인기 상품 조회
		// 적금
		List<CmmnMap> popSavings = systemMainSvc.getPopProdSavings();
		System.out.println("인기 적금 상품: " + popSavings);
		model.addAttribute("popSavings", popSavings);

		// 예금
		List<CmmnMap> popDeposit = systemMainSvc.getPopProdDeposit();
		System.out.println("인기 예금 상품: " + popDeposit);
		model.addAttribute("popDeposit", popDeposit);

		// 대출
		List<CmmnMap> popLoan = systemMainSvc.getPopProdLoan();
		System.out.println("인기 대출 상품: " + popLoan);
		model.addAttribute("popLoan", popLoan);
		
		// 베스트 마케터 조회
		List<CmmnMap> bestMarketer = systemMainSvc.getBestMarketer();
		System.out.println("이 달의 마케터: " + bestMarketer);
		model.addAttribute("bestMarketer", bestMarketer);
		
		return "kcg/system/main/SystemMain";
	}
	
	
	
//	전체 흐름:
//		클라이언트가 **"/app/hello"**로 메시지를 보냄.
//		서버는 이 메시지를 받아서 처리.
//		처리한 메시지를 **"/topic/chat"**을 구독하는 클라이언트들에게 전송.
	@MessageMapping("/hello") // 서버로 보내는 메시지 처리하는 경로 지정
	@SendTo("/topic/chatted") // 서버가 처리한 결과를 보내는 경로 지정
	public CmmnMap chat(CmmnMap map) {
		String currentTime = LocalDateTime.now().format(DateTimeFormatter.ofPattern("MM-dd HH:mm"));
		
		CmmnMap msg = new CmmnMap();
		// 메시지, 이름, 사진, 시간
		msg.put("message", map.get("message"));
		msg.put("name", map.get("name"));
		msg.put("profileImage", map.get("profileImage"));
		msg.put("time", currentTime);
		return msg;
	}

	
	
	
	
	// 기존 코드
	@RequestMapping("/getReqStat")
	public CmmnMap getReqStat(CmmnMap params) {
		return systemMainSvc.getReqStat(params);
	}

	@RequestMapping(value = "/batchResult/cntcMthd")
	public String openPopupCntcMthd(ModelMap model) {
		return "kcg/batchResult/cntcMthd";
	}

	@RequestMapping(value = "/batchResult/system")
	public String openPopupSystem(ModelMap model) {
		return "kcg/batchResult/system";
	}

	@RequestMapping(value = "/batchResult/table")
	public String openPopupTable(ModelMap model) {
		return "kcg/batchResult/table";
	}
}
