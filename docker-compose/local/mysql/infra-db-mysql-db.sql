
-- ---------------------------------------------------------------------------
-- create a database;
-- ---------------------------------------------------------------------------

-- create database if not exists `test`;

-- 数据库创建: 用户数据库
DROP DATABASE IF EXISTS `mall-java`;
CREATE DATABASE `mall-java` DEFAULT CHARACTER SET = `utf8mb4` DEFAULT COLLATE `utf8mb4_unicode_ci`;

DROP DATABASE IF EXISTS `mall`;
CREATE DATABASE `mall` DEFAULT CHARACTER SET = `utf8mb4` DEFAULT COLLATE `utf8mb4_unicode_ci`;


-- fix for deleted_at = 0
select @@sql_mode;
set sql_mode = '';

