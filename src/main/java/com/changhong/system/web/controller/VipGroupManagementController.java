package com.changhong.system.web.controller;

import com.changhong.system.service.UserService;
import com.changhong.system.web.facade.dto.VipGroupDTO;
import com.changhong.system.web.paging.VipGroupOverviewPaging;
import org.springframework.util.StringUtils;
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
 * Date: 16-2-17
 * Time: 上午10:46
 */
public class VipGroupManagementController extends AbstractController {

    private UserService userService;

    @Override
    protected ModelAndView handleRequestInternal(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Map<String, Object> model = new HashMap<String, Object>();
        int current = ServletRequestUtils.getIntParameter(request, "current", 1);
        String filterName = StringUtils.trimWhitespace(ServletRequestUtils.getStringParameter(request, "filterName", ""));
        request.setAttribute("current", current);
        request.setAttribute("filterName", filterName);

        VipGroupOverviewPaging paging = new VipGroupOverviewPaging(userService);
        constructPaging(paging, current, filterName);
        List<VipGroupDTO> groups = paging.getItems();
        model.put("groups", groups);
        model.put("paging", paging);

        return new ModelAndView("backend/system/vipgroupoverview", model);
    }

    private void constructPaging(VipGroupOverviewPaging paging, int current, String filterName) {
        paging.setCurrentPageNumber(current);
        paging.setFilterName(filterName);
    }

    public void setUserService(UserService userService) {
        this.userService = userService;
    }
}
