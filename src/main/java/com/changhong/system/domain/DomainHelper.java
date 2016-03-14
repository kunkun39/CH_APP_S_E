package com.changhong.system.domain;

import com.changhong.common.repository.EntityLoadHolder;
import com.changhong.common.utils.SecurityUtils;
import com.changhong.system.web.facade.dto.MarketAppDTO;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * User: Jack Wang
 * Date: 15-9-1
 * Time: 下午3:07
 */
public class DomainHelper {

    public static AppChangeHistory generateAppChangeHistories(MarketApp app, MarketAppDTO dto) {
        AppChangeHistory history = new AppChangeHistory();
        if (app.getId() <= 0) {
            AppChangeDetails details = new AppChangeDetails("NEW", "");
            history.addChangeDetails(details);
        } else {
            if (!app.getAppName().equals(dto.getAppFullName())) {
                AppChangeDetails details = new AppChangeDetails("App Name", app.getAppName() + " -> " + dto.getAppFullName());
                history.addChangeDetails(details);
            }
            if (app.getAppScores() != dto.getAppScores()) {
                AppChangeDetails details = new AppChangeDetails("App Scores", app.getAppScores() + " -> " + dto.getAppScores());
                history.addChangeDetails(details);
            }
            /**
            if (app.getAppVersionInt() != Integer.valueOf(dto.getAppVersionInt())) {
                AppChangeDetails details = new AppChangeDetails("应用数字版本", app.getAppVersionInt() + " -> " + dto.getAppVersionInt());
                history.addChangeDetails(details);
            }
            if (!app.getAppVersion().equals(dto.getAppVersion())) {
                AppChangeDetails details = new AppChangeDetails("应用版本", app.getAppVersion() + " -> " + dto.getAppVersion());
                history.addChangeDetails(details);
            }
            if (!app.getAppPackage().equals(dto.getAppPackage())) {
                AppChangeDetails details = new AppChangeDetails("应用包名", app.getAppPackage() + " -> " + dto.getAppPackage());
                history.addChangeDetails(details);
            }
            */
            if (app.isRecommend() != dto.isRecommend()) {
                AppChangeDetails details = new AppChangeDetails("App Recommend", "Change recommend status");
                history.addChangeDetails(details);
            }
            if (app.getAppCategory().getId() != dto.getCategoryId()) {
                AppCategory oldCategory = (AppCategory) EntityLoadHolder.getUserDao().findById(dto.getCategoryId(), AppCategory.class);
                AppChangeDetails details = new AppChangeDetails("App Category", app.getAppCategory().getCategoryName() + " -> " + oldCategory.getCategoryName());
                history.addChangeDetails(details);
            }
            if (!dto.getAddTopics().equals(dto.getTopicIds())) {
                AppChangeDetails details = new AppChangeDetails("App Topic", "Change app topic");
                history.addChangeDetails(details);
            }
            if (dto.getIconFile() != null && dto.getIconFile().getSize() > 0) {
                AppChangeDetails details = new AppChangeDetails("App ICON", "upload new icon file");
                history.addChangeDetails(details);
            }
            if (dto.getPosterFile() != null && dto.getPosterFile().getSize() > 0) {
                AppChangeDetails details = new AppChangeDetails("App Poster", "upload new poster file");
                history.addChangeDetails(details);
            }
        }

        return history;
    }

    public static AppChangeHistory generateStatusChangeHistory(MarketApp app, String oldStatus, String newStatus) {
        AppChangeHistory history = new AppChangeHistory();
        User currentUser = new User();
        currentUser.setId(SecurityUtils.currectUserId());
        history.setUser(currentUser);
        history.setApp(app);

        AppChangeDetails details = new AppChangeDetails("App Status", AppStatus.valueOf(oldStatus).getDescription() + " -> " + AppStatus.valueOf(newStatus).getDescription());
        history.addChangeDetails(details);
        return history;
    }

    public static AppChangeDetails generateNewApkFileChangeDetails(MultipartFile newFile, String oldVersion, String newVersion) {
        AppChangeDetails details = null;
        if (newFile != null && newFile.getSize() > 0) {
            details = new AppChangeDetails("App APK File", "upload new app apk file, apk version from " + oldVersion + "to " + newVersion);
        }

        return details;
    }
}
