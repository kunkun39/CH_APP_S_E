package com.changhong.system.web.controller;

import com.changhong.system.domain.AppMustType;
import com.changhong.system.service.AppService;
import com.changhong.system.web.facade.dto.AppCategoryDTO;
import com.changhong.system.web.facade.dto.AppMustDTO;
import com.changhong.system.web.facade.dto.LuncherRecommendDTO;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * User: Jack Wang
 * Date: 15-9-29
 * Time: 上午9:49
 */
public class AppMustManagementController extends AbstractController {

    private AppService appService;

    private String fileRequestHost;

    @Override
    protected ModelAndView handleRequestInternal(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String appMustType = ServletRequestUtils.getStringParameter(request, "appMustType", "INSTALL");
        Map<String, Object> model = new HashMap<String, Object>();
        List<AppCategoryDTO> categories = appService.obtainAllFirstLevelCategory(true);
        model.put("categories", categories);

        List<AppMustDTO> appMusts = appService.obtainAppMust(appMustType);
        model.put("appMusts", appMusts);

        model.put("fileRequestHost", fileRequestHost);
        model.put("appMustType", appMustType);
        if (appMustType.equals(AppMustType.INSTALL.name())) {
            model.put("pageName", "Force Install");
        } else if (appMustType.equals(AppMustType.UPDATE.name())) {
            model.put("pageName", "Force Update");
        } else {
            model.put("pageName", "Force Uninstall");
        }
        return new ModelAndView("backend/app/appmust", model);
    }

    public void setAppService(AppService appService) {
        this.appService = appService;
    }

    public void setFileRequestHost(String fileRequestHost) {
        this.fileRequestHost = fileRequestHost;
    }

}
