package com.changhong.system.repository;

import com.changhong.common.utils.AppInfoUtils;
import com.changhong.common.utils.CHStringUtils;
import com.changhong.common.utils.NumberUtils;
import com.changhong.system.domain.AppCategory;
import com.changhong.system.domain.AppDownloadHistory;
import com.changhong.system.domain.MarketApp;
import junit.framework.TestCase;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.methods.StringRequestEntity;
import org.hibernate.SQLQuery;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.classic.Session;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;
import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Random;

/**
 * User: Jack Wang
 * Date: 14-4-29
 * Time: 下午4:12
 */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"/database.xml", "/applicationContext.xml"})
public class StatisticDaoImplTest extends TestCase {
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
    public void testInsertManyData() {
        List<AppCategory> parents = hibernateTemplate.find("from AppCategory a where a.parent is null");
        for (AppCategory parent : parents) {
            System.out.println("一级类别:" + parent.getCategoryName() + "-------------------------------------------------------------------");
            List<AppCategory> children = hibernateTemplate.find("from AppCategory a where a.parent != null and a.parent.id = ?", new Object[]{parent.getId()});
            for (AppCategory child : children) {
                System.out.println("    二级类别:" + child.getCategoryName());
                List<MarketApp> apps = hibernateTemplate.find("from MarketApp a where a.appCategory.id = ?", new Object[]{child.getId()});
                int i = 1;
                for (MarketApp app : apps) {
                    System.out.println(i++ + "-" + app.getAppName());
                }
            }
        }


    }

    @Test
    public void testUpdateDownloadTimes() {
        List<MarketApp> apps = hibernateTemplate.find("from MarketApp a");
        for (MarketApp app : apps) {
            app.setDownloadTimes(NumberUtils.generateRandomNumber(10000000));
        }
        hibernateTemplate.saveOrUpdateAll(apps);
    }

    @Test
    public void testFindApkInfoNotMatch() {
        int i = 0;
        File file = null;

        List<MarketApp> apps = hibernateTemplate.find("from MarketApp a");
        for (MarketApp app : apps) {
            file = new File("D:\\ChangHong\\Projects\\App_Market\\application\\tomcat\\webapps\\appmarket\\upload\\" + app.getAppKey(), app.getAppFile().getActualFileName());
            Map<String, String> map = AppInfoUtils.obtainApkInfo(file.getAbsolutePath(), false);

            if(!map.get("versionCode").equals(app.getAppVersionInt() + "") || !map.get("versionName").equals(app.getAppVersion()) || !map.get("packageName").equals(app.getAppPackage())) {
                i++;
                System.out.println(app.getId() + ":" + app.getAppName() + " info not match: versionCode[" + app.getAppVersionInt() + "->" + map.get("versionCode") + "] versionName[" + app.getAppVersion() + "->" + map.get("versionName") + "] package[" + app.getAppPackage() + "->" + map.get("packageName") + "]");
            }
        }
        hibernateTemplate.saveOrUpdateAll(apps);
    }
}
