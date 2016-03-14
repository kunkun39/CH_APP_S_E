package com.changhong.system.repository;

import com.changhong.common.repository.EntityObjectDao;
import com.changhong.system.domain.*;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.List;

/**
 * User: Jack Wang
 * Date: 14-4-9
 * Time: 上午9:25
 */
public interface UserDao extends EntityObjectDao {

    UserDetails findUserByName(String username);

    List<User> loadUsers(String name, int startPosition, int pageSize);

    int loadUserSize(String name);

    boolean loadUserExist(int userId, String username);

    /***********************************************客户部分**********************************************************/

    int loadClientSize(String contactName);

    List<Client> loadClients(String contactName, int startPosition, int pageSize);

    /***********************************************VIP部分**********************************************************/

    List<VipGroup> loadAllVipGroups();

    int loadVipGroupSize(String groupName);

    List<VipGroup> loadVipGroups(String groupName, int startPosition, int pageSize);

    List<MarketApp> loadVipGroupRelations(int groupId);

    int loadVipMemberSize(int groupId, String filterMac);

    List<VipMember> loadVipMembers(int groupId, String filterMac, int startPosition, int pageSize);

    boolean obtainMemberAlreadyAddInGroup(int groupId, String boxMac);
}
