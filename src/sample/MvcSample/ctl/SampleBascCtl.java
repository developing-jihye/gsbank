package sample.MvcSample.ctl;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import common.externalApi.ExChangeRate;
import common.utils.common.CmmnMap;
import common.utils.common.CmmnUtil;
import common.utils.common.PagingConfig;
import common.utils.mybatis_paginator.domain.PageList;
import common.utils.string.StringUtil;
import kcg.common.svc.CommonSvc;
import sample.MvcSample.svc.SampleBascSvc;

/**
 * 
* @packageName    : sample.MvcSample.ctl
* @fileName       : SampleBascCtl.java
* @author         : (성명)/(직위)
* @date           : 2024.07.24
* @description    :
* ===========================================================
* DATE                        AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.07.24    (성명)/(직위)       최초 생성
 */
@RequestMapping("/sample/sampleBasc")
@Controller
public class SampleBascCtl {

	//
	@Autowired
	CommonSvc commonSvc;

	@Autowired
	ExChangeRate exChangeRate;
	
	@Autowired
	SampleBascSvc sampleBascSvc;

	
	private final Logger log = LoggerFactory.getLogger(getClass());

	
	/**
	 * 
	* @methodName    : sampleBascSelect
	* @author        : (성명)/(직위)
	* @date          : 2024.07.24
	* @param model
	* @param request
	* @return
	* Description 	 :
	 */
	@RequestMapping("")
	public String sampleBascSelect(ModelMap model, HttpServletRequest request) {

		log.info("sampleBascSelect START");
		log.info("sampleBascSelect START");
		log.info("sampleBascSelect START");
        
		String contextPath = request.getContextPath();

		log.info("contextPath ==>" + contextPath);

		String rootPath = Thread.currentThread().getContextClassLoader().getResource("").getPath();

		log.info("rootPath ==>" + rootPath);
		
		
		

		sampleBascSvc.test();
		
		// 환율정보 API
		// exChangeRate.fetchExchangeRates();

		
		// @RequestMapping("") == 화면의 경로 리턴.
		return "sample/sample";
	}

	
	/**
	 * AJAX 예제
	 * @param params
	 * @param request
	 */
	@PostMapping("/ajaxSample")
	public void checkEmail(//MultipartFile multipartFile,
						   CmmnMap params,
						   HttpServletRequest request) {
		
		log.info("params >>> " + params);
		log.info("params >>> " + params.get("from")); // params에서의 특정값만 가져오기
		log.info("from>>>>" + request.getParameter("from")); //@RequestBody의 경우 HttpServletRequest request 로 값 받기
		
		
		String uploadRelativePath = StringUtil.join("/test/", CmmnUtil.getTodayString().substring(0,6), '/');
		
		log.info("uploadRelativePath>>>" + uploadRelativePath);
		
		// commonSvc.uploadFile(multipartFile, uploadRelativePath);



	}
	
	/**
	 * 조건없이 전체검색 + 페이징
	 * @param params
	 * @param pagingConfig
	 * @return
	 */
	@RequestMapping("/getAllList")
	public PageList<CmmnMap> getAllList(CmmnMap params, PagingConfig pagingConfig) {
		
		log.info("getAllList.pagingConfig >>> " + pagingConfig);
		
		PageList<CmmnMap> pageList = sampleBascSvc.getAllList(params, pagingConfig); 
		log.debug("pageList>>>>> {}",pageList);
		return pageList;
		//return custMngSvc.getList(params, pagingConfig);
	}
	
	/**
	 * 
	* @methodName    : getList
	* @author        : (성명)/(직위)
	* @date          : 2024.08.07
	* @param params
	* @param pagingConfig
	* @return
	* Description 	 :
	 */
	@RequestMapping("/getList")
	public PageList<CmmnMap> getList(CmmnMap params, PagingConfig pagingConfig) {
		PageList<CmmnMap> pageList = sampleBascSvc.getList(params, pagingConfig); 
		log.debug("{}",pageList);
		return pageList;
		//return custMngSvc.getList(params, pagingConfig);
	}
	
	// TODO 리스트
	// 단일선택 예제
	// 리스트 선택 예제
	// 파일전송 예제
	// 화면에서 컨트롤러로 받아오기
	// 컨트롤러에서 화면으로 보내기
	// AJAX로 파일보내기
	// 체크박스
	// 조건 검색
	// 동적 쿼리
	//
}
