package com.changhong.system.web.controller;

import com.changhong.system.service.UserService;
import com.changhong.system.web.facade.dto.VipGroupDTO;
import com.changhong.system.web.facade.dto.VipMemberDTO;
import com.changhong.system.web.paging.VipMemberOverviewPaging;
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
public class VipMemberManagementController extends AbstractController {

    private UserService userService;

    @Override
    protected ModelAndView handleRequestInternal(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Map<String, Object> model = new HashMap<String, Object>();
        int groupId = ServletRequestUtils.getIntParameter(request, "groupId", -1);
        int current = ServletRequestUtils.getIntParameter(request, "current", 1);
        String filterMac = StringUtils.trimWhitespace(ServletRequestUtils.getStringParameter(request, "filterMac", ""));
        request.setAttribute("current", current);
        request.setAttribute("filterMac", filterMac);

        VipGroupDTO groupDTO = userService.obtainVipGroupById(groupId);
        request.setAttribute("group", groupDTO);

        VipMemberOverviewPaging paging = new VipMemberOverviewPaging(userService);
        constructPaging(paging, current, groupId, filterMac);
        List<VipMemberDTO> members = paging.getItems();
        model.put("members", members);
        model.put("paging", paging);

        return new ModelAndView("backend/system/vipmemberoverview", model);
    }

    private void constructPaging(VipMemberOverviewPaging paging, int current, int groupId, String filterMac) {
        paging.setCurrentPageNumber(current);
        paging.setGroupId(groupId);
        paging.setFilterMac(filterMac);
    }

    public void setUserService(UserService userService) {
        this.userService = userService;
    }
}
