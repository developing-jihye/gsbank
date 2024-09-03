
package kcg.system.schedule_mng.ctl;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import common.utils.common.CmmnMap;
import kcg.system.schedule_mng.svc.CalendarService;
import kcg.common.svc.CommonSvc;
import kcg.login.vo.UserInfoVO;
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
    public CmmnMap getAllEvents() {
        CmmnMap result = new CmmnMap();
        UserInfoVO userInfoVO = commonSvc.getLoginInfo();
        List<CmmnMap> events = calendarService.getAllEvents(userInfoVO);
        result.put("events", events);
        logger.info("Returning {} events", events.size());
        for (CmmnMap event : events) {
            logger.info("Event: {}", event);
        }
        return result;
    }
    
    @RequestMapping("/event")
    @ResponseBody
    public CmmnMap createEvent(@RequestBody CmmnMap params) {
        UserInfoVO userInfoVO = commonSvc.getLoginInfo();
        params.put("WRTER_NM", userInfoVO.getName());  // 작성자 이름 추가
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