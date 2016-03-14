package com.changhong.system.domain;

import com.changhong.common.domain.EntityBase;

/**
 * User: Jack Wang
 * Date: 16-2-17
 * Time: 上午10:24
 */
public class VipMember extends EntityBase {

    private String boxMac;

    private VipGroup vipGroup;

    public VipMember() {
    }

    public VipMember(String boxMac, int groupId) {
        this.boxMac = boxMac.toLowerCase();
        VipGroup vipGroup = new VipGroup();
        vipGroup.setId(groupId);
        this.vipGroup = vipGroup;
    }

    public String getBoxMac() {
        return boxMac;
    }

    public void setBoxMac(String boxMac) {
        this.boxMac = boxMac;
    }

    public VipGroup getVipGroup() {
        return vipGroup;
    }

    public void setVipGroup(VipGroup vipGroup) {
        this.vipGroup = vipGroup;
    }
}
