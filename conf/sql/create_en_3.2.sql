SET FOREIGN_KEY_CHECKS=0;

DROP TABLE IF EXISTS `system_user`;
CREATE TABLE `system_user` (
  `id` int(11) NOT NULL auto_increment,
  `timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `name` varchar(120) collate utf8_bin default NULL,
  `contactway` varchar(255) collate utf8_bin default '',
  `username` varchar(48) collate utf8_bin default '',
  `password` varchar(48) collate utf8_bin default '',
  `enabled` tinyint(1) default '0' COMMENT '1 for YES or 0 for NO',
  PRIMARY KEY  (`id`),
  KEY `system_user_index_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

DROP TABLE IF EXISTS `system_role`;
CREATE TABLE `system_role` (
  `id` int(11) NOT NULL auto_increment,
  `timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `role_type` varchar(255) default NULL,
  `user_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `user_id` (`user_id`),
  KEY `FKA47ECC86493A45AB` (`user_id`),
  CONSTRAINT `FKA47ECC86493A45AB` FOREIGN KEY (`user_id`) REFERENCES `system_user` (`id`),
  CONSTRAINT `system_role_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `system_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `system_client`;
CREATE TABLE `system_client` (
  `id` int(11) NOT NULL auto_increment,
  `timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `mac_from` varchar(17) collate utf8_bin default '',
  `mac_to` varchar(17) collate utf8_bin default '',
  `client_note` text collate utf8_bin,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

DROP TABLE IF EXISTS `multip_host`;
CREATE TABLE `multip_host` (
  `id` int(11) NOT NULL auto_increment,
  `timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `host_name` varchar(240) collate utf8_bin default '',
  `host_enabled` tinyint(1) default '0' COMMENT '1 for YES or 0 for NO',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

DROP TABLE IF EXISTS `boot_image`;
CREATE TABLE `boot_image` (
  `id` int(11) NOT NULL auto_increment,
  `actual_filename` varchar(20) collate utf8_bin default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

DROP TABLE IF EXISTS `client_version`;
CREATE TABLE `client_version` (
  `id` int(11) NOT NULL auto_increment,
  `client_version` int(11) default '1',
  `begin_update` tinyint(1) default '0' COMMENT '1 for YES or 0 for NO',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

DROP TABLE IF EXISTS `box_page_recommend`;
CREATE TABLE `box_page_recommend` (
  `id` int(11) NOT NULL auto_increment,
  `timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `page_number` int(4) NOT NULL,
  `recommend_position` int(11) NOT NULL,
  `recommend_app_id` int(11) default NULL,
  `recommend_tmp_app_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `recommend_app_id` (`recommend_app_id`),
  KEY `recommend_tmp_app_id` (`recommend_tmp_app_id`),
  KEY `FK37E5080051F51698` (`recommend_tmp_app_id`),
  KEY `FK37E508009C881BF0` (`recommend_app_id`),
  CONSTRAINT `FK37E508009C881BF0` FOREIGN KEY (`recommend_app_id`) REFERENCES `market_app` (`id`),
  CONSTRAINT `box_page_recommend_ibfk_1` FOREIGN KEY (`recommend_app_id`) REFERENCES `market_app` (`id`),
  CONSTRAINT `box_page_recommend_ibfk_2` FOREIGN KEY (`recommend_tmp_app_id`) REFERENCES `market_app` (`id`),
  CONSTRAINT `FK37E5080051F51698` FOREIGN KEY (`recommend_tmp_app_id`) REFERENCES `market_app` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

DROP TABLE IF EXISTS `luncher_recommend`;
CREATE TABLE `luncher_recommend` (
  `id` int(11) NOT NULL auto_increment,
  `timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `position` int(11) default '1',
  `app_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `app_id` (`app_id`),
  KEY `FK32C037D4FAA33B0D` (`app_id`),
  CONSTRAINT `FK32C037D4FAA33B0D` FOREIGN KEY (`app_id`) REFERENCES `market_app` (`id`),
  CONSTRAINT `luncher_recommend_ibfk_1` FOREIGN KEY (`app_id`) REFERENCES `market_app` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

DROP TABLE IF EXISTS `recommend_record`;
CREATE TABLE `recommend_record` (
  `id` int(11) NOT NULL auto_increment,
  `timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `user_id` int(11) default '-1',
  `user_name` varchar(40) collate utf8_bin default '',
  `commit` tinyint(1) default '0' COMMENT '1 for YES or 0 for NO',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

DROP TABLE IF EXISTS `app_file`;
CREATE TABLE `app_file` (
  `id` int(11) NOT NULL auto_increment,
  `timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `upload_filename` varchar(100) collate utf8_bin default '',
  `actual_filename` varchar(20) collate utf8_bin default '',
  `actual_filepath` varchar(20) collate utf8_bin default '',
  `upload_time` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

DROP TABLE IF EXISTS `app_icon`;
CREATE TABLE `app_icon` (
  `id` int(11) NOT NULL auto_increment,
  `timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `upload_filename` varchar(100) collate utf8_bin default '',
  `actual_filename` varchar(20) collate utf8_bin default '',
  `actual_filepath` varchar(20) collate utf8_bin default '',
  `upload_time` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

DROP TABLE IF EXISTS `app_poster`;
CREATE TABLE `app_poster` (
  `id` int(11) NOT NULL auto_increment,
  `timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `upload_filename` varchar(100) collate utf8_bin default '',
  `actual_filename` varchar(20) collate utf8_bin default '',
  `actual_filepath` varchar(20) collate utf8_bin default '',
  `upload_time` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

DROP TABLE IF EXISTS `market_app`;
CREATE TABLE `market_app` (
  `id` int(11) NOT NULL auto_increment,
  `timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `createtime` datetime default NULL,
  `app_key` varchar(10) collate utf8_bin default '',
  `app_name` varchar(120) collate utf8_bin default '',
  `app_description` text collate utf8_bin,
  `app_note` text collate utf8_bin,
  `app_version_int` int(11) default '1',
  `app_version` varchar(48) collate utf8_bin default '',
  `app_package` varchar(120) collate utf8_bin default '',
  `download_times` int(11) default '0',
  `app_size` varchar(48) collate utf8_bin default '',
  `app_status` varchar(10) collate utf8_bin default 'CREAETED',
  `app_scores` int(11) default '8',
  `app_recommend` tinyint(1) default '0' COMMENT '1 for YES or 0 for NO',
  `app_pinying_short` varchar(20) collate utf8_bin default '',
  `app_pinying_full` varchar(40) collate utf8_bin default '',
  `app_category_id` int(11) default NULL,
  `app_icon_id` int(11) default NULL,
  `app_file_id` int(11) default NULL,
  `app_poster_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `app_category_id` (`app_category_id`),
  KEY `app_icon_id` (`app_icon_id`),
  KEY `app_file_id` (`app_file_id`),
  KEY `app_poster_id` (`app_poster_id`),
  KEY `market_app_index_name` (`app_name`),
  KEY `market_app_index_key` (`app_key`),
  KEY `market_app_pinying_short` (`app_pinying_short`),
  KEY `market_app_pinying_full` (`app_pinying_full`),
  KEY `FK429CBF9E26791C2C` (`app_category_id`),
  KEY `FK429CBF9E11DA0F4C` (`app_icon_id`),
  KEY `FK429CBF9E7D34CC6C` (`app_file_id`),
  KEY `FK429CBF9EDACC2A4C` (`app_poster_id`),
  CONSTRAINT `FK429CBF9EDACC2A4C` FOREIGN KEY (`app_poster_id`) REFERENCES `app_poster` (`id`),
  CONSTRAINT `FK429CBF9E11DA0F4C` FOREIGN KEY (`app_icon_id`) REFERENCES `app_icon` (`id`),
  CONSTRAINT `FK429CBF9E26791C2C` FOREIGN KEY (`app_category_id`) REFERENCES `app_category` (`id`),
  CONSTRAINT `FK429CBF9E7D34CC6C` FOREIGN KEY (`app_file_id`) REFERENCES `app_file` (`id`),
  CONSTRAINT `market_app_ibfk_1` FOREIGN KEY (`app_category_id`) REFERENCES `app_category` (`id`),
  CONSTRAINT `market_app_ibfk_2` FOREIGN KEY (`app_icon_id`) REFERENCES `app_icon` (`id`),
  CONSTRAINT `market_app_ibfk_3` FOREIGN KEY (`app_file_id`) REFERENCES `app_file` (`id`),
  CONSTRAINT `market_app_ibfk_4` FOREIGN KEY (`app_poster_id`) REFERENCES `app_poster` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

DROP TABLE IF EXISTS `app_topic`;
CREATE TABLE `app_topic` (
  `id` int(11) NOT NULL auto_increment,
  `timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `topic_name` varchar(120) collate utf8_bin default '',
  `topic_icon_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `topic_icon_id` (`topic_icon_id`),
  KEY `FK6DDECD91CDB654F9` (`topic_icon_id`),
  CONSTRAINT `FK6DDECD91CDB654F9` FOREIGN KEY (`topic_icon_id`) REFERENCES `category_icon` (`id`),
  CONSTRAINT `app_topic_ibfk_1` FOREIGN KEY (`topic_icon_id`) REFERENCES `category_icon` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

DROP TABLE IF EXISTS `app_topic_link`;
CREATE TABLE `app_topic_link` (
  `id` int(11) NOT NULL auto_increment,
  `app_id` int(11) default NULL,
  `topic_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `app_id` (`app_id`),
  KEY `topic_id` (`topic_id`),
  KEY `FK5B356DE8290B8D0A` (`topic_id`),
  KEY `FK5B356DE8FAA33B0D` (`app_id`),
  CONSTRAINT `FK5B356DE8FAA33B0D` FOREIGN KEY (`app_id`) REFERENCES `market_app` (`id`),
  CONSTRAINT `app_topic_link_ibfk_1` FOREIGN KEY (`app_id`) REFERENCES `market_app` (`id`),
  CONSTRAINT `app_topic_link_ibfk_2` FOREIGN KEY (`topic_id`) REFERENCES `app_topic` (`id`),
  CONSTRAINT `FK5B356DE8290B8D0A` FOREIGN KEY (`topic_id`) REFERENCES `app_topic` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

DROP TABLE IF EXISTS `category_icon`;
CREATE TABLE `category_icon` (
  `id` int(11) NOT NULL auto_increment,
  `timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `upload_filename` varchar(100) collate utf8_bin default '',
  `actual_filename` varchar(20) collate utf8_bin default '',
  `actual_filepath` varchar(20) collate utf8_bin default '',
  `upload_time` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

DROP TABLE IF EXISTS `app_category`;
CREATE TABLE `app_category` (
  `id` int(11) NOT NULL auto_increment,
  `timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `category_name` varchar(120) collate utf8_bin default '',
  `parent_id` int(11) default NULL,
  `category_icon_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `parent_id` (`parent_id`),
  KEY `category_icon_id` (`category_icon_id`),
  KEY `FKF6E7495C34CC721E` (`parent_id`),
  KEY `FKF6E7495CF61905C8` (`category_icon_id`),
  CONSTRAINT `FKF6E7495CF61905C8` FOREIGN KEY (`category_icon_id`) REFERENCES `category_icon` (`id`),
  CONSTRAINT `app_category_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `app_category` (`id`),
  CONSTRAINT `app_category_ibfk_2` FOREIGN KEY (`category_icon_id`) REFERENCES `category_icon` (`id`),
  CONSTRAINT `FKF6E7495C34CC721E` FOREIGN KEY (`parent_id`) REFERENCES `app_category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

DROP TABLE IF EXISTS `app_download_history`;
CREATE TABLE `app_download_history` (
  `id` int(11) NOT NULL auto_increment,
  `timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `sta_year` int(4) NOT NULL,
  `sta_month` int(2) NOT NULL,
  `sta_day` int(2) NOT NULL,
  `sta_hour` int(2) NOT NULL,
  `box_mac` varchar(17) collate utf8_bin NOT NULL,
  `app_id` int(11) default NULL,
  `app_father_category_id` int(11) default NULL,
  `app_category_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `history_year_index` (`sta_year`),
  KEY `history_month_index` (`sta_month`),
  KEY `history_hour_index` (`sta_hour`),
  KEY `history_app_index` (`app_id`),
  KEY `history_father_category_index` (`app_father_category_id`),
  KEY `history_category_index` (`app_category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

DROP TABLE IF EXISTS `app_change_history`;
CREATE TABLE `app_change_history` (
  `id` int(11) NOT NULL auto_increment,
  `timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `app_id` int(11) default NULL,
  `user_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `app_id` (`app_id`),
  KEY `user_id` (`user_id`),
  KEY `FK7CC53CE3493A45AB` (`user_id`),
  KEY `FK7CC53CE3FAA33B0D` (`app_id`),
  CONSTRAINT `FK7CC53CE3FAA33B0D` FOREIGN KEY (`app_id`) REFERENCES `market_app` (`id`),
  CONSTRAINT `app_change_history_ibfk_1` FOREIGN KEY (`app_id`) REFERENCES `market_app` (`id`),
  CONSTRAINT `app_change_history_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `system_user` (`id`),
  CONSTRAINT `FK7CC53CE3493A45AB` FOREIGN KEY (`user_id`) REFERENCES `system_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

DROP TABLE IF EXISTS `app_change_details`;
CREATE TABLE `app_change_details` (
  `id` int(11) NOT NULL auto_increment,
  `timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `change_field` varchar(40) collate utf8_bin NOT NULL,
  `change_details` varchar(512) collate utf8_bin NOT NULL,
  `history_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `history_id` (`history_id`),
  KEY `FKA25E4A919C92651A` (`history_id`),
  CONSTRAINT `FKA25E4A919C92651A` FOREIGN KEY (`history_id`) REFERENCES `app_change_history` (`id`),
  CONSTRAINT `app_change_details_ibfk_1` FOREIGN KEY (`history_id`) REFERENCES `app_change_history` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

DROP TABLE IF EXISTS `app_must`;
CREATE TABLE `app_must` (
  `id` int(11) NOT NULL auto_increment,
  `timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `install` tinyint(1) default '0' COMMENT '1 for YES or 0 for NO',
  `app_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `app_id` (`app_id`),
  KEY `FK4598BD67FAA33B0D` (`app_id`),
  CONSTRAINT `FK4598BD67FAA33B0D` FOREIGN KEY (`app_id`) REFERENCES `market_app` (`id`),
  CONSTRAINT `app_must_ibfk_1` FOREIGN KEY (`app_id`) REFERENCES `market_app` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

DROP TABLE IF EXISTS `app_backup`;
CREATE TABLE `app_backup` (
  `id` int(11) NOT NULL auto_increment,
  `timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `box_mac` varchar(17) NOT NULL,
  `app_ids` text,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `app_backup_history`;
CREATE TABLE `app_backup_history` (
  `id` int(11) NOT NULL auto_increment,
  `timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `sta_year` int(4) NOT NULL,
  `sta_month` int(2) NOT NULL,
  `sta_day` int(2) NOT NULL,
  `sta_hour` int(2) NOT NULL,
  `box_mac` varchar(17) character set utf8 NOT NULL,
  `opcode` int(2) NOT NULL,
  `app_ids` text character set utf8,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

DROP TABLE IF EXISTS `vip_group`;
CREATE TABLE `vip_group` (
  `id` int(11) NOT NULL auto_increment,
  `timestamp` timestamp default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `group_name` varchar(48) default '',
  `group_desc` text,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

DROP TABLE IF EXISTS `vip_member`;
CREATE TABLE `vip_member` (
  `id` int(11) NOT NULL auto_increment,
  `timestamp` timestamp default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `box_mac` varchar(17) default '',
  `group_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  FOREIGN KEY (`group_id`) REFERENCES vip_group (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

ALTER TABLE `market_app` ADD COLUMN `is_vip` tinyint(1) default '0' COMMENT '1 for YES or 0 for NO';
UPDATE `market_app` set is_vip = 0;

DROP TABLE IF EXISTS `app_vipgroup_link`;
CREATE TABLE `app_vipgroup_link` (
  `id` int(11) NOT NULL auto_increment,
  `app_id` int(11) default NULL,
  `vip_group_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  FOREIGN KEY (`app_id`) REFERENCES market_app (`id`),
  FOREIGN KEY (`vip_group_id`) REFERENCES vip_group (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

SET FOREIGN_KEY_CHECKS=1;