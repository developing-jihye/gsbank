package kcg.system.main.svc;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import common.dao.CmmnDao;
import common.utils.common.CmmnMap;
import common.utils.common.CmmnUtil;

@Service
public class SystemMainSvc {

	private final Logger log = LoggerFactory.getLogger(getClass());

	@Autowired
	CmmnDao cmmnDao;

	// 담당 고객 나이 분포
	public List<CmmnMap> getAgeDistr(String userId) {
		return cmmnDao.selectList("system.main.fetchCustomerAgeDistribution", userId);
	}

	// 담당 고객 성별 분포
	public List<CmmnMap> getGenderDistr(String userId) {
		return cmmnDao.selectList("system.main.fetchCustomerGenderDistribution", userId);
	}
	
	// 담당 고객 직업 분포
	public List<CmmnMap> getJobDistr(String userId) {
		return cmmnDao.selectList("system.main.fetchCustomerJobDistribution",userId);
	}

	// 나의 판매량
	public List<CmmnMap> getMysales(String userId) {
		return cmmnDao.selectList("system.main.fetchMySales", userId);
	}

	// 종류별 인기 상품 조회
	// 적금
	public List<CmmnMap> getPopProd1() {
		return cmmnDao.selectList("system.main.fetchPopProd1");
	}

	// 예금
	public List<CmmnMap> getPopProd2() {
		return cmmnDao.selectList("system.main.fetchPopProd2");
	}

	// 대출
	public List<CmmnMap> getPopProd3() {
		return cmmnDao.selectList("system.main.fetchPopProd3");
	}

	// 베스트 마케터 조회
	public List<CmmnMap> getBestMarketer() {
		return cmmnDao.selectList("system.main.fetchBestMarketer");
	}
	
	
	
	
	
	// 기존 코드

	public CmmnMap getStatData() {

		String today = CmmnUtil.getTodayFormedString();

		CmmnMap params = new CmmnMap().put("from_date", today).put("to_date", today);

		CmmnMap todayStat = getTodayStat();
		CmmnMap visitStat = getVisitStat();
		CmmnMap reqStat = getReqStat(params);

		return new CmmnMap().put("today", today).put("todayStat", todayStat).put("visitStat", visitStat).put("reqStat",
				reqStat);

	}

	public CmmnMap getTodayStat() {

		String today = CmmnUtil.getTodayFormedString();

		CmmnMap rslt = cmmnDao.selectOne("system.main.getTodayStat", today);
		if (rslt == null) {
			cmmnDao.insert("system.main.init", today);
			rslt = cmmnDao.selectOne("system.main.getTodayStat", today);
		}
		return rslt;
	}

	public CmmnMap getReqStat(CmmnMap params) {
		return cmmnDao.selectOne("system.main.getReqStat", params);
	}

	public CmmnMap getVisitStat() {

		String to_date = CmmnUtil.getTodayFormedString();
		String from_date = CmmnUtil.calcDate(to_date, -9);

		CmmnMap params = new CmmnMap().put("from_date", from_date).put("to_date", to_date);

		List<CmmnMap> dataList = cmmnDao.selectList("system.main.getVisitStat", params);

		String title = new StringBuilder().append("(").append(from_date).append(" ~ ").append(to_date).append(") 접속통계")
				.toString();

		return new CmmnMap().put("title", title).put("dataList", dataList);
	}

}
