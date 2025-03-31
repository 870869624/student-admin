-- MySQL dump 10.13  Distrib 9.2.0, for macos14.7 (x86_64)
--
-- Host: 127.0.0.1    Database: data
-- ------------------------------------------------------
-- Server version	8.0.41

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `announce`
--

DROP TABLE IF EXISTS `announce`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `announce` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `title` varchar(512) NOT NULL,
  `content` varchar(512) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `announce`
--

LOCK TABLES `announce` WRITE;
/*!40000 ALTER TABLE `announce` DISABLE KEYS */;
INSERT INTO `announce` VALUES (1,'公告11111','1111111'),(2,'公告2222222','1111111'),(6,'新公告','# 公告');
/*!40000 ALTER TABLE `announce` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `note`
--

DROP TABLE IF EXISTS `note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `note` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `title` varchar(512) NOT NULL,
  `user_id` bigint NOT NULL,
  `status` tinyint NOT NULL,
  `content` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `note`
--

LOCK TABLES `note` WRITE;
/*!40000 ALTER TABLE `note` DISABLE KEYS */;
INSERT INTO `note` VALUES (1,'子项目1111',1,1,'declared'),(2,'子项目1111',1,1,'declared'),(3,'子项目1111',1,1,'initiated'),(4,'子项目1111',1,1,'initiated'),(5,'子项目1111',1,1,'progress'),(6,'子项目1111',1,0,'completed'),(7,'子项目1111',2,0,'completed'),(8,'子项目1111',6,1,'completed'),(9,'新项目测试',6,0,'declared'),(10,'新项目1',6,0,'declared'),(11,'新项目1',6,0,'initiated'),(12,'新项目1',6,0,'initiated'),(13,'新项目1',6,0,'progress'),(14,'新项目测试',6,0,'declared'),(15,'新项目1',6,0,'progress');
/*!40000 ALTER TABLE `note` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permission`
--

DROP TABLE IF EXISTS `permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permission` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '权限名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='权限表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permission`
--

LOCK TABLES `permission` WRITE;
/*!40000 ALTER TABLE `permission` DISABLE KEYS */;
INSERT INTO `permission` VALUES (1,'管理员权限'),(2,'用户权限'),(3,'教师权限');
/*!40000 ALTER TABLE `permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project`
--

DROP TABLE IF EXISTS `project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '项目名称',
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '项目描述',
  `start_date` date NOT NULL COMMENT '项目开始时间',
  `expected_end_date` date NOT NULL COMMENT '预计结束时间',
  `status` enum('declared','initiated','progress','completed','extended','terminated','down') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'declared' COMMENT '项目状态（已申报、已立项、进行中、已完成、已延期、已终止、驳回）',
  `user_id` bigint NOT NULL COMMENT '项目负责人',
  `department` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '部门',
  `teacher_id` bigint NOT NULL COMMENT '导师',
  `batch` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '批次名称',
  `source` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '项目来源',
  `participant` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '项目组成员',
  `result_type` enum('paper','software','project','patent') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'paper' COMMENT '科研成果类型（论文、软著、项目、专利）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='项目表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project`
--

LOCK TABLES `project` WRITE;
/*!40000 ALTER TABLE `project` DISABLE KEYS */;
INSERT INTO `project` VALUES (1,'医信链','打开命令行终端。\n输入 redis-cli --version 或 redis-cli -v 命令。\n按下回车键，系统会返回 Redis 的版本信息。','2024-03-01','2024-12-01','terminated',2,'区块链',0,'第一批次','Amy','[2]','paper'),(2,'NFT数字藏品','NFT的核心价值在于推动数字内容资产化，保证数字资产的唯一性、真实性和永久性，提高数字资产的交易流动性，刺激“创作者经济”的持续发展。','2024-04-01','2024-11-30','initiated',2,'市场',0,'第二批次','seacher','[2]','project'),(3,'CET反拨效应基准研究','反拨效应是指测试对教与学所产生的影响，在应用语言学领域中特指语言测试尤其是外语测试对相应的外语教和学产生的影响。语言测试反拨效应研究是应用语言学中一个相对较新的领域,同时也是测试领域的一个重要研究课题。近年来，众多学者对反拨效应进行了大量而深入的研究，不断丰富和完善了反拨效应理论，同时也在一定程度上推动了测试和教学改革。','2023-05-01','2024-01-01','initiated',1,'教育',0,'第一批次','研究','[6]','software'),(4,'高考能力考查与内容改革创新研究','高考制度恢复以来，其自身的改革不断进行，逐渐发展为较为科学、基本准确测量考生知识和能力水平的标准化考试。但2013年11月，《中共中央关于全面深化改革若干重大问题的决定》提出推进考试招生制度改革的任务，其中关于高考内容改革的主要目标和措施有：“加快推进职业院校分类招考或注册入学”、“逐步推行普通高校基于统一高考和高中学业水平考试成绩的综合评价多元录取机制”和“探索全国统考减少科目、不分文理科、外语等科目社会化考试一年多考”等，这些改革措施都是高考历史上首次提出来的。高考的定位与考试的内容都发生了较大变化，必须对内容改革与能力考查进行创新研究。','2024-06-01','2025-01-01','declared',1,'教育',0,'第二批次','研究','[2]','software'),(5,'浅析震源位置准确度及其影响因素','联合应用多种设计策略优化聚氨酯神经导管虽然可以在多方面改善受损神经的功能,但由于神经复杂的结构和动态变化的病理生理微环境,神经导管设计策略仍旧有待完善。未来进一步改进和创新神经仿生设计策略,有望为神经组织工程领域的发展提供新的思路和机遇。','2024-11-20','2025-12-30','declared',1,'国安',5,'第一批次','实验','[7]','project'),(6,'长筒花叶片离体培养研究','为建立长筒花的叶片离体培养体系,以苦苣苔科长筒花属长筒花品种‘kim blue’的叶片作为外植体,探索培养过程中各个可能影响培养结果的因素,包括灭菌时长的不同组合、灭菌方法,各培养阶段的激素种类及其配比,进而筛选出影响因素的最佳值。结果显示,叶片外植体最适的灭菌组合和方法为75%酒精消毒15 s+2%次氯酸钠7 min;最佳的启动培养基配方为:MS+6-BA1.0 mg/L+NAA 0.1 mg/L;最佳的增殖培养基配方为:MS+6-BA 2.0 mg/L+NAA 0.5 mg/L;最佳的壮苗培养基配方为:1/2MS+IBA 0.1 mg/L+NAA0.1 mg/L+CCC 0.5 mg/L。','2024-12-10','2025-02-20','completed',1,'科学',5,'第一批次','研究','[]','patent'),(7,'元宇宙服务的人机交互综述','近年来,元宇宙飞速发展,已成为未来数字世界的一个重要发展方向。元宇宙中的人机交互是实现虚实融合的核心,其解决了元宇宙中的多用户协作、沟通、社交等挑战,促进了创新和合作。为了深入探讨元宇宙作为虚拟和现实世界融合的数字化空间,其服务如何与人机交互相结合,创造出丰富、沉浸式、个性化的用户体验,调研了元宇宙和人机交互技术,并从人机交互的角度对元宇宙的概念进行了定义。讨论了元宇宙服务和人机融合的可行性与优势,并整理归纳了现有的挑战。最后探讨了元宇宙服务的未来发展趋势。','2025-01-13','2025-03-30','declared',1,'科学',0,'第二批次','研究','[8]','patent'),(8,'论文一','这是一篇论文！这是一篇论文！这是一篇论文！','2025-02-01','2025-03-15','extended',1,'教育',4,'第一批次','研究','[2]','paper'),(9,'论文二','这是论文二！这是一篇论文！这是一篇论文！','2024-05-26','2025-03-15','initiated',1,'教育',4,'第一批次','研究','[]','paper'),(10,'论著一','这是论著一！这是一篇论著！这是一篇论著！','2024-09-05','2025-03-15','completed',1,'科研',4,'第一批次','实验','[]','software'),(11,'论著二','这是论著二！这是一篇论著！这是一篇论著！','2024-08-08','2025-03-15','initiated',1,'科研',5,'第一批次','实验','[]','software'),(12,'项目一','这是项目一！这是一个项目！这是一个项目！','2024-07-20','2025-04-15','completed',1,'计算机',4,'第一批次','编码','[]','project'),(13,'项目二','这是项目二！这是一个项目！这是一个项目！','2025-03-05','2025-06-10','initiated',1,'计算机',5,'第二批次','编码','[]','project'),(14,'专利一','这是专利一！这是一项专利！这是一项专利！','2025-04-15','2025-05-30','progress',1,'化学',4,'第一批次','研究','[]','patent'),(15,'专利二','这是专利二！这是一项专利！这是一项专利！','2024-10-25','2025-04-15','down',1,'生物',5,'第二批次','研究','[]','patent'),(18,'这是我的科研项目','科研项目!科研项目!科研项目!','2025-03-11','2025-04-10','extended',19,'区块链',4,'第一批次',' ','[2,3]','project'),(19,'111111','11111','2025-03-28','2025-03-31','terminated',1,'11111',5,'yi','11','[9]','project'),(20,'子项目1111','1111','2025-03-28','2025-03-31','completed',1,'11111',16,'1111','111','[9]','project'),(21,'新项目测试','``````','2025-03-31','2025-04-09','declared',6,'11111',4,'11111','132312','[6]','paper'),(22,'新项目1','1111','2025-03-31','2025-03-30','progress',6,'111',4,'1','1','[6]','project');
/*!40000 ALTER TABLE `project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_delay`
--

DROP TABLE IF EXISTS `project_delay`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_delay` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `project_id` bigint NOT NULL COMMENT '项目id',
  `requested_extension_date` date DEFAULT NULL COMMENT '申请的延期日期',
  `reason` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '延期理由',
  `status` enum('pending','approved','rejected') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'pending' COMMENT '延期申请状态（待审核、已批准、已拒绝）',
  `approval_date` date DEFAULT NULL COMMENT '审批日期',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='记录项目延期申请的信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_delay`
--

LOCK TABLES `project_delay` WRITE;
/*!40000 ALTER TABLE `project_delay` DISABLE KEYS */;
INSERT INTO `project_delay` VALUES (1,1,'2024-11-19','不完善','pending','2024-12-10'),(2,8,'2025-01-04','不够规范','pending','2025-03-28'),(3,16,'2025-03-10','时间不够','pending','2025-06-01'),(4,18,'2025-03-11','时间不充足','pending','2025-05-20'),(5,19,'2025-03-28','未知','pending','2025-03-12');
/*!40000 ALTER TABLE `project_delay` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_document`
--

DROP TABLE IF EXISTS `project_document`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_document` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `project_id` bigint NOT NULL COMMENT '项目id',
  `stage_id` bigint NOT NULL COMMENT '阶段id',
  `file_path` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文件路径',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='存储项目相关文件';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_document`
--

LOCK TABLES `project_document` WRITE;
/*!40000 ALTER TABLE `project_document` DISABLE KEYS */;
INSERT INTO `project_document` VALUES (1,1,1,'http://127.0.0.1:8100/api/files/30940b92-95ab-4f9a-ad8a-8a35b69f0147.txt'),(2,1,2,''),(3,1,3,''),(4,1,4,''),(5,1,5,''),(6,1,6,''),(7,2,7,'http://127.0.0.1:8100/api/files/2b124a86-4100-4577-a172-4ea9112b95b1.docx'),(8,2,8,'http://127.0.0.1:8100/api/files/f563e892-e76c-47ae-85c6-13058be98e55.jpg'),(9,3,9,'http://127.0.0.1:8100/api/files/c9e577be-0826-4933-b975-2d6aa23f5132.doc'),(10,4,10,'http://127.0.0.1:8100/api/files/7eeec311-1c87-4dd0-8362-eb74b34ff8ca.doc'),(11,5,11,'http://127.0.0.1:8100/api/files/d8164ae7-479e-40ef-b92c-99915bc71779.docx'),(12,6,12,'http://127.0.0.1:8100/api/files/55b6614d-c817-40fb-820c-8b4765b77a01.docx'),(13,7,13,'http://127.0.0.1:8100/api/files/2c281aa2-4e47-4923-b3cc-03c9f3a75619.docx'),(14,8,14,'http://127.0.0.1:8100/api/files/fd094fd9-614d-4f9a-97de-8a2c706e5c4d.txt'),(15,9,15,'http://127.0.0.1:8100/api/files/82d052f6-f449-4502-b7a4-0f03d06e8895.txt'),(16,10,16,'http://127.0.0.1:8100/api/files/5becff1b-d5e1-4d04-83e8-e3131060feca.txt'),(17,11,17,'http://127.0.0.1:8100/api/files/50c60425-727f-4184-a97d-19a1a9678ca6.txt'),(18,12,18,'http://127.0.0.1:8100/api/files/f357ca3d-fa8c-47f1-b0ab-0c0913d9bf5d.txt'),(19,13,19,'http://127.0.0.1:8100/api/files/ca81f5a1-265c-4986-a35f-9fd7e14774ba.txt'),(20,14,20,'http://127.0.0.1:8100/api/files/0778f776-27ed-4220-90d5-625456e768a5.txt'),(21,15,21,'http://127.0.0.1:8100/api/files/dfdf1f36-baa0-404a-a5a7-5d71e07dc67e.txt'),(22,8,22,''),(23,9,23,''),(24,10,24,''),(25,11,25,''),(26,12,26,''),(27,13,27,''),(28,14,28,''),(29,15,29,''),(30,8,30,''),(31,10,31,''),(32,12,32,''),(33,14,33,''),(34,8,34,''),(35,12,35,''),(36,15,36,''),(37,15,37,''),(38,8,38,''),(39,15,39,'http://127.0.0.1:8100/api/files/f563e892-e76c-47ae-85c6-13058be98e55.jpg'),(40,16,40,'http://127.0.0.1:8100/api/files/05f5ea5f-68f8-4c11-b086-98f1bf53c4b4.docx'),(41,17,41,'http://127.0.0.1:8100/api/files/3f5ac35b-b17f-45c7-a73c-6ff2e44fb33e.docx'),(42,6,42,''),(43,6,43,''),(44,6,44,''),(45,6,45,''),(46,16,46,''),(47,16,47,''),(48,16,48,''),(49,16,49,''),(50,18,50,'http://127.0.0.1:8100/api/files/a1e3a9f0-1c05-496e-a7e8-e129ea380adb.docx'),(51,18,51,''),(52,18,52,''),(53,18,53,''),(54,18,54,'http://127.0.0.1:8100/api/files/f563e892-e76c-47ae-85c6-13058be98e55.jpg'),(55,6,55,''),(56,10,56,''),(57,3,57,''),(58,19,58,'http://127.0.0.1:8100/api/files/fd1d61a3-b7ea-49a5-a3a4-e5105e81e3dc.doc'),(59,19,59,''),(60,19,60,''),(61,19,61,''),(62,19,62,''),(63,19,63,''),(64,19,64,''),(65,19,65,''),(66,19,66,''),(67,19,67,'http://127.0.0.1:8100/api/files/f563e892-e76c-47ae-85c6-13058be98e55.jpg'),(68,20,68,'http://127.0.0.1:8100/api/files/87cae968-91de-4de3-80fe-64dd46a9f7d0.doc'),(69,20,69,''),(70,20,70,''),(71,20,71,'http://127.0.0.1:8100/api/files/f563e892-e76c-47ae-85c6-13058be98e55.jpg'),(72,21,72,'http://127.0.0.1:8100/api/files/1d14b8ea-5e5a-4f82-ab5f-cf62a989d950.pdf'),(73,22,73,'http://127.0.0.1:8100/api/files/fc282e63-d06e-4139-8097-773d0f731d77.jpg'),(74,22,74,'http://127.0.0.1:8100/api/files/d63b32d2-d4f7-4ff2-ac73-1d3539d1352f.sql'),(75,22,75,'http://127.0.0.1:8100/api/files/f563e892-e76c-47ae-85c6-13058be98e55.jpg');
/*!40000 ALTER TABLE `project_document` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_down`
--

DROP TABLE IF EXISTS `project_down`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_down` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `project_id` bigint NOT NULL COMMENT '项目id',
  `reason` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '驳回理由',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='项目驳回表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_down`
--

LOCK TABLES `project_down` WRITE;
/*!40000 ALTER TABLE `project_down` DISABLE KEYS */;
INSERT INTO `project_down` VALUES (1,15,'不够创新'),(2,6,'可行性不通过'),(3,19,'不合格'),(4,19,'1222');
/*!40000 ALTER TABLE `project_down` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_stage`
--

DROP TABLE IF EXISTS `project_stage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_stage` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `project_id` bigint NOT NULL COMMENT '项目id',
  `name` enum('declared','initiated','progress','completed','extended','terminated','down') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'declared' COMMENT '阶段名称（申报、立项、中检、结项、延期、终止、驳回）',
  `start_date` date NOT NULL COMMENT '阶段开始日期',
  `end_date` date DEFAULT NULL COMMENT '阶段结束日期',
  `status` enum('pending','approved','rejected','progress','completed') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '阶段状态（待审核、已批准、已拒绝、进行中、已完成）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='存储项目不同阶段的信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_stage`
--

LOCK TABLES `project_stage` WRITE;
/*!40000 ALTER TABLE `project_stage` DISABLE KEYS */;
INSERT INTO `project_stage` VALUES (1,1,'declared','2024-11-01',NULL,'pending'),(2,1,'initiated','2024-11-19',NULL,'pending'),(3,1,'progress','2024-11-19',NULL,'pending'),(4,1,'completed','2024-11-19',NULL,'pending'),(5,1,'extended','2024-11-19',NULL,'pending'),(6,1,'terminated','2024-11-19',NULL,'pending'),(7,2,'declared','2024-11-19',NULL,'pending'),(8,2,'initiated','2024-11-19',NULL,'pending'),(9,3,'declared','2023-12-30',NULL,'pending'),(10,4,'declared','2024-12-01',NULL,'pending'),(11,5,'declared','2024-11-20',NULL,'pending'),(12,6,'declared','2024-12-10',NULL,'pending'),(13,7,'declared','2025-01-13',NULL,'pending'),(14,8,'declared','2025-01-04',NULL,'pending'),(15,9,'declared','2025-01-04',NULL,'pending'),(16,10,'declared','2025-01-04',NULL,'pending'),(17,11,'declared','2025-01-04',NULL,'pending'),(18,12,'declared','2025-01-04',NULL,'pending'),(19,13,'declared','2025-01-04',NULL,'pending'),(20,14,'declared','2025-01-04',NULL,'pending'),(21,15,'declared','2025-01-04',NULL,'pending'),(22,8,'initiated','2025-01-04',NULL,'pending'),(23,9,'initiated','2025-01-04',NULL,'pending'),(24,10,'initiated','2025-01-04',NULL,'pending'),(25,11,'initiated','2025-01-04',NULL,'pending'),(26,12,'initiated','2025-01-04',NULL,'pending'),(27,13,'initiated','2025-01-04',NULL,'pending'),(28,14,'initiated','2025-01-04',NULL,'pending'),(29,15,'initiated','2025-01-04',NULL,'pending'),(30,8,'progress','2025-01-04',NULL,'pending'),(31,10,'progress','2025-01-04',NULL,'pending'),(32,12,'progress','2025-01-04',NULL,'pending'),(33,14,'progress','2025-01-04',NULL,'pending'),(34,8,'completed','2025-01-04',NULL,'pending'),(35,12,'completed','2025-01-04',NULL,'pending'),(36,15,'progress','2025-01-04',NULL,'pending'),(37,15,'completed','2025-01-04',NULL,'pending'),(38,8,'extended','2025-01-04',NULL,'pending'),(39,15,'down','2025-01-04',NULL,'pending'),(40,16,'declared','2025-03-10',NULL,'pending'),(41,17,'declared','2025-03-10',NULL,'pending'),(42,6,'initiated','2025-03-10',NULL,'pending'),(43,6,'progress','2025-03-10',NULL,'pending'),(44,6,'completed','2025-03-10',NULL,'pending'),(45,6,'down','2025-03-10',NULL,'pending'),(46,16,'initiated','2025-03-10',NULL,'pending'),(47,16,'progress','2025-03-10',NULL,'pending'),(48,16,'completed','2025-03-10',NULL,'pending'),(49,16,'extended','2025-03-10',NULL,'pending'),(50,18,'declared','2025-03-11',NULL,'pending'),(51,18,'initiated','2025-03-11',NULL,'pending'),(52,18,'progress','2025-03-11',NULL,'pending'),(53,18,'completed','2025-03-11',NULL,'pending'),(54,18,'extended','2025-03-11',NULL,'pending'),(55,6,'completed','2025-03-28',NULL,'pending'),(56,10,'completed','2025-03-28',NULL,'pending'),(57,3,'initiated','2025-03-28',NULL,'pending'),(58,19,'declared','2025-03-28',NULL,'pending'),(59,19,'initiated','2025-03-28',NULL,'pending'),(60,19,'progress','2025-03-28',NULL,'pending'),(61,19,'completed','2025-03-28',NULL,'pending'),(62,19,'down','2025-03-28',NULL,'pending'),(63,19,'completed','2025-03-28',NULL,'pending'),(64,19,'down','2025-03-28',NULL,'pending'),(65,19,'completed','2025-03-28',NULL,'pending'),(66,19,'extended','2025-03-28',NULL,'pending'),(67,19,'terminated','2025-03-28',NULL,'pending'),(68,20,'declared','2025-03-28',NULL,'pending'),(69,20,'initiated','2025-03-28',NULL,'pending'),(70,20,'progress','2025-03-28',NULL,'pending'),(71,20,'completed','2025-03-28',NULL,'pending'),(72,21,'declared','2025-03-31',NULL,'pending'),(73,22,'declared','2025-03-31',NULL,'pending'),(74,22,'initiated','2025-03-31',NULL,'pending'),(75,22,'progress','2025-03-31',NULL,'pending');
/*!40000 ALTER TABLE `project_stage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='角色表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'管理员'),(2,'用户'),(3,'教师'),(4,'监察员'),(5,'审核员');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_permission`
--

DROP TABLE IF EXISTS `role_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_permission` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `role_id` bigint NOT NULL COMMENT '角色id',
  `permission_id` bigint NOT NULL COMMENT '权限id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='角色权限表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_permission`
--

LOCK TABLES `role_permission` WRITE;
/*!40000 ALTER TABLE `role_permission` DISABLE KEYS */;
INSERT INTO `role_permission` VALUES (1,1,1),(2,2,2),(3,3,3),(4,4,1);
/*!40000 ALTER TABLE `role_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `account` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '账号',
  `password` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密码',
  `position` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '教师' COMMENT '职位',
  `phone` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '手机号',
  `email` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '邮箱',
  `department` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '部门',
  `username` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户名',
  `role_id` bigint NOT NULL DEFAULT '2' COMMENT '用户权限：用户/管理员/教师',
  `gender` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '男' COMMENT '性别',
  `organization` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '组织',
  `job` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '工作',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'admin','$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K','科研机构负责人','12345678900','a@qq.com','总部','万丹风',1,'男','总部','管理'),(2,'searcher','$2a$10$a0qNl3hz92JTqF6vSf.f6u0KJRRZ4YdicFbAdB3Q5d6SKECqGNENy','研究员','13517947350','2827264925@qq.com','区块链','Amy',2,'女','区块链','科研'),(3,'searcher2','$2a$10$79IqO6T9Gi/aOl2X229OCOXjBnD7J.A9RObb4pjnJvK8qBkS2qBue','科研','13117858020','2827264925@qq.com','经济管理','王维',2,'男','经济管理','科研'),(4,'master','$2a$10$Ss69MJWTilaKUykzTYzcA.WlG.OWJbeToWaHq2dK/jTGAK2VtU4Zy','教授','11111111111','1587691976@qq.com','软件工程','宋浩然',3,'男','软件工程','指导'),(5,'master2','$2a$10$zMOJRabtl7OQhhn5gnu0/urfObeOrdB6IQJLzHnZJw9AOHMZAlUYe','教授','22222222222','1587691976@qq.com','机械工程','王熙凤',3,'女','机械工程','指导'),(6,'AAAA','$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K','A','11111111111','1587691976@qq.com','机械工程','A',2,'女','机械工程','指导'),(7,'BBBB','$2a$10$djDMk/1FcJC5mfw1YIBxPON2TbNctiViZrpCxaYA9OPgaBVQQe1lC','B','11111111111','1587691976@qq.com','机械工程','B',2,'女','机械工程','指导'),(8,'CCCC','$2a$10$M0WCHibxftfEYrcyDci33O0/CkBxA6l7X3epTLeUaW9EhZDlna2Mu','C','11111111111','1587691976@qq.com','机械工程','C',2,'女','机械工程','指导'),(9,'DDDD','$2a$10$.tKi9Gcxws7jGR/Ur0M/c.1OJbxsis0JAgiLpEqdxQz5NfTZ2v8PG','D','11111111111','1587691976@qq.com','机械工程','D',2,'女','机械工程','指导'),(10,'EEEE','$2a$10$cjVaeP.tt4CznhLZXpnpFOyU7OuCLW5GD1/fa8qfCKnlLtuZAf7Dq','E','11111111111','1587691976@qq.com','机械工程','E',2,'女','机械工程','指导'),(13,'lisi','$2a$10$vmGIP9W0a3r7jPFeb6MfU.941K4im5ITx4l1agLqJRq0fCN8NHS.W','无','13125333167','1587691976@qq.com','机械工程','张三',2,'女','机械工程','干事'),(14,'lisi','$2a$10$evRljb9FfBXrrZWfLHU9yewgJIoY72G93LCGYbbE/qIfU2YrU.9XO','无','13125333167','1587691976@qq.com','机械工程','张三',2,'女','机械工程','干事'),(15,'wangwu','$2a$10$D7obNcqP.MQmDmXCc94iguMhWJe4DODiM2lqTmoGUXxP4reGXilHK','无','13125333167','1587691976@qq.com','机械工程','王五',3,'男','机械工程','干事'),(16,'zzzzz','$2a$10$DgYjD34LmcPRMaRegFZOOO91ILHAZQNA2UbN.lQE2EUbzoFpxrgYS','z','13517947350','2827264925@qq.com','zz','zz',3,'zz','zz','zz'),(19,'WWWW','$2a$10$Xv74iG76q0StQIj359utau8A5IUAFarwzLhGfcV3df.Hui4DHWMuq','学生','13517947350','2827264925@qq.com','区块链','万丹风',2,'女',' ','研究'),(20,'WWWW','$2a$10$ZmJ0MinVimg53vQq2JSwOuvX7j63JdG4Pbj/gYZ8yrcY1myX3y99O','学生','13517947350','2827264925@qq.com','区块链','万丹风',2,'女',' ','研究'),(21,'qwerty','$2a$10$asp2ZrxPOsNumoEJdRh/yOj5xKRrcFhhnAF0Khd6FvQ3oLlJSoXRO','科研机构负责人','17364747210','870869624@qq.com','总部','万丹风',4,'男','总部','管理'),(22,'qwerty','$2a$10$8uUAdf/n3QcVhabO71FzD.IF.esYecqybVy15vb0kYYHF.5TAkzfe','科研机构负责人','17364747210','870869624@qq.com','总部','万丹风',4,'男','总部','管理');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-31 16:34:12
