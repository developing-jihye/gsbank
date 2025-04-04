package kcg.system.user_auth_mng.ctl;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import common.utils.common.CmmnMap;
import common.utils.common.PagingConfig;
import common.utils.mybatis_paginator.domain.PageList;
import kcg.common.svc.CommonSvc;
import kcg.system.user_auth_mng.svc.PortalAuthMngSvc;

@RequestMapping("/system/portal_auth_mng")
@Controller
public class PortalAuthMngCtl {
	
	private final Logger log = LoggerFactory.getLogger(getClass());
	
	@Autowired
	PortalAuthMngSvc portalAuthMngSvc;
	
	@Autowired
	CommonSvc commonSvc;
	
	@RequestMapping("/list")
	public String openPageList(Model model) {
		return "kcg/system/user_auth_mng/PortalAuthMngList";
	}
	
	@RequestMapping("/dtl")
	public String openPageDtl(Model model, CmmnMap params) {
		model.addAttribute("auth_cd", params.getString("auth_cd", ""));
		return "kcg/system/user_auth_mng/PortalAuthMngDtl";
	}
	
	@RequestMapping("/getList")
	public PageList<CmmnMap> getList(CmmnMap params, PagingConfig pagingConfig) {
		return portalAuthMngSvc.getList(params, pagingConfig);
	}
	
	@RequestMapping("/getInfo")
	public CmmnMap getInfo(CmmnMap params) {
		return portalAuthMngSvc.getInfo(params);
	}
	
	@RequestMapping("/save")
	public CmmnMap save(CmmnMap params) {
		return portalAuthMngSvc.save(params);
	}
	
	@RequestMapping("/delete")
	public void delete(CmmnMap params) {
		portalAuthMngSvc.delete(params);
	}
	
	@RequestMapping("/chkExist")
	public CmmnMap chkExist(CmmnMap params) {
		return portalAuthMngSvc.chkExist(params);
	}

}
