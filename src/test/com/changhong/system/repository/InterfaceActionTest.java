package com.changhong.system.repository;

import com.alibaba.fastjson.JSONObject;
import com.changhong.common.service.HttpClientServiceImpl;
import com.changhong.common.utils.DesUtils;
import junit.framework.TestCase;
import org.apache.commons.httpclient.methods.MultipartPostMethod;
import org.apache.commons.httpclient.methods.multipart.FilePart;
import org.apache.commons.httpclient.methods.multipart.StringPart;
import org.hibernate.SessionFactory;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;
import java.io.File;
import java.net.URLEncoder;

/**
 * User: Jack Wang
 * Date: 15-12-2
 * Time: 下午3:06
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"/database.xml", "/applicationContext.xml"})
public class InterfaceActionTest extends TestCase {

    private static final String host = "http://localhost:8080/taskmanager/client/";
//    private static final String host = "http://112.124.15.158:8080/taskmanager/client/";
//    private static final String host = "http://www.ottserver.com:18080/taskmanager/client/";

    @Resource
    SessionFactory sessionFactory;

    HibernateTemplate hibernateTemplate;

    @Before
    public void setUp() {
        hibernateTemplate = new HibernateTemplate(sessionFactory);
    }

    @After
    public void tearDown() {
        hibernateTemplate = null;
    }

    /**
     * 用户注册，备注，让用户不要用中文注册, YES代表从注册模块发送，NO代码从其他模块发送
     */
    @Test
    public void testSendCode() throws Exception {
        HttpClientServiceImpl client = new HttpClientServiceImpl();

        JSONObject json = new JSONObject();
        json.put("username", "11111111111");
        json.put("fromRegister", "YES");
        String parameter = DesUtils.getEncString(json.toJSONString());

        String result = client.httpGetRequestForString(host + "sendcode.html?json=" + parameter);
        System.out.println(result);
    }

    /**
     * 用户注册， -1注册失败，0已经注册 》0，注册成功
     */
    @Test
    public void testRegister() {
        HttpClientServiceImpl client = new HttpClientServiceImpl();

        JSONObject json = new JSONObject();
        json.put("username", "11111111111");
        json.put("password", "123456");
        json.put("code", "2816");
        json.put("invitecode", "000015");
        String parameter = DesUtils.getEncString(json.toJSONString());

        String result = client.httpGetRequestForString(host + "register.html?json=" + parameter);
        System.out.println(result);
    }

    /**
     * 用户登录，-1，登录失败， 》0登录成功
     */
    @Test
    public void testLogin() {
        HttpClientServiceImpl client = new HttpClientServiceImpl();

        JSONObject json = new JSONObject();
        json.put("username", "11111111111");
        json.put("password", "111111");
        String parameter = DesUtils.getEncString(json.toJSONString());

        String result = client.httpGetRequestForString(host + "login.html?json=" + parameter);
        System.out.println(result);
    }

     /**
     * 用户注册， -1修改密码失败，0,未注册，》0修改密码成功
     */
    @Test
    public void testChangePassword() {
        HttpClientServiceImpl client = new HttpClientServiceImpl();

        JSONObject json = new JSONObject();
        json.put("username", "11111111111");
        json.put("password", "111111");
        json.put("code", "2816");
        String parameter = DesUtils.getEncString(json.toJSONString());

        String result = client.httpGetRequestForString(host + "changepwd.html?json=" + parameter);
        System.out.println(result);
    }

    /**
     * 获得现在正在开发的任务
     */
    @Test
    public void testSearchTask() {
        HttpClientServiceImpl client = new HttpClientServiceImpl();

        JSONObject json = new JSONObject();
        json.put("current", "1");
        json.put("clientId", "6");
        String parameter = DesUtils.getEncString(json.toJSONString());

        String result = client.httpGetRequestForString(host + "searchtask.html?json=" + parameter);
        System.out.println(result);
    }

    /**
     * 查看某个任务的详情
     */
    @Test
    public void testTaskDetails() {
        HttpClientServiceImpl client = new HttpClientServiceImpl();

        JSONObject json = new JSONObject();
        json.put("taskId", "27");
        json.put("clientId", "25");
        String parameter = DesUtils.getEncString(json.toJSONString());

        String result = client.httpGetRequestForString(host + "taskdetails.html?json=" + parameter);
        System.out.println(result);
    }

    /**
     * 提交任务
     */
    @Test
    public void testTaskSubmit() throws Exception {
        HttpClientServiceImpl client = new HttpClientServiceImpl();

        JSONObject json = new JSONObject();
        json.put("takeTaskId", "0");
        json.put("clientId", "25");
        json.put("taskId", "23");

        MultipartPostMethod postMethod = new MultipartPostMethod(host + "clientsumbit.html");
        postMethod.addPart(new StringPart("json", DesUtils.getEncString(json.toJSONString())));
        postMethod.addPart(new StringPart("content", "任务做完了3", "UTF-8"));

        File file1 = new File("C:\\Users\\Administrator\\Desktop\\code.png");
        FilePart filePart1 = new FilePart("submit_image_1", file1);
        postMethod.addPart(filePart1);

//        File file2 = new File("C:\\Users\\Administrator\\Desktop\\code.png");
//        FilePart filePart2 = new FilePart("submit_image_2", file2);
//        postMethod.addPart(filePart2);
//
//        File file3 = new File("C:\\Users\\Administrator\\Desktop\\code.png");
//        FilePart filePart3 = new FilePart("submit_image_3", file3);
//        postMethod.addPart(filePart3);

        String result = client.httpPostRequest(postMethod);
        System.out.println(result);
    }

    /**
     * 查看自己的任务历史
     */
    @Test
    public void testOwnTask() throws Exception {
        HttpClientServiceImpl client = new HttpClientServiceImpl();

        JSONObject json = new JSONObject();
        json.put("clientId", "25");
        json.put("current", "1");
        String parameter = DesUtils.getEncString(json.toJSONString());

        String result = client.httpGetRequestForString(host + "clientowntask.html?json=" + parameter);
        System.out.println(result);
    }

    /**
     * 体现申请
     */
    @Test
    public void testTiXian() throws Exception {
        HttpClientServiceImpl client = new HttpClientServiceImpl();

        JSONObject json = new JSONObject();
        json.put("clientId", "15");
        json.put("money", "1");
        json.put("account", "655399873939834");
        json.put("way", "BANK");
        json.put("password", "80874042");
        String parameter = DesUtils.getEncString(json.toJSONString());

        String result = client.httpGetRequestForString(host + "clienttixian.html?json=" + parameter + "&realname=" + URLEncoder.encode("王昆", "utf-8"));

        System.out.println(result);
    }

    /**
     * 查看自己的体现历史（个人资产）
     */
    @Test
    public void testClientResource() throws Exception {
        HttpClientServiceImpl client = new HttpClientServiceImpl();

        JSONObject json = new JSONObject();
        json.put("clientId", "15");
        json.put("current", "1");
        String parameter = DesUtils.getEncString(json.toJSONString());

        String result = client.httpGetRequestForString(host + "resource.html?json=" + parameter);
        System.out.println(result);
    }

    /**
     * 查看自己的体现历史（个人资产）
     */
    @Test
    public void testClientLeftMoney() throws Exception {
        HttpClientServiceImpl client = new HttpClientServiceImpl();

        JSONObject json = new JSONObject();
        json.put("clientId", "15");
        String parameter = DesUtils.getEncString(json.toJSONString());

        String result = client.httpGetRequestForString(host + "leftm.html?json=" + parameter);
        System.out.println(result);
    }

    /**
     * 查看自己的体现历史（个人资产）
     */
    @Test
    public void testClientMoneyHistory() throws Exception {
        HttpClientServiceImpl client = new HttpClientServiceImpl();

        JSONObject json = new JSONObject();
        json.put("clientId", "6");
        json.put("current", "1");
        String parameter = DesUtils.getEncString(json.toJSONString());

        String result = client.httpGetRequestForString(host + "mutation.html?json=" + parameter);
        System.out.println(result);
    }

    /**
     * 粉丝总体信息
     */
    @Test
    public void testFenSiGeneral() throws Exception {
        HttpClientServiceImpl client = new HttpClientServiceImpl();

        JSONObject json = new JSONObject();
        json.put("clientId", "15");
        String parameter = DesUtils.getEncString(json.toJSONString());

        String result = client.httpGetRequestForString(host + "fensigeneral.html?json=" + parameter);
        System.out.println(result);
    }

    /**
     * 粉丝详细信息
     */
    @Test
    public void testFenSiDetails() throws Exception {
        HttpClientServiceImpl client = new HttpClientServiceImpl();

        JSONObject json = new JSONObject();
        json.put("clientId", "15");
        json.put("current", "1");
        String parameter = DesUtils.getEncString(json.toJSONString());

        String result = client.httpGetRequestForString(host + "fensidetails.html?json=" + parameter);
        System.out.println(result);
    }

    /**
     * 粉丝详细信息
     */
    @Test
    public void testSubmitThridPartMutation() throws Exception {
        HttpClientServiceImpl client = new HttpClientServiceImpl();

        JSONObject json = new JSONObject();
        json.put("total", "15");
        json.put("clientId", "1");
        json.put("thirdWay", "T_DUOMENG");
        String parameter = DesUtils.getEncString(json.toJSONString());

        String result = client.httpGetRequestForString(host + "thirdpart.html?json=" + parameter + "&desc=" + URLEncoder.encode("我下载了一个APP", "utf-8"));

        System.out.println(result);
    }
}
