package sample.MvcSample.ctl;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import common.utils.common.CmmnMap;
import common.utils.common.CmmnUtil;
import common.utils.string.StringUtil;

@RequestMapping("/sample")
@Controller
public class practiceController {
    
    private final Logger log = LoggerFactory.getLogger(getClass());
    
    @RequestMapping("/home")
    public String sample() {
        
        log.info("나는 컨트롤러");
        
        return "sample/home";
    }
    
    @PostMapping("/ajaxTest")
    public void checkEmail(CmmnMap params) {
        log.info("params >>> ");
        log.info("params >>> " + params);
        log.info("params >>> " + params.get("inputVl1")); 
    }
    
    @RequestMapping("/sampleMovePage")
    public String page(CmmnMap params, ModelMap model) {
        
        log.debug("movePage test>>>" + params);
        
        model.addAttribute("col1", params.get("inputVl1"));
        model.addAttribute("col2", params.get("inputVl2"));
        model.addAttribute("col3", params.get("inputVl3"));

        return "sample/sampleMovePage";
    }
    
    
}