package com.changhong.system.domain;

/**
 * User: Jack Wang
 * Date: 15-7-30
 * Time: 下午2:34
 */
public enum AppStatus {
    CREAETED("Waiting Verify"),
    PASSED("Already Published"),
    REJECTED("Already Rejected"),
    OFFSHELVES("Not Used");

    private String description;

    AppStatus(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
