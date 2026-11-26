-- ============================================================
-- Gallery 演示种子数据（本地开发环境使用）
-- 说明：密码为 BCrypt 加密存储，明文均为 123456。
-- 运行顺序：先执行 schema.sql，再执行本文件。
-- ============================================================

USE gallery_db;

-- 四类角色演示账号：blogger / admin / service / user（密码明文 123456）
INSERT INTO `user` (`id`, `account`, `password`, `nickname`, `user_code`, `role`, `avatar`, `status`) VALUES
(1, 'blogger01', '$2a$10$eVBU/5hVLwXCzvWJw4ZvuO2n2UAUvHeN6EmK0qK9YdQRkt/ijZtTi', '听雨',     'BG10001', 'blogger', NULL, 1),
(2, 'admin01',   '$2a$10$eVBU/5hVLwXCzvWJw4ZvuO2n2UAUvHeN6EmK0qK9YdQRkt/ijZtTi', '管理小助手', 'AD10001', 'admin',   NULL, 1),
(3, 'service01', '$2a$10$eVBU/5hVLwXCzvWJw4ZvuO2n2UAUvHeN6EmK0qK9YdQRkt/ijZtTi', '客服小助手', 'SV10001', 'service', NULL, 1),
(4, 'user01',    '$2a$10$eVBU/5hVLwXCzvWJw4ZvuO2n2UAUvHeN6EmK0qK9YdQRkt/ijZtTi', '访客小林',  'U10001',  'user',    NULL, 1);

-- 博主主页信息（与博主账号 1 一一对应）
INSERT INTO `blog_profile` (`blogger_id`, `avatar`, `background_img`, `signature`)
VALUES (1, NULL, NULL, '用画面记录生活，欢迎来到我的画廊。');

-- 演示合集（一级合集）
INSERT INTO `collection` (`id`, `name`, `parent_id`, `sort`) VALUES
(1, '推荐',   0, 1),
(2, '插画集', 0, 2),
(3, '音频集', 0, 3);

-- 演示作品
INSERT INTO `work` (`collection_id`, `title`, `content`, `type`, `cover_url`, `resource_url`, `like_count`, `collect_count`) VALUES
(2, '午后窗边',   '一幅记录午后光影的插画。',       'image', NULL, NULL, 12, 5),
(3, '雨夜钢琴曲', '一段即兴录制的钢琴音频片段。',    'audio', NULL, NULL, 8,  3);

-- 演示商品
INSERT INTO `goods` (`name`, `cover`, `description`, `price`, `stock`, `status`) VALUES
('插画明信片套装', NULL, '一套 6 张原创插画明信片', 29.90, 100, 1),
('定制头像稿',     NULL, '单人头像定制，需私信沟通', 99.00, 20,  1);
