create database `data`;

use `data`;

create table `user`
(
    `id`           bigint auto_increment primary key comment 'id',
    `account`      varchar(256) not null comment '账号',
    `password`     varchar(512) not null comment '密码',
    `position`     varchar(512) null     default '教师' comment '职位',
    `phone`        varchar(128) not null comment '手机号',
    `email`        varchar(512) not null comment '邮箱',
    `department`   varchar(512) null comment '部门',
    `username`     varchar(512) null comment '用户名',
    `role_id`      bigint       not null default 2 comment '用户权限：用户/管理员/教师',
    `gender`       varchar(8)   not null default '男' comment '性别',
    `organization` varchar(128) not null comment '组织',
    `job`          varchar(128) not null comment '工作'
) comment '用户表' collate = utf8mb4_unicode_ci
                   engine = InnoDB;

INSERT INTO `user` (`account`, `password`, `position`, `phone`, `email`, `department`, `username`, `role_id`, `gender`,
                    `organization`, `job`)
VALUES ('admin', '$2a$10$VHrENgpMz3Vace4zE38Kf.WO/wpThfszy/Q7q3suOzFvB2wLkrp3K', 'a', '12345678900', 'a@qq.com', 'b',
        'c', 1, '男', 'd', 'e');

create table `role`
(
    `id`   bigint auto_increment primary key comment 'id',
    `name` varchar(512) not null comment '角色名称'
) comment '角色表' collate = utf8mb4_unicode_ci
                   engine = InnoDB;

insert `role` (`name`)
values ('管理员'),
       ('用户'),
       ('教师');

create table `permission`
(
    `id`   bigint auto_increment primary key comment 'id',
    `name` varchar(512) not null comment '权限名称'
) comment '权限表' collate = utf8mb4_unicode_ci
                   engine = InnoDB;

insert `permission` (`name`)
values ('管理员权限'),
       ('用户权限'),
       ('教师权限');

create table `role_permission`
(
    `id`            bigint auto_increment primary key comment 'id',
    `role_id`       bigint not null comment '角色id',
    `permission_id` bigint not null comment '权限id'
) comment '角色权限表' collate = utf8mb4_unicode_ci
                       engine = InnoDB;

insert `role_permission` (`role_id`, `permission_id`)
values (1, 1),
       (2, 2),
       (3, 3);

create table `project`
(
    `id`                bigint auto_increment primary key comment 'id',
    `name`              varchar(512)                                                                                                 not null comment '项目名称',
    `description`       longtext                                                                                                     not null comment '项目描述',
    `start_date`        date                                                                                                         not null comment '项目开始时间',
    `expected_end_date` date                                                                                                         not null comment '预计结束时间',
    `status`            enum ('declared', 'initiated', 'progress', 'completed', 'extended', 'terminated', 'down') default 'declared' not null comment '项目状态（已申报、已立项、进行中、已完成、已延期、已终止、驳回）',
    `user_id`           bigint                                                                                                       not null comment '项目负责人',
    `department`        varchar(512)                                                                                                 not null comment '部门',
    `teacher_id`        bigint                                                                                                       not null comment '导师',
    `batch`             varchar(256)                                                                                                 not null comment '批次名称',
    `source`            varchar(256)                                                                                                 not null comment '项目来源',
    `participant`       varchar(512)                                                                                                 null comment '项目组成员',
    `result_type`       ENUM ('paper', 'software', 'project', 'patent')                                           default 'paper'    NOT NULL COMMENT '科研成果类型（论文、软著、项目、专利）'
) comment '项目表' collate = utf8mb4_unicode_ci
                   engine = InnoDB;

create table `project_stage`
(
    `id`         bigint auto_increment primary key comment 'id',
    `project_id` bigint                                                                                                       not null comment '项目id',
    `name`       enum ('declared', 'initiated', 'progress', 'completed', 'extended', 'terminated', 'down') default 'declared' not null comment '阶段名称（申报、立项、中检、结项、延期、终止、驳回）',
    `start_date` date                                                                                                         not null comment '阶段开始日期',
    `end_date`   date                                                                                                         null comment '阶段结束日期',
    `status`     enum ('pending', 'approved', 'rejected', 'progress', 'completed') comment '阶段状态（待审核、已批准、已拒绝、进行中、已完成）'
) comment '存储项目不同阶段的信息' collate = utf8mb4_unicode_ci
                                   engine = InnoDB;

create table `project_delay`
(
    `id`                       bigint auto_increment primary key comment 'id',
    `project_id`               bigint   not null comment '项目id',
    `requested_extension_date` date comment '申请的延期日期',
    `reason`                   longtext not null comment '延期理由',
    `status`                   enum ('pending', 'approved', 'rejected') default 'pending' comment '延期申请状态（待审核、已批准、已拒绝）',
    `approval_date`            date comment '审批日期'
) comment '记录项目延期申请的信息' collate = utf8mb4_unicode_ci
                                   engine = InnoDB;

create table `project_down`
(
    `id`         bigint auto_increment primary key comment 'id',
    `project_id` bigint   not null comment '项目id',
    `reason`     longtext not null comment '驳回理由'
) comment '项目驳回表' collate = utf8mb4_unicode_ci
                       engine = InnoDB;

create table `project_document`
(
    `id`         bigint auto_increment primary key comment 'id',
    `project_id` bigint       not null comment '项目id',
    `stage_id`   bigint       not null comment '阶段id',
    `file_path`  varchar(512) not null comment '文件路径'
) comment '存储项目相关文件' collate = utf8mb4_unicode_ci
                             engine = InnoDB;