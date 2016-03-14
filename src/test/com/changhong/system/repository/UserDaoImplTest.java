package com.changhong.system.repository;

import com.changhong.common.utils.CHStringUtils;
import com.changhong.system.domain.Client;
import com.changhong.system.domain.User;
import junit.framework.TestCase;
import org.hibernate.SessionFactory;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * User: Jack Wang
 * Date: 14-11-20
 * Time: 上午8:40
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"/database.xml", "/applicationContext.xml"})
public class UserDaoImplTest extends TestCase {

    @Resource
    SessionFactory sessionFactory;

    @Resource
    UserDaoImpl userDao;

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
    public void testFindUserByName() {
        UserDetails user = userDao.findUserByName("jack");
        assertNull(user);

        User saveUser = new User("jack", "128", "jackwang", "password");
        hibernateTemplate.saveOrUpdate(saveUser);

        user = userDao.findUserByName("jackwang");
        assertNotNull(user);
        assertEquals(user.getUsername(), "jackwang");
        assertEquals(user.getPassword(), "password");

        saveUser.setEnabled(false);
        hibernateTemplate.saveOrUpdate(saveUser);
        user = userDao.findUserByName("jackwang");
        assertNull(user);
    }

    /**
     * mysql take time 117s with 20000
     */
    @Test
    public void testInsertManyData_MYSQL() {
        long start = System.currentTimeMillis();
        for (int i = 0; i < 20000; i++) {
            Client client = new Client("from", "to", CHStringUtils.getRandomString(1));
            hibernateTemplate.save(client);
        }
        long end = System.currentTimeMillis();
        long during = end - start;
        System.out.println("mysql take time " + during);
    }

    /**
     * mysql batch take time 11s with 20000
     * mysql batch take time 3178s with 10000000 with mem 6.8G
     */
    @Test
    public void testInsertBatchManyData_MYSQL() {
        long start = System.currentTimeMillis();
        List<Client> clients = new ArrayList<Client>();
        for (int i = 0; i < 10000000; i++) {
            Client client = new Client("from", "to", CHStringUtils.getRandomString(1));
            clients.add(client);
            if (clients.size() == 50) {
                hibernateTemplate.saveOrUpdateAll(clients);
                hibernateTemplate.flush();
                clients.clear();
                System.out.println(i);
            }
        }
        long end = System.currentTimeMillis();
        long during = end - start;
        System.out.println("mysql take time " + during);
    }
}
