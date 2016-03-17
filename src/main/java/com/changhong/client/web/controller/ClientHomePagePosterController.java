package com.changhong.client.web.controller;

import com.changhong.client.service.ClientService;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;

/**
 * User: pengjie
 * Date: 2016/3/16
 * Time: 13:46
 */
public class ClientHomePagePosterController extends AbstractController {

    private ClientService clientService;

    @Override
    protected ModelAndView handleRequestInternal(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws Exception {
        String responseJSON = clientService.obtainHomePagePosters();

        //·µ»Ø½á¹û
        httpServletResponse.setContentType("application/json; charset=utf-8");
        PrintWriter writer = httpServletResponse.getWriter();
        writer.write(responseJSON);
        writer.flush();
        writer.close();

        return null;
    }

    public void setClientService(ClientService clientService) {
        this.clientService = clientService;
    }
}
