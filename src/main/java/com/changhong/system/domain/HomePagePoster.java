package com.changhong.system.domain;

import org.springframework.web.multipart.MultipartFile;

/**
 * User: pengjie
 * Date: 2016/3/15
 * Time: 13:42
 */
public class HomePagePoster extends Document {

    public HomePagePoster() {
    }

    public HomePagePoster(MultipartFile file, String actualFilePath) {
        super(file, actualFilePath);
    }
}
