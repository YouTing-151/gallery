-- ============================================================
-- Gallery 博主作品画廊 · 数据库建表脚本
-- 数据库：gallery_db    字符集：utf8mb4
-- 角色约定：blogger(博主) / admin(管理员) / service(客服) / user(普通用户)
-- ============================================================

CREATE DATABASE IF NOT EXISTS gallery_db
    DEFAULT CHARACTER SET utf8mb4
    COLLATE utf8mb4_general_ci;

USE gallery_db;

-- ------------------------------------------------------------
-- 1. 用户表（账号唯一，昵称可重复；角色与账号绑定，登录时校验）
-- ------------------------------------------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
    `id`          BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `account`     VARCHAR(50)     NOT NULL COMMENT '登录账号（唯一）',
    `password`    VARCHAR(100)    NOT NULL COMMENT '登录密码（加密存储，不存明文）',
    `nickname`    VARCHAR(50)     NOT NULL COMMENT '昵称（允许重名）',
    `user_code`   VARCHAR(20)     NOT NULL COMMENT '身份编号，如 BG10001 / AD10001',
    `role`        VARCHAR(20)     NOT NULL COMMENT '角色：blogger/admin/service/user',
    `avatar`      VARCHAR(255)    DEFAULT NULL COMMENT '头像URL',
    `status`      TINYINT         NOT NULL DEFAULT 1 COMMENT '状态：1正常 0已拉黑',
    `create_time` DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_account` (`account`),
    UNIQUE KEY `uk_user_code` (`user_code`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COMMENT ='用户表';

-- ------------------------------------------------------------
-- 2. 博主主页信息表（单博主站点，一条记录对应博主账号）
-- ------------------------------------------------------------
DROP TABLE IF EXISTS `blog_profile`;
CREATE TABLE `blog_profile` (
    `id`             BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `blogger_id`     BIGINT UNSIGNED NOT NULL COMMENT '关联用户表ID',
    `avatar`         VARCHAR(255)    DEFAULT NULL COMMENT '主页头像URL',
    `background_img` VARCHAR(255)    DEFAULT NULL COMMENT '主页背景图URL',
    `signature`      VARCHAR(255)    DEFAULT NULL COMMENT '博主签名 / 简介',
    `create_time`    DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time`    DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_blogger` (`blogger_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COMMENT ='博主主页信息表';

-- ------------------------------------------------------------
-- 3. 合集表（parent_id 自关联，支持无限嵌套；0 表示一级合集）
-- ------------------------------------------------------------
DROP TABLE IF EXISTS `collection`;
CREATE TABLE `collection` (
    `id`          BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `name`        VARCHAR(100)    NOT NULL COMMENT '合集名称',
    `parent_id`   BIGINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '父合集ID，0为一级合集',
    `sort`        INT             NOT NULL DEFAULT 0 COMMENT '排序号，越小越靠前',
    `create_time` DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    KEY `idx_parent_id` (`parent_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COMMENT ='合集表（可嵌套）';

-- ------------------------------------------------------------
-- 4. 作品表（图文 image / 视频 video / 音频 audio）
-- ------------------------------------------------------------
DROP TABLE IF EXISTS `work`;
CREATE TABLE `work` (
    `id`            BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `collection_id` BIGINT UNSIGNED DEFAULT NULL COMMENT '所属合集ID',
    `title`         VARCHAR(100)    NOT NULL COMMENT '作品标题',
    `content`       TEXT            COMMENT '作品简介 / 正文',
    `type`          VARCHAR(20)     NOT NULL COMMENT '作品类型：image/video/audio',
    `cover_url`     VARCHAR(255)    DEFAULT NULL COMMENT '封面图URL',
    `resource_url`  VARCHAR(255)    DEFAULT NULL COMMENT '作品资源文件URL',
    `like_count`    INT             NOT NULL DEFAULT 0 COMMENT '点赞数（冗余计数）',
    `collect_count` INT             NOT NULL DEFAULT 0 COMMENT '收藏数（冗余计数）',
    `create_time`   DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time`   DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    KEY `idx_collection_id` (`collection_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COMMENT ='作品表';

-- ------------------------------------------------------------
-- 5. 点赞表（同一用户对同一作品仅一条记录）
-- ------------------------------------------------------------
DROP TABLE IF EXISTS `user_like`;
CREATE TABLE `user_like` (
    `id`          BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `user_id`     BIGINT UNSIGNED NOT NULL COMMENT '点赞用户ID',
    `work_id`     BIGINT UNSIGNED NOT NULL COMMENT '被点赞作品ID',
    `create_time` DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '点赞时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_user_work` (`user_id`, `work_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COMMENT ='点赞表';

-- ------------------------------------------------------------
-- 6. 收藏表
-- ------------------------------------------------------------
DROP TABLE IF EXISTS `user_collect`;
CREATE TABLE `user_collect` (
    `id`          BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `user_id`     BIGINT UNSIGNED NOT NULL COMMENT '收藏用户ID',
    `work_id`     BIGINT UNSIGNED NOT NULL COMMENT '被收藏作品ID',
    `create_time` DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '收藏时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_user_work` (`user_id`, `work_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COMMENT ='收藏表';

-- ------------------------------------------------------------
-- 7. 评论表
-- ------------------------------------------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
    `id`          BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `work_id`     BIGINT UNSIGNED NOT NULL COMMENT '所属作品ID',
    `user_id`     BIGINT UNSIGNED NOT NULL COMMENT '评论用户ID',
    `content`     VARCHAR(500)    NOT NULL COMMENT '评论内容',
    `create_time` DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '评论时间',
    `update_time` DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    KEY `idx_work_id` (`work_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COMMENT ='评论表';

-- ------------------------------------------------------------
-- 8. 商品表（小店）
-- ------------------------------------------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods` (
    `id`          BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `name`        VARCHAR(100)    NOT NULL COMMENT '商品名称',
    `cover`       VARCHAR(255)    DEFAULT NULL COMMENT '商品封面图URL',
    `description` TEXT            COMMENT '商品描述',
    `price`       DECIMAL(10,2)   NOT NULL DEFAULT 0.00 COMMENT '单价',
    `stock`       INT             NOT NULL DEFAULT 0 COMMENT '库存',
    `status`      TINYINT         NOT NULL DEFAULT 1 COMMENT '状态：1上架 0下架',
    `create_time` DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COMMENT ='商品表';

-- ------------------------------------------------------------
-- 9. 收货地址表（用户可保存多个地址）
-- ------------------------------------------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address` (
    `id`             BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `user_id`        BIGINT UNSIGNED NOT NULL COMMENT '所属用户ID',
    `receiver`       VARCHAR(50)     NOT NULL COMMENT '收货人姓名',
    `phone`          VARCHAR(20)     NOT NULL COMMENT '联系电话',
    `detail_address` VARCHAR(255)    NOT NULL COMMENT '详细收货地址',
    `is_default`     TINYINT         NOT NULL DEFAULT 0 COMMENT '是否默认地址：1是 0否',
    `create_time`    DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time`    DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    KEY `idx_user_id` (`user_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COMMENT ='收货地址表';

-- ------------------------------------------------------------
-- 10. 订单表（orders 规避 MySQL 保留字 order）
-- ------------------------------------------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
    `id`           BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `order_no`     VARCHAR(32)     NOT NULL COMMENT '订单号',
    `user_id`      BIGINT UNSIGNED NOT NULL COMMENT '下单用户ID',
    `goods_id`     BIGINT UNSIGNED NOT NULL COMMENT '购买商品ID',
    `quantity`     INT             NOT NULL DEFAULT 1 COMMENT '购买数量',
    `total_amount` DECIMAL(10,2)   NOT NULL DEFAULT 0.00 COMMENT '订单总金额',
    `receiver`     VARCHAR(50)     NOT NULL COMMENT '收货人',
    `phone`        VARCHAR(20)     NOT NULL COMMENT '联系电话',
    `address`      VARCHAR(255)    NOT NULL COMMENT '收货地址',
    `status`       VARCHAR(20)     NOT NULL DEFAULT 'pending' COMMENT '状态：pending待付款/paid已付款/shipped已发货/done已完成/cancelled已取消',
    `create_time`  DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '下单时间',
    `update_time`  DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_order_no` (`order_no`),
    KEY `idx_user_id` (`user_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COMMENT ='订单表';

-- ------------------------------------------------------------
-- 11. 站点通知表（管理员发布）
-- ------------------------------------------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice` (
    `id`          BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `title`       VARCHAR(100)    NOT NULL COMMENT '通知标题',
    `content`     TEXT            COMMENT '通知内容',
    `admin_id`    BIGINT UNSIGNED NOT NULL COMMENT '发布管理员ID',
    `create_time` DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发布时间',
    `update_time` DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COMMENT ='站点通知表';

-- ------------------------------------------------------------
-- 12. 打赏记录表（用户对博主打赏）
-- ------------------------------------------------------------
DROP TABLE IF EXISTS `reward`;
CREATE TABLE `reward` (
    `id`          BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `user_id`     BIGINT UNSIGNED NOT NULL COMMENT '打赏用户ID',
    `blogger_id`  BIGINT UNSIGNED NOT NULL COMMENT '被打赏博主ID',
    `amount`      DECIMAL(10,2)   NOT NULL COMMENT '打赏金额',
    `create_time` DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '打赏时间',
    PRIMARY KEY (`id`),
    KEY `idx_blogger_id` (`blogger_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COMMENT ='打赏记录表';
