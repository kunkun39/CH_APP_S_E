SET FOREIGN_KEY_CHECKS=0;

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