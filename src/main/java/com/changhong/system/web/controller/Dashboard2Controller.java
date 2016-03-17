package com.changhong.system.web.controller;

import com.changhong.system.service.AppService;
import com.changhong.system.web.facade.dto.HomePagePosterDTO;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * User: pengjie
 * Date: 2016/3/15
 * Time: 15:21
 */
public class Dashboard2Controller extends AbstractController {

    private AppService appService;

    private String fileRequestHost;

    @Override
    protected ModelAndView handleRequestInternal(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws Exception {
        Map<String, Object> model = new HashMap<String, Object>();
        List<HomePagePosterDTO> posters = appService.obtainHomePagePoster();

        model.put("posters", posters);

        model.put("fileRequestHost", fileRequestHost);
        return new ModelAndView("backend/dashboard2", model);
    }

    public void setAppService(AppService appService) {
        this.appService = appService;
    }

    public void setFileRequestHost(String fileRequestHost) {
        this.fileRequestHost = fileRequestHost;
    }
}
