/*
 Navicat Premium Data Transfer

 Source Server         : text
 Source Server Type    : MySQL
 Source Server Version : 80029
 Source Host           : localhost:3306
 Source Schema         : data

 Target Server Type    : MySQL
 Target Server Version : 80029
 File Encoding         : 65001

 Date: 11/03/2025 00:42:43
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for permission
-- ----------------------------
DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '权限名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of permission
-- ----------------------------
INSERT INTO `permission` VALUES (1, '管理员权限');
INSERT INTO `permission` VALUES (2, '用户权限');
INSERT INTO `permission` VALUES (3, '教师权限');

-- ----------------------------
-- Table structure for project
-- ----------------------------
DROP TABLE IF EXISTS `project`;
CREATE TABLE `project`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '项目名称',
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '项目描述',
  `start_date` date NOT NULL COMMENT '项目开始时间',
  `expected_end_date` date NOT NULL COMMENT '预计结束时间',
  `status` enum('declared','initiated','progress','completed','extended','terminated','down') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'declared' COMMENT '项目状态（已申报、已立项、进行中、已完成、已延期、已终止、驳回）',
  `user_id` bigint(0) NOT NULL COMMENT '项目负责人',
  `department` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '部门',
  `teacher_id` bigint(0) NOT NULL COMMENT '导师',
  `batch` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '批次名称',
  `source` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '项目来源',
  `participant` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '项目组成员',
  `result_type` enum('paper','software','project','patent') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'paper' COMMENT '科研成果类型（论文、软著、项目、专利）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '项目表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of project
-- ----------------------------
INSERT INTO `project` VALUES (1, '医信链', '打开命令行终端。\n输入 redis-cli --version 或 redis-cli -v 命令。\n按下回车键，系统会返回 Redis 的版本信息。', '2024-03-01', '2024-12-01', 'terminated', 2, '区块链', 0, '第一批次', 'Amy', '[2]', 'paper');
INSERT INTO `project` VALUES (2, 'NFT数字藏品', 'NFT的核心价值在于推动数字内容资产化，保证数字资产的唯一性、真实性和永久性，提高数字资产的交易流动性，刺激“创作者经济”的持续发展。', '2024-04-01', '2024-11-30', 'initiated', 2, '市场', 0, '第二批次', 'seacher', '[2]', 'project');
INSERT INTO `project` VALUES (3, 'CET反拨效应基准研究', '反拨效应是指测试对教与学所产生的影响，在应用语言学领域中特指语言测试尤其是外语测试对相应的外语教和学产生的影响。语言测试反拨效应研究是应用语言学中一个相对较新的领域,同时也是测试领域的一个重要研究课题。近年来，众多学者对反拨效应进行了大量而深入的研究，不断丰富和完善了反拨效应理论，同时也在一定程度上推动了测试和教学改革。', '2023-05-01', '2024-01-01', 'declared', 1, '教育', 0, '第一批次', '研究', '[6]', 'software');
INSERT INTO `project` VALUES (4, '高考能力考查与内容改革创新研究', '高考制度恢复以来，其自身的改革不断进行，逐渐发展为较为科学、基本准确测量考生知识和能力水平的标准化考试。但2013年11月，《中共中央关于全面深化改革若干重大问题的决定》提出推进考试招生制度改革的任务，其中关于高考内容改革的主要目标和措施有：“加快推进职业院校分类招考或注册入学”、“逐步推行普通高校基于统一高考和高中学业水平考试成绩的综合评价多元录取机制”和“探索全国统考减少科目、不分文理科、外语等科目社会化考试一年多考”等，这些改革措施都是高考历史上首次提出来的。高考的定位与考试的内容都发生了较大变化，必须对内容改革与能力考查进行创新研究。', '2024-06-01', '2025-01-01', 'declared', 1, '教育', 0, '第二批次', '研究', '[2]', 'software');
INSERT INTO `project` VALUES (5, '浅析震源位置准确度及其影响因素', '联合应用多种设计策略优化聚氨酯神经导管虽然可以在多方面改善受损神经的功能,但由于神经复杂的结构和动态变化的病理生理微环境,神经导管设计策略仍旧有待完善。未来进一步改进和创新神经仿生设计策略,有望为神经组织工程领域的发展提供新的思路和机遇。', '2024-11-20', '2025-12-30', 'declared', 1, '国安', 5, '第一批次', '实验', '[7]', 'project');
INSERT INTO `project` VALUES (6, '长筒花叶片离体培养研究', '为建立长筒花的叶片离体培养体系,以苦苣苔科长筒花属长筒花品种‘kim blue’的叶片作为外植体,探索培养过程中各个可能影响培养结果的因素,包括灭菌时长的不同组合、灭菌方法,各培养阶段的激素种类及其配比,进而筛选出影响因素的最佳值。结果显示,叶片外植体最适的灭菌组合和方法为75%酒精消毒15 s+2%次氯酸钠7 min;最佳的启动培养基配方为:MS+6-BA1.0 mg/L+NAA 0.1 mg/L;最佳的增殖培养基配方为:MS+6-BA 2.0 mg/L+NAA 0.5 mg/L;最佳的壮苗培养基配方为:1/2MS+IBA 0.1 mg/L+NAA0.1 mg/L+CCC 0.5 mg/L。', '2024-12-10', '2025-02-20', 'down', 1, '科学', 5, '第一批次', '研究', '[]', 'patent');
INSERT INTO `project` VALUES (7, '元宇宙服务的人机交互综述', '近年来,元宇宙飞速发展,已成为未来数字世界的一个重要发展方向。元宇宙中的人机交互是实现虚实融合的核心,其解决了元宇宙中的多用户协作、沟通、社交等挑战,促进了创新和合作。为了深入探讨元宇宙作为虚拟和现实世界融合的数字化空间,其服务如何与人机交互相结合,创造出丰富、沉浸式、个性化的用户体验,调研了元宇宙和人机交互技术,并从人机交互的角度对元宇宙的概念进行了定义。讨论了元宇宙服务和人机融合的可行性与优势,并整理归纳了现有的挑战。最后探讨了元宇宙服务的未来发展趋势。', '2025-01-13', '2025-03-30', 'declared', 1, '科学', 0, '第二批次', '研究', '[8]', 'patent');
INSERT INTO `project` VALUES (8, '论文一', '这是一篇论文！这是一篇论文！这是一篇论文！', '2025-02-01', '2025-03-15', 'extended', 1, '教育', 4, '第一批次', '研究', '[2]', 'paper');
INSERT INTO `project` VALUES (9, '论文二', '这是论文二！这是一篇论文！这是一篇论文！', '2024-05-26', '2025-03-15', 'initiated', 1, '教育', 4, '第一批次', '研究', '[]', 'paper');
INSERT INTO `project` VALUES (10, '论著一', '这是论著一！这是一篇论著！这是一篇论著！', '2024-09-05', '2025-03-15', 'progress', 1, '科研', 4, '第一批次', '实验', '[]', 'software');
INSERT INTO `project` VALUES (11, '论著二', '这是论著二！这是一篇论著！这是一篇论著！', '2024-08-08', '2025-03-15', 'initiated', 1, '科研', 5, '第一批次', '实验', '[]', 'software');
INSERT INTO `project` VALUES (12, '项目一', '这是项目一！这是一个项目！这是一个项目！', '2024-07-20', '2025-04-15', 'completed', 1, '计算机', 4, '第一批次', '编码', '[]', 'project');
INSERT INTO `project` VALUES (13, '项目二', '这是项目二！这是一个项目！这是一个项目！', '2025-03-05', '2025-06-10', 'initiated', 1, '计算机', 5, '第二批次', '编码', '[]', 'project');
INSERT INTO `project` VALUES (14, '专利一', '这是专利一！这是一项专利！这是一项专利！', '2025-04-15', '2025-05-30', 'progress', 1, '化学', 4, '第一批次', '研究', '[]', 'patent');
INSERT INTO `project` VALUES (15, '专利二', '这是专利二！这是一项专利！这是一项专利！', '2024-10-25', '2025-04-15', 'down', 1, '生物', 5, '第二批次', '研究', '[]', 'patent');
INSERT INTO `project` VALUES (18, '这是我的科研项目', '科研项目!科研项目!科研项目!', '2025-03-11', '2025-04-10', 'extended', 19, '区块链', 4, '第一批次', ' ', '[2,3]', 'project');

-- ----------------------------
-- Table structure for project_delay
-- ----------------------------
DROP TABLE IF EXISTS `project_delay`;
CREATE TABLE `project_delay`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `project_id` bigint(0) NOT NULL COMMENT '项目id',
  `requested_extension_date` date NULL DEFAULT NULL COMMENT '申请的延期日期',
  `reason` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '延期理由',
  `status` enum('pending','approved','rejected') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'pending' COMMENT '延期申请状态（待审核、已批准、已拒绝）',
  `approval_date` date NULL DEFAULT NULL COMMENT '审批日期',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '记录项目延期申请的信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of project_delay
-- ----------------------------
INSERT INTO `project_delay` VALUES (1, 1, '2024-11-19', '不完善', 'pending', '2024-12-10');
INSERT INTO `project_delay` VALUES (2, 8, '2025-01-04', '不够规范', 'pending', '2025-03-28');
INSERT INTO `project_delay` VALUES (3, 16, '2025-03-10', '时间不够', 'pending', '2025-06-01');
INSERT INTO `project_delay` VALUES (4, 18, '2025-03-11', '时间不充足', 'pending', '2025-05-20');

-- ----------------------------
-- Table structure for project_document
-- ----------------------------
DROP TABLE IF EXISTS `project_document`;
CREATE TABLE `project_document`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `project_id` bigint(0) NOT NULL COMMENT '项目id',
  `stage_id` bigint(0) NOT NULL COMMENT '阶段id',
  `file_path` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文件路径',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 39 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '存储项目相关文件' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of project_document
-- ----------------------------
INSERT INTO `project_document` VALUES (1, 1, 1, 'http://127.0.0.1:8100/api/files/30940b92-95ab-4f9a-ad8a-8a35b69f0147.txt');
INSERT INTO `project_document` VALUES (2, 1, 2, '');
INSERT INTO `project_document` VALUES (3, 1, 3, '');
INSERT INTO `project_document` VALUES (4, 1, 4, '');
INSERT INTO `project_document` VALUES (5, 1, 5, '');
INSERT INTO `project_document` VALUES (6, 1, 6, '');
INSERT INTO `project_document` VALUES (7, 2, 7, 'http://127.0.0.1:8100/api/files/2b124a86-4100-4577-a172-4ea9112b95b1.docx');
INSERT INTO `project_document` VALUES (8, 2, 8, '');
INSERT INTO `project_document` VALUES (9, 3, 9, 'http://127.0.0.1:8100/api/files/c9e577be-0826-4933-b975-2d6aa23f5132.doc');
INSERT INTO `project_document` VALUES (10, 4, 10, 'http://127.0.0.1:8100/api/files/7eeec311-1c87-4dd0-8362-eb74b34ff8ca.doc');
INSERT INTO `project_document` VALUES (11, 5, 11, 'http://127.0.0.1:8100/api/files/d8164ae7-479e-40ef-b92c-99915bc71779.docx');
INSERT INTO `project_document` VALUES (12, 6, 12, 'http://127.0.0.1:8100/api/files/55b6614d-c817-40fb-820c-8b4765b77a01.docx');
INSERT INTO `project_document` VALUES (13, 7, 13, 'http://127.0.0.1:8100/api/files/2c281aa2-4e47-4923-b3cc-03c9f3a75619.docx');
INSERT INTO `project_document` VALUES (14, 8, 14, 'http://127.0.0.1:8100/api/files/fd094fd9-614d-4f9a-97de-8a2c706e5c4d.txt');
INSERT INTO `project_document` VALUES (15, 9, 15, 'http://127.0.0.1:8100/api/files/82d052f6-f449-4502-b7a4-0f03d06e8895.txt');
INSERT INTO `project_document` VALUES (16, 10, 16, 'http://127.0.0.1:8100/api/files/5becff1b-d5e1-4d04-83e8-e3131060feca.txt');
INSERT INTO `project_document` VALUES (17, 11, 17, 'http://127.0.0.1:8100/api/files/50c60425-727f-4184-a97d-19a1a9678ca6.txt');
INSERT INTO `project_document` VALUES (18, 12, 18, 'http://127.0.0.1:8100/api/files/f357ca3d-fa8c-47f1-b0ab-0c0913d9bf5d.txt');
INSERT INTO `project_document` VALUES (19, 13, 19, 'http://127.0.0.1:8100/api/files/ca81f5a1-265c-4986-a35f-9fd7e14774ba.txt');
INSERT INTO `project_document` VALUES (20, 14, 20, 'http://127.0.0.1:8100/api/files/0778f776-27ed-4220-90d5-625456e768a5.txt');
INSERT INTO `project_document` VALUES (21, 15, 21, 'http://127.0.0.1:8100/api/files/dfdf1f36-baa0-404a-a5a7-5d71e07dc67e.txt');
INSERT INTO `project_document` VALUES (22, 8, 22, '');
INSERT INTO `project_document` VALUES (23, 9, 23, '');
INSERT INTO `project_document` VALUES (24, 10, 24, '');
INSERT INTO `project_document` VALUES (25, 11, 25, '');
INSERT INTO `project_document` VALUES (26, 12, 26, '');
INSERT INTO `project_document` VALUES (27, 13, 27, '');
INSERT INTO `project_document` VALUES (28, 14, 28, '');
INSERT INTO `project_document` VALUES (29, 15, 29, '');
INSERT INTO `project_document` VALUES (30, 8, 30, '');
INSERT INTO `project_document` VALUES (31, 10, 31, '');
INSERT INTO `project_document` VALUES (32, 12, 32, '');
INSERT INTO `project_document` VALUES (33, 14, 33, '');
INSERT INTO `project_document` VALUES (34, 8, 34, '');
INSERT INTO `project_document` VALUES (35, 12, 35, '');
INSERT INTO `project_document` VALUES (36, 15, 36, '');
INSERT INTO `project_document` VALUES (37, 15, 37, '');
INSERT INTO `project_document` VALUES (38, 8, 38, '');
INSERT INTO `project_document` VALUES (39, 15, 39, '');
INSERT INTO `project_document` VALUES (40, 16, 40, 'http://127.0.0.1:8100/api/files/05f5ea5f-68f8-4c11-b086-98f1bf53c4b4.docx');
INSERT INTO `project_document` VALUES (41, 17, 41, 'http://127.0.0.1:8100/api/files/3f5ac35b-b17f-45c7-a73c-6ff2e44fb33e.docx');
INSERT INTO `project_document` VALUES (42, 6, 42, '');
INSERT INTO `project_document` VALUES (43, 6, 43, '');
INSERT INTO `project_document` VALUES (44, 6, 44, '');
INSERT INTO `project_document` VALUES (45, 6, 45, '');
INSERT INTO `project_document` VALUES (46, 16, 46, '');
INSERT INTO `project_document` VALUES (47, 16, 47, '');
INSERT INTO `project_document` VALUES (48, 16, 48, '');
INSERT INTO `project_document` VALUES (49, 16, 49, '');
INSERT INTO `project_document` VALUES (50, 18, 50, 'http://127.0.0.1:8100/api/files/a1e3a9f0-1c05-496e-a7e8-e129ea380adb.docx');
INSERT INTO `project_document` VALUES (51, 18, 51, '');
INSERT INTO `project_document` VALUES (52, 18, 52, '');
INSERT INTO `project_document` VALUES (53, 18, 53, '');
INSERT INTO `project_document` VALUES (54, 18, 54, '');

-- ----------------------------
-- Table structure for project_down
-- ----------------------------
DROP TABLE IF EXISTS `project_down`;
CREATE TABLE `project_down`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `project_id` bigint(0) NOT NULL COMMENT '项目id',
  `reason` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '驳回理由',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '项目驳回表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of project_down
-- ----------------------------
INSERT INTO `project_down` VALUES (1, 15, '不够创新');
INSERT INTO `project_down` VALUES (2, 6, '可行性不通过');

-- ----------------------------
-- Table structure for project_stage
-- ----------------------------
DROP TABLE IF EXISTS `project_stage`;
CREATE TABLE `project_stage`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `project_id` bigint(0) NOT NULL COMMENT '项目id',
  `name` enum('declared','initiated','progress','completed','extended','terminated','down') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'declared' COMMENT '阶段名称（申报、立项、中检、结项、延期、终止、驳回）',
  `start_date` date NOT NULL COMMENT '阶段开始日期',
  `end_date` date NULL DEFAULT NULL COMMENT '阶段结束日期',
  `status` enum('pending','approved','rejected','progress','completed') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '阶段状态（待审核、已批准、已拒绝、进行中、已完成）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 39 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '存储项目不同阶段的信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of project_stage
-- ----------------------------
INSERT INTO `project_stage` VALUES (1, 1, 'declared', '2024-11-01', NULL, 'pending');
INSERT INTO `project_stage` VALUES (2, 1, 'initiated', '2024-11-19', NULL, 'pending');
INSERT INTO `project_stage` VALUES (3, 1, 'progress', '2024-11-19', NULL, 'pending');
INSERT INTO `project_stage` VALUES (4, 1, 'completed', '2024-11-19', NULL, 'pending');
INSERT INTO `project_stage` VALUES (5, 1, 'extended', '2024-11-19', NULL, 'pending');
INSERT INTO `project_stage` VALUES (6, 1, 'terminated', '2024-11-19', NULL, 'pending');
INSERT INTO `project_stage` VALUES (7, 2, 'declared', '2024-11-19', NULL, 'pending');
INSERT INTO `project_stage` VALUES (8, 2, 'initiated', '2024-11-19', NULL, 'pending');
INSERT INTO `project_stage` VALUES (9, 3, 'declared', '2023-12-30', NULL, 'pending');
INSERT INTO `project_stage` VALUES (10, 4, 'declared', '2024-12-01', NULL, 'pending');
INSERT INTO `project_stage` VALUES (11, 5, 'declared', '2024-11-20', NULL, 'pending');
INSERT INTO `project_stage` VALUES (12, 6, 'declared', '2024-12-10', NULL, 'pending');
INSERT INTO `project_stage` VALUES (13, 7, 'declared', '2025-01-13', NULL, 'pending');
INSERT INTO `project_stage` VALUES (14, 8, 'declared', '2025-01-04', NULL, 'pending');
INSERT INTO `project_stage` VALUES (15, 9, 'declared', '2025-01-04', NULL, 'pending');
INSERT INTO `project_stage` VALUES (16, 10, 'declared', '2025-01-04', NULL, 'pending');
INSERT INTO `project_stage` VALUES (17, 11, 'declared', '2025-01-04', NULL, 'pending');
INSERT INTO `project_stage` VALUES (18, 12, 'declared', '2025-01-04', NULL, 'pending');
INSERT INTO `project_stage` VALUES (19, 13, 'declared', '2025-01-04', NULL, 'pending');
INSERT INTO `project_stage` VALUES (20, 14, 'declared', '2025-01-04', NULL, 'pending');
INSERT INTO `project_stage` VALUES (21, 15, 'declared', '2025-01-04', NULL, 'pending');
INSERT INTO `project_stage` VALUES (22, 8, 'initiated', '2025-01-04', NULL, 'pending');
INSERT INTO `project_stage` VALUES (23, 9, 'initiated', '2025-01-04', NULL, 'pending');
INSERT INTO `project_stage` VALUES (24, 10, 'initiated', '2025-01-04', NULL, 'pending');
INSERT INTO `project_stage` VALUES (25, 11, 'initiated', '2025-01-04', NULL, 'pending');
INSERT INTO `project_stage` VALUES (26, 12, 'initiated', '2025-01-04', NULL, 'pending');
INSERT INTO `project_stage` VALUES (27, 13, 'initiated', '2025-01-04', NULL, 'pending');
INSERT INTO `project_stage` VALUES (28, 14, 'initiated', '2025-01-04', NULL, 'pending');
INSERT INTO `project_stage` VALUES (29, 15, 'initiated', '2025-01-04', NULL, 'pending');
INSERT INTO `project_stage` VALUES (30, 8, 'progress', '2025-01-04', NULL, 'pending');
INSERT INTO `project_stage` VALUES (31, 10, 'progress', '2025-01-04', NULL, 'pending');
INSERT INTO `project_stage` VALUES (32, 12, 'progress', '2025-01-04', NULL, 'pending');
INSERT INTO `project_stage` VALUES (33, 14, 'progress', '2025-01-04', NULL, 'pending');
INSERT INTO `project_stage` VALUES (34, 8, 'completed', '2025-01-04', NULL, 'pending');
INSERT INTO `project_stage` VALUES (35, 12, 'completed', '2025-01-04', NULL, 'pending');
INSERT INTO `project_stage` VALUES (36, 15, 'progress', '2025-01-04', NULL, 'pending');
INSERT INTO `project_stage` VALUES (37, 15, 'completed', '2025-01-04', NULL, 'pending');
INSERT INTO `project_stage` VALUES (38, 8, 'extended', '2025-01-04', NULL, 'pending');
INSERT INTO `project_stage` VALUES (39, 15, 'down', '2025-01-04', NULL, 'pending');
INSERT INTO `project_stage` VALUES (40, 16, 'declared', '2025-03-10', NULL, 'pending');
INSERT INTO `project_stage` VALUES (41, 17, 'declared', '2025-03-10', NULL, 'pending');
INSERT INTO `project_stage` VALUES (42, 6, 'initiated', '2025-03-10', NULL, 'pending');
INSERT INTO `project_stage` VALUES (43, 6, 'progress', '2025-03-10', NULL, 'pending');
INSERT INTO `project_stage` VALUES (44, 6, 'completed', '2025-03-10', NULL, 'pending');
INSERT INTO `project_stage` VALUES (45, 6, 'down', '2025-03-10', NULL, 'pending');
INSERT INTO `project_stage` VALUES (46, 16, 'initiated', '2025-03-10', NULL, 'pending');
INSERT INTO `project_stage` VALUES (47, 16, 'progress', '2025-03-10', NULL, 'pending');
INSERT INTO `project_stage` VALUES (48, 16, 'completed', '2025-03-10', NULL, 'pending');
INSERT INTO `project_stage` VALUES (49, 16, 'extended', '2025-03-10', NULL, 'pending');
INSERT INTO `project_stage` VALUES (50, 18, 'declared', '2025-03-11', NULL, 'pending');
INSERT INTO `project_stage` VALUES (51, 18, 'initiated', '2025-03-11', NULL, 'pending');
INSERT INTO `project_stage` VALUES (52, 18, 'progress', '2025-03-11', NULL, 'pending');
INSERT INTO `project_stage` VALUES (53, 18, 'completed', '2025-03-11', NULL, 'pending');
INSERT INTO `project_stage` VALUES (54, 18, 'extended', '2025-03-11', NULL, 'pending');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '角色表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (1, '管理员');
INSERT INTO `role` VALUES (2, '用户');
INSERT INTO `role` VALUES (3, '教师');
INSERT INTO `role` VALUES (4, '监察员');
INSERT INTO `role` VALUES (5, '审核员');

-- ----------------------------
-- Table structure for role_permission
-- ----------------------------
DROP TABLE IF EXISTS `role_permission`;
CREATE TABLE `role_permission`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `role_id` bigint(0) NOT NULL COMMENT '角色id',
  `permission_id` bigint(0) NOT NULL COMMENT '权限id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '角色权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role_permission
-- ----------------------------
INSERT INTO `role_permission` VALUES (1, 1, 1);
INSERT INTO `role_permission` VALUES (2, 2, 2);
INSERT INTO `role_permission` VALUES (3, 3, 3);
INSERT INTO `role_permission` VALUES (4, 4, 1);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `account` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '账号',
  `password` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密码',
  `position` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '教师' COMMENT '职位',
  `phone` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '手机号',
  `email` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '邮箱',
  `department` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '部门',
  `username` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户名',
  `role_id` bigint(0) NOT NULL DEFAULT 2 COMMENT '用户权限：用户/管理员/教师',
  `gender` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '男' COMMENT '性别',
  `organization` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '组织',
  `job` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '工作',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'admin', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '科研机构负责人', '12345678900', 'a@qq.com', '总部', '万丹风', 1, '男', '总部', '管理');
INSERT INTO `user` VALUES (2, 'searcher', '$2a$10$a0qNl3hz92JTqF6vSf.f6u0KJRRZ4YdicFbAdB3Q5d6SKECqGNENy', '研究员', '13517947350', '2827264925@qq.com', '区块链', 'Amy', 2, '女', '区块链', '科研');
INSERT INTO `user` VALUES (3, 'searcher2', '$2a$10$79IqO6T9Gi/aOl2X229OCOXjBnD7J.A9RObb4pjnJvK8qBkS2qBue', '科研', '13117858020', '2827264925@qq.com', '经济管理', '王维', 2, '男', '经济管理', '科研');
INSERT INTO `user` VALUES (4, 'master', '$2a$10$Ss69MJWTilaKUykzTYzcA.WlG.OWJbeToWaHq2dK/jTGAK2VtU4Zy', '教授', '11111111111', '1587691976@qq.com', '软件工程', '宋浩然', 3, '男', '软件工程', '指导');
INSERT INTO `user` VALUES (5, 'master2', '$2a$10$zMOJRabtl7OQhhn5gnu0/urfObeOrdB6IQJLzHnZJw9AOHMZAlUYe', '教授', '22222222222', '1587691976@qq.com', '机械工程', '王熙凤', 3, '女', '机械工程', '指导');
INSERT INTO `user` VALUES (6, 'AAAA', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', 'A', '11111111111', '1587691976@qq.com', '机械工程', 'A', 2, '女', '机械工程', '指导');
INSERT INTO `user` VALUES (7, 'BBBB', '$2a$10$djDMk/1FcJC5mfw1YIBxPON2TbNctiViZrpCxaYA9OPgaBVQQe1lC', 'B', '11111111111', '1587691976@qq.com', '机械工程', 'B', 2, '女', '机械工程', '指导');
INSERT INTO `user` VALUES (8, 'CCCC', '$2a$10$M0WCHibxftfEYrcyDci33O0/CkBxA6l7X3epTLeUaW9EhZDlna2Mu', 'C', '11111111111', '1587691976@qq.com', '机械工程', 'C', 2, '女', '机械工程', '指导');
INSERT INTO `user` VALUES (9, 'DDDD', '$2a$10$.tKi9Gcxws7jGR/Ur0M/c.1OJbxsis0JAgiLpEqdxQz5NfTZ2v8PG', 'D', '11111111111', '1587691976@qq.com', '机械工程', 'D', 2, '女', '机械工程', '指导');
INSERT INTO `user` VALUES (10, 'EEEE', '$2a$10$cjVaeP.tt4CznhLZXpnpFOyU7OuCLW5GD1/fa8qfCKnlLtuZAf7Dq', 'E', '11111111111', '1587691976@qq.com', '机械工程', 'E', 2, '女', '机械工程', '指导');
INSERT INTO `user` VALUES (13, 'lisi', '$2a$10$vmGIP9W0a3r7jPFeb6MfU.941K4im5ITx4l1agLqJRq0fCN8NHS.W', '无', '13125333167', '1587691976@qq.com', '机械工程', '张三', 2, '女', '机械工程', '干事');
INSERT INTO `user` VALUES (14, 'lisi', '$2a$10$evRljb9FfBXrrZWfLHU9yewgJIoY72G93LCGYbbE/qIfU2YrU.9XO', '无', '13125333167', '1587691976@qq.com', '机械工程', '张三', 2, '女', '机械工程', '干事');
INSERT INTO `user` VALUES (15, 'wangwu', '$2a$10$D7obNcqP.MQmDmXCc94iguMhWJe4DODiM2lqTmoGUXxP4reGXilHK', '无', '13125333167', '1587691976@qq.com', '机械工程', '王五', 3, '男', '机械工程', '干事');
INSERT INTO `user` VALUES (16, 'zzzzz', '$2a$10$DgYjD34LmcPRMaRegFZOOO91ILHAZQNA2UbN.lQE2EUbzoFpxrgYS', 'z', '13517947350', '2827264925@qq.com', 'zz', 'zz', 3, 'zz', 'zz', 'zz');
INSERT INTO `user` VALUES (19, 'WWWW', '$2a$10$Xv74iG76q0StQIj359utau8A5IUAFarwzLhGfcV3df.Hui4DHWMuq', '学生', '13517947350', '2827264925@qq.com', '区块链', '万丹风', 2, '女', ' ', '研究');
INSERT INTO `user` VALUES (20, 'WWWW', '$2a$10$ZmJ0MinVimg53vQq2JSwOuvX7j63JdG4Pbj/gYZ8yrcY1myX3y99O', '学生', '13517947350', '2827264925@qq.com', '区块链', '万丹风', 2, '女', ' ', '研究');

SET FOREIGN_KEY_CHECKS = 1;
