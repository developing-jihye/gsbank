package kcg.system.schedule_mng.svc;

import org.apache.commons.lang3.builder.ReflectionToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import common.dao.CmmnDao;
import common.utils.common.CmmnMap;
import kcg.common.svc.CommonSvc;
import kcg.login.vo.UserInfoVO;
import java.util.List;
import java.util.TimeZone;
import java.util.UUID;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;

@Service
public class CalendarService {
    
    private static final Logger logger = LoggerFactory.getLogger(CalendarService.class);
    
    @Autowired
    private CmmnDao cmmnDao;
    
    @Autowired
    private CommonSvc commonSvc;

    public List<CmmnMap> getAllEvents(String userId) {
    	CmmnMap params = new CmmnMap();
        params.put("userId", userId); // userId만 사용
        logger.info("Fetching events with userId: {}", userId);

        List<CmmnMap> events = cmmnDao.selectList("Calendar.getAllEvents", params);
        logger.info("Number of events retrieved: {}", events.size());

        if (events != null) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
            sdf.setTimeZone(TimeZone.getTimeZone("UTC"));

            for (CmmnMap event : events) {
                logger.info("Raw Event Data: {}", event);

                // 필드 이름을 대문자로 변환
                event.put("EVT_SN", event.get("evt_sn"));
                event.put("EVT_TITLE", event.get("evt_title"));
                event.put("EVT_BGNG_DT", event.get("evt_bgng_dt"));
                event.put("EVT_END_DT", event.get("evt_end_dt"));
                event.put("CALENDAR_ID", event.get("calendar_id"));

                // location과 state 처리
                event.put("location", event.get("EVT_LOCATION"));
                event.put("state", event.get("EVT_STCD"));
                
                // 날짜 형식 변환
                if (event.get("EVT_BGNG_DT") instanceof java.sql.Timestamp) {
                    event.put("start", sdf.format(event.get("EVT_BGNG_DT")));
                }
                if (event.get("EVT_END_DT") instanceof java.sql.Timestamp) {
                    event.put("end", sdf.format(event.get("EVT_END_DT")));
                }

                // 프론트엔드에서 예상하는 필드 이름으로 매핑
                event.put("id", event.get("EVT_SN"));
                event.put("calendarId", event.get("CALENDAR_ID"));
                event.put("title", event.get("EVT_TITLE"));
                event.put("body", event.get("evt_cn"));
                event.put("isAllDay", "Y".equals(event.get("is_all_day")));
                event.put("category", event.get("evt_category"));
                event.put("location", event.get("evt_location"));
                event.put("state", event.get("evt_stcd"));
                event.put("isPrivate", "Y".equals(event.get("is_private")));
            }
        }

        return events;
    }

    public CmmnMap createEvent(CmmnMap params) {
        UserInfoVO userInfoVO = commonSvc.getLoginInfo();
        // UserInfoVO의 모든 필드를 로그로 출력
        String userInfoString = ReflectionToStringBuilder.toString(userInfoVO, ToStringStyle.MULTI_LINE_STYLE);
        logger.info("UserInfoVO contents:\n{}", userInfoString);
        
        // 현재 로그인한 사용자의 핸드폰 번호를 가져옵니다.
        String userPhoneNumber = userInfoVO.getHandphone();
        
        // 핸드폰 번호를 params에 추가합니다.
        params.put("PIC_MBL_TELNO", userPhoneNumber);
        
        // 개인 일정인 경우 참석자 목록에 사용자 이름 추가
        String calendarId = params.getString("calendarId");
        if ("personal".equals(calendarId)) {
            params.put("EVT_ATND_LST", userInfoVO.getName());
        } else if ("team".equals(calendarId)) {
            // 팀 일정인 경우 참석자 목록에 부서명 추가
            params.put("EVT_ATND_LST", userInfoVO.getTdeptNm());
        } else if ("company".equals(calendarId)) {
            // 팀 일정인 경우 참석자 목록에 부서명 추가
            params.put("EVT_ATND_LST", "Everyone");
        }
        
        SimpleDateFormat sdfInput = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
        sdfInput.setTimeZone(TimeZone.getTimeZone("UTC"));
        
        params.put("EVT_SN", UUID.randomUUID().toString());
        params.put("PIC_MBL_TELNO", userInfoVO.getHandphone());
        params.put("WRTER_NM", userInfoVO.getName());
        
        params.put("CALENDAR_ID", params.getString("calendarId", "default"));
        params.put("EVT_TITLE", params.getString("title", "Untitled Event"));
        params.put("EVT_CATEGORY", params.getString("category", "time"));
        params.put("EVT_STCD", params.getString("state", "busy"));
        // location이 null이면 빈 문자열로 설정
        params.put("EVT_LOCATION", params.getString("location", ""));
        params.put("IS_ALL_DAY", params.getBoolean("isAllday", false) ? "Y" : "N");
        params.put("IS_PRIVATE", params.getBoolean("isPrivate", false) ? "Y" : "N");

        try {
            if (params.get("start") != null) {
                Date startDate = sdfInput.parse(params.getString("start"));
                params.put("EVT_BGNG_DT", new java.sql.Timestamp(startDate.getTime()));
            }
            if (params.get("end") != null) {
                Date endDate = sdfInput.parse(params.getString("end"));
                params.put("EVT_END_DT", new java.sql.Timestamp(endDate.getTime()));
            }
        } catch (Exception e) {
            logger.error("Error parsing date", e);
            Date now = new Date();
            params.put("EVT_BGNG_DT", new java.sql.Timestamp(now.getTime()));
            params.put("EVT_END_DT", new java.sql.Timestamp(now.getTime() + 3600000)); // 1시간 후
        }

        logger.info("Creating event with params: {}", params);
        cmmnDao.insert("Calendar.createEvent", params);
        return params;
    }

    public CmmnMap updateEvent(CmmnMap params) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
        sdf.setTimeZone(TimeZone.getTimeZone("UTC"));
        try {
            if (params.get("EVT_BGNG_DT") != null) {
                Date startDate = sdf.parse(params.getString("EVT_BGNG_DT"));
                params.put("EVT_BGNG_DT", new java.sql.Timestamp(startDate.getTime()));
            }
            if (params.get("EVT_END_DT") != null) {
                Date endDate = sdf.parse(params.getString("EVT_END_DT"));
                params.put("EVT_END_DT", new java.sql.Timestamp(endDate.getTime()));
            }
        } catch (Exception e) {
            logger.error("Error parsing date for update", e);
        }

        params.put("IS_ALL_DAY", params.getBoolean("IS_ALL_DAY", false) ? "Y" : "N");
        params.put("IS_PRIVATE", params.getBoolean("IS_PRIVATE", false) ? "Y" : "N");
        
        // location 처리
        String location = params.getString("EVT_LOCATION");
        if (location == null) {
            location = params.getString("location", "");
        }
        params.put("EVT_LOCATION", location);
        
        // attendees 처리
        String attendees = params.getString("attendees");
        if (attendees != null) {
            params.put("EVT_ATND_LST", attendees);
        }

        logger.info("Updating event with params: {}", params);
        cmmnDao.update("Calendar.updateEvent", params);
        return params;
    }

    public void deleteEvent(CmmnMap params) {
        logger.info("Deleting event with params: {}", params);
        cmmnDao.delete("Calendar.deleteEvent", params);
    }
}