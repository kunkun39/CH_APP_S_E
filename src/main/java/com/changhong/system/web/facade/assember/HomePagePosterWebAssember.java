package com.changhong.system.web.facade.assember;

import com.changhong.system.domain.HomePagePoster;
import com.changhong.system.web.facade.dto.HomePagePosterDTO;

import java.util.ArrayList;
import java.util.List;

/**
 * User: pengjie
 * Date: 2016/3/15
 * Time: 14:12
 */
public class HomePagePosterWebAssember {
    public static HomePagePosterDTO toPosterDTO(HomePagePoster poster) {
        HomePagePosterDTO dto = null;
        if (poster != null) {
            dto = new HomePagePosterDTO();
            dto.setId(poster.getId());
            dto.setPosterActualFileName(poster.getActualFileName());
        }

        return dto;
    }

    public static List<HomePagePosterDTO> toMarketAppDTOList(List<HomePagePoster> posters) {
        List<HomePagePosterDTO> dtos = new ArrayList<HomePagePosterDTO>();
        if (posters != null) {
            for (HomePagePoster app : posters) {
                dtos.add(toPosterDTO(app));
            }
        }
        return dtos;
    }
}
