package com.changhong.system.web.facade.dto;

import java.io.Serializable;

/**
 * User: pengjie
 * Date: 2016/3/15
 * Time: 14:03
 */
public class HomePagePosterDTO implements Serializable {
    private int id;

    private String posterActualFileName;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getPosterActualFileName() {
        return posterActualFileName;
    }

    public void setPosterActualFileName(String posterActualFileName) {
        this.posterActualFileName = posterActualFileName;
    }
}
