package com.changhong.system.web.facade.assember;

import com.changhong.system.domain.AppMust;
import com.changhong.system.domain.MarketApp;
import com.changhong.system.web.facade.dto.AppMustDTO;
import com.changhong.system.web.facade.dto.MarketAppDTO;

import java.util.ArrayList;
import java.util.List;

/**
 * User: Jack Wang
 * Date: 15-9-25
 * Time: 下午3:06
 */
public class AppMustWebAssember {

    public static AppMustDTO toAppMustDTODTO(AppMust appMust) {
        final int id = appMust.getId();
        final String appMustType = appMust.getAppMustType().name();
        MarketApp app = appMust.getMarketApp();
        final int appId = app.getId();
        final String appKey = app.getAppKey();
        final String appName = app.getAppName();
        final String appVersion = app.getAppVersion();
        final int appVersionInt = app.getAppVersionInt();
        final String iconActualFileName = app.getAppIcon().getActualFileName();
        final String packageName = app.getAppPackage();
        final String apkActualFileName = app.getAppFile().getActualFileName();

        return new AppMustDTO(id, appMustType, appId, appName, appVersion, appVersionInt, appKey, iconActualFileName, packageName, apkActualFileName);
    }

    public static void resetAppMustDTO(AppMustDTO appMustDTO, MarketAppDTO marketAppDTO) {
        final String appName = marketAppDTO.getAppFullName();
        final String appVersion = marketAppDTO.getAppVersion();
        final int appVersionInt = Integer.valueOf(marketAppDTO.getAppVersionInt());
        final String iconActualFileName = marketAppDTO.getIconActualFileName();
        final String packageName = marketAppDTO.getAppPackage();
        final String apkActualFileName = marketAppDTO.getApkActualFileName();

        appMustDTO.setAppName(appName);
        appMustDTO.setAppVersion(appVersion);
        appMustDTO.setAppVersionInt(appVersionInt);
        appMustDTO.setIconActualFileName(iconActualFileName);
        appMustDTO.setPackageName(packageName);
        appMustDTO.setApkActualFileName(apkActualFileName);
    }

    public static List<AppMustDTO> toAppMustDTOList(List<AppMust> appMusts) {
        List<AppMustDTO> dtos = new ArrayList<AppMustDTO>();
        if (appMusts != null) {
            for (AppMust app : appMusts) {
                dtos.add(toAppMustDTODTO(app));
            }
        }
        return dtos;
    }
}
