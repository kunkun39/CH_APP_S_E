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
import java.util.ArrayList;
import java.util.List;

/**
 * User: Jack Wang
 * Date: 15-12-2
 * Time: 下午3:06
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"/database.xml", "/applicationContext.xml"})
public class InterfaceActionTest extends TestCase {

    private static final String host = "http://localhost:8080/appmarket/client/bootadvertise.html";
//    private static final String host = "http://chappstore.yuppcdn.net/appmarket/client/bootadvertise.html";

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

    @Test
    public void testSendCode() throws Exception {
        HttpClientServiceImpl client = new HttpClientServiceImpl();
        List<String> macs = new ArrayList<String>();
//        macs.add("00:6c:fd:26:bf:00");
//        macs.add("00:6c:fd:26:bf:01");
//        macs.add("00:6c:fd:26:bf:02");
//        macs.add("00:6c:fd:26:bf:03");
//        macs.add("00:6c:fd:26:bf:04");
//        macs.add("00:6c:fd:26:bf:05");
//        macs.add("00:6c:fd:26:bf:06");
//        macs.add("00:6c:fd:26:bf:07");
//        macs.add("00:6c:fd:26:bf:08");
//        macs.add("00:6c:fd:26:bf:09");
//        macs.add("00:6c:fd:26:bf:0a");
//        macs.add("00:6c:fd:26:bf:0b");
//        macs.add("00:6c:fd:26:bf:0c");
//        macs.add("00:6c:fd:26:bf:0d");
//        macs.add("00:6c:fd:26:bf:0e");
//        macs.add("00:6c:fd:26:bf:0f");
//
//        macs.add("00:6c:fd:26:bf:10");
//        macs.add("00:6c:fd:26:bf:11");
//        macs.add("00:6c:fd:26:bf:12");
//        macs.add("00:6c:fd:26:bf:13");
//        macs.add("00:6c:fd:26:bf:14");
//        macs.add("00:6c:fd:26:bf:15");
//        macs.add("00:6c:fd:26:bf:16");
//        macs.add("00:6c:fd:26:bf:17");
//        macs.add("00:6c:fd:26:bf:18");
//        macs.add("00:6c:fd:26:bf:19");
//        macs.add("00:6c:fd:26:bf:1a");
//        macs.add("00:6c:fd:26:bf:1b");
//        macs.add("00:6c:fd:26:bf:1c");
//        macs.add("00:6c:fd:26:bf:1d");
//        macs.add("00:6c:fd:26:bf:1e");
//        macs.add("00:6c:fd:26:bf:1f");
//
//        macs.add("00:6c:fd:26:bf:20");
//        macs.add("00:6c:fd:26:bf:21");
//        macs.add("00:6c:fd:26:bf:22");
//        macs.add("00:6c:fd:26:bf:23");
//        macs.add("00:6c:fd:26:bf:24");
//        macs.add("00:6c:fd:26:bf:25");
//        macs.add("00:6c:fd:26:bf:26");
//        macs.add("00:6c:fd:26:bf:27");
//        macs.add("00:6c:fd:26:bf:28");
//        macs.add("00:6c:fd:26:bf:29");
//        macs.add("00:6c:fd:26:bf:2a");
//        macs.add("00:6c:fd:26:bf:2b");
//        macs.add("00:6c:fd:26:bf:2c");
//        macs.add("00:6c:fd:26:bf:2d");
//        macs.add("00:6c:fd:26:bf:2e");
//        macs.add("00:6c:fd:26:bf:2f");
//
//        macs.add("00:6c:fd:26:bf:30");
//        macs.add("00:6c:fd:26:bf:31");
//        macs.add("00:6c:fd:26:bf:32");
//        macs.add("00:6c:fd:26:bf:33");
//        macs.add("00:6c:fd:26:bf:34");
//        macs.add("00:6c:fd:26:bf:35");
//        macs.add("00:6c:fd:26:bf:36");
        macs.add("00:6C:FD:26:BF:37");
//        macs.add("00:6c:fd:26:bf:38");
//        macs.add("00:6c:fd:26:bf:39");
        macs.add("00:6c:fd:26:bf:3a");
//        macs.add("00:6c:fd:26:bf:3b");
//        macs.add("00:6c:fd:26:bf:3c");
//        macs.add("00:6c:fd:26:bf:3d");
//        macs.add("00:6c:fd:26:bf:3e");
//        macs.add("00:6c:fd:26:bf:3f");
//
//        macs.add("00:6c:fd:26:bf:40");
//        macs.add("00:6c:fd:26:bf:41");
//        macs.add("00:6c:fd:26:bf:42");
//        macs.add("00:6c:fd:26:bf:43");
//        macs.add("00:6c:fd:26:bf:44");
//        macs.add("00:6c:fd:26:bf:45");
//        macs.add("00:6c:fd:26:bf:46");
//        macs.add("00:6c:fd:26:bf:47");
//        macs.add("00:6c:fd:26:bf:48");
//        macs.add("00:6c:fd:26:bf:49");
//        macs.add("00:6c:fd:26:bf:4a");
//        macs.add("00:6c:fd:26:bf:4b");
//        macs.add("00:6c:fd:26:bf:4c");
//        macs.add("00:6c:fd:26:bf:4d");
//        macs.add("00:6c:fd:26:bf:4e");
//        macs.add("00:6c:fd:26:bf:4f");
//
//        macs.add("00:6c:fd:26:bf:50");
//        macs.add("00:6c:fd:26:bf:51");
//        macs.add("00:6c:fd:26:bf:52");
//        macs.add("00:6c:fd:26:bf:53");
//        macs.add("00:6c:fd:26:bf:54");
//        macs.add("00:6c:fd:26:bf:55");
//        macs.add("00:6c:fd:26:bf:56");
//        macs.add("00:6c:fd:26:bf:57");
//        macs.add("00:6c:fd:26:bf:58");
//        macs.add("00:6c:fd:26:bf:59");
//        macs.add("00:6c:fd:26:bf:5a");
//        macs.add("00:6c:fd:26:bf:5b");
//        macs.add("00:6c:fd:26:bf:5c");
//        macs.add("00:6c:fd:26:bf:5d");
//        macs.add("00:6c:fd:26:bf:5e");
//        macs.add("00:6c:fd:26:bf:5f");

        for (String mac : macs) {
            String encMac = DesUtils.getEncString(mac);
            String result = client.httpGetRequestForString(host + "?boxMac=" + encMac);
            System.out.println(result);
        }
    }

}
