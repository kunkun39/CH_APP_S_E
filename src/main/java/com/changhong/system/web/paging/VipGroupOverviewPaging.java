package com.changhong.system.web.paging;

import com.changhong.system.service.UserService;
import com.changhong.system.web.facade.dto.VipGroupDTO;

import java.util.List;

/**
 * User: Jack Wang
 * Date: 14-4-9
 * Time: 上午10:34
 */
public class VipGroupOverviewPaging extends AbstractPaging<VipGroupDTO> {

    private UserService userService;

    private String filterName;

    public VipGroupOverviewPaging(UserService userService) {
        this.userService = userService;
    }

    public List<VipGroupDTO> getItems() {
        return userService.obtainVipGroups(filterName, getStartPosition(), getPageSize());
    }

    public long getTotalItemSize() {
        if (totalItemSize >= 0) {
            return totalItemSize;
        }
        totalItemSize = userService.obtainVipGroupSize(filterName);
        return totalItemSize;
    }

    public String getParameterValues() {
        return "&filterName=" + getFilterName();
    }

    public String getFilterName() {
        return filterName;
    }

    public void setFilterName(String filterName) {
        this.filterName = filterName;
    }
}

