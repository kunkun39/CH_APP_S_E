package com.changhong.system.repository;

import com.changhong.common.repository.EntityObjectDao;
import com.changhong.system.domain.*;

import java.util.List;

/**
 * User: Jack Wang
 * Date: 15-7-30
 * Time: 上午9:31
 */
public interface AppDao extends EntityObjectDao {

    /**************************************类别部分****************************************/

    List<AppCategory> loadAllCategory();

    List<AppCategory> loadAllFirstLevelCategory();

    int loadCategoryApps(int categoryId);

    /**
     * 通过methos方法获取该sequence相邻的AppCategory
     * @param sequence
     * @param method 取值：up down
     * @return AppCategory
     */
    AppCategory loadAppCategory(int sequence, String method);

    /**************************************专题部分****************************************/

    List<AppTopic> loadAllTopics();

    void removeConstraintForApp(int topicId);

    /**************************************应用部分****************************************/

    boolean loadAppPackageDuplicate(int marketAppId, String packageName);

    List<MarketApp> loadMarketApps(String appName, int categoryId, int topicId, int groupId, String appStatus, int startPosition, int pageSize);

    int loadMarketAppSize(String appName, int categoryId, int topicId, int groupId, String appStatus);

    List<MarketApp> loadPageAppsByStartNumber(int startNumber);

    List<AppChangeHistory> loadAppChangeHistories(int appId);

    /**************************************推荐部分****************************************/

    List<MarketApp> loadRecommendApps(int categoryId, String appName);

    BoxRecommend loadBoxRecommendPosition(int pageNumber, int recommendPosition);

    List<BoxRecommend> loadAllBoxRecommends();

    BoxRecommend loadCheckIsAppRecommend(int appId, int pageNumber, int recommendPosition);

    /************************************LUNCHER推荐部分************************************/

    List<LuncherRecommend> loadAllLuncherRecommend();

    int loadMaxLuncherRecommendPosition();

    boolean isAppLauncherSet(int appId);

    /************************************应用强制升级和卸载************************************/

    List<AppMust> loadAllAppMust();

    List<AppMust> loadAppMust(boolean install);

    boolean isAppMustSet(int appId);

    /************************************首页海报************************************/

    List<HomePagePoster> loadAllHomePagePoster();
}
