package com.changhong.system.domain;

import com.changhong.common.domain.EntityBase;

/**
 * User: Jack Wang
 * Date: 15-9-29
 * Time: 上午9:40
 */
public class AppMust extends EntityBase {

    //ture stand for must install else stand for uninstall
    private AppMustType appMustType;

    private MarketApp marketApp;

    public AppMust() {
    }

    public AppMust(String appMustType, MarketApp marketApp) {
        this.appMustType = AppMustType.valueOf(appMustType);
        this.marketApp = marketApp;
    }

    public AppMustType getAppMustType() {
        return appMustType;
    }

    public void setAppMustType(AppMustType appMustType) {
        this.appMustType = appMustType;
    }

    public MarketApp getMarketApp() {
        return marketApp;
    }

    public void setMarketApp(MarketApp marketApp) {
        this.marketApp = marketApp;
    }
}
