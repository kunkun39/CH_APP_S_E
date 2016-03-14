package com.changhong.system.repository;

import com.changhong.common.repository.HibernateEntityObjectDao;
import com.changhong.system.domain.*;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;

import java.util.List;

/**
 * User: Jack Wang
 * Date: 14-4-9
 * Time: 上午9:26
 */
@Repository("userDao")
public class UserDaoImpl extends HibernateEntityObjectDao implements UserDao {

    public UserDetails findUserByName(String username) {
        List<User> users = getHibernateTemplate().find("from User u where u.username = ? and u.enabled = true", username);
        return users.isEmpty() ? null : users.get(0);
    }

    public List<User> loadUsers(String name, int startPosition, int pageSize) {
        StringBuilder builder = new StringBuilder();
        builder.append("from User u");
        if (StringUtils.hasText(name)) {
            builder.append(" where u.name like '%" + name + "%' or u.username like '%" + name + "%'");
        }

        Session session = getHibernateTemplate().getSessionFactory().getCurrentSession();
        Query query = session.createQuery(builder.toString());
        query.setMaxResults(pageSize);
        query.setFirstResult(startPosition);

        List<User> users = query.list();
        return users;
    }

    public int loadUserSize(String name) {
        StringBuilder builder = new StringBuilder();
        builder.append("select count(u.id) from User u");
        if (StringUtils.hasText(name)) {
            builder.append(" where u.name like '%" + name + "%' or u.username like '%" + name + "%'");
        }
        List list =  getHibernateTemplate().find(builder.toString());
        return ((Long)list.get(0)).intValue();
    }

    public boolean loadUserExist(int userId, String username) {
        if (userId < 0) {
            List list = getHibernateTemplate().find("select count(u.id) from User u where u.username = ?", username);
            return ((Long)list.get(0)).intValue() > 0 ? true : false;
        } else {
            List list = getHibernateTemplate().find("select count(u.id) from User u where u.username = ? and u.id <> ?",
                    new Object[]{username, userId});
            return ((Long)list.get(0)).intValue() > 0 ? true : false;
        }
    }

    /***********************************************客户部分**********************************************************/

    public List<VipGroup> loadAllVipGroups() {
        return getHibernateTemplate().find("from VipGroup");
    }

    public List<Client> loadClients(String contactName, int startPosition, int pageSize) {
        StringBuilder builder = new StringBuilder();
        builder.append("from Client c");
        if (StringUtils.hasText(contactName)) {
            builder.append(" where c.macFrom <= '" + contactName + "' and c.macTo >= '" + contactName + "'");
        }

        Session session = getHibernateTemplate().getSessionFactory().getCurrentSession();
        Query query = session.createQuery(builder.toString());
        query.setMaxResults(pageSize);
        query.setFirstResult(startPosition);

        List<Client> clients = query.list();
        return clients;
    }

    public int loadClientSize(String contactName) {
        StringBuilder builder = new StringBuilder();
        builder.append("select count(c.id) from Client c");
        if (StringUtils.hasText(contactName)) {
            builder.append(" where c.macFrom <= '" + contactName + "' and c.macTo >= '" + contactName + "'");
        }
        List list =  getHibernateTemplate().find(builder.toString());
        return ((Long)list.get(0)).intValue();
    }

    /***********************************************VIP部分**********************************************************/

    public int loadVipGroupSize(String groupName) {
        StringBuilder builder = new StringBuilder();
        builder.append("select count(v.id) from VipGroup v");
        if (StringUtils.hasText(groupName)) {
            builder.append(" where v.groupName like '%" + groupName + "%'");
        }
        List list =  getHibernateTemplate().find(builder.toString());
        return ((Long)list.get(0)).intValue();
    }

    public List<VipGroup> loadVipGroups(String groupName, int startPosition, int pageSize) {
        StringBuilder builder = new StringBuilder();
        builder.append("from VipGroup v");
        if (StringUtils.hasText(groupName)) {
            builder.append(" where v.groupName like '%" + groupName + "%'");
        }

        Session session = getHibernateTemplate().getSessionFactory().getCurrentSession();
        Query query = session.createQuery(builder.toString());
        query.setMaxResults(pageSize);
        query.setFirstResult(startPosition);

        List<VipGroup> vips = query.list();
        return vips;
    }

    public List<MarketApp> loadVipGroupRelations(int groupId) {
        return getHibernateTemplate().find("select distinct(m) from MarketApp m left join m.vipGroups g where g.id = ?", new Object[]{groupId});
    }

    public int loadVipMemberSize(int groupId, String filterMac) {
        StringBuilder builder = new StringBuilder();
        builder.append("select count(v.id) from VipMember v where v.vipGroup.id = " + groupId);
        if (StringUtils.hasText(filterMac)) {
            builder.append(" and v.boxMac like '%" + filterMac + "%'");
        }
        List list =  getHibernateTemplate().find(builder.toString());
        return ((Long)list.get(0)).intValue();
    }

    public List<VipMember> loadVipMembers(int groupId, String filterMac, int startPosition, int pageSize) {
        StringBuilder builder = new StringBuilder();
        builder.append("from VipMember v where v.vipGroup.id = " + groupId);
        if (StringUtils.hasText(filterMac)) {
            builder.append(" and v.boxMac like '%" + filterMac + "%'");
        }

        Session session = getHibernateTemplate().getSessionFactory().getCurrentSession();
        Query query = session.createQuery(builder.toString());
        query.setMaxResults(pageSize);
        query.setFirstResult(startPosition);

        List<VipMember> vips = query.list();
        return vips;
    }

    public boolean obtainMemberAlreadyAddInGroup(int groupId, String boxMac) {
        StringBuilder builder = new StringBuilder();
        builder.append("select count(v.id) from VipMember v where v.vipGroup.id = " + groupId + " and boxMac = '" + boxMac + "'");
        List list =  getHibernateTemplate().find(builder.toString());
        int number = ((Long)list.get(0)).intValue();
        return number > 0 ? true : false;
    }
}
