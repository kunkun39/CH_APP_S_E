package com.changhong.system.web.controller;

import com.changhong.system.service.AppService;
import com.changhong.system.service.UserService;
import com.changhong.system.web.facade.dto.AppTopicDTO;
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
 * User: Jack Wang
 * Date: 15-7-30
 * Time: 上午11:10
 */
public class VipMemberFormController extends AbstractController {

    private UserService userService;

    @Override
    protected ModelAndView handleRequestInternal(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String method = ServletRequestUtils.getStringParameter(request, "method");
        int groupId = ServletRequestUtils.getIntParameter(request, "groupId", -1);

        if ("save".equals(method)) {
            String boxMac = ServletRequestUtils.getStringParameter(request, "boxMac", "");

            userService.saveVipMember(groupId, boxMac);
            return new ModelAndView(new RedirectView("vipmemberoverview.html?groupId=" + groupId));
        } else {
            Map<String, Object> model = new HashMap<String, Object>();
            model.put("groupId", groupId);
            return new ModelAndView("backend/system/vipmemberform", model);
        }
    }

    public void setUserService(UserService userService) {
        this.userService = userService;
    }
}
