package kcg.login.svc;

import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import common.dao.CmmnDao;
import common.utils.common.CmmnMap;
import common.utils.crypt.CryptUtil;
import common.utils.string.StringUtil;
import kcg.common.svc.CommonSvc;
import kcg.common.util.KcgConstants;
import kcg.common.util.KcgCryptUtil;
import kcg.login.vo.MenuVO;
import kcg.login.vo.UserInfoVO;

@Service
public class LoginSvc  {

	private final Logger log = LoggerFactory.getLogger(getClass());

	@Autowired
	CmmnDao cmmnDao;

	@Autowired
	CommonSvc commonSvc;

	@Autowired(required = false)
	HttpServletRequest request;


	public List<MenuVO> getAuthMenuList(String auth_cd, String admin_yn){

		if("admin".equals(auth_cd)) {
			List<MenuVO> rslt = cmmnDao.selectList("login.getAuthMenuList_superadmin");
			// 관리자는 마이페이지 삭제
			for(MenuVO vo : rslt) {
				if(vo.getMenuUrl().startsWith("/mypage")) {
					vo.setUseYn("N");
				}
			}

			return rslt;
		}

		if("Y".equals(admin_yn)) {

			List<MenuVO> allPortalMenuList = cmmnDao.selectList("login.getAuthMenuList_allportal");
			List<MenuVO> adminAuthMenuList = cmmnDao.selectList("login.getAuthMenuList", auth_cd);

			List<MenuVO> rslt = new ArrayList<MenuVO>();
			rslt.addAll(allPortalMenuList);
			rslt.addAll(adminAuthMenuList);

			// 관리자는 마이페이지 삭제
			for(MenuVO vo : rslt) {
				if(vo.getMenuUrl().startsWith("/mypage")) {
					vo.setUseYn("N");
				}
			}

			return rslt;
		}


		return cmmnDao.selectList("login.getAuthMenuList", auth_cd);
	}

	/**
	 * 로그인 처리 서비스
	 * @param request2
	 * @param params
	 * @return login.jsp 에서 받아옴
	 * @throws Exception
	 */
	public String proc(HttpServletRequest request2, CmmnMap params) throws Exception {
		
		log.debug(">>> LoginSvc.proc START");
		
		String user_id = params.getString("usr_id","");
		String userPw;
		String ubi_ori = params.getString("ubi_ori","");

		ubi_ori = URLDecoder.decode(ubi_ori, "UTF-8");
		
		log.debug(">>> ubi_ori : " + ubi_ori);
		
		String ubi = KcgCryptUtil.decrypt(ubi_ori);

		UserInfoVO userInfoVO;

			params.put("user_id", user_id);
			params.put("iam_yn", "N");
			userInfoVO = cmmnDao.selectOne("login.geUsertInfo", params);
			if(userInfoVO == null) {
				return "NO_USER";
			}

			// 사용자가 입력한 PW암호화
			userPw = params.getString("usr_pw","");
			userPw = CryptUtil.hashSHA512HexString(userPw);
			userInfoVO.setFromIamYn("N");
		

		log.debug(">>> Pass get user info.");
		params.put("status_cd", userInfoVO.getStatusCd());
		params.put("name", userInfoVO.getName());
		params.put("jikgub_cd", userInfoVO.getJikgubCd());
		params.put("jikgub_nm", userInfoVO.getJikgubNm());
		params.put("dept", userInfoVO.getDept());
		params.put("tdept_nm", userInfoVO.getTdeptNm());
		params.put("email", userInfoVO.getEmail());

		// 로그인 한 사람이 관리자 여부 판별
		CmmnMap authInfo = cmmnDao.selectOne("login.getUserAuthInfo", params);
		if(authInfo == null) {
			params.put("auth_cd", "normal");
			cmmnDao.insert("login.insertUserAuthInfo", params);
			authInfo = new CmmnMap()
					.put("auth_cd", "normal")
					.put("admin_yn", "N")
					;

			userInfoVO.setFirstYn("Y");
		} else {
			params.put("auth_cd", authInfo.getString("auth_cd"));
			cmmnDao.update("login.updateUserAuthInfo", params);

			userInfoVO.setFirstYn("N");
		}
		log.debug(">>> Pass update user auth info.");

		userInfoVO.setAuth(authInfo.getString("auth_cd"));
		userInfoVO.setAdminYn(authInfo.getString("admin_yn"));

		// 비밀번호가 일치하지 않을경우
		log.debug(">>> Check user password.");
		if("N".equals(userInfoVO.getFromIamYn()) &&  !StringUtil.equals(userPw, userInfoVO.getUserPw())) {
			return "FAIL_PW_ERR";
		}

		// 사용자권한별 메뉴정보 셋팅
		userInfoVO.setMenuList(getAuthMenuList(userInfoVO.getAuth(), userInfoVO.getAdminYn()));

		request2.getSession().setAttribute("userInfoVO", userInfoVO);

		if("Y".equals(userInfoVO.getFirstYn())) {
			// 등록횟수 카운트업
			log.debug(">>> Count up Register Count.");
			commonSvc.addStatisticCnt(KcgConstants.STATISTIC_REG_CNT);
		}


		// 접속횟수 카운트업
		log.debug(">>> Count up Access Count.");
		commonSvc.addStatisticCnt(KcgConstants.STATISTIC_VISIT_CNT);

		String rslt = "Y".equals(userInfoVO.getAdminYn()) ? "SUCC_ADMIN" : "SUCC_CLIENT";

		log.debug(">>> LoginSvc.proc END");
		
		return rslt;
	}


	public String ajaxFindUserIdProc(CmmnMap params) {

		return cmmnDao.selectOne("login.findUserId", params);
	}

	
	public String ajaxFindUserPwProc(CmmnMap params) {

		return cmmnDao.selectOne("login.findUserPw", params);
	}
	
	public List<?> selectCodeJbpsTyCdList() {
		log.info(">>> LoginSvc.selectCodeJbpsTyCdList START");
		
		
		log.info(">>> LoginSvc.selectCodeJbpsTyCdList END");
		return cmmnDao.selectList("login.selectCodeJbpsTyCdList");
	}
	
	
	public int registUserInfo(CmmnMap params) {
		log.info(">>> LoginSvc.registUserInfo START");
		
		
		log.info(">>> LoginSvc.registUserInfo END");
		return cmmnDao.insert("login.registUserInfo", params);
	}
	
}
