/*
 Navicat Premium Data Transfer

 Source Server         : 127.0.0.1
 Source Server Type    : MySQL
 Source Server Version : 80012
 Source Host           : 127.0.0.1:3306
 Source Schema         : ypp_sql

 Target Server Type    : MySQL
 Target Server Version : 80012
 File Encoding         : 65001

 Date: 01/10/2018 18:09:16
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for core_account
-- ----------------------------
DROP TABLE IF EXISTS `core_account`;
CREATE TABLE `core_account` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `first_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `last_name` varchar(150) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `email` varchar(254) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `group` varchar(40) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `department` varchar(40) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `auth_group` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `real_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of core_account
-- ----------------------------
BEGIN;
INSERT INTO `core_account` VALUES (1, 'pbkdf2_sha256$100000$wcNV4SbnsmiA$0HBBo9clJD5q8+3Ok325BiIIetT4Kl5h6l+Z0N6Kc7w=', NULL, 0, 'admin', '', 'pass', 'chenwu@yupaopao.cn', 1, 1, '2018-07-26 07:15:33.931971', 'admin', '', 'admin', '');
INSERT INTO `core_account` VALUES (2, 'pbkdf2_sha256$100000$Rc4mlO0GUJiv$C8LppuEtBX5E3aWharyBtPA1ODvKCKK5UGFA87VRWAY=', NULL, 0, 'chenwu', '', '', 'chenwu@yupaopao.cn', 1, 1, '2018-10-01 09:33:31.532803', 'admin', 'DBA', 'admin', '陈武');
INSERT INTO `core_account` VALUES (3, 'pbkdf2_sha256$100000$wcNV4SbnsmiA$0HBBo9clJD5q8+3Ok325BiIIetT4Kl5h6l+Z0N6Kc7w=', NULL, 0, 'test', '', '', 'chenwu@yupaopao.cn', 1, 1, '2018-10-01 09:34:44.037953', 'perform', 'dba', 'admin', 'test');
COMMIT;

-- ----------------------------
-- Table structure for core_account_groups
-- ----------------------------
DROP TABLE IF EXISTS `core_account_groups`;
CREATE TABLE `core_account_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `core_account_groups_account_id_group_id_9e3c433f_uniq` (`account_id`,`group_id`),
  KEY `core_account_groups_group_id_ffac212f_fk_auth_group_id` (`group_id`),
  CONSTRAINT `core_account_groups_account_id_3bd74ec9_fk_core_account_id` FOREIGN KEY (`account_id`) REFERENCES `core_account` (`id`),
  CONSTRAINT `core_account_groups_group_id_ffac212f_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for core_account_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `core_account_user_permissions`;
CREATE TABLE `core_account_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `core_account_user_permis_account_id_permission_id_5d993b63_uniq` (`account_id`,`permission_id`),
  KEY `core_account_user_pe_permission_id_6e106098_fk_auth_perm` (`permission_id`),
  CONSTRAINT `core_account_user_pe_account_id_9fe697ec_fk_core_acco` FOREIGN KEY (`account_id`) REFERENCES `core_account` (`id`),
  CONSTRAINT `core_account_user_pe_permission_id_6e106098_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for core_applygrained
-- ----------------------------
DROP TABLE IF EXISTS `core_applygrained`;
CREATE TABLE `core_applygrained` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `permissions` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `work_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `auth_group` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `core_applygrained_username_01d55fc9` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for core_databaselist
-- ----------------------------
DROP TABLE IF EXISTS `core_databaselist`;
CREATE TABLE `core_databaselist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `connection_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `computer_room` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `ip` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `username` varchar(150) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `port` int(11) NOT NULL,
  `password` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `before` longtext CHARACTER SET utf8 COLLATE utf8_bin,
  `after` longtext CHARACTER SET utf8 COLLATE utf8_bin,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for core_globalpermissions
-- ----------------------------
DROP TABLE IF EXISTS `core_globalpermissions`;
CREATE TABLE `core_globalpermissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `authorization` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `inception` longtext CHARACTER SET utf8 COLLATE utf8_bin,
  `ldap` longtext CHARACTER SET utf8 COLLATE utf8_bin,
  `message` longtext CHARACTER SET utf8 COLLATE utf8_bin,
  `other` longtext CHARACTER SET utf8 COLLATE utf8_bin,
  PRIMARY KEY (`id`),
  KEY `core_globalpermissions_authorization_b3bfe975` (`authorization`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of core_globalpermissions
-- ----------------------------
BEGIN;
INSERT INTO `core_globalpermissions` VALUES (2, 'global', '{\'host\': \'\', \'port\': \'\', \'user\': \'\', \'password\': \'\', \'back_host\': \'\', \'back_port\': \'\', \'back_user\': \'\', \'back_password\': \'\'}', '{\'type\': \'1\', \'host\': \'\', \'sc\': \'\', \'domain\': \'\', \'user\': \'\', \'password\': \'\'}', '{\'webhook\': \'\', \'smtp_host\': \'smtp.exmail.qq.com\', \'smtp_port\': \'465\', \'user\': \'chenwu@yupaopao.cn\', \'password\': \'Cic2012\', \'to_user\': \'chenwu@yupaopao.cn\', \'mail\': True, \'ding\': False, \'ssl\': True}', '{\'limit\': \'100\', \'con_room\': [\'测试环境\', \'生产环境\'], \'foce\': \'\', \'multi\': True, \'query\': True, \'sensitive_list\': [], \'sensitive\': \'\', \'exclued_db_list\': [], \'exclued_db\': \'\', \'email_suffix_list\': [\'yupaopao.cn\'], \'email_suffix\': \'\'}');
COMMIT;

-- ----------------------------
-- Table structure for core_grained
-- ----------------------------
DROP TABLE IF EXISTS `core_grained`;
CREATE TABLE `core_grained` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `permissions` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `core_grained_username_4cd48d82` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of core_grained
-- ----------------------------
BEGIN;
INSERT INTO `core_grained` VALUES (29, 'admin', '{\'ddl\': \'1\', \'ddlcon\': [], \'dml\': \'1\', \'dmlcon\': [], \'dic\': \'1\', \'diccon\': [], \'dicedit\': \'0\', \'user\': \'1\', \'base\': \'1\', \'dicexport\': \'1\', \'person\': [], \'query\': \'1\', \'querycon\': []}');
COMMIT;

-- ----------------------------
-- Table structure for core_query_order
-- ----------------------------
DROP TABLE IF EXISTS `core_query_order`;
CREATE TABLE `core_query_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `work_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `username` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `date` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `instructions` longtext CHARACTER SET utf8 COLLATE utf8_bin,
  `query_per` smallint(6) DEFAULT NULL,
  `computer_room` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `connection_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `export` smallint(6) DEFAULT NULL,
  `audit` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `time` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `core_query_order_work_id_1ae60daa` (`work_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for core_querypermissions
-- ----------------------------
DROP TABLE IF EXISTS `core_querypermissions`;
CREATE TABLE `core_querypermissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `work_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `username` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `statements` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `core_querypermissions_work_id_da29a27b` (`work_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for core_sqldictionary
-- ----------------------------
DROP TABLE IF EXISTS `core_sqldictionary`;
CREATE TABLE `core_sqldictionary` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `BaseName` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `TableName` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `Field` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `Type` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `Extra` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `TableComment` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `Name` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for core_sqlorder
-- ----------------------------
DROP TABLE IF EXISTS `core_sqlorder`;
CREATE TABLE `core_sqlorder` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `work_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `username` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `status` int(11) NOT NULL,
  `type` smallint(6) NOT NULL,
  `backup` smallint(6) NOT NULL,
  `bundle_id` int(11) DEFAULT NULL,
  `date` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `basename` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `sql` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `text` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `assigned` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `delay` int(11) DEFAULT NULL,
  `rejected` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `real_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `core_sqlorder_bundle_id_3d5581f1` (`bundle_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for core_sqlrecord
-- ----------------------------
DROP TABLE IF EXISTS `core_sqlrecord`;
CREATE TABLE `core_sqlrecord` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `state` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `sql` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `error` longtext CHARACTER SET utf8 COLLATE utf8_bin,
  `workid` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `affectrow` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `sequence` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `SQLSHA1` longtext CHARACTER SET utf8 COLLATE utf8_bin,
  `execute_time` varchar(150) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `backup_dbname` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for core_todolist
-- ----------------------------
DROP TABLE IF EXISTS `core_todolist`;
CREATE TABLE `core_todolist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `content` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `model` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

SET FOREIGN_KEY_CHECKS = 1;
