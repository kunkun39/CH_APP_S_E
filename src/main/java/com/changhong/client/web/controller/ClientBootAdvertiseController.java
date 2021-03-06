package com.changhong.client.web.controller;

import com.changhong.client.service.ClientService;
import com.changhong.common.utils.DesUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;

/**
 * User: dangwei
 * Date: 15-10-21
 * Time: 上午9:58
 * To change this template use File | Settings | File Templates.
 */
public class ClientBootAdvertiseController extends AbstractController{

    private static final Log logger = LogFactory.getLog(ClientBootAdvertiseController.class);

      private ClientService clientService;

    @Override
    protected ModelAndView handleRequestInternal(HttpServletRequest request, HttpServletResponse response) throws Exception {
        //获得开机图片的JSPON数据
        String boxMac = ServletRequestUtils.getStringParameter(request, "boxMac");
        boxMac = DesUtils.getDesString(boxMac);
        logger.info("mac address " + boxMac);

        String responseJSON = clientService.obtainBootImage(boxMac);

        /*****************返回结果******************/
        response.setContentType("application/json; charset=utf-8");
        //获得输出流对象
        PrintWriter writer = response.getWriter();
        //把输出流发送到页面URL上
        writer.write(responseJSON);
        //刷新缓冲
        writer.flush();
        //关闭数据发送
        writer.close();

        return null;
    }

    public void setClientService(ClientService clientService) {
        this.clientService = clientService;
    }
}
