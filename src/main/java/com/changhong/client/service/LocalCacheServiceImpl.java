package com.changhong.client.service;

import com.changhong.common.utils.CHPagingUtils;
import com.changhong.common.utils.DesUtils;
import com.changhong.common.utils.NumberUtils;
import com.changhong.system.domain.*;
import com.changhong.system.repository.AppDao;
import com.changhong.system.repository.SystemDao;
import com.changhong.system.web.facade.assember.*;
import com.changhong.system.web.facade.dto.*;
import com.javacodegeeks.concurrent.ConcurrentLinkedHashMap;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Set;

/**
 * User: Peng Jie
 */
@Service("localcacheService")
public class LocalCacheServiceImpl implements CacheService {

    private final static Logger log = LogManager.getLogger(LocalCacheServiceImpl.class);

    private static final int MAX_CACHE_SIZE = 10000;

    @Autowired
    private AppDao appDao;

    @Autowired
    private SystemDao systemDao;

    private ConcurrentLinkedHashMap<String, AppCategoryDTO> categoryCache = new ConcurrentLinkedHashMap<String, AppCategoryDTO>(200);

    private ConcurrentLinkedHashMap<String, AppTopicDTO> topicCache = new ConcurrentLinkedHashMap<String, AppTopicDTO>(200);

    private ConcurrentLinkedHashMap<String, MarketAppDTO> appCache = new ConcurrentLinkedHashMap<String, MarketAppDTO>(MAX_CACHE_SIZE);

    private ConcurrentLinkedHashMap<String, LuncherRecommendDTO> luncherCache = new ConcurrentLinkedHashMap<String, LuncherRecommendDTO>(20);

    private ConcurrentLinkedHashMap<String, AppMustDTO> mustAppCache = new ConcurrentLinkedHashMap<String, AppMustDTO>(20);

    private ConcurrentLinkedHashMap<String, String> multipHosts =  new ConcurrentLinkedHashMap<String, String>(10);

    private ConcurrentLinkedHashMap<String, HomePagePosterDTO> posterCache =  new ConcurrentLinkedHashMap<String, HomePagePosterDTO>(10);

    private String bootImageFileName = "initial.png";

    private int currentClientApkVersion = 1;

    private boolean clientBeginUpdate = false;

    public void obtainInitCachedObjects() {
        long begin = System.currentTimeMillis();

        /**
         * 缓存APP
         */
        int totalApps = appDao.loadMarketAppSize("", -1, -1, -1, "ALL");
        CHPagingUtils paging = new CHPagingUtils(totalApps);
        int totalPages = paging.getNumPages();

        for (int currentPage = 1; currentPage <= totalPages; currentPage++) {
            paging.setCurrentPage(currentPage + "");

            List<MarketApp> apps = appDao.loadMarketApps("", -1, -1, -1, "ALL", paging.getStartPosition(), paging.getMaxItems());
            for (MarketApp app : apps) {
                MarketAppDTO dto = MarketAppWebAssember.toMarketAppDTO(app);
                appCache.put("APP_" + dto.getId(), dto);
            }
        }
        log.info("finish init apps with objects count " + appCache.size());

        /**
         * 缓存CATEGORY
         */
        List<AppCategory> categories = appDao.loadAllCategory();
        List<AppCategoryDTO> dtos = AppCategoryWebAssember.toAppCategoryDTOList(categories, false);
        for (AppCategoryDTO dto : dtos) {
            categoryCache.put("CATE_" + dto.getId(), dto);
        }
        log.info("finish init category with objects count " + categoryCache.size());

        /**
         * 缓存TOPIC
         */
        List<AppTopic> topics = appDao.loadAllTopics();
        List<AppTopicDTO> topicDTOs = AppTopicWebAssember.toAppTopicDTOList(topics);
        for (AppTopicDTO dto : topicDTOs) {
            topicCache.put("TOP_" + dto.getId(), dto);
        }
        log.info("finish init topic with objects count " + topicCache.size());

         /**
         * 缓存Luncher
         */
        List<LuncherRecommend> recommends = appDao.loadAllLuncherRecommend();
        List<LuncherRecommendDTO> recommendDTOs = LuncherRecommendWebAssember.toLuncherRecommendDTOList(recommends);
        for (LuncherRecommendDTO dto : recommendDTOs) {
            luncherCache.put("LUN_" + dto.getId(), dto);
        }
        log.info("finish init luncher recommend with objects count " + luncherCache.size());

         /**
         * 强制应用
         */
        List<AppMust> appMusts = appDao.loadAllAppMust();
        List<AppMustDTO> appMustDTOs = AppMustWebAssember.toAppMustDTOList(appMusts);
        for (AppMustDTO dto : appMustDTOs) {
            mustAppCache.put("MUST_" + dto.getId(), dto);
        }
        log.info("finish init must app with objects count " + mustAppCache.size());

        /**
         * 强制应用
         */
        ClientBootImage bootImage = (ClientBootImage) appDao.findById(1, ClientBootImage.class);
        bootImageFileName = bootImage.getActualFileName();
        log.info("finish init boot image");

        /**
         * 系统当前版本
         */
        ClientVersion clientVersion = systemDao.findClientVersion();
        currentClientApkVersion = clientVersion.getClientVersion();
        clientBeginUpdate = clientVersion.isBeginUpdate();
        log.info("finish init client version");

        /**
         * 所有的HOST
         */
        List<MultipHost> hosts = systemDao.loadAllMultipHosts();
        for (MultipHost host : hosts) {
            multipHosts.put("HOST_" + host.getId(), DesUtils.getEncString(host.getHostName()));
        }
        log.info("finish init multip host");

        /**
         * 首页海报
         */
        List<HomePagePoster> posters = appDao.loadAllHomePagePoster();
        List<HomePagePosterDTO> posterDTOs = HomePagePosterWebAssember.toMarketAppDTOList(posters);
        for (HomePagePosterDTO dto : posterDTOs) {
            posterCache.put("POSTER_" + dto.getId(), dto);
        }
        log.info("finish init home page poster with objects count " + posterCache.size());

        long end = System.currentTimeMillis();
        long during = end - begin;
        log.info("finish init all in " + during + "ms");
    }

    /************************************文件服务器************************************/

    public void resetMultipHost(int hostId, String hostName, boolean remove) {
        if (remove) {
            multipHosts.remove("HOST_" + hostId);
        } else {
            multipHosts.put("HOST_" + hostId, DesUtils.getEncString(hostName));
        }
    }

    public String getRandomMutipHost() {
        if (!multipHosts.isEmpty()) {
            List<String> keys = new ArrayList<String>(multipHosts.keySet());
            int index = NumberUtils.generateRandomNumber(keys.size());
            return multipHosts.get(keys.get(index));
        }
        return null;
    }

    /************************************专题和类别部分************************************/

    public void resetAppCategoryInCache(AppCategoryDTO dto, boolean remove) {
        if (remove) {
            categoryCache.remove("CATE_" + dto.getId());
        } else {
            categoryCache.put("CATE_" + dto.getId(), dto);
        }
    }

    public void processDestoryCached() {
        //do nothing
    }

    public Collection<AppCategoryDTO> obtainAllCategories() {
        return categoryCache.values();
    }

    public void resetAppTopicInCache(AppTopicDTO dto, boolean remove) {
        if (remove) {
            topicCache.remove("TOP_" + dto.getId());
        } else {
            topicCache.put("TOP_" + dto.getId(), dto);
        }
    }

    public Collection<AppTopicDTO> obtainAllTopics() {
        return topicCache.values();
    }

    /************************************App部分************************************/

    public void resetMarketAppInCache(MarketAppDTO dto) {
        appCache.put("APP_" + dto.getId(), dto);

        //如果APP MUST里面有，同样会更新
        Set<String> mustKeys = mustAppCache.keySet();
        if (mustKeys != null) {
            for (String mustKey : mustKeys) {
                AppMustDTO appMustDTO = mustAppCache.get(mustKey);
                if (appMustDTO.getAppId() == dto.getId()) {
                    AppMustWebAssember.resetAppMustDTO(appMustDTO, dto);
                }
            }
        }
    }

    public MarketAppDTO obtainMarketAppInCache(int appId) {
        MarketAppDTO dto = appCache.get("APP_" + appId);
        if (dto != null) {
            return dto;
        }

        log.info("not get app from cache for id " + appId);
        MarketApp app = (MarketApp) appDao.findById(appId, MarketApp.class);
        if(app != null) {
            dto =  MarketAppWebAssember.toMarketAppDTO(app);
            appCache.put("APP_" + appId, dto);
        }
        return dto;
    }

    public List<MarketAppDTO> obtainMarketAppInCache(String[] appPackages) {
        List<MarketAppDTO> apps = new ArrayList<MarketAppDTO>(appPackages.length);

        for (String appPackage : appPackages) {
            boolean find = false;

            for (MarketAppDTO dto : appCache.values()) {
                if (dto.getAppPackage().equals(appPackage)) {
                    apps.add(dto);
                    find = true;
                }
            }

            if (!find) {
                log.info("not get app from cache for package " + appPackage);
            }
        }

        return apps;
    }

    public List<MarketAppDTO> obtainCachedAppByCategoryId(int categoryId) {
        List<MarketAppDTO> apps = new ArrayList<MarketAppDTO>();
        for (MarketAppDTO dto : appCache.values()) {
            int loopCategoryId = dto.getCategoryId();
            if ((categoryId == loopCategoryId || categoryId == -1) && "PASSED".equals(dto.getStatus())) {
                apps.add(dto);
            }
        }
        return apps;
    }

    public List<MarketAppDTO> obtainCachedAppByTopicId(int topicId) {
        List<MarketAppDTO> apps = new ArrayList<MarketAppDTO>();
        for (MarketAppDTO dto : appCache.values()) {
            List<AppTopicDTO> appTopics = dto.getTopics();
            if (appTopics != null) {
                for (AppTopicDTO appTopic : appTopics) {
                    if (topicId == appTopic.getId() && "PASSED".equals(dto.getStatus())) {
                        apps.add(dto);
                    }
                }
            }
        }
        return apps;
    }

    public List<MarketAppDTO> obtainSearchApps(String keyWords) {
        keyWords = keyWords.toUpperCase();
        int searchNumber = 0;
        List<MarketAppDTO> apps = new ArrayList<MarketAppDTO>();
        for (MarketAppDTO dto : appCache.values()) {
            String fullName = dto.getPinYingFull();
            String shortName = dto.getPinYingShort();
            if ((fullName.startsWith(keyWords) || shortName.startsWith(keyWords)) && "PASSED".equals(dto.getStatus())) {
                apps.add(dto);
                searchNumber++;
                if (searchNumber == 10) {
                    break;
                }
            }
        }
        return apps;
    }

    public int obtainAppCategoryId(int appId) {
        MarketAppDTO dto = obtainMarketAppInCache(appId);
        return dto.getCategoryId();
    }

    public int obtainCategoryFatherId(int categoryId) {
        for (AppCategoryDTO dto : categoryCache.values()) {
            if (dto.getId() == categoryId) {
                return dto.getParentId();
            }
        }
        return -1;
    }

    public void updateAppDownloadTimes(int appId) {
        MarketAppDTO dto = obtainMarketAppInCache(appId);
        dto.setDownloadTimes(dto.getDownloadTimes() + 1);
        resetMarketAppInCache(dto);
    }

    /************************************LUNCHER推荐部分************************************/

    public void resetLuncherRecommendInCache(LuncherRecommendDTO dto, boolean remove) {
        if (remove) {
            luncherCache.remove("LUN_" + dto.getId());
        } else {
            luncherCache.put("LUN_" + dto.getId(), dto);
        }
    }

    public List<LuncherRecommendDTO> obtainLuncherRecommends() {
        return new ArrayList<LuncherRecommendDTO>(luncherCache.values());
    }

    /************************************应用强制升级和卸载************************************/

    public void resetAppMustInCache(AppMustDTO dto, boolean remove) {
        if (remove) {
            mustAppCache.remove("MUST_" + dto.getId());
        } else {
            mustAppCache.put("MUST_" + dto.getId(), dto);
        }
    }

    public List<AppMustDTO> obtainAppMust() {
        return new ArrayList<AppMustDTO>(mustAppCache.values());
    }

    /************************************开机图片************************************/

    public String getBootImageFileName() {
        return bootImageFileName;
    }

    public void setBootImageFileName(String bootImageFileName) {
        this.bootImageFileName = bootImageFileName;
    }

    /************************************系统版本************************************/

    public int getCurrentClientVersion() {
        return currentClientApkVersion;
    }

    public void setCurrentClientVersion(int clientVersion) {
        this.currentClientApkVersion = clientVersion;
    }

    public boolean isClientBeginUpdate() {
        return clientBeginUpdate;
    }

    public void setClientBeginUpdate(boolean clientBeginUpdate) {
        this.clientBeginUpdate = clientBeginUpdate;
    }

    /************************************首页海报************************************/

    @Override
    public void resetHomePagePoster(HomePagePosterDTO dto, boolean remove) {
        if (remove) {
            posterCache.remove("POSTER_" + dto.getId());
        } else {
            posterCache.put("POSTER_" + dto.getId(), dto);
        }
    }

    @Override
    public List<HomePagePosterDTO> obtainHomePagePoster() {
        return new ArrayList<HomePagePosterDTO>(posterCache.values());
    }
}
