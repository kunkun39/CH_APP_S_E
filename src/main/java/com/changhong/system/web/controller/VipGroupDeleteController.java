package com.changhong.system.web.controller;

import com.changhong.system.service.UserService;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;
import org.springframework.web.servlet.view.RedirectView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * User: Jack Wang
 * Date: 16-2-17
 * Time: 上午10:46
 */
public class VipGroupDeleteController extends AbstractController {

    private UserService userService;

    @Override
    protected ModelAndView handleRequestInternal(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int current = ServletRequestUtils.getIntParameter(request, "current", 1);
        String filterName = StringUtils.trimWhitespace(ServletRequestUtils.getStringParameter(request, "filterName", ""));
        request.setAttribute("current", current);
        request.setAttribute("filterName", filterName);

        int groupId = ServletRequestUtils.getIntParameter(request, "groupId", -1);
        if (groupId > 0) {
            userService.deleteVipGroup(groupId);
        }

        return new ModelAndView(new RedirectView("vipgroupoverview.html?current=" + current + "&filterName=" + filterName));
    }

    public void setUserService(UserService userService) {
        this.userService = userService;
    }
}
