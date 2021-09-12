/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80021
 Source Host           : localhost:3306
 Source Schema         : xuanke

 Target Server Type    : MySQL
 Target Server Version : 80021
 File Encoding         : 65001

 Date: 18/12/2020 19:38:58
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admins
-- ----------------------------
DROP TABLE IF EXISTS `admins`;
CREATE TABLE `admins`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '帐号',
  `pwd` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `xingming` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '姓名',
  `shouji` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '手机',
  `addtime` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '添加时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of admins
-- ----------------------------
INSERT INTO `admins` VALUES (1, 'admin', 'admin', '', '', '2020-12-14 09:50:43');

-- ----------------------------
-- Table structure for chengji
-- ----------------------------
DROP TABLE IF EXISTS `chengji`;
CREATE TABLE `chengji`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `kechengid` int(0) UNSIGNED NOT NULL COMMENT '课程id',
  `xueqi` int(0) UNSIGNED NOT NULL COMMENT '学期',
  `kechengming` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '课程名',
  `xuefen` int(0) NOT NULL COMMENT '学分',
  `xuesheng` int(0) UNSIGNED NOT NULL COMMENT '学生ID',
  `xuehao` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '学号',
  `xingming` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '姓名',
  `chengji` int(0) NOT NULL COMMENT '成绩',
  `addtime` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '添加时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `chengji_kechengid_index`(`kechengid`) USING BTREE,
  INDEX `chengji_xueqi_index`(`xueqi`) USING BTREE,
  INDEX `chengji_xuesheng_index`(`xuesheng`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of chengji
-- ----------------------------
INSERT INTO `chengji` VALUES (8, 17, 4, '离散数学Ⅱ', 3, 6, '2018052755', '曾令浩', 100, '2020-12-18 18:55:48');

-- ----------------------------
-- Table structure for kecheng
-- ----------------------------
DROP TABLE IF EXISTS `kecheng`;
CREATE TABLE `kecheng`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `dingjifenlei` int(0) UNSIGNED NOT NULL COMMENT '顶级分类',
  `kechengming` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '课程名',
  `xuefen` int(0) NOT NULL COMMENT '学分',
  `xingqi` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '星期',
  `dijijie` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '第几节',
  `addtime` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '添加时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `kecheng_dingjifenlei_index`(`dingjifenlei`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of kecheng
-- ----------------------------
INSERT INTO `kecheng` VALUES (2, 1, '高等数学11', 8, '周五', '5,6', '2020-12-15 17:28:32');
INSERT INTO `kecheng` VALUES (3, 1, '高等数学222', 6, '周五', '1,2,3', '2020-12-15 17:28:49');
INSERT INTO `kecheng` VALUES (5, 4, '计算机111', 5, '周四', '5,6', '2020-12-15 17:30:34');
INSERT INTO `kecheng` VALUES (6, 4, '计算机科学', 5, '周二', '3,4', '2020-12-15 17:30:51');
INSERT INTO `kecheng` VALUES (8, 7, '测试11', 4, '周一', '5,6', '2020-12-16 11:48:12');
INSERT INTO `kecheng` VALUES (9, 7, '测试22', 6, '周一', '3,4', '2020-12-16 11:48:28');
INSERT INTO `kecheng` VALUES (11, 0, '高等数学Ⅰ', 3, '周二', '3,4', '2020-12-18 17:43:32');
INSERT INTO `kecheng` VALUES (12, 0, '高等数学Ⅱ', 3, '周三', '3,4', '2020-12-18 17:43:51');
INSERT INTO `kecheng` VALUES (13, 0, '大学语文', 3, '周四', '3,4', '2020-12-18 17:45:26');
INSERT INTO `kecheng` VALUES (14, 0, '计算机导论', 3, '周五', '6,7,8', '2020-12-18 17:47:08');
INSERT INTO `kecheng` VALUES (15, 11, '大学物理', 3, '周三', '10,11,12', '2020-12-18 17:48:14');
INSERT INTO `kecheng` VALUES (16, 0, '离散数学Ⅰ', 3, '周一', '1,2', '2020-12-18 17:48:38');
INSERT INTO `kecheng` VALUES (17, 0, '离散数学Ⅱ', 3, '周四', '5,6,7', '2020-12-18 17:48:58');
INSERT INTO `kecheng` VALUES (18, 17, '人工智能', 2, '周五', '1,2', '2020-12-18 17:49:26');
INSERT INTO `kecheng` VALUES (19, 0, '数据结构', 4, '周三', '3,4', '2020-12-18 17:49:51');
INSERT INTO `kecheng` VALUES (20, 0, '大学物理实验', 1, '周一', '6,7,8', '2020-12-18 17:54:57');
INSERT INTO `kecheng` VALUES (21, 0, '数据结构实验', 1, '周五', '3,4', '2020-12-18 17:55:15');
INSERT INTO `kecheng` VALUES (22, 0, '线性代数', 3, '周四', '1,2', '2020-12-18 17:55:32');

-- ----------------------------
-- Table structure for xuanke
-- ----------------------------
DROP TABLE IF EXISTS `xuanke`;
CREATE TABLE `xuanke`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `kechengid` int(0) UNSIGNED NOT NULL COMMENT '课程id',
  `kechengming` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '课程名',
  `xuefen` int(0) NOT NULL COMMENT '学分',
  `xingqi` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '星期',
  `dijijie` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '第几节',
  `xuankeren` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '选课人',
  `addtime` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '添加时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `xuanke_kechengid_index`(`kechengid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of xuanke
-- ----------------------------
INSERT INTO `xuanke` VALUES (18, 19, '数据结构', 4, '周三', '3,4', '2018052755', '2020-12-18 19:24:19');

-- ----------------------------
-- Table structure for xueqi
-- ----------------------------
DROP TABLE IF EXISTS `xueqi`;
CREATE TABLE `xueqi`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `xueqiming` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '学期名',
  `addtime` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '添加时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of xueqi
-- ----------------------------
INSERT INTO `xueqi` VALUES (1, '2019上', '2020-12-15 17:56:45');
INSERT INTO `xueqi` VALUES (2, '2019下', '2020-12-15 17:56:51');
INSERT INTO `xueqi` VALUES (3, '2020上', '2020-12-15 17:56:56');
INSERT INTO `xueqi` VALUES (4, '2020下', '2020-12-15 17:57:02');

-- ----------------------------
-- Table structure for xuesheng
-- ----------------------------
DROP TABLE IF EXISTS `xuesheng`;
CREATE TABLE `xuesheng`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `xuehao` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '学号',
  `mima` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `xingming` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '姓名',
  `xingbie` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '性别',
  `shouji` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '手机',
  `shenfenzheng` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '身份证',
  `addtime` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '添加时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of xuesheng
-- ----------------------------
INSERT INTO `xuesheng` VALUES (6, '2018052755', '000', '曾令浩', '男', '12345678990', '421302200192001992', '2020-12-18 17:57:22');

SET FOREIGN_KEY_CHECKS = 1;
