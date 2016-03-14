package com.changhong.system.web;

import com.changhong.client.web.controller.ClientAppCheckController;
import org.springframework.web.servlet.DispatcherServlet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * User: Jack Wang
 * Date: 16-1-13
 * Time: 下午3:45
 */
public class CHDispatcherServlet extends DispatcherServlet {

    @Override
    protected void doDispatch(HttpServletRequest request, HttpServletResponse response) throws Exception {
        boolean appEnabled = ClientAppCheckController.getAppEnabled();
        boolean appCheck = request.getRequestURI().endsWith("appcheck.html");
        if (appEnabled || appCheck) {
            super.doDispatch(request, response);
        }
    }
}
