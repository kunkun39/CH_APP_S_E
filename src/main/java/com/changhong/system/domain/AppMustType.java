package com.changhong.system.domain;

/**
 * User: Jack Wang
 * Date: 16-6-12
 * Time: 上午9:18
 */
public enum AppMustType {

    INSTALL("强制安装"),
    UN_INSTALL("强制卸载"),
    UPDATE("强制更新");

    private String description;

    AppMustType(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
