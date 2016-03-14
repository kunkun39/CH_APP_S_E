package com.changhong.system.web.facade.dto;

/**
 * User: Jack Wang
 * Date: 16-2-17
 * Time: 上午10:55
 */
public class VipMemberDTO {

    private int id;

    private String boxMac;

    private int groupId;

    public VipMemberDTO() {
    }

    public VipMemberDTO(int id, String boxMac, int groupId) {
        this.id = id;
        this.boxMac = boxMac;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getBoxMac() {
        return boxMac;
    }

    public void setBoxMac(String boxMac) {
        this.boxMac = boxMac;
    }

    public int getGroupId() {
        return groupId;
    }

    public void setGroupId(int groupId) {
        this.groupId = groupId;
    }
}
