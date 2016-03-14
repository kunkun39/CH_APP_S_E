package com.changhong.system.web.paging;

import com.changhong.system.service.UserService;
import com.changhong.system.web.facade.dto.VipMemberDTO;

import java.util.List;

/**
 * User: Jack Wang
 * Date: 14-4-9
 * Time: 上午10:34
 */
public class VipMemberOverviewPaging extends AbstractPaging<VipMemberDTO> {

    private UserService userService;

    private int groupId;

    private String filterMac;

    public VipMemberOverviewPaging(UserService userService) {
        this.userService = userService;
    }

    public List<VipMemberDTO> getItems() {
        return userService.obtainVipMembers(groupId, filterMac, getStartPosition(), getPageSize());
    }

    public long getTotalItemSize() {
        if (totalItemSize >= 0) {
            return totalItemSize;
        }
        totalItemSize = userService.obtainVipMemberSize(groupId, filterMac);
        return totalItemSize;
    }

    public String getParameterValues() {
        return "&groupId=" + getGroupId() + "&filterMac=" + getFilterMac();
    }

    public int getGroupId() {
        return groupId;
    }

    public void setGroupId(int groupId) {
        this.groupId = groupId;
    }

    public String getFilterMac() {
        return filterMac;
    }

    public void setFilterMac(String filterMac) {
        this.filterMac = filterMac;
    }
}

