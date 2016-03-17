package com.changhong.system.web.controller;

import com.changhong.system.service.AppService;
import com.changhong.system.web.facade.dto.HomePagePosterDTO;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.support.DefaultMultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;
import org.springframework.web.servlet.view.RedirectView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

/**
 * User: pengjie
 * Date: 2016/3/16
 * Time: 8:46
 */
public class HomePagePosterFormController extends AbstractController {

    private AppService appService;

    private String fileRequestHost;

    @Override
    protected ModelAndView handleRequestInternal(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws Exception {
        int id = ServletRequestUtils.getIntParameter(httpServletRequest, "id", -1);
        String method = ServletRequestUtils.getStringParameter(httpServletRequest, "method");

        if ("save".equals(method)) {
            DefaultMultipartHttpServletRequest multipartRequest = (DefaultMultipartHttpServletRequest) httpServletRequest;
            MultipartFile posterFile = multipartRequest.getFile("posterFile");
            appService.updateHomePagePoster(id, posterFile);

            return new ModelAndView(new RedirectView("dashboard.html"));
        } else {
            Map<String, Object> model = new HashMap<String, Object>();
            HomePagePosterDTO dto = appService.obtainHomePagePosterById(id);

            model.put("poster", dto);
            model.put("fileRequestHost", fileRequestHost);

            return new ModelAndView("backend/app/homepageposterform", model);
        }
    }

    public void setAppService(AppService appService) {
        this.appService = appService;
    }

    public void setFileRequestHost(String fileRequestHost) {
        this.fileRequestHost = fileRequestHost;
    }
}
