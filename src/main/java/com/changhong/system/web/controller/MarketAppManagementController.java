package com.changhong.system.web.controller;

import com.changhong.system.service.AppService;
import com.changhong.system.service.UserService;
import com.changhong.system.web.facade.dto.AppCategoryDTO;
import com.changhong.system.web.facade.dto.AppTopicDTO;
import com.changhong.system.web.facade.dto.MarketAppDTO;
import com.changhong.system.web.facade.dto.VipGroupDTO;
import com.changhong.system.web.paging.MarketOverviewPaging;
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
 * Date: 15-7-30
 * Time: 下午2:14
 */
public class MarketAppManagementController extends AbstractController {

    private AppService appService;

    private UserService userService;

    private String fileRequestHost;

    @Override
    protected ModelAndView handleRequestInternal(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Map<String, Object> model = new HashMap<String, Object>();

        List<AppCategoryDTO> categories = appService.obtainAllFirstLevelCategory(true);
        model.put("categories", categories);

        List<AppTopicDTO> topics = appService.obtainAllTopics();
        model.put("topics", topics);

        List<VipGroupDTO> groups = userService.obtainAllVipGroups();
        model.put("groups", groups);

        int current = ServletRequestUtils.getIntParameter(request, "current", 1);
        String appName = ServletRequestUtils.getStringParameter(request, "appName", "").trim();
        String appStatus = ServletRequestUtils.getStringParameter(request, "appStatus", "ALL");
        int categoryId = ServletRequestUtils.getIntParameter(request, "categoryId", -1);
        int topicId = ServletRequestUtils.getIntParameter(request, "topicId", -1);
        int groupId = ServletRequestUtils.getIntParameter(request, "groupId", -1);

        MarketOverviewPaging paging = new MarketOverviewPaging(appService);
        constructPaging(paging, current, appName, categoryId, topicId, groupId, appStatus);
        List<MarketAppDTO> apps = paging.getItems();
        model.put("paging", paging);
        model.put("apps", apps);

        model.put("fileRequestHost", fileRequestHost);
        return new ModelAndView("backend/app/marketappmanage", model);
    }

    private void constructPaging(MarketOverviewPaging paging, int current, String appName, int categoryId, int topicId, int groupId, String appStatus) {
        paging.setCurrentPageNumber(current);
        paging.setAppName(appName);
        paging.setCategoryId(categoryId);
        paging.setTopicId(topicId);
        paging.setGroupId(groupId);
        paging.setAppStatus(appStatus);
    }

    public void setAppService(AppService appService) {
        this.appService = appService;
    }

    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    public void setFileRequestHost(String fileRequestHost) {
        this.fileRequestHost = fileRequestHost;
    }
}
