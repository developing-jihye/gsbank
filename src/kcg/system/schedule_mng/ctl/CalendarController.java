
package kcg.system.schedule_mng.ctl;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import common.utils.common.CmmnMap;
import kcg.common.svc.CommonSvc;
import kcg.login.vo.UserInfoVO;
import kcg.system.schedule_mng.svc.CalendarService;
@RequestMapping("/schedule")
@Controller
public class CalendarController {

    private static final Logger logger = LoggerFactory.getLogger(CalendarController.class);

    @Autowired
    private CalendarService calendarService;

    @Autowired
    private CommonSvc commonSvc;
    
    @RequestMapping("/calendar")
    public String showCalendar() {
        return "kcg/system/schedule_mng/schedule_todoList";
    }
    
    @RequestMapping("/events")
    @ResponseBody
    public CmmnMap getAllEvents(HttpServletRequest request, HttpServletResponse response) {
    	CmmnMap result = new CmmnMap();
        
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userId");
        logger.info("Retrieved userId from session: {}", userId);
        
        // 서비스 메서드 호출
        List<CmmnMap> events = calendarService.getAllEvents(userId);
        logger.info("Retrieved {} events from the service", events.size());

        // 필터링 제거
        // 직접 필터링 없이 결과를 사용
        
        // 결과에 이벤트 추가
        result.put("events", events);
        return result;
    }
    
    
    @RequestMapping("/event")
    @ResponseBody
    public CmmnMap createEvent(@RequestBody CmmnMap params, HttpServletRequest request, HttpServletResponse response) {
        UserInfoVO userInfoVO = commonSvc.getLoginInfo();
        params.put("WRTER_NM", userInfoVO.getName());  // 작성자 이름 추가
        

        HttpSession session = request.getSession();
        // 세션에서 값 꺼내기
        String userId = (String) session.getAttribute("userId");
        params.put("userId", userId);
        
        logger.info("userId>>>>" + userId);
        return calendarService.createEvent(params);
    }
    
    @RequestMapping("/event/update")
    @ResponseBody
    public CmmnMap updateEvent(@RequestBody CmmnMap params) {
        return calendarService.updateEvent(params);
    }
    
    @RequestMapping("/event/delete")
    @ResponseBody
    public CmmnMap deleteEvent(@RequestBody CmmnMap params) {
        calendarService.deleteEvent(params);
        return new CmmnMap().put("status", "OK");
    }
}