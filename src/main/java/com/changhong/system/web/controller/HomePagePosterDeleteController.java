package com.changhong.system.web.controller;

import com.changhong.system.service.AppService;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;
import org.springframework.web.servlet.view.RedirectView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * User: pengjie
 * Date: 2016/3/16
 * Time: 11:09
 */
public class HomePagePosterDeleteController extends AbstractController {

    private AppService appService;

    @Override
    protected ModelAndView handleRequestInternal(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws Exception {
        int id = ServletRequestUtils.getIntParameter(httpServletRequest, "id", -1);

        appService.deleteHomePagePoster(id);

        return new ModelAndView(new RedirectView("dashboard.html"));
    }

    public void setAppService(AppService appService) {
        this.appService = appService;
    }
}
