package com.changhong.system.service;

import com.changhong.system.domain.VipGroup;
import com.changhong.system.web.facade.dto.*;
import org.springframework.security.core.userdetails.UserDetailsService;

import java.util.List;

/**
 * User: Jack Wang
 * Date: 14-4-9
 * Time: 上午9:20
 */
public interface UserService extends UserDetailsService {

    UserDTO obtainUserById(int userId);

    List<UserDTO> obtainUsers(String name, int startPosition, int pageSize);

    int obtainUserSize(String name);

    boolean obtainUserExist(int userId, String username);

    void changeUserDetails(UserDTO userDTO);

    void changeStatusForUser(int userId);

    UserPasswordDTO obtainUserPassword(int userId);

    boolean obtainOldPasswordRight(int userId, String oldPassword);

    void changeUserPassword(int userId, String newPassword);

    /***********************************************客户部分**********************************************************/

    int obtainClientSize(String contactName);

    List<ClientDTO> obtainClients(String contactName, int startPosition, int pageSize);

    ClientDTO obtainClientById(int clientId);

    void changeClientDetails(ClientDTO clientDTO);

    void saveImportClients(String clientFrom, String clientTo);

    void deleteClientMacRange(int clientId);

    /***********************************************VIP部分**********************************************************/

    List<VipGroupDTO> obtainAllVipGroups();

    int obtainVipGroupSize(String filterName);

    List<VipGroupDTO> obtainVipGroups(String filterName, int startPosition, int pageSize);

    VipGroupDTO obtainVipGroupById(int groupId);

    void changeVipGroupDetails(VipGroupDTO vipGroupDTO);

    void deleteVipGroup(int groupId);

    int obtainVipMemberSize(int groupId, String filterMac);

    List<VipMemberDTO> obtainVipMembers(int groupId, String filterMac, int startPosition, int pageSize);

    void saveVipMember(int groupId, String boxMac);

    boolean obtainMemberAlreadyAddInGroup(int groupId, String boxMac);

    void deleteVipMember(int memberId);
}
