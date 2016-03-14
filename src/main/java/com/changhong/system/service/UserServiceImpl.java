package com.changhong.system.service;

import com.changhong.system.domain.*;
import com.changhong.system.repository.UserDao;
import com.changhong.system.web.facade.dto.*;
import com.changhong.system.web.facade.assember.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * User: Jack Wang
 * Date: 14-4-9
 * Time: 上午9:20
 */
@Service("userService")
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDao userDao;

    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException, DataAccessException {
        return userDao.findUserByName(username);
    }

    public UserDTO obtainUserById(int userId) {
        User user = (User) userDao.findById(userId, User.class);
        return UserWebAssember.toUserDTO(user);
    }

    public List<UserDTO> obtainUsers(String name, int startPosition, int pageSize) {
        List<User> users = userDao.loadUsers(name, startPosition, pageSize);
        return UserWebAssember.toUserDTOList(users);
    }

    public int obtainUserSize(String name) {
        return userDao.loadUserSize(name);
    }

    public boolean obtainUserExist(int id, String username) {
        return userDao.loadUserExist(id, username);
    }

    public void changeUserDetails(UserDTO userDTO) {
        User user = UserWebAssember.toUserDomain(userDTO);
        userDao.persist(user);
    }

    public void changeStatusForUser(int userId) {
        User user = (User) userDao.findById(userId, User.class);
        if("chappadmin".equals(user.getUsername())) {
            return;
        }

        if (user.isEnabled()) {
            user.setEnabled(false);
        } else {
            user.setEnabled(true);
        }
    }

    public UserPasswordDTO obtainUserPassword(int userId) {
        User user = (User) userDao.findById(userId, User.class);
        return UserWebAssember.toPasswordDTO(user);
    }

    public boolean obtainOldPasswordRight(int userId, String oldPassword) {
        User user = (User) userDao.findById(userId, User.class);
        return user.getPassword().equals(oldPassword) ? true : false;
    }

    public void changeUserPassword(int userId, String newPassword) {
        User user = (User) userDao.findById(userId, User.class);
        user.setPassword(newPassword);
    }

    /***********************************************客户部分**********************************************************/

    public List<ClientDTO> obtainClients(String contactName, int startPosition, int pageSize) {
        List<Client> clients = userDao.loadClients(contactName, startPosition, pageSize);
        return ClientWebAssember.toClientDTOList(clients);
    }

    public int obtainClientSize(String contactName) {
        return userDao.loadClientSize(contactName);
    }

    public ClientDTO obtainClientById(int clientId) {
        Client client = (Client) userDao.findById(clientId, Client.class);
        return ClientWebAssember.toClientDTO(client);
    }

    public void changeClientDetails(ClientDTO clientDTO) {
        Client client = ClientWebAssember.toClientDomain(clientDTO);
        userDao.saveOrUpdate(client);
    }

    public void saveImportClients(String clientFrom, String clientTo) {
        try {
            Thread.sleep(10000);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deleteClientMacRange(int clientId) {
        Client client = (Client) userDao.findById(clientId, Client.class);
        userDao.delete(client);
    }

    /***********************************************VIP部分**********************************************************/

    public List<VipGroupDTO> obtainAllVipGroups() {
        List<VipGroup> groups = userDao.loadAllVipGroups();
        return VipWebAssember.toVipGroupDTOList(groups);
    }

    public int obtainVipGroupSize(String filterName) {
        return userDao.loadVipGroupSize(filterName);
    }

    public List<VipGroupDTO> obtainVipGroups(String filterName, int startPosition, int pageSize) {
        List<VipGroup> vipGroups = userDao.loadVipGroups(filterName, startPosition, pageSize);
        return VipWebAssember.toVipGroupDTOList(vipGroups);
    }

    public VipGroupDTO obtainVipGroupById(int groupId) {
        VipGroup group = (VipGroup) userDao.findById(groupId, VipGroup.class);
        return VipWebAssember.toVipGroupDTO(group);
    }

    public void changeVipGroupDetails(VipGroupDTO vipGroupDTO) {
        VipGroup group = VipWebAssember.toVipGroupDomain(vipGroupDTO);
        userDao.saveOrUpdate(group);
    }

    public void deleteVipGroup(int groupId) {
        VipGroup group = (VipGroup) userDao.findById(groupId, VipGroup.class);

        List<MarketApp> marketApps = userDao.loadVipGroupRelations(groupId);
        for (MarketApp marketApp : marketApps) {
            List<VipGroup> groups = marketApp.getVipGroups();
            groups.remove(group);
            if (groups.isEmpty()) {
                marketApp.setVip(false);
            }
        }
        userDao.saveAll(marketApps);

        userDao.delete(group);
    }

    public int obtainVipMemberSize(int groupId, String filterMac) {
        return userDao.loadVipMemberSize(groupId, filterMac);
    }

    public List<VipMemberDTO> obtainVipMembers(int groupId, String filterMac, int startPosition, int pageSize) {
        List<VipMember> members = userDao.loadVipMembers(groupId, filterMac, startPosition, pageSize);
        return VipWebAssember.toVipMemberDTOList(members);
    }

    public void saveVipMember(int groupId, String boxMac) {
        VipMember member = new VipMember(boxMac, groupId);
        userDao.saveOrUpdate(member);
    }

    public boolean obtainMemberAlreadyAddInGroup(int groupId, String boxMac) {
        return userDao.obtainMemberAlreadyAddInGroup(groupId, boxMac);
    }

    public void deleteVipMember(int memberId) {
        VipMember member = (VipMember) userDao.findById(memberId, VipMember.class);
        userDao.delete(member);
    }
}
