package com.changhong.system.web.controller;

import com.changhong.common.utils.CHFileUtils;
import com.changhong.system.service.AppService;
import com.changhong.system.web.facade.dto.HomePagePosterDTO;
import org.springframework.validation.BindException;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.support.DefaultMultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;
import org.springframework.web.servlet.mvc.SimpleFormController;
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
public class HomePagePosterFormController extends SimpleFormController {

    private final static int MAX_IMAGE_SIZE = 1024 * 50;

    private AppService appService;

    private String fileRequestHost;

    public HomePagePosterFormController() {
        setCommandClass(HomePagePosterDTO.class);
        setCommandName("poster");
        setFormView("/backend/app/homepageposterform");
    }

    @Override
    protected Object formBackingObject(HttpServletRequest request) throws Exception {
        int id = ServletRequestUtils.getIntParameter(request, "id", -1);
        HomePagePosterDTO dto = appService.obtainHomePagePosterById(id);

        request.setAttribute("fileRequestHost", fileRequestHost);

        return dto;
    }

    @Override
    protected void onBindAndValidate(HttpServletRequest request, Object command, BindException errors) throws Exception {
        DefaultMultipartHttpServletRequest multipartRequest = (DefaultMultipartHttpServletRequest) request;
        MultipartFile posterFile = multipartRequest.getFile("posterFile");

        if (posterFile == null || posterFile.getSize() <= 0) {
            errors.rejectValue("posterActualFileName", "homepage.poster.empty");
        } else {
            if (!CHFileUtils.isImageFile(posterFile.getOriginalFilename())) {
                errors.rejectValue("posterActualFileName", "homepage.not.image");
            } else if (posterFile.getSize() > MAX_IMAGE_SIZE) {
                errors.rejectValue("posterActualFileName", "homepage.image.bigger");
            }
        }
    }

    @Override
        protected ModelAndView onSubmit(HttpServletRequest request, HttpServletResponse response, Object command, BindException errors) throws Exception {
        DefaultMultipartHttpServletRequest multipartRequest = (DefaultMultipartHttpServletRequest) request;
        MultipartFile posterFile = multipartRequest.getFile("posterFile");
        appService.updateHomePagePoster(((HomePagePosterDTO) command).getId(), posterFile);

        return new ModelAndView(new RedirectView("dashboard.html"));
    }

    public void setAppService(AppService appService) {
        this.appService = appService;
    }

    public void setFileRequestHost(String fileRequestHost) {
        this.fileRequestHost = fileRequestHost;
    }
}
