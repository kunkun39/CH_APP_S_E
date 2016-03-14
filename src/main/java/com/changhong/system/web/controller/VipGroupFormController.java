package com.changhong.system.web.controller;

import com.changhong.system.service.UserService;
import com.changhong.system.web.facade.dto.VipGroupDTO;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindException;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.SimpleFormController;
import org.springframework.web.servlet.view.RedirectView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * User: Jack Wang
 * Date: 14-4-9
 * Time: 上午11:42
 */
public class VipGroupFormController extends SimpleFormController {

    private UserService userService;

    public VipGroupFormController() {
        setCommandClass(VipGroupDTO.class);
        setCommandName("vipGroup");
        setFormView("/backend/system/vipgroupform");
    }

    @Override
    protected Object formBackingObject(HttpServletRequest request) throws Exception {
        int groupId = ServletRequestUtils.getIntParameter(request, "groupId", -1);
        String current = ServletRequestUtils.getStringParameter(request, "current", "");
        String filterName = ServletRequestUtils.getStringParameter(request, "filterName", "");
        request.setAttribute("current", current);
        request.setAttribute("filterName", filterName);

        if (groupId > 0) {
            return userService.obtainVipGroupById(groupId);
        }
        return new VipGroupDTO();
    }

    @Override
    protected void onBindAndValidate(HttpServletRequest request, Object command, BindException errors) throws Exception {
        String groupName = ServletRequestUtils.getStringParameter(request, "groupName", "");
        if (!StringUtils.hasText(groupName)) {
            errors.rejectValue("groupName", "vip.name.empty");
        }
        String groupDesc = ServletRequestUtils.getStringParameter(request, "groupDesc", "");
        if (!StringUtils.hasText(groupDesc)) {
            errors.rejectValue("groupDesc", "vip.desc.empty");
        }
    }

    @Override
    protected ModelAndView onSubmit(HttpServletRequest request, HttpServletResponse response, Object command, BindException errors) throws Exception {
        VipGroupDTO vipGroupDTO = (VipGroupDTO) command;

        String current = ServletRequestUtils.getStringParameter(request, "current", "");
        String filterName = ServletRequestUtils.getStringParameter(request, "filterName", "");
        userService.changeVipGroupDetails(vipGroupDTO);

        return new ModelAndView(new RedirectView("vipgroupoverview.html?current=" + current + "&filterName=" + filterName));
    }

    public void setUserService(UserService userService) {
        this.userService = userService;
    }
}
