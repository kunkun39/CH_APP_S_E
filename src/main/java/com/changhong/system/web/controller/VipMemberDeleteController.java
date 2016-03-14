package com.changhong.system.web.controller;

import com.changhong.system.service.UserService;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;
import org.springframework.web.servlet.view.RedirectView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

/**
 * User: Jack Wang
 * Date: 15-7-30
 * Time: 上午11:10
 */
public class VipMemberDeleteController extends AbstractController {

    private UserService userService;

    @Override
    protected ModelAndView handleRequestInternal(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int memberId = ServletRequestUtils.getIntParameter(request, "memberId", -1);
        int groupId = ServletRequestUtils.getIntParameter(request, "groupId", -1);

        userService.deleteVipMember(memberId);
        return new ModelAndView(new RedirectView("vipmemberoverview.html?groupId=" + groupId));
    }

    public void setUserService(UserService userService) {
        this.userService = userService;
    }
}
