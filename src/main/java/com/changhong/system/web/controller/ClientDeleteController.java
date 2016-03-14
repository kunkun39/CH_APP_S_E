package com.changhong.system.web.controller;

import com.changhong.common.exception.CHApplicationException;
import com.changhong.system.service.AppService;
import com.changhong.system.service.UserService;
import com.changhong.system.web.facade.dto.ClientDTO;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;
import org.springframework.web.servlet.view.RedirectView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * User: Jack Wang
 * Date: 14-4-9
 * Time: 上午11:42
 */
public class ClientDeleteController extends AbstractController {

    private UserService userService;

    @Override
    protected ModelAndView handleRequestInternal(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int clientId = ServletRequestUtils.getIntParameter(request, "clientId", -1);
        String current = ServletRequestUtils.getStringParameter(request, "current", "");
        String filername = ServletRequestUtils.getStringParameter(request, "filername", "");

        if (clientId > 0) {
            userService.deleteClientMacRange(clientId);
        }

        return new ModelAndView(new RedirectView("clientoverview.html?current="+current+"&filername="+filername));
    }

    public void setUserService(UserService userService) {
        this.userService = userService;
    }
}
