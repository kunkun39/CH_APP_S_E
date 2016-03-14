package com.changhong.system.domain;

import com.changhong.common.domain.EntityBase;

import java.util.List;

/**
 * User: Jack Wang
 * Date: 16-2-17
 * Time: 上午9:35
 */
public class VipGroup extends EntityBase {

    private String groupName;

    private String groupDesc;

    private List<VipMember> members;

    public VipGroup() {
    }

    public VipGroup(int groupId) {
        setId(groupId);
    }

    public VipGroup(String groupName, String groupDesc) {
        this.groupName = groupName;
        this.groupDesc = groupDesc;
    }

    public String getGroupName() {
        return groupName;
    }

    public void setGroupName(String groupName) {
        this.groupName = groupName;
    }

    public String getGroupDesc() {
        return groupDesc;
    }

    public void setGroupDesc(String groupDesc) {
        this.groupDesc = groupDesc;
    }

    public List<VipMember> getMembers() {
        return members;
    }

    public void setMembers(List<VipMember> members) {
        this.members = members;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        VipGroup vipGroup = (VipGroup) o;

        if (getId() != vipGroup.getId()) return false;

        return true;
    }
}