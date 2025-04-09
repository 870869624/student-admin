/*
 Navicat Premium Data Transfer

 Source Server         : intelligent
 Source Server Type    : MySQL
 Source Server Version : 80029
 Source Host           : localhost:3306
 Source Schema         : data

 Target Server Type    : MySQL
 Target Server Version : 80029
 File Encoding         : 65001

 Date: 05/04/2025 18:43:02
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for announce
-- ----------------------------
DROP TABLE IF EXISTS `announce`;
CREATE TABLE `announce`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `title` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `content` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of announce
-- ----------------------------
INSERT INTO `announce` VALUES (1, '系统升级公告', '亲爱的科研人员：\r\n为进一步提升科研管理系统的功能与稳定性，我们将于 2025年4月20日 24：00对系统进行升级维护。届时，系统将暂时无法访问。\r\n此次升级将优化项目申报流程，新增数据智能分析功能，助力您更高效地开展科研工作。维护结束后，您可正常登录使用系统。若您在使用过程中遇到问题，欢迎联系系统客服，联系电话：[13123456789]，邮箱：[keyan@qq.com]。\r\n感谢您的理解与支持！');
INSERT INTO `announce` VALUES (2, '科研项目申报通知', '2025 年度省级自然科学基金项目申报工作现已开启。该基金旨在支持基础研究，鼓励科研创新。');
INSERT INTO `announce` VALUES (7, '新公告', '这是一条新公告！');

-- ----------------------------
-- Table structure for note
-- ----------------------------
DROP TABLE IF EXISTS `note`;
CREATE TABLE `note`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `title` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `user_id` bigint(0) NOT NULL,
  `status` tinyint(0) NOT NULL,
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of note
-- ----------------------------
INSERT INTO `note` VALUES (16, '区块链供应链管理平台开发', 6, 1, 'initiated');
INSERT INTO `note` VALUES (17, '基于深度学习的图像语义分割算法优化研究', 1, 1, 'declared');
INSERT INTO `note` VALUES (18, '基于深度学习的图像语义分割算法优化研究', 6, 1, 'initiated');

-- ----------------------------
-- Table structure for permission
-- ----------------------------
DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '权限名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '权限表' ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 40 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '项目表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of project
-- ----------------------------
INSERT INTO `project` VALUES (1, '医信链', '打开命令行终端。\n输入 redis-cli --version 或 redis-cli -v 命令。\n按下回车键，系统会返回 Redis 的版本信息。', '2024-03-01', '2024-12-01', 'terminated', 2, '区块链', 0, '第一批次', 'Amy', '[2]', 'paper');
INSERT INTO `project` VALUES (2, 'NFT数字藏品', 'NFT的核心价值在于推动数字内容资产化，保证数字资产的唯一性、真实性和永久性，提高数字资产的交易流动性，刺激“创作者经济”的持续发展。', '2024-04-01', '2024-11-30', 'initiated', 2, '市场', 0, '第二批次', 'seacher', '[2]', 'project');
INSERT INTO `project` VALUES (3, 'CET反拨效应基准研究', '反拨效应是指测试对教与学所产生的影响，在应用语言学领域中特指语言测试尤其是外语测试对相应的外语教和学产生的影响。语言测试反拨效应研究是应用语言学中一个相对较新的领域,同时也是测试领域的一个重要研究课题。近年来，众多学者对反拨效应进行了大量而深入的研究，不断丰富和完善了反拨效应理论，同时也在一定程度上推动了测试和教学改革。', '2023-05-01', '2024-01-01', 'completed', 1, '教育', 0, '第一批次', '研究', '[6]', 'software');
INSERT INTO `project` VALUES (4, '高考能力考查与内容改革创新研究', '高考制度恢复以来，其自身的改革不断进行，逐渐发展为较为科学、基本准确测量考生知识和能力水平的标准化考试。但2013年11月，《中共中央关于全面深化改革若干重大问题的决定》提出推进考试招生制度改革的任务，其中关于高考内容改革的主要目标和措施有：“加快推进职业院校分类招考或注册入学”、“逐步推行普通高校基于统一高考和高中学业水平考试成绩的综合评价多元录取机制”和“探索全国统考减少科目、不分文理科、外语等科目社会化考试一年多考”等，这些改革措施都是高考历史上首次提出来的。高考的定位与考试的内容都发生了较大变化，必须对内容改革与能力考查进行创新研究。', '2024-06-01', '2025-01-01', 'declared', 1, '教育', 0, '第二批次', '研究', '[2]', 'software');
INSERT INTO `project` VALUES (5, '浅析震源位置准确度及其影响因素', '联合应用多种设计策略优化聚氨酯神经导管虽然可以在多方面改善受损神经的功能,但由于神经复杂的结构和动态变化的病理生理微环境,神经导管设计策略仍旧有待完善。未来进一步改进和创新神经仿生设计策略,有望为神经组织工程领域的发展提供新的思路和机遇。', '2024-11-20', '2025-12-30', 'declared', 1, '国安', 5, '第一批次', '实验', '[7]', 'project');
INSERT INTO `project` VALUES (6, '长筒花叶片离体培养研究', '为建立长筒花的叶片离体培养体系,以苦苣苔科长筒花属长筒花品种‘kim blue’的叶片作为外植体,探索培养过程中各个可能影响培养结果的因素,包括灭菌时长的不同组合、灭菌方法,各培养阶段的激素种类及其配比,进而筛选出影响因素的最佳值。结果显示,叶片外植体最适的灭菌组合和方法为75%酒精消毒15 s+2%次氯酸钠7 min;最佳的启动培养基配方为:MS+6-BA1.0 mg/L+NAA 0.1 mg/L;最佳的增殖培养基配方为:MS+6-BA 2.0 mg/L+NAA 0.5 mg/L;最佳的壮苗培养基配方为:1/2MS+IBA 0.1 mg/L+NAA0.1 mg/L+CCC 0.5 mg/L。', '2024-12-10', '2025-02-20', 'down', 1, '科学', 5, '第一批次', '研究', '[]', 'patent');
INSERT INTO `project` VALUES (7, '元宇宙服务的人机交互综述', '近年来,元宇宙飞速发展,已成为未来数字世界的一个重要发展方向。元宇宙中的人机交互是实现虚实融合的核心,其解决了元宇宙中的多用户协作、沟通、社交等挑战,促进了创新和合作。为了深入探讨元宇宙作为虚拟和现实世界融合的数字化空间,其服务如何与人机交互相结合,创造出丰富、沉浸式、个性化的用户体验,调研了元宇宙和人机交互技术,并从人机交互的角度对元宇宙的概念进行了定义。讨论了元宇宙服务和人机融合的可行性与优势,并整理归纳了现有的挑战。最后探讨了元宇宙服务的未来发展趋势。', '2025-01-13', '2025-03-30', 'declared', 1, '科学', 0, '第二批次', '研究', '[8]', 'patent');
INSERT INTO `project` VALUES (8, '量子计算在量子化学中的应用研究', '本项目研究量子计算在量子化学中的应用，特别是如何通过量子算法加速分子模拟和化学反应的计算。项目将开发高效的量子模拟算法，并在实验室环境中进行测试，以验证其在化学研究中的潜力。', '2025-02-01', '2025-03-15', 'extended', 1, '教育', 4, '第一批次', '研究', '[2]', 'paper');
INSERT INTO `project` VALUES (9, '人工智能在智能电网中的应用研究', '本项目探讨人工智能技术在智能电网中的应用，特别是如何通过机器学习算法优化电力分配和故障预测。项目将与多家电力公司合作，开发智能电网管理系统，并进行实地测试。', '2024-05-26', '2025-03-15', 'initiated', 1, '教育', 4, '第一批次', '研究', '[]', 'paper');
INSERT INTO `project` VALUES (10, '量子计算模拟软件开发', '本项目开发一款用于量子计算模拟的软件，旨在帮助研究人员和学生更好地理解和使用量子算法。软件将提供用户友好的界面和强大的模拟功能，支持多种量子计算模型。', '2024-09-05', '2025-03-15', 'progress', 1, '科研', 4, '第一批次', '实验', '[]', 'software');
INSERT INTO `project` VALUES (11, '智能电网管理系统开发', '本项目开发一套智能电网管理系统，利用人工智能技术优化电力分配和故障预测。系统将集成实时数据分析和自动化控制功能，提高电网运行效率。', '2024-08-08', '2025-03-15', 'progress', 1, '科研', 5, '第一批次', '实验', '[]', 'software');
INSERT INTO `project` VALUES (12, '量子计算实验项目', '本项目开展量子计算实验研究，探索量子比特的制备、操控和测量技术。项目将与多家科研机构合作，建设量子计算实验室，并进行一系列实验验证。', '2024-07-20', '2025-04-15', 'completed', 1, '物理部', 4, '第一批次', '编码', '[]', 'project');
INSERT INTO `project` VALUES (13, '智能电网示范项目', '本项目开展智能电网示范工程建设，展示人工智能技术在电力分配和故障预测中的实际应用。项目将与多家电力公司合作，建设智能电网示范区域。', '2025-03-05', '2025-06-10', 'initiated', 1, '能源部', 5, '第二批次', '编码', '[]', 'project');
INSERT INTO `project` VALUES (14, '智能电网管理系统专利申请', '本项目致力于开发智能电网管理系统，并申请相关专利。项目将与多家电力公司合作，研究智能电网的优化和故障预测技术，并提交专利申请。', '2025-04-15', '2025-05-30', 'completed', 1, '能源部', 4, '第一批次', '研究', '[]', 'patent');
INSERT INTO `project` VALUES (15, '虚拟现实心理治疗方案专利申请', '本项目致力于开发虚拟现实心理治疗方案，并申请相关专利。项目将与多家医疗机构合作，研究虚拟现实技术在心理治疗中的应用，并提交专利申请。', '2024-10-25', '2025-04-15', 'down', 1, '心理部\'', 5, '第二批次', '研究', '[]', 'patent');
INSERT INTO `project` VALUES (18, '区块链供应链试点项目', '本项目开展区块链供应链试点项目，验证区块链技术在货物追踪和溯源中的应用效果。项目将与多家物流企业合作，建设区块链供应链试点区域。', '2025-03-11', '2025-04-10', 'extended', 19, '区块链', 4, '第一批次', ' 研究', '[2,3]', 'project');
INSERT INTO `project` VALUES (19, '区块链供应链管理平台开发', '本项目开发一个基于区块链的供应链管理平台，提高供应链的透明度和效率。平台将支持货物追踪、溯源和智能合约功能，降低运营成本。', '2025-03-11', '2025-04-15', 'initiated', 6, '区块链', 4, '第一批次', ' 研究', '[2,3]', 'project');
INSERT INTO `project` VALUES (20, '区块链技术应用', '区块链技术在金融领域的应用，提升交易透明度和安全性。', '2024-12-01', '2025-07-10', 'declared', 82, '计算机', 0, '第三批次', '研究', '[83]', 'software');
INSERT INTO `project` VALUES (21, '人工智能研究', '研究人工智能在医疗影像分析中的应用。', '2024-03-20', '2025-06-30', 'progress', 83, '医疗', 0, '第三批次', '实验', '[84]', 'patent');
INSERT INTO `project` VALUES (22, '量子计算探索', '本项目探索量子计算在密码学中的应用，特别是在量子加密和量子密钥分发（QKD）方面。研究将评估量子计算对传统加密算法的影响，并开发新的量子安全协议。项目目标是为未来的信息安全提供更强大的保障。', '2024-03-20', '2025-06-30', 'declared', 84, '科学', 0, '第三批次', '实验', '[82]', 'software');
INSERT INTO `project` VALUES (23, '虚拟现实开发', '本项目开发虚拟现实技术在教育领域的应用，特别是如何通过沉浸式学习环境提高学生的学习兴趣和效果。项目将设计和开发一系列虚拟现实课程，并在多所学校进行试点。', '2024-05-31', '2025-05-22', 'declared', 84, '教育', 0, '第三批次', '研究', '[]', 'software');
INSERT INTO `project` VALUES (24, '基因编辑技术', '研究基因编辑技术在医学中的应用。', '2024-08-30', '2025-06-30', 'initiated', 84, '医疗', 0, '第四批次', '研究', '[]', 'project');
INSERT INTO `project` VALUES (25, '量子通信技术', '探索量子通信技术在信息安全中的应用。', '2024-07-20', '2025-07-25', 'declared', 84, '科学', 0, '第四批次', '实验', '[]', 'patent');
INSERT INTO `project` VALUES (26, '量子计算优化', '优化量子计算算法以提高计算效率。', '2025-01-20', '2025-10-30', 'initiated', 84, '科学', 0, '第五批次', '实验', '[]', 'patent');
INSERT INTO `project` VALUES (27, '人工智能伦理', '研究人工智能在社会中的伦理问题。', '2024-08-30', '2025-07-15', 'initiated', 84, '教育', 0, '第五批次', '研究', '[]', 'paper');
INSERT INTO `project` VALUES (28, '航空航天研究', '探索航空航天技术在卫星通信中的应用。', '2025-05-30', '2025-08-30', 'initiated', 85, '航空航天', 0, '第二批次', '研究', '[]', 'project');
INSERT INTO `project` VALUES (29, '可再生能源研究', '研究可再生能源在电力供应中的应用。', '2024-07-30', '2025-10-10', 'initiated', 85, '研究', 0, '第三批次', '能源', '[]', 'patent');
INSERT INTO `project` VALUES (30, '海洋能源开发', '研究海洋能源的开发与利用。', '2025-03-30', '2025-11-20', 'initiated', 85, '研究', 0, '第五批次', '研究', '[]', 'software');
INSERT INTO `project` VALUES (31, '海洋能源转换', '研究海洋能源转换技术的效率提升。', '2024-03-20', '2025-06-20', 'initiated', 85, '研究', 0, '第三批次', '实验', '[]', 'patent');
INSERT INTO `project` VALUES (32, '智能交通系统', '开发智能交通系统在城市交通中的应用。', '2024-11-05', '2025-08-21', 'declared', 85, '研究', 0, '第三批次', '研究', '[]', 'paper');
INSERT INTO `project` VALUES (33, '智能机器人控制', '开发智能机器人在复杂环境中的控制技术。', '2025-02-10', '2025-09-20', 'declared', 85, '计算机', 0, '第五批次', '实验', '[]', 'patent');
INSERT INTO `project` VALUES (34, 'NFT数字藏品创新应用', '本项目旨在探索NFT技术在数字艺术、文化遗产保护和虚拟经济中的创新应用。通过区块链技术，确保数字资产的唯一性、真实性和永久性，提升数字内容的价值和交易流动性。项目将与多家艺术机构合作，推动“创作者经济”的持续发展。', '2024-04-01', '2024-11-30', 'progress', 65, '市场部', 0, '第一批次', '研究', '[]', 'paper');
INSERT INTO `project` VALUES (35, '区块链金融安全研究', '本项目聚焦于区块链技术在金融领域的应用，特别是如何通过区块链提升交易的透明度和安全性。研究将涵盖智能合约的开发、去中心化金融（DeFi）的风险评估以及区块链在跨境支付中的应用。项目目标是为金融机构提供创新的解决方案，以应对当前的网络安全挑战。', '2024-05-01', '2024-12-31', 'initiated', 65, '技术部', 0, '第三批次', '研究', '[]', 'software');
INSERT INTO `project` VALUES (36, '人工智能医疗影像分析', '本项目致力于开发人工智能算法，用于医疗影像的自动分析和诊断。通过深度学习技术，提高影像诊断的准确性和效率，帮助医生更快地发现疾病迹象。项目将与多家医院合作，收集和标注大量影像数据，以训练和验证算法的性能。', '2024-06-01', '2024-11-30', 'progress', 65, '研发部', 0, '第二批次', '研究', '[]', 'project');
INSERT INTO `project` VALUES (37, '6G通信技术在下一代网络中的应用', '本项目研究6G通信技术在下一代网络中的应用，特别是在高带宽、低延迟和大规模连接方面的优势。项目将与多家通信企业合作，开发新型6G网络架构。', '2025-08-01', '2025-11-30', 'completed', 65, '通信部', 0, '第四批次', '研究', '[]', 'software');
INSERT INTO `project` VALUES (38, '虚拟现实技术在职业教育中的应用', '本项目开发虚拟现实技术在职业教育中的应用，特别是如何通过沉浸式学习环境提高学生的学习兴趣和效果。项目将设计和开发一系列虚拟现实课程，并在多所学校进行试点', '2025-03-26', '2025-12-20', 'initiated', 65, '教育', 0, '第三批次', '研究', '[]', 'paper');
INSERT INTO `project` VALUES (39, '这是一个科研项目', 'lin_daiyu——这是一个科研项目！', '2025-03-10', '2025-07-25', 'completed', 28, '科研', 0, '第三批次', '研究', '[2]', 'project');
INSERT INTO `project` VALUES (40, '20210329科研项目视频', '科研项目视频！科研项目视频！', '2025-03-28', '2025-07-30', 'completed', 6, '科研', 0, '第四批次', '研究', '[]', 'project');
INSERT INTO `project` VALUES (41, '基于深度学习的图像语义分割算法优化研究', '本项目旨在通过对现有深度学习算法的深入研究和改进，提高图像语义分割的准确性和效率。利用卷积神经网络（CNN）和循环神经网络（RNN）的结合，探索更有效的特征提取和融合方法，以应对复杂场景下的图像分割任务，如医疗影像分析、自动驾驶中的道路和物体识别等。', '2025-04-05', '2025-08-30', 'initiated', 6, '计算机科学', 0, '第四批次', '研究', '[28]', 'software');

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
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '记录项目延期申请的信息' ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 105 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '存储项目相关文件' ROW_FORMAT = Dynamic;

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
INSERT INTO `project_document` VALUES (55, 19, 55, 'http://127.0.0.1:8100/api/files/5410df43-d6bb-45f7-8981-d7cdbf2597a1.txt');
INSERT INTO `project_document` VALUES (56, 20, 56, 'http://127.0.0.1:8100/api/files/566a3dcf-3b64-4ccb-ae5c-b9ad820f488e.txt');
INSERT INTO `project_document` VALUES (57, 21, 57, 'http://127.0.0.1:8100/api/files/a69f28fc-f077-40ae-ad64-60533dd9a8ea.txt');
INSERT INTO `project_document` VALUES (58, 22, 58, 'http://127.0.0.1:8100/api/files/2c937670-ff11-41b4-8dd0-64978c14d848.txt');
INSERT INTO `project_document` VALUES (59, 23, 59, 'http://127.0.0.1:8100/api/files/5c8de702-ec81-44ba-96e2-1a511d3d33ad.txt');
INSERT INTO `project_document` VALUES (60, 24, 60, 'http://127.0.0.1:8100/api/files/8fc707a7-9c6e-40c8-8d05-438969c336fb.txt');
INSERT INTO `project_document` VALUES (61, 25, 61, 'http://127.0.0.1:8100/api/files/575418db-d732-47b8-b387-e3de2d0aeba8.txt');
INSERT INTO `project_document` VALUES (62, 26, 62, 'http://127.0.0.1:8100/api/files/8acf0dc5-c2b2-4739-8029-b2a733b04e09.txt');
INSERT INTO `project_document` VALUES (63, 27, 63, 'http://127.0.0.1:8100/api/files/23e0e6b4-3f79-49da-b5b2-7b9831ffb54e.txt');
INSERT INTO `project_document` VALUES (64, 28, 64, 'http://127.0.0.1:8100/api/files/b577c54a-756a-4fac-a853-37f5140124b6.txt');
INSERT INTO `project_document` VALUES (65, 29, 65, 'http://127.0.0.1:8100/api/files/93fc9411-99f9-48bc-8716-08c7360f1cb0.txt');
INSERT INTO `project_document` VALUES (66, 30, 66, 'http://127.0.0.1:8100/api/files/6da77c45-b844-44b0-ac35-81e7e30aaadb.txt');
INSERT INTO `project_document` VALUES (67, 31, 67, 'http://127.0.0.1:8100/api/files/d2badc2b-7ed7-42df-80f1-a6975cd70139.txt');
INSERT INTO `project_document` VALUES (68, 32, 68, 'http://127.0.0.1:8100/api/files/99ee736b-6454-4d10-a342-811ab21b9a2e.txt');
INSERT INTO `project_document` VALUES (69, 33, 69, 'http://127.0.0.1:8100/api/files/6f4b2881-fc7b-4bf5-8468-d3aae877233b.txt');
INSERT INTO `project_document` VALUES (70, 34, 70, 'http://127.0.0.1:8100/api/files/e50bef17-b595-4913-aa61-df04a13740a9.txt');
INSERT INTO `project_document` VALUES (71, 35, 71, 'http://127.0.0.1:8100/api/files/8aa994ac-a57c-4000-9d97-01c0a10dd6a9.txt');
INSERT INTO `project_document` VALUES (72, 36, 72, 'http://127.0.0.1:8100/api/files/2bc550cc-7d85-422a-90cb-3c242eb16b3e.txt');
INSERT INTO `project_document` VALUES (73, 37, 73, 'http://127.0.0.1:8100/api/files/f6e65543-b926-468d-9057-58a3c827ae0e.txt');
INSERT INTO `project_document` VALUES (74, 38, 74, 'http://127.0.0.1:8100/api/files/3f4eff0d-7d15-4f58-a137-a8031ed1a7b4.txt');
INSERT INTO `project_document` VALUES (75, 3, 75, '');
INSERT INTO `project_document` VALUES (76, 37, 76, '');
INSERT INTO `project_document` VALUES (77, 34, 77, '');
INSERT INTO `project_document` VALUES (78, 38, 78, '');
INSERT INTO `project_document` VALUES (79, 27, 79, '');
INSERT INTO `project_document` VALUES (80, 30, 80, '');
INSERT INTO `project_document` VALUES (81, 34, 81, '');
INSERT INTO `project_document` VALUES (82, 26, 82, '');
INSERT INTO `project_document` VALUES (83, 31, 83, '');
INSERT INTO `project_document` VALUES (84, 35, 84, '');
INSERT INTO `project_document` VALUES (85, 28, 85, '');
INSERT INTO `project_document` VALUES (86, 36, 86, '');
INSERT INTO `project_document` VALUES (87, 21, 87, '');
INSERT INTO `project_document` VALUES (88, 24, 88, '');
INSERT INTO `project_document` VALUES (89, 29, 89, '');
INSERT INTO `project_document` VALUES (90, 3, 90, '');
INSERT INTO `project_document` VALUES (91, 11, 91, '');
INSERT INTO `project_document` VALUES (92, 37, 92, '');
INSERT INTO `project_document` VALUES (93, 36, 93, '');
INSERT INTO `project_document` VALUES (94, 21, 94, '');
INSERT INTO `project_document` VALUES (95, 37, 95, '');
INSERT INTO `project_document` VALUES (96, 3, 96, '');
INSERT INTO `project_document` VALUES (97, 14, 97, '');
INSERT INTO `project_document` VALUES (98, 39, 98, 'http://127.0.0.1:8100/api/files/d999d199-1987-4de5-ba1e-c36211c8d00d.txt');
INSERT INTO `project_document` VALUES (99, 39, 99, '');
INSERT INTO `project_document` VALUES (100, 39, 100, '');
INSERT INTO `project_document` VALUES (101, 39, 101, '');
INSERT INTO `project_document` VALUES (102, 40, 102, 'http://127.0.0.1:8100/api/files/afa1a4dd-73cd-41ab-9824-6e25acbf178a.txt');
INSERT INTO `project_document` VALUES (103, 40, 103, '');
INSERT INTO `project_document` VALUES (104, 40, 104, '');
INSERT INTO `project_document` VALUES (105, 40, 105, '');
INSERT INTO `project_document` VALUES (106, 19, 106, '');
INSERT INTO `project_document` VALUES (107, 41, 107, 'http://127.0.0.1:8100/api/files/f1d5c45b-b060-4c92-b548-062fb3ed22f1.pdf');
INSERT INTO `project_document` VALUES (108, 41, 108, '');

-- ----------------------------
-- Table structure for project_down
-- ----------------------------
DROP TABLE IF EXISTS `project_down`;
CREATE TABLE `project_down`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `project_id` bigint(0) NOT NULL COMMENT '项目id',
  `reason` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '驳回理由',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '项目驳回表' ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 105 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '存储项目不同阶段的信息' ROW_FORMAT = Dynamic;

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
INSERT INTO `project_stage` VALUES (55, 19, 'declared', '2025-03-11', NULL, 'pending');
INSERT INTO `project_stage` VALUES (56, 20, 'declared', '2024-12-01', NULL, 'pending');
INSERT INTO `project_stage` VALUES (57, 21, 'declared', '2024-03-20', NULL, 'pending');
INSERT INTO `project_stage` VALUES (58, 22, 'declared', '2024-03-20', NULL, 'pending');
INSERT INTO `project_stage` VALUES (59, 23, 'declared', '2024-05-31', NULL, 'pending');
INSERT INTO `project_stage` VALUES (60, 24, 'declared', '2024-08-30', NULL, 'pending');
INSERT INTO `project_stage` VALUES (61, 25, 'declared', '2024-07-20', NULL, 'pending');
INSERT INTO `project_stage` VALUES (62, 26, 'declared', '2025-01-20', NULL, 'pending');
INSERT INTO `project_stage` VALUES (63, 27, 'declared', '2024-08-30', NULL, 'pending');
INSERT INTO `project_stage` VALUES (64, 28, 'declared', '2025-05-30', NULL, 'pending');
INSERT INTO `project_stage` VALUES (65, 29, 'declared', '2024-07-30', NULL, 'pending');
INSERT INTO `project_stage` VALUES (66, 30, 'declared', '2025-03-30', NULL, 'pending');
INSERT INTO `project_stage` VALUES (67, 31, 'declared', '2024-03-20', NULL, 'pending');
INSERT INTO `project_stage` VALUES (68, 32, 'declared', '2024-11-05', NULL, 'pending');
INSERT INTO `project_stage` VALUES (69, 33, 'declared', '2025-02-10', NULL, 'pending');
INSERT INTO `project_stage` VALUES (70, 34, 'declared', '2024-04-01', NULL, 'pending');
INSERT INTO `project_stage` VALUES (71, 35, 'declared', '2024-05-01', NULL, 'pending');
INSERT INTO `project_stage` VALUES (72, 36, 'declared', '2024-06-01', NULL, 'pending');
INSERT INTO `project_stage` VALUES (73, 37, 'declared', '2025-08-01', NULL, 'pending');
INSERT INTO `project_stage` VALUES (74, 38, 'declared', '2025-03-26', NULL, 'pending');
INSERT INTO `project_stage` VALUES (75, 3, 'initiated', '2025-03-26', NULL, 'pending');
INSERT INTO `project_stage` VALUES (76, 37, 'initiated', '2025-03-26', NULL, 'pending');
INSERT INTO `project_stage` VALUES (77, 34, 'initiated', '2025-03-26', NULL, 'pending');
INSERT INTO `project_stage` VALUES (78, 38, 'initiated', '2025-03-26', NULL, 'pending');
INSERT INTO `project_stage` VALUES (79, 27, 'initiated', '2025-03-26', NULL, 'pending');
INSERT INTO `project_stage` VALUES (80, 30, 'initiated', '2025-03-26', NULL, 'pending');
INSERT INTO `project_stage` VALUES (81, 34, 'progress', '2025-03-26', NULL, 'pending');
INSERT INTO `project_stage` VALUES (82, 26, 'initiated', '2025-03-26', NULL, 'pending');
INSERT INTO `project_stage` VALUES (83, 31, 'initiated', '2025-03-26', NULL, 'pending');
INSERT INTO `project_stage` VALUES (84, 35, 'initiated', '2025-03-26', NULL, 'pending');
INSERT INTO `project_stage` VALUES (85, 28, 'initiated', '2025-03-26', NULL, 'pending');
INSERT INTO `project_stage` VALUES (86, 36, 'initiated', '2025-03-26', NULL, 'pending');
INSERT INTO `project_stage` VALUES (87, 21, 'initiated', '2025-03-26', NULL, 'pending');
INSERT INTO `project_stage` VALUES (88, 24, 'initiated', '2025-03-26', NULL, 'pending');
INSERT INTO `project_stage` VALUES (89, 29, 'initiated', '2025-03-26', NULL, 'pending');
INSERT INTO `project_stage` VALUES (90, 3, 'progress', '2025-03-26', NULL, 'pending');
INSERT INTO `project_stage` VALUES (91, 11, 'progress', '2025-03-26', NULL, 'pending');
INSERT INTO `project_stage` VALUES (92, 37, 'progress', '2025-03-26', NULL, 'pending');
INSERT INTO `project_stage` VALUES (93, 36, 'progress', '2025-03-26', NULL, 'pending');
INSERT INTO `project_stage` VALUES (94, 21, 'progress', '2025-03-26', NULL, 'pending');
INSERT INTO `project_stage` VALUES (95, 37, 'completed', '2025-03-26', NULL, 'pending');
INSERT INTO `project_stage` VALUES (96, 3, 'completed', '2025-03-26', NULL, 'pending');
INSERT INTO `project_stage` VALUES (97, 14, 'completed', '2025-03-26', NULL, 'pending');
INSERT INTO `project_stage` VALUES (98, 39, 'declared', '2025-03-10', NULL, 'pending');
INSERT INTO `project_stage` VALUES (99, 39, 'initiated', '2025-03-28', NULL, 'pending');
INSERT INTO `project_stage` VALUES (100, 39, 'progress', '2025-03-28', NULL, 'pending');
INSERT INTO `project_stage` VALUES (101, 39, 'completed', '2025-03-28', NULL, 'pending');
INSERT INTO `project_stage` VALUES (102, 40, 'declared', '2025-03-28', NULL, 'pending');
INSERT INTO `project_stage` VALUES (103, 40, 'initiated', '2025-03-28', NULL, 'pending');
INSERT INTO `project_stage` VALUES (104, 40, 'progress', '2025-03-28', NULL, 'pending');
INSERT INTO `project_stage` VALUES (105, 40, 'completed', '2025-03-28', NULL, 'pending');
INSERT INTO `project_stage` VALUES (106, 19, 'initiated', '2025-04-05', NULL, 'pending');
INSERT INTO `project_stage` VALUES (107, 41, 'declared', '2025-04-05', NULL, 'pending');
INSERT INTO `project_stage` VALUES (108, 41, 'initiated', '2025-04-05', NULL, 'pending');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 31 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '角色表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (1, '管理员');
INSERT INTO `role` VALUES (2, '用户');
INSERT INTO `role` VALUES (3, '教师');

-- ----------------------------
-- Table structure for role_permission
-- ----------------------------
DROP TABLE IF EXISTS `role_permission`;
CREATE TABLE `role_permission`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `role_id` bigint(0) NOT NULL COMMENT '角色id',
  `permission_id` bigint(0) NOT NULL COMMENT '权限id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '角色权限表' ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 121 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'admin', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '科研机构负责人', '12345678900', 'admin@qq.com', '总部', '万丹风', 1, '男', '总部', '管理');
INSERT INTO `user` VALUES (2, 'searcher', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究员', '13517947350', '2827264925@qq.com', '区块链', 'Amy', 2, '女', '区块链', '科研');
INSERT INTO `user` VALUES (3, 'searcher2', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13117858020', '2827264925@qq.com', '经济管理', '王维', 2, '男', '经济管理', '科研');
INSERT INTO `user` VALUES (4, 'master', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '教授', '13120000000', '1587691976@qq.com', '软件工程', '宋徽宗', 3, '男', '软件工程', '指导');
INSERT INTO `user` VALUES (5, 'master2', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '教授', '13520000000', '1587691976@qq.com', '机械工程', '吴彦祖', 3, '男', '机械工程', '指导');
INSERT INTO `user` VALUES (6, 'liu_yifei', '$2a$10$zMFf3poxtClPGnZk8B8L7u6JqQGrTcE3mleZibwNLvamwoXj2FQKi', '研究人员', '13230000000', '1587691976@qq.com', '机械工程', '刘亦菲', 2, '女', '机械工程', '指导');
INSERT INTO `user` VALUES (27, 'jia_baoyu', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000001', 'jia_baoyu@qq.com', '研发部', '贾宝玉', 2, '男', '贾府', '研发');
INSERT INTO `user` VALUES (28, 'lin_daiyu', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000002', 'lin_daiyu@qq.com', '市场部', '林黛玉', 2, '女', '贾府', '市场');
INSERT INTO `user` VALUES (29, 'xue_baochai', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000003', 'xue_baochai@qq.com', '人事部', '薛宝钗', 2, '女', '贾府', '人事');
INSERT INTO `user` VALUES (30, 'wang_xifeng', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000004', 'wang_xifeng@qq.com', '财务部', '王熙凤', 2, '女', '贾府', '财务');
INSERT INTO `user` VALUES (31, 'jia_yuan Chun', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000005', 'jia_yuanchun@qq.com', '后勤部', '贾元春', 2, '女', '贾府', '后勤');
INSERT INTO `user` VALUES (32, 'jia_tanchun', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000006', 'jia_tanchun@qq.com', '公关部', '贾探春', 2, '女', '贾府', '公关');
INSERT INTO `user` VALUES (33, 'jia_xichun', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000007', 'jia_xichun@qq.com', '技术部', '贾惜春', 2, '女', '贾府', '技术');
INSERT INTO `user` VALUES (34, 'jia_zhao', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000008', 'jia_zhao@qq.com', '销售部', '贾赦', 2, '男', '贾府', '销售');
INSERT INTO `user` VALUES (35, 'jia_jing', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000009', 'jia_jing@qq.com', '客服部', '贾敬', 2, '男', '贾府', '客服');
INSERT INTO `user` VALUES (36, 'jia_zhen', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000010', 'jia_zhen@qq.com', '采购部', '贾珍', 2, '男', '贾府', '采购');
INSERT INTO `user` VALUES (37, 'jia_zheng', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000011', 'jia_zheng@qq.com', '研发部', '贾政', 2, '男', '贾府', '研发');
INSERT INTO `user` VALUES (38, 'jia_yu', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000012', 'jia_yu@qq.com', '市场部', '贾蓉', 2, '男', '贾府', '市场');
INSERT INTO `user` VALUES (39, 'jia_huan', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000013', 'jia_huan@qq.com', '人事部', '贾环', 2, '男', '贾府', '人事');
INSERT INTO `user` VALUES (40, 'jia_lan', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000014', 'jia_lan@qq.com', '财务部', '贾兰', 2, '男', '贾府', '财务');
INSERT INTO `user` VALUES (41, 'jia_qiao', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000015', 'jia_qiao@qq.com', '后勤部', '贾巧姐', 2, '女', '贾府', '后勤');
INSERT INTO `user` VALUES (42, 'jia_xue', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000016', 'jia_xue@qq.com', '公关部', '贾惜春', 2, '女', '贾府', '公关');
INSERT INTO `user` VALUES (43, 'jia_ying', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000017', 'jia_ying@qq.com', '技术部', '贾迎春', 2, '女', '贾府', '技术');
INSERT INTO `user` VALUES (44, 'jia_meng', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000018', 'jia_meng@qq.com', '销售部', '贾敏', 2, '女', '贾府', '销售');
INSERT INTO `user` VALUES (45, 'jia_ming', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000019', 'jia_ming@qq.com', '客服部', '贾敏', 2, '女', '贾府', '客服');
INSERT INTO `user` VALUES (46, 'jia_hai', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000020', 'jia_hai@qq.com', '采购部', '贾海', 2, '男', '贾府', '采购');
INSERT INTO `user` VALUES (47, 'song_jiang', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000021', 'song_jiang@qq.com', '研发部', '宋江', 2, '男', '梁山泊', '研发');
INSERT INTO `user` VALUES (48, 'lu_zhi Shen', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000022', 'lu_zhishen@qq.com', '市场部', '鲁智深', 2, '男', '梁山泊', '市场');
INSERT INTO `user` VALUES (49, 'wu_song', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000023', 'wu_song@qq.com', '人事部', '武松', 2, '男', '梁山泊', '人事');
INSERT INTO `user` VALUES (50, 'lin_chong', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000024', 'lin_chong@qq.com', '财务部', '林冲', 2, '男', '梁山泊', '财务');
INSERT INTO `user` VALUES (51, 'wu_yong', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000025', 'wu_yong@qq.com', '后勤部', '吴用', 2, '男', '梁山泊', '后勤');
INSERT INTO `user` VALUES (52, 'gong_sunsheng', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000026', 'gong_sunsheng@qq.com', '公关部', '公孙胜', 2, '男', '梁山泊', '公关');
INSERT INTO `user` VALUES (53, 'guan_sheng', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000027', 'guan_sheng@qq.com', '技术部', '关胜', 2, '男', '梁山泊', '技术');
INSERT INTO `user` VALUES (54, 'hu_yong', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000028', 'hu_yong@qq.com', '销售部', '呼延灼', 2, '男', '梁山泊', '销售');
INSERT INTO `user` VALUES (55, 'kong_xiaoyao', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000029', 'kong_xiaoyao@qq.com', '客服部', '孔小妖', 2, '女', '梁山泊', '客服');
INSERT INTO `user` VALUES (56, 'song_jiang', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000005', 'song_jiang@qq.com', '后勤部', '宋江', 2, '男', '梁山泊', '后勤');
INSERT INTO `user` VALUES (57, 'lu_zhishen', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000006', 'lu_zhishen@qq.com', '公关部', '鲁智深', 2, '男', '梁山泊', '公关');
INSERT INTO `user` VALUES (58, 'wu_song', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000007', 'wu_song@qq.com', '技术部', '武松', 2, '男', '梁山泊', '技术');
INSERT INTO `user` VALUES (59, 'lin_chong', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000008', 'lin_chong@qq.com', '销售部', '林冲', 2, '男', '梁山泊', '销售');
INSERT INTO `user` VALUES (60, 'zhang_fei', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000009', 'zhang_fei@qq.com', '客服部', '张飞', 2, '男', '蜀国', '客服');
INSERT INTO `user` VALUES (61, 'guan_yu', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000010', 'guan_yu@qq.com', '采购部', '关羽', 2, '男', '蜀国', '采购');
INSERT INTO `user` VALUES (62, 'zhao_yun', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000011', 'zhao_yun@qq.com', '研发部', '赵云', 2, '男', '蜀国', '研发');
INSERT INTO `user` VALUES (63, 'ma_chao', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000012', 'ma_chao@qq.com', '市场部', '马超', 2, '男', '蜀国', '市场');
INSERT INTO `user` VALUES (64, 'huang_zhong', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000013', 'huang_zhong@qq.com', '人事部', '黄忠', 2, '男', '蜀国', '人事');
INSERT INTO `user` VALUES (65, 'sun_wukong', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000014', 'sun_wukong@qq.com', '财务部', '孙悟空', 2, '男', '花果山', '财务');
INSERT INTO `user` VALUES (66, 'zhu_bajie', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000015', 'zhu_bajie@qq.com', '后勤部', '猪八戒', 2, '男', '花果山', '后勤');
INSERT INTO `user` VALUES (67, 'sha_wujing', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000016', 'sha_wujing@qq.com', '公关部', '沙悟净', 2, '男', '花果山', '公关');
INSERT INTO `user` VALUES (68, 'tang_seng', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000017', 'tang_seng@qq.com', '技术部', '唐僧', 2, '男', '花果山', '技术');
INSERT INTO `user` VALUES (69, 'zhong_yun', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000018', 'zhong_yun@qq.com', '销售部', '钟云', 2, '男', '魏国', '销售');
INSERT INTO `user` VALUES (70, 'xun_yu', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000019', 'xun_yu@qq.com', '客服部', '荀彧', 2, '男', '魏国', '客服');
INSERT INTO `user` VALUES (71, 'guo_jia', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000020', 'guo_jia@qq.com', '采购部', '郭嘉', 2, '男', '魏国', '采购');
INSERT INTO `user` VALUES (72, 'zhou_yu', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000021', 'zhou_yu@qq.com', '研发部', '周瑜', 2, '男', '吴国', '研发');
INSERT INTO `user` VALUES (73, 'lu_su', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000022', 'lu_su@qq.com', '市场部', '鲁肃', 2, '男', '吴国', '市场');
INSERT INTO `user` VALUES (74, 'huang_gai', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000023', 'huang_gai@qq.com', '人事部', '黄盖', 2, '男', '吴国', '人事');
INSERT INTO `user` VALUES (75, 'lvmeng', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000024', 'lvmeng@qq.com', '财务部', '吕蒙', 2, '男', '吴国', '财务');
INSERT INTO `user` VALUES (76, 'zhang_liao', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000025', 'zhang_liao@qq.com', '后勤部', '张辽', 2, '男', '魏国', '后勤');
INSERT INTO `user` VALUES (77, 'xu_huang', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000026', 'xu_huang@qq.com', '公关部', '徐晃', 2, '男', '魏国', '公关');
INSERT INTO `user` VALUES (78, 'zhang_he', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000027', 'zhang_he@qq.com', '技术部', '张郃', 2, '男', '魏国', '技术');
INSERT INTO `user` VALUES (79, 'dian_wei', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000028', 'dian_wei@qq.com', '销售部', '典韦', 2, '男', '魏国', '销售');
INSERT INTO `user` VALUES (80, 'xiahou_dun', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000029', 'xiahou_dun@qq.com', '客服部', '夏侯惇', 2, '男', '魏国', '客服');
INSERT INTO `user` VALUES (81, 'xiahou_yuan', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000030', 'xiahou_yuan@qq.com', '采购部', '夏侯渊', 2, '男', '魏国', '采购');
INSERT INTO `user` VALUES (82, 'cao_cao', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000031', 'cao_cao@qq.com', '研发部', '曹操', 2, '男', '魏国', '研发');
INSERT INTO `user` VALUES (83, 'liu_bei', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000032', 'liu_bei@qq.com', '市场部', '刘备', 2, '男', '蜀国', '市场');
INSERT INTO `user` VALUES (84, 'sun_quan', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000033', 'sun_quan@qq.com', '人事部', '孙权', 2, '男', '吴国', '人事');
INSERT INTO `user` VALUES (85, 'zhuge_liang', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000034', 'zhuge_liang@qq.com', '财务部', '诸葛亮', 2, '男', '蜀国', '财务');
INSERT INTO `user` VALUES (86, 'zhang_san', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000039', 'zhang_san@qq.com', '研发部', '张三', 2, '男', '现代研究所', '研发');
INSERT INTO `user` VALUES (87, 'li_si', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000040', 'li_si@qq.com', '市场部', '李四', 2, '女', '现代研究所', '市场');
INSERT INTO `user` VALUES (88, 'wang_wu', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000041', 'wang_wu@qq.com', '人事部', '王五', 2, '男', '现代研究所', '人事');
INSERT INTO `user` VALUES (89, 'zhao_liu', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000042', 'zhao_liu@qq.com', '财务部', '赵六', 2, '女', '现代研究所', '财务');
INSERT INTO `user` VALUES (90, 'qian_qi', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000043', 'qian_qi@qq.com', '后勤部', '钱七', 2, '男', '现代研究所', '后勤');
INSERT INTO `user` VALUES (91, 'sun_ba', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000044', 'sun_ba@qq.com', '公关部', '孙八', 2, '女', '现代研究所', '公关');
INSERT INTO `user` VALUES (92, 'li_jiu', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000045', 'li_jiu@qq.com', '技术部', '李九', 2, '男', '现代研究所', '技术');
INSERT INTO `user` VALUES (93, 'zhou_shi', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000046', 'zhou_shi@qq.com', '销售部', '周十', 2, '女', '现代研究所', '销售');
INSERT INTO `user` VALUES (94, 'wu_shi', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000047', 'wu_shi@qq.com', '客服部', '吴十一', 2, '男', '现代研究所', '客服');
INSERT INTO `user` VALUES (95, 'zheng_shi', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000048', 'zheng_shi@qq.com', '采购部', '郑十二', 2, '女', '现代研究所', '采购');
INSERT INTO `user` VALUES (96, 'liu_shi', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000049', 'liu_shi@qq.com', '研发部', '刘十三', 2, '男', '现代研究所', '研发');
INSERT INTO `user` VALUES (97, 'qian_shi', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000050', 'qian_shi@qq.com', '市场部', '钱十四', 2, '女', '现代研究所', '市场');
INSERT INTO `user` VALUES (98, 'zhang_shi', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000051', 'zhang_shi@qq.com', '人事部', '张十五', 2, '男', '现代研究所', '人事');
INSERT INTO `user` VALUES (99, 'li_shi', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000052', 'li_shi@qq.com', '财务部', '李十六', 2, '女', '现代研究所', '财务');
INSERT INTO `user` VALUES (100, 'zhou_shi', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000053', 'zhou_shi@qq.com', '后勤部', '周十七', 2, '男', '现代研究所', '后勤');
INSERT INTO `user` VALUES (101, 'wu_shi', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000054', 'wu_shi@qq.com', '公关部', '吴十八', 2, '女', '现代研究所', '公关');
INSERT INTO `user` VALUES (102, 'zheng_shi', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000055', 'zheng_shi@qq.com', '技术部', '郑十九', 2, '男', '现代研究所', '技术');
INSERT INTO `user` VALUES (103, 'qian_shi', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000056', 'qian_shi@qq.com', '销售部', '钱二十', 2, '女', '现代研究所', '销售');
INSERT INTO `user` VALUES (104, 'john_doe', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000059', 'john_doe@qq.com', '研发部', '约翰', 2, '男', '西方研究所', '研发');
INSERT INTO `user` VALUES (105, 'jane_smith', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000060', 'jane_smith@qq.com', '市场部', '简', 2, '女', '西方研究所', '市场');
INSERT INTO `user` VALUES (106, 'michael_jordan', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000061', 'michael_jordan@qq.com', '人事部', '迈克尔', 2, '男', '西方研究所', '人事');
INSERT INTO `user` VALUES (107, 'sarah_connor', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000062', 'sarah_connor@qq.com', '财务部', '莎拉', 2, '女', '西方研究所', '财务');
INSERT INTO `user` VALUES (108, 'tom_hanks', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000063', 'tom_hanks@qq.com', '后勤部', '汤姆', 2, '男', '西方研究所', '后勤');
INSERT INTO `user` VALUES (109, 'julia_roberts', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000064', 'julia_roberts@qq.com', '公关部', '朱莉娅', 2, '女', '西方研究所', '公关');
INSERT INTO `user` VALUES (110, 'brad_pitt', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000065', 'brad_pitt@qq.com', '技术部', '布拉德', 2, '男', '西方研究所', '技术');
INSERT INTO `user` VALUES (111, 'angelina_jolie', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000066', 'angelina_jolie@qq.com', '销售部', '安吉丽娜', 2, '女', '西方研究所', '销售');
INSERT INTO `user` VALUES (112, 'leonardo_dicaprio', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000067', 'leonardo_dicaprio@qq.com', '客服部', '莱昂纳多', 2, '男', '西方研究所', '客服');
INSERT INTO `user` VALUES (113, 'natalie_portman', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000068', 'natalie_portman@qq.com', '采购部', '娜塔莉', 2, '女', '西方研究所', '采购');
INSERT INTO `user` VALUES (114, 'chris_hemsworth', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000069', 'chris_hemsworth@qq.com', '研发部', '克里斯', 2, '男', '西方研究所', '研发');
INSERT INTO `user` VALUES (115, 'scarlett_johansson', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000070', 'scarlett_johansson@qq.com', '市场部', '斯嘉丽', 2, '女', '西方研究所', '市场');
INSERT INTO `user` VALUES (116, 'robert_downey_jr', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000071', 'robert_downey_jr@qq.com', '人事部', '小罗伯特', 2, '男', '西方研究所', '人事');
INSERT INTO `user` VALUES (117, 'jennifer_lawrence', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000072', 'jennifer_lawrence@qq.com', '财务部', '詹妮弗', 2, '女', '西方研究所', '财务');
INSERT INTO `user` VALUES (118, 'chris_evans', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000073', 'chris_evans@qq.com', '后勤部', '克里斯', 2, '男', '西方研究所', '后勤');
INSERT INTO `user` VALUES (119, 'gal_gadot', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000074', 'gal_gadot@qq.com', '公关部', '盖尔', 2, '女', '西方研究所', '公关');
INSERT INTO `user` VALUES (120, 'mark_ruffalo', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', '研究人员', '13800000075', 'mark_ruffalo@qq.com', '技术部', '马克', 2, '男', '西方研究所', '技术');

SET FOREIGN_KEY_CHECKS = 1;
