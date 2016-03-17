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
 * Date: 2016/3/17
 * Time: 10:24
 */
public class AppCategorySequenceChangeController extends AbstractController {

    private AppService appService;

    @Override
    protected ModelAndView handleRequestInternal(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws Exception {
        String method = ServletRequestUtils.getStringParameter(httpServletRequest, "method", "");
        int categoryId = ServletRequestUtils.getIntParameter(httpServletRequest, "categoryId", -1);

        if (categoryId > 0 && ("up".equals(method) || "down".equals(method))) {
            appService.changeCategorySequence(categoryId, method);
        }
        return new ModelAndView(new RedirectView("appcategoryoverview.html"));
    }

    public void setAppService(AppService appService) {
        this.appService = appService;
    }
}
