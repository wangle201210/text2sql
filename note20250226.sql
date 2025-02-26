/*
 Navicat Premium Data Transfer

 Source Server         : docker-mysql
 Source Server Type    : MySQL
 Source Server Version : 80200 (8.2.0)
 Source Host           : localhost:3306
 Source Schema         : note

 Target Server Type    : MySQL
 Target Server Version : 80200 (8.2.0)
 File Encoding         : 65001

 Date: 26/02/2025 16:19:11
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for article
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'note id',
  `user_id` int NOT NULL COMMENT 'user id',
  `status` tinyint DEFAULT NULL COMMENT 'status',
  `title` varchar(255) DEFAULT NULL COMMENT '文章标题',
  `content` text COMMENT '文章内容',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Records of article
-- ----------------------------
BEGIN;
INSERT INTO `article` (`id`, `user_id`, `status`, `title`, `content`, `created_at`, `updated_at`) VALUES (1, 1, 1, '我从哪里来', '我从四川来', '2025-02-26 16:12:33', '2025-02-26 16:12:37');
COMMIT;

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'category id',
  `name` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '消费类目',
  `status` tinyint DEFAULT NULL COMMENT 'category status',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Records of category
-- ----------------------------
BEGIN;
INSERT INTO `category` (`id`, `name`, `status`) VALUES (1, '餐饮食品', 1);
INSERT INTO `category` (`id`, `name`, `status`) VALUES (2, '教育学习', 1);
INSERT INTO `category` (`id`, `name`, `status`) VALUES (3, '交通出行', 1);
INSERT INTO `category` (`id`, `name`, `status`) VALUES (4, '娱乐休闲', 1);
INSERT INTO `category` (`id`, `name`, `status`) VALUES (5, '工资薪酬', 1);
INSERT INTO `category` (`id`, `name`, `status`) VALUES (6, '房租房贷', 1);
INSERT INTO `category` (`id`, `name`, `status`) VALUES (7, '服饰鞋包', 1);
INSERT INTO `category` (`id`, `name`, `status`) VALUES (8, '日用品类', 1);
INSERT INTO `category` (`id`, `name`, `status`) VALUES (9, '医疗健康', 1);
INSERT INTO `category` (`id`, `name`, `status`) VALUES (10, '数码电器', 1);
INSERT INTO `category` (`id`, `name`, `status`) VALUES (11, '生活缴费', 1);
INSERT INTO `category` (`id`, `name`, `status`) VALUES (12, '美容美发', 1);
INSERT INTO `category` (`id`, `name`, `status`) VALUES (13, '意外支出', 1);
COMMIT;

-- ----------------------------
-- Table structure for note
-- ----------------------------
DROP TABLE IF EXISTS `note`;
CREATE TABLE `note` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'note id',
  `user_id` int NOT NULL COMMENT 'user id',
  `category_id` int NOT NULL COMMENT '消费类型',
  `amount` decimal(12,2) DEFAULT NULL COMMENT '具体金额',
  `org_content` text COMMENT '原始内容',
  `status` tinyint DEFAULT NULL COMMENT 'note status',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=170 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Records of note
-- ----------------------------
BEGIN;
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (6, 1, 2, 5.70, '笔2.5元，本子3.2元', 0, '2024-01-06 11:35:30', '2025-01-07 11:35:30');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (7, 1, 3, 3.00, '地铁3元，馒头5元', 0, '2025-01-06 11:40:04', '2025-01-07 11:40:04');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (8, 1, 1, 5.00, '地铁3元，馒头5元', 0, '2024-12-07 11:40:04', '2025-01-07 11:40:04');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (9, 1, 1, 5.50, '馒头3.5元，豆浆2元，笔2.4元，本子5.2元，公交2元，地铁3元', 0, '2025-01-07 11:44:25', '2025-01-07 11:44:25');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (10, 1, 2, 7.60, '馒头3.5元，豆浆2元，笔2.4元，本子5.2元，公交2元，地铁3元', 0, '2025-01-07 11:44:25', '2025-01-07 11:44:25');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (11, 1, 3, 5.00, '馒头3.5元，豆浆2元，笔2.4元，本子5.2元，公交2元，地铁3元', 0, '2025-01-07 11:44:25', '2025-01-07 11:44:25');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (12, 1, 1, 98.00, '火锅98元，动车80元', 0, '2025-01-07 11:47:08', '2025-01-07 11:47:08');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (13, 1, 3, 80.00, '火锅98元，动车80元', 0, '2025-01-07 11:47:08', '2025-01-07 11:47:08');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (14, 1, 9, 14.00, '看病14 早餐5 公交车2', 0, '2025-01-07 12:01:43', '2025-01-07 12:01:43');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (15, 1, 1, 5.00, '看病14 早餐5 公交车2', 0, '2025-01-07 12:01:43', '2025-01-07 12:01:43');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (16, 1, 3, 2.00, '看病14 早餐5 公交车2', 0, '2025-01-07 12:01:43', '2025-01-07 12:01:43');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (17, 1, 1, 11.00, '中午吃面11', 0, '2025-01-07 12:09:56', '2025-01-07 12:09:56');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (18, 1, 1, 12.15, '中午吃了12.15', 0, '2025-01-07 12:10:49', '2025-01-07 12:10:49');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (19, 1, 1, 5.00, '昨天花了5元买香蕉', 0, '2025-01-07 18:23:52', '2025-01-07 18:23:52');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (20, 1, 1, 15.00, '小明中午吃了15块', 0, '2025-01-08 13:57:54', '2025-01-08 13:57:54');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (21, 1, 1, 12.00, '包子12', 0, '2025-01-08 13:58:15', '2025-01-08 13:58:15');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (22, 1, 11, 25.00, '上网费用25', 0, '2025-01-08 14:00:53', '2025-01-08 14:00:53');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (23, 1, 1, 11.20, '午饭11.2', 0, '2025-01-08 14:09:21', '2025-01-08 14:09:21');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (24, 2, 3, 5.00, '公交5元\n\n', 0, '2025-01-08 14:29:54', '2025-01-08 14:29:54');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (25, 1, 1, 2.00, '吃饭2元', 0, '2025-01-08 15:02:43', '2025-01-08 15:02:43');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (26, 1, 3, 3.00, '公交三元', 0, '2025-01-08 15:02:57', '2025-01-08 15:02:57');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (27, 4, 1, 98.00, '火锅98元，动车80元', 0, '2025-01-08 15:39:50', '2025-01-08 15:39:50');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (28, 4, 3, 80.00, '火锅98元，动车80元', 0, '2025-01-08 15:39:50', '2025-01-08 15:39:50');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (29, 5, 1, 98.00, '火锅98元，动车80元', 0, '2025-01-08 16:13:04', '2025-01-08 16:13:04');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (30, 5, 3, 80.00, '火锅98元，动车80元', 0, '2025-01-08 16:13:04', '2025-01-08 16:13:04');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (31, 1, 1, 16.00, '中午吃了16块的米线', 0, '2025-01-08 17:36:17', '2025-01-08 17:36:17');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (33, 6, 1, 20.00, '午饭20', 0, '2025-01-09 15:31:22', '2025-01-09 15:31:22');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (34, 6, 1, 20.00, '午饭20', 0, '2025-01-09 15:31:23', '2025-01-09 15:31:23');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (35, 6, 3, 18.00, '公交18', 0, '2025-01-09 15:35:00', '2025-01-09 15:35:00');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (36, 6, 1, 19.00, '馒头19', 0, '2025-01-09 15:39:53', '2025-01-09 15:39:53');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (37, 6, 1, 14.00, '面包14', 0, '2025-01-09 15:40:02', '2025-01-09 15:40:02');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (38, 6, 10, 7.00, '笔记本7元', 0, '2025-01-09 15:40:38', '2025-01-09 15:40:38');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (39, 6, 1, 3.60, '包子3.6', 0, '2025-01-09 15:51:32', '2025-01-09 15:51:32');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (40, 6, 1, 12.00, '包子12，打车5', 0, '2025-01-09 16:42:24', '2025-01-09 16:42:24');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (41, 6, 3, 5.00, '包子12，打车5', 0, '2025-01-09 16:42:24', '2025-01-09 16:42:24');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (42, 6, 1, 12.00, '包子12，打车5', 0, '2025-01-09 16:42:27', '2025-01-09 16:42:27');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (43, 6, 3, 5.00, '包子12，打车5', 0, '2025-01-09 16:42:28', '2025-01-09 16:42:28');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (44, 8, 1, 10.00, '吃饭10元', 0, '2025-01-09 16:51:44', '2025-01-09 16:51:44');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (45, 8, 3, 10.00, '坐公交10元', 0, '2025-01-09 17:00:14', '2025-01-09 17:00:14');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (46, 6, 9, 3.00, '拉肚子花了3元', 0, '2025-01-09 17:12:34', '2025-01-09 17:12:34');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (47, 6, 1, 25.00, '豆浆5元，公交8，午饭二十', 0, '2025-01-09 17:13:55', '2025-01-09 17:13:55');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (48, 6, 3, 8.00, '豆浆5元，公交8，午饭二十', 0, '2025-01-09 17:13:55', '2025-01-09 17:13:55');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (49, 6, 1, 25.00, '豆浆5元，公交8，午饭二十', 0, '2025-01-09 17:13:58', '2025-01-09 17:13:58');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (50, 6, 3, 8.00, '豆浆5元，公交8，午饭二十', 0, '2025-01-09 17:13:59', '2025-01-09 17:13:59');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (51, 9, 12, 10.00, '洗脚花了十块', 0, '2025-01-09 17:36:36', '2025-01-09 17:36:36');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (52, 9, 3, 700.00, '刚刚违章被罚款700', 0, '2025-01-09 17:38:39', '2025-01-09 17:38:39');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (53, 9, 4, 500.00, '打麻将被罚了500', 0, '2025-01-09 17:53:57', '2025-01-09 17:53:57');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (54, 9, 1, 80.00, '去买菜，给了100，找了20，发现20块是假币', 0, '2025-01-09 18:22:05', '2025-01-09 18:22:05');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (55, 9, 1, 90.00, '去买菜，给了5毛一斤，买了20斤，给了一百块', 0, '2025-01-09 18:28:41', '2025-01-09 18:28:41');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (56, 9, 1, 90.00, '去买菜，给了5毛一斤，买了20斤，给了一百块，忘记叫他找钱了', 0, '2025-01-09 18:29:25', '2025-01-09 18:29:25');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (57, 6, 1, 40.00, '荔枝8元一斤，我买了5斤，给了50，商家补了我3块', 0, '2025-01-09 18:37:48', '2025-01-09 18:37:48');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (58, 9, 1, 80.00, '去买菜，菜农说丝瓜5.5一斤，买上3斤按4块一斤算，我买了20斤，给了100块', 0, '2025-01-09 18:39:18', '2025-01-09 18:39:18');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (59, 9, 1, 80.00, '去买菜，菜农说丝瓜5.5一斤，买上3斤按4块一斤算，我买了20斤，给了100块，苦瓜10块一斤，我准备买3斤，发现钱不够了，不买苦瓜了', 0, '2025-01-09 18:42:50', '2025-01-09 18:42:50');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (60, 8, 1, 80.00, '去买菜，菜农说丝瓜5.5一斤，买上3斤按4块一斤算，我买了20斤，给了100块，苦瓜10块一斤，我准备买3斤，发现钱不够了，不买苦瓜了', 0, '2025-01-10 09:56:02', '2025-01-10 09:56:02');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (61, 8, 1, 80.00, '去买菜，菜农说丝瓜5.5一斤，买上3斤按4块一斤算，我买了20斤，给了100块，苦瓜10块一斤，我准备买3斤，发现钱不够了，不买苦瓜了', 0, '2025-01-10 09:59:42', '2025-01-10 09:59:42');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (62, 8, 13, 20.00, '去买菜，菜农说丝瓜5.5一斤，买上3斤按4块一斤算，我买了20斤，给了100块，苦瓜10块一斤，我准备买3斤，发现钱不够了，不买苦瓜了', 0, '2025-01-10 09:59:43', '2025-01-10 09:59:43');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (63, 8, 1, 70.00, '去买菜，菜农说丝瓜5.5一斤，买上3斤按4块一斤算，我买了20斤，给了100块，找了我10块，苦瓜10块一斤，我准备买3斤，发现钱不够了，不买苦瓜了', 0, '2025-01-10 10:00:17', '2025-01-10 10:00:17');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (64, 8, 13, 20.00, '去买菜，菜农说丝瓜5.5一斤，买上3斤按4块一斤算，我买了20斤，给了100块，找了我10块，苦瓜10块一斤，我准备买3斤，发现钱不够了，不买苦瓜了', 0, '2025-01-10 10:00:17', '2025-01-10 10:00:17');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (65, 8, 1, 80.00, '去买菜，菜农说丝瓜5.5一斤，买上3斤按4块一斤算，我买了20斤，给了100块，找了我10块，苦瓜10块一斤，我准备买3斤，发现钱不够了，不买苦瓜了', 0, '2025-01-10 10:01:13', '2025-01-10 10:01:13');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (66, 8, 1, 80.00, '去买菜，菜农说丝瓜5.5一斤，买上3斤按4块一斤算，我买了20斤，给了100块，找了我10块，苦瓜10块一斤，我准备买3斤，发现钱不够了，不买苦瓜了\n\n', 0, '2025-01-10 10:02:53', '2025-01-10 10:02:53');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (67, 8, 13, 10.00, '去买菜，菜农说丝瓜5.5一斤，买上3斤按4块一斤算，我买了20斤，给了100块，找了我10块，苦瓜10块一斤，我准备买3斤，发现钱不够了，不买苦瓜了\n\n', 0, '2025-01-10 10:02:53', '2025-01-10 10:02:53');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (68, 8, 1, 70.00, '去买菜，菜农说丝瓜5.5一斤，买上3斤按4块一斤算，我买了20斤，给了100块，找了我10块，苦瓜10块一斤，我准备买3斤，发现钱不够了，不买苦瓜了', 0, '2025-01-10 10:04:34', '2025-01-10 10:04:34');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (69, 8, 13, 20.00, '去买菜，菜农说丝瓜5.5一斤，买上3斤按4块一斤算，我买了20斤，给了100块，找了我10块，苦瓜10块一斤，我准备买3斤，发现钱不够了，不买苦瓜了', 0, '2025-01-10 10:04:34', '2025-01-10 10:04:34');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (70, 8, 1, 80.00, '去买菜，菜农说丝瓜5.5一斤，买上3斤按4块一斤算，我买了20斤，给了100块，找了我10块，苦瓜10块一斤，我准备买3斤，发现钱不够了，不买苦瓜了', 0, '2025-01-10 10:05:35', '2025-01-10 10:05:35');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (71, 8, 13, 10.00, '去买菜，菜农说丝瓜5.5一斤，买上3斤按4块一斤算，我买了20斤，给了100块，找了我10块，苦瓜10块一斤，我准备买3斤，发现钱不够了，不买苦瓜了', 0, '2025-01-10 10:05:35', '2025-01-10 10:05:35');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (72, 8, 4, 250.00, '打牌输了250，被警察逮住罚了1000', 0, '2025-01-10 10:08:44', '2025-01-10 10:08:44');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (73, 8, 13, 1000.00, '打牌输了250，被警察逮住罚了1000', 0, '2025-01-10 10:08:44', '2025-01-10 10:08:44');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (74, 8, 13, 250.00, '打牌输了250', 0, '2025-01-10 10:13:36', '2025-01-10 10:13:36');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (75, 8, 13, 1250.00, '打牌输了250，被警察逮住罚了1k\n\n', 0, '2025-01-10 10:33:34', '2025-01-10 10:33:34');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (76, 8, 4, 250.00, '打牌输了250，被警察逮住罚了1k', 0, '2025-01-10 10:58:07', '2025-01-10 10:58:07');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (77, 8, 13, 1000.00, '打牌输了250，被警察逮住罚了1k', 0, '2025-01-10 10:58:07', '2025-01-10 10:58:07');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (78, 8, 13, 1250.00, '打牌输了250，被警察逮住罚了1k\n\n', 0, '2025-01-10 10:58:17', '2025-01-10 10:58:17');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (79, 8, 4, 250.00, '打牌输了250，被警察逮住罚了1k', 0, '2025-01-10 11:01:11', '2025-01-10 11:01:11');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (80, 8, 13, 1000.00, '打牌输了250，被警察逮住罚了1k', 0, '2025-01-10 11:01:11', '2025-01-10 11:01:11');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (81, 8, 4, 250.00, '打牌输了250，被警察逮住罚了1k', 0, '2025-01-10 11:01:19', '2025-01-10 11:01:19');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (82, 8, 13, 1000.00, '打牌输了250，被警察逮住罚了1k', 0, '2025-01-10 11:01:19', '2025-01-10 11:01:19');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (83, 8, 4, 250.00, '打牌输了250，被警察逮住罚了1k', 0, '2025-01-10 11:01:25', '2025-01-10 11:01:25');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (84, 8, 13, 1000.00, '打牌输了250，被警察逮住罚了1k', 0, '2025-01-10 11:01:25', '2025-01-10 11:01:25');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (85, 8, 13, 1250.00, '打牌输了250，被警察逮住罚了1k\n\n|| 意外支出:1250.0', 0, '2025-01-10 11:04:36', '2025-01-10 11:04:36');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (86, 8, 13, 1250.00, '打牌输了250，被警察逮住罚了1k|| 意外支出:1250.0', 0, '2025-01-10 11:05:40', '2025-01-10 11:05:40');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (87, 8, 13, 1250.00, '意外支出:1250.0||打牌输了250，被警察逮住罚了1k', 0, '2025-01-10 11:15:03', '2025-01-10 11:15:03');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (88, 8, 4, 250.00, '娱乐休闲:250.0||打牌输了250，被警察逮住罚了1k\n\n', 0, '2025-01-10 11:16:35', '2025-01-10 11:16:35');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (89, 8, 13, 1000.00, '意外支出:1000.0||打牌输了250，被警察逮住罚了1k\n\n', 0, '2025-01-10 11:16:35', '2025-01-10 11:16:35');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (90, 10, 1, 98.00, '餐饮食品:98.0||火锅98元，动车80元', 0, '2025-01-10 11:35:41', '2025-01-10 11:35:41');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (91, 10, 3, 80.00, '交通出行:80.0||火锅98元，动车80元', 0, '2025-01-10 11:35:41', '2025-01-10 11:35:41');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (108, 6, 1, 40.00, '餐饮食品:40.0||荔枝8元一斤，我买了5斤，给了50，商家补了我3块', 0, '2025-01-10 11:48:30', '2025-01-10 11:48:30');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (109, 6, 13, 7.00, '意外支出:7.0||荔枝8元一斤，我买了5斤，给了50，商家补了我3块', 0, '2025-01-10 11:48:31', '2025-01-10 11:48:31');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (110, 6, 1, 40.00, '餐饮食品:40.0||荔枝8元一斤，我买了5斤，给了50，商家补了我3块', 0, '2025-01-10 11:48:35', '2025-01-10 11:48:35');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (111, 6, 13, 7.00, '意外支出:7.0||荔枝8元一斤，我买了5斤，给了50，商家补了我3块', 0, '2025-01-10 11:48:36', '2025-01-10 11:48:36');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (112, 6, 1, 37.00, '餐饮食品:37.0||荔枝8元一斤，我买了5斤，给了50，商家补了我3块', 0, '2025-01-10 11:48:41', '2025-01-10 11:48:41');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (113, 6, 1, 37.00, '餐饮食品:37.0||荔枝8元一斤，我买了5斤，给了50，商家补了我3块', 0, '2025-01-10 11:52:06', '2025-01-10 11:52:06');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (114, 6, 13, 10.00, '意外支出:10.0||荔枝8元一斤，我买了5斤，给了50，商家补了我3块', 0, '2025-01-10 11:52:06', '2025-01-10 11:52:06');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (115, 6, 1, 40.00, '餐饮食品:40.0||荔枝8元一斤，我买了5斤，给了50，商家补了我3块', 0, '2025-01-10 11:52:10', '2025-01-10 11:52:10');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (116, 6, 13, 7.00, '意外支出:7.0||荔枝8元一斤，我买了5斤，给了50，商家补了我3块', 0, '2025-01-10 11:52:10', '2025-01-10 11:52:10');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (117, 6, 1, 37.00, '餐饮食品:37.0||荔枝8元一斤，我买了5斤，给了50，商家补了我3块', 0, '2025-01-10 11:52:15', '2025-01-10 11:52:15');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (118, 6, 13, 10.00, '意外支出:10.0||荔枝8元一斤，我买了5斤，给了50，商家补了我3块', 0, '2025-01-10 11:52:16', '2025-01-10 11:52:16');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (119, 1, 1, 37.00, '餐饮食品:37.0||荔枝8元一斤，我买了5斤，给了50，商家补了我3块', 0, '2025-01-10 11:54:14', '2025-01-10 11:54:14');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (120, 1, 1, 37.00, '餐饮食品:37.0||荔枝8元一斤，我买了5斤，给了50，商家补了我3块', 0, '2025-01-10 11:54:32', '2025-01-10 11:54:32');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (121, 1, 1, 37.00, '餐饮食品:37.0||荔枝8元一斤，我买了5斤，给了50，商家补了我3块', 0, '2025-01-10 11:55:05', '2025-01-10 11:55:05');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (122, 1, 13, 10.00, '意外支出:10.0||荔枝8元一斤，我买了5斤，给了50，商家补了我3块', 0, '2025-01-10 11:55:05', '2025-01-10 11:55:05');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (123, 1, 1, 40.00, '餐饮食品:40.0||荔枝8元一斤，我买了5斤，给了50，商家补了我3块', 0, '2025-01-10 11:55:26', '2025-01-10 11:55:26');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (124, 1, 13, 7.00, '意外支出:7.0||荔枝8元一斤，我买了5斤，给了50，商家补了我3块', 0, '2025-01-10 11:55:27', '2025-01-10 11:55:27');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (125, 1, 1, 37.00, '餐饮食品:37.0||荔枝8元一斤，我买了5斤，给了50，商家补了我3块', 0, '2025-01-10 11:55:41', '2025-01-10 11:55:41');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (126, 6, 1, 37.00, '餐饮食品:37.0||荔枝8元一斤，我买了5斤，给了50，商家补了我3块', 0, '2025-01-10 11:56:38', '2025-01-10 11:56:38');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (127, 6, 13, 10.00, '意外支出:10.0||荔枝8元一斤，我买了5斤，给了50，商家补了我3块', 0, '2025-01-10 11:56:39', '2025-01-10 11:56:39');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (128, 6, 13, 7.00, '意外支出:7.0||荔枝8元一斤，我买了5斤，给了50，商家补了我3块', 0, '2025-01-10 11:56:46', '2025-01-10 11:56:46');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (129, 6, 1, 37.00, '餐饮食品:37.0||荔枝8元一斤，我买了5斤，给了50，商家补了我3块', 0, '2025-01-10 11:57:03', '2025-01-10 11:57:03');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (130, 6, 13, 10.00, '意外支出:10.0||荔枝8元一斤，我买了5斤，给了50，商家补了我3块', 0, '2025-01-10 11:57:04', '2025-01-10 11:57:04');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (131, 6, 1, 8.00, '餐饮食品:8.0||午餐8元', 0, '2025-01-10 13:53:35', '2025-01-10 13:53:35');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (132, 6, 1, 8.00, '餐饮食品:8.0||午餐8元', 0, '2025-01-10 13:53:38', '2025-01-10 13:53:38');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (133, 6, 1, 37.00, '餐饮食品:37.0||荔枝8元一斤，我买了5斤，给了50，商家补了我3块', 0, '2025-01-10 14:02:10', '2025-01-10 14:02:10');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (134, 6, 13, 10.00, '意外支出:10.0||荔枝8元一斤，我买了5斤，给了50，商家补了我3块', 0, '2025-01-10 14:02:11', '2025-01-10 14:02:11');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (135, 6, 1, 37.00, '餐饮食品:37.0||荔枝8元一斤，我买了5斤，给了50，商家补了我3块', 0, '2025-01-10 14:02:13', '2025-01-10 14:02:13');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (136, 6, 1, 37.00, '餐饮食品:37.0||荔枝8元一斤，我买了5斤，给了50，商家补了我3块', 0, '2025-01-10 14:02:18', '2025-01-10 14:02:18');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (137, 6, 1, 37.00, '餐饮食品:37.0||荔枝8元一斤，我买了5斤，给了50，商家补了我3块', 0, '2025-01-10 14:05:38', '2025-01-10 14:05:38');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (138, 6, 1, 37.00, '餐饮食品:37.0||荔枝8元一斤，我买了5斤，给了50，商家补了我3块', 0, '2025-01-10 14:05:41', '2025-01-10 14:05:41');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (139, 6, 1, 37.00, '餐饮食品:37.0||荔枝8元一斤，我买了5斤，给了50，商家补了我3块', 0, '2025-01-10 14:05:46', '2025-01-10 14:05:46');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (140, 6, 1, 37.00, '餐饮食品:37.0||荔枝8元一斤，我买了5斤，给了50，商家补了我3块', 0, '2025-01-10 14:07:41', '2025-01-10 14:07:41');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (141, 6, 1, 37.00, '餐饮食品:37.0||荔枝8元一斤，我买了5斤，给了50，商家补了我3块', 0, '2025-01-10 14:07:46', '2025-01-10 14:07:46');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (142, 6, 1, 37.00, '餐饮食品:37.0||荔枝8元一斤，我买了5斤，给了50，商家补了我3块', 0, '2025-01-10 14:07:50', '2025-01-10 14:07:50');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (143, 6, 1, 25.00, '餐饮食品:25.0||豆浆5元，公交8，午饭二十', 0, '2025-01-10 14:08:34', '2025-01-10 14:08:34');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (144, 6, 3, 8.00, '交通出行:8.0||豆浆5元，公交8，午饭二十', 0, '2025-01-10 14:08:34', '2025-01-10 14:08:34');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (145, 6, 1, 25.00, '餐饮食品:25.0||豆浆5元，公交8，午饭二十', 0, '2025-01-10 14:08:39', '2025-01-10 14:08:39');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (146, 6, 3, 8.00, '交通出行:8.0||豆浆5元，公交8，午饭二十', 0, '2025-01-10 14:08:39', '2025-01-10 14:08:39');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (147, 6, 1, 25.00, '餐饮食品:25.0||豆浆5元，公交8，午饭二十', 0, '2025-01-10 14:08:44', '2025-01-10 14:08:44');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (148, 6, 3, 8.00, '交通出行:8.0||豆浆5元，公交8，午饭二十', 0, '2025-01-10 14:08:45', '2025-01-10 14:08:45');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (149, 6, 1, 37.00, '餐饮食品:37.0||荔枝8元一斤，我买了5斤，给了50，商家补了我3块', 0, '2025-01-10 14:11:41', '2025-01-10 14:11:41');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (150, 6, 1, 37.00, '餐饮食品:37.0||荔枝8元一斤，我买了5斤，给了50，商家补了我3块', 0, '2025-01-10 14:11:50', '2025-01-10 14:11:50');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (151, 6, 1, 37.00, '餐饮食品:37.0||荔枝8元一斤，我买了5斤，给了50，商家补了我3块', 0, '2025-01-10 14:11:52', '2025-01-10 14:11:52');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (152, 6, 1, 25.00, '餐饮食品:25.0||豆浆5元，公交8，午饭二十', 0, '2025-01-10 14:17:18', '2025-01-10 14:17:18');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (153, 6, 1, 25.00, '餐饮食品:25.0||豆浆5元，公交8，午饭二十', 0, '2025-01-10 14:17:28', '2025-01-10 14:17:28');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (154, 6, 1, 25.00, '餐饮食品:25.0||豆浆5元，公交8，午饭二十', 0, '2025-01-10 14:17:28', '2025-01-10 14:17:28');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (155, 6, 3, 8.00, '交通出行:8.0||豆浆5元，公交8，午饭二十', 0, '2025-01-10 14:17:39', '2025-01-10 14:17:39');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (156, 6, 3, 8.00, '交通出行:8.0||豆浆5元，公交8，午饭二十', 0, '2025-01-10 14:17:39', '2025-01-10 14:17:39');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (157, 6, 1, 37.00, '餐饮食品:37.0||荔枝8元一斤，我买了5斤，给了50，商家补了我3块', 0, '2025-01-10 14:25:39', '2025-01-10 14:25:39');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (158, 6, 1, 37.00, '餐饮食品:37.0||荔枝8元一斤，我买了5斤，给了50，商家补了我3块', 0, '2025-01-10 14:42:55', '2025-01-10 14:42:55');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (159, 6, 13, 10.00, '意外支出:10.0||荔枝8元一斤，我买了5斤，给了50，商家补了我3块', 0, '2025-01-10 14:42:55', '2025-01-10 14:42:55');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (160, 6, 1, 37.00, '餐饮食品:37.0||荔枝8元一斤，我买了5斤，给了50，商家补了我3块', 0, '2025-01-10 14:47:16', '2025-01-10 14:47:16');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (161, 6, 13, 10.00, '意外支出:10.0||荔枝8元一斤，我买了5斤，给了50，商家补了我3块', 0, '2025-01-10 14:47:16', '2025-01-10 14:47:16');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (162, 6, 1, 25.00, '餐饮食品:25.0||豆浆5元，公交8，午饭二十', 0, '2025-01-10 14:51:51', '2025-01-10 14:51:51');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (163, 6, 3, 8.00, '交通出行:8.0||豆浆5元，公交8，午饭二十', 0, '2025-01-10 14:51:52', '2025-01-10 14:51:52');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (164, 6, 3, 5.60, '交通出行:5.6||公交2元，地铁3.6元，馒头二块五，豆浆两块', 0, '2025-01-15 11:05:26', '2025-01-15 11:05:26');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (165, 6, 1, 4.50, '餐饮食品:4.5||公交2元，地铁3.6元，馒头二块五，豆浆两块', 0, '2025-01-15 11:05:26', '2025-01-15 11:05:26');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (166, 6, 1, 20.00, '餐饮食品:20.0||橘子3元一斤，4斤以上2.5元，我买了8斤，给了50，老板找我10元', 0, '2025-01-15 11:07:50', '2025-01-15 11:07:50');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (167, 6, 13, 20.00, '意外支出:20.0||橘子3元一斤，4斤以上2.5元，我买了8斤，给了50，老板找我10元', 0, '2025-01-15 11:07:50', '2025-01-15 11:07:50');
INSERT INTO `note` (`id`, `user_id`, `category_id`, `amount`, `org_content`, `status`, `created_at`, `updated_at`) VALUES (168, 6, 4, 80.00, '娱乐休闲:80.0||打麻将输了80', 0, '2025-01-15 11:08:38', '2025-01-15 11:08:38');
COMMIT;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'user id',
  `name` varchar(45) DEFAULT NULL COMMENT 'user name',
  `status` tinyint DEFAULT NULL COMMENT 'user status',
  `open_id` varchar(255) DEFAULT NULL COMMENT 'wechat open_id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Records of user
-- ----------------------------
BEGIN;
INSERT INTO `user` (`id`, `name`, `status`, `open_id`) VALUES (1, '王五', 0, '12345');
INSERT INTO `user` (`id`, `name`, `status`, `open_id`) VALUES (2, '王六', 0, NULL);
INSERT INTO `user` (`id`, `name`, `status`, `open_id`) VALUES (3, 'wjj1', 0, '');
INSERT INTO `user` (`id`, `name`, `status`, `open_id`) VALUES (4, 'ashui', 0, '');
INSERT INTO `user` (`id`, `name`, `status`, `open_id`) VALUES (5, '我叫', 0, '');
INSERT INTO `user` (`id`, `name`, `status`, `open_id`) VALUES (6, 'oPciXvwvLAtqtiXT3Gmx_j8q-jmM', 0, '');
INSERT INTO `user` (`id`, `name`, `status`, `open_id`) VALUES (7, 'oPciXv9cBjww85E4BOtIw1FroOrg', 0, '');
INSERT INTO `user` (`id`, `name`, `status`, `open_id`) VALUES (8, '44774b67-5224-419b-8466-b60724fced1e', 0, '');
INSERT INTO `user` (`id`, `name`, `status`, `open_id`) VALUES (9, 'oPciXv4V8wbKoZHSGPuf_Uc3dnwQ', 0, '');
INSERT INTO `user` (`id`, `name`, `status`, `open_id`) VALUES (10, 'c39d726a-b1ce-466c-99b7-f36309cbc320', 0, '');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
