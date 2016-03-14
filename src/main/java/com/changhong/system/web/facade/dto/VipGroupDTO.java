package com.changhong.system.web.facade.dto;

/**
 * User: Jack Wang
 * Date: 16-2-17
 * Time: 上午10:55
 */
public class VipGroupDTO {

    private int id;

    private String groupName;

    private String groupDesc;

    public VipGroupDTO() {
    }

    public VipGroupDTO(int id, String groupName, String groupDesc) {
        this.id = id;
        this.groupName = groupName;
        this.groupDesc = groupDesc;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
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
}
