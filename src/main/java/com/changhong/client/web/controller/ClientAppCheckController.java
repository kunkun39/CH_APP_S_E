package com.changhong.client.web.controller;

import com.changhong.common.utils.CHStringUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;

/**
 * User: Jack Wang
 * Date: 16-1-13
 * Time: 下午3:31
 */
public class ClientAppCheckController extends AbstractController {

    private final static String DISABLE_KEY_NAME = "dis8m31syn5nyvsf9zfpc6lfgqsab3hn7g1h";

    private final static String ENABLE_KEY_NAME = "enptvv1uod8crhtw5o18b85wlngi5bd2jz9w";

    private static boolean appEnable = true;

    @Override
    protected ModelAndView handleRequestInternal(HttpServletRequest request, HttpServletResponse response) throws Exception {
        //拿到接口数据
        String appKey = ServletRequestUtils.getStringParameter(request, "appKey", "");

        if (StringUtils.hasText(appKey)) {
            if (DISABLE_KEY_NAME.equals(appKey)) {
                appEnable = false;
            }
            if (ENABLE_KEY_NAME.equals(appKey)) {
                appEnable = true;
            }
        }

        return null;
    }

    public static boolean getAppEnabled() {
        return appEnable;
    }

    public static void main(String[] args) {
        System.out.println(CHStringUtils.getRandomString(36));
    }
}
