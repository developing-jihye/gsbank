package kcg.system.main.ctl;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
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

	@Autowired
	HnpWeather hnpWeather;

	@RequestMapping("")
	public String openPage(ModelMap model, HttpServletRequest request) {

		// 세션에서 로그인한 마케터의 정보를 가져와야 함
		HttpSession session = request.getSession();
		String userId = (String) session.getAttribute("userId");
		System.out.println("아이디: " + userId);
		model.addAttribute("userId", userId);

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
		List<CmmnMap> popSavings = systemMainSvc.getPopProd1();
		System.out.println("인기 적금 상품: " + popSavings);
		model.addAttribute("popSavings", popSavings);

		// 예금
		List<CmmnMap> popDeposit = systemMainSvc.getPopProd2();
		System.out.println("인기 예금 상품: " + popDeposit);
		model.addAttribute("popDeposit", popDeposit);

		// 대출
		List<CmmnMap> popLoan = systemMainSvc.getPopProd3();
		System.out.println("인기 대출 상품: " + popLoan);
		model.addAttribute("popLoan", popLoan);
		
		// 베스트 마케터 조회
		List<CmmnMap> bestMarketer = systemMainSvc.getBestMarketer();
		System.out.println("이 달의 마케터: " + bestMarketer);
		model.addAttribute("bestMarketer", bestMarketer);
		
		
		

		// 기존 코드
		CmmnMap statData = systemMainSvc.getStatData();
		model.addAttribute("statData", statData);

		/*
		 * 페이지 온로드시 ajax로 호출할 예정 int x = latitude; int y = longitude;
		 * 
		 * 
		 * log.info("현재 위도는 : " + x); log.info("현재 경도는 : " + y);
		 * 
		 * 
		 * String[] v = new String[5]; v = hnpWeather.get(x, y, v); // TODO 현재 위치를 받아와야함
		 * model.addAttribute("date", v[0]); model.addAttribute("time", v[1]);
		 * model.addAttribute("weather", v[2]); model.addAttribute("Temperatures",
		 * v[3]); model.addAttribute("humidity", v[4]);
		 */

		return "kcg/system/main/SystemMain";
	}

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
