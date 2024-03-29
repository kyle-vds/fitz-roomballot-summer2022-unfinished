DROP TABLE news;
DROP TABLE ballot_individuals;
DROP TABLE ballot_individuals_housed;
DROP TABLE ballot_groups;
DROP TABLE timetable;
DROP TABLE ballot_seed;
DROP TABLE ballot_errata;
DROP TABLE rooms;
DROP TABLE room_quotes;

UPDATE pages SET url = 'registration', title = 'Registration' WHERE id = 1;
UPDATE pages SET url = 'roomballot', title = 'Room Ballot' WHERE id = 2;
UPDATE pages SET url = 'housingballot', title = 'Housing Ballot' WHERE id = 4;
UPDATE pages SET url = 'pageeditor', title = 'Admin Page Editor' WHERE id = 7;
UPDATE pages SET url = 'controlpanel', title = 'Admin Control Panel' WHERE id = 8;

INSERT INTO pages (id, url, title, content) VALUES (3, 'groups', 'Group Editor', '');
INSERT INTO pages (id, url, title, content) VALUES (9, 'balloteditor', 'Admin Ballot Editor', '');
INSERT INTO pages (id, url, title, content) VALUES (10, 'roomallocator', 'Room Selector', '');
INSERT INTO pages (id, url, title, content) VALUES (11, 'roomeditor', 'Room Editor', '');
INSERT INTO `pages`(`id`, `url`, `title`, `content`) VALUES (12,'imageeditor','Image Editor','');
 
CREATE TABLE `admin` (
`crsid` VARCHAR(7) NOT NULL, 
`name` TINYTEXT NOT NULL, 
PRIMARY KEY(`crsid`));

INSERT INTO admin (crsid, name) VALUES ('kv330', 'Kyle Van Der Spuy');

CREATE TABLE `users` ( 
`crsid` VARCHAR(7) NOT NULL, 
`name` TINYTEXT NOT NULL, 
`group_id` BIGINT(20) unsigned NULL DEFAULT NULL,
`room` BIGINT(20) unsigned NULL DEFAULT NULL,
`proxy` VARCHAR(7) NULL DEFAULT NULL,
`requests` TINYTEXT NULL DEFAULT NULL,
`searching` TINYINT(1) unsigned NOT NULL DEFAULT 1,
`priority` ENUM('FIRSTYEAR', 'SECONDYEAR', 'THIRDYEAR', 'THIRDYEARABROAD') NOT NULL,
`room_ballot` TINYINT(1) unsigned NOT NULL,
`access` TINYTEXT NULL DEFAULT NULL,
PRIMARY KEY(`crsid`));

CREATE TABLE `room_ballot` (
`group_id` BIGINT(20) unsigned NOT NULL AUTO_INCREMENT, 
`crsids` VARCHAR(75) NOT NULL,
`priority` ENUM('FIRSTYEAR', 'SECONDYEAR', 'THIRDYEAR', 'THIRDYEARABROAD') NOT NULL,
`size` TINYINT(2) unsigned NOT NULL DEFAULT 1,
`order` INT(3) unsigned NULL DEFAULT NULL,
`requesting` TINYTEXT NULL DEFAULT NULL,
`rooms` VARCHAR(200) NULL DEFAULT NULL,
PRIMARY KEY(`group_id`));

CREATE TABLE `housing_ballot` (
`group_id` BIGINT(20) unsigned NOT NULL AUTO_INCREMENT, 
`crsids` VARCHAR(75) NOT NULL,
`priority` ENUM('FIRSTYEAR', 'SECONDYEAR', 'THIRDYEAR', 'THIRDYEARABROAD') NOT NULL,
`size` TINYINT(2) unsigned NOT NULL DEFAULT 1,
`order` INT(3) unsigned NULL DEFAULT NULL,
`requesting` TINYTEXT NULL DEFAULT NULL,
`house` BIGINT(20) NULL DEFAULT NULL,
PRIMARY KEY(`group_id`));

CREATE TABLE `ballot_log` (
`year`  INT(4) unsigned NOT NULL,
`stage` INT unsigned NOT NULL DEFAULT 0,
`hb_seed` BIGINT(20) unsigned NULL DEFAULT NULL,
`rb_seed` BIGINT(20) unsigned NULL DEFAULT NULL,
`position` INT(3) unsigned NULL DEFAULT NULL,
`proxy` VARCHAR(7) NULL DEFAULT NULL,
PRIMARY KEY(`year`)); 

CREATE TABLE `key_value` (
`key` VARCHAR(20) NOT NULL, 
`value` TINYTEXT NOT NULL, 
PRIMARY KEY(`key`));

CREATE TABLE `access` (
`id` BIGINT(20) unsigned NOT NULL AUTO_INCREMENT, 
`name` TINYTEXT NOT NULL,
`users` TINYTEXT NULL DEFAULT NULL, 
PRIMARY KEY(`id`));

CREATE TABLE `rooms` (
`id` BIGINT(20) unsigned NOT NULL AUTO_INCREMENT, 
`name` TINYTEXT NOT NULL,
`price` INT(6) unsigned NOT NULL,
`available` TINYINT(1) unsigned NOT NULL DEFAULT 1,
`access` TINYTEXT NULL DEFAULT NULL, 
`house` BIGINT(20) unsigned NOT NULL,
`floor` TINYINT(2) NOT NULL,
PRIMARY KEY(`id`));

CREATE TABLE `houses` (
`id` BIGINT(20) unsigned NOT NULL AUTO_INCREMENT, 
`name` TINYTEXT NOT NULL,
`rooms` TINYTEXT NULL DEFAULT NULL,
`size` TINYINT(2) unsigned NOT NULL DEFAULT 0,
`house` TINYINT(1) unsigned NOT NULL,
`description` MEDIUMTEXT NULL DEFAULT NULL,
`images` MEDIUMTEXT NULL DEFAULT NULL,
`available` TINYINT unsigned NOT NULL DEFAULT 1, 
PRIMARY KEY(`id`));

CREATE TABLE `images` (
`id` BIGINT(20) unsigned NOT NULL AUTO_INCREMENT, 
`src` VARCHAR(100) NOT NULL,
`description` TINYTEXT NOT NULL,
`house` BIGINT(20) unsigned NOT NULL,
PRIMARY KEY(`id`));

---- Updated Already ----

DROP TABLE `access`;
DROP TABLE `pages`;
DROP TABLE `key_value`;

ALTER TABLE `admin` CHANGE `crsid` `id` VARCHAR(7) NOT NULL;
ALTER TABLE `admin` MODIFY `name` TINYTEXT NOT NULL;

ALTER TABLE `ballot_log` CHANGE `year` `id` BIGINT(20) unsigned NOT NULL AUTO_INCREMENT;
ALTER TABLE `ballot_log` MODIFY `position` TINYINT(3) unsigned NULL DEFAULT NULL;
ALTER TABLE `ballot_log` ADD `group` BIGINT(20) unsigned NULL DEFAULT NULL;
ALTER TABLE `ballot_log` ADD `reg_open` DATE NULL DEFAULT NULL
ALTER TABLE `ballot_log` ADD `hb_drawn` DATE NULL DEFAULT NULL
ALTER TABLE `ballot_log` ADD `hb_dead` DATE NULL DEFAULT NULL
ALTER TABLE `ballot_log` ADD `rb_drawn` DATE NULL DEFAULT NULL
ALTER TABLE `ballot_log` ADD `rb_dead` DATE NULL DEFAULT NULL
ALTER TABLE `ballot_log` ADD `contract_dead` DATE NULL DEFAULT NULL

ALTER TABLE `houses` MODIFY `images` TINYTEXT unsigned NULL DEFAULT NULL;
ALTER TABLE `houses` MODIFY `available` TINYINT(2) unsigned NOT NULL DEFAULT 0;

ALTER TABLE `housing_ballot` CHANGE `group_id` `id` BIGINT(20) unsigned NOT NULL AUTO_INCREMENT;
ALTER TABLE `housing_ballot` MODIFY `crsids` TINYTEXT NOT NULL;
ALTER TABLE `housing_ballot` MODIFY `priority` TINYINT(1) unsigned NOT NULL;
ALTER TABLE `housing_ballot` MODIFY `order` TINYINT(3) unsigned NULL;
ALTER TABLE `housing_ballot` ADD `proxy` VARCHAR(7) NULL DEFAULT NULL;
ALTER TABLE `housing_ballot` ADD `date` DATETIME NULL DEFAULT NULL

ALTER TABLE `images` CHANGE `house` `houses` TINYTEXT NULL DEFAULT NULL;
ALTER TABLE `images` MODIFY `src` TINYTEXT NOT NULL;
ALTER TABLE `images` MODIFY `houses` TINYTEXT NOT NULL;

ALTER TABLE `rooms` DROP `access`;
ALTER TABLE `rooms` MODIFY `price` DECIMAL(6,2) unsigned NOT NULL;
ALTER TABLE `rooms` MODIFY `floor` TINYINT(1) unsigned NOT NULL;
ALTER TABLE `rooms` ADD `allocation` VARCHAR(7) NULL DEFAULT NULL;

ALTER TABLE `room_ballot` CHANGE `group_id` `id` BIGINT(20) unsigned NOT NULL AUTO_INCREMENT;
ALTER TABLE `room_ballot` MODIFY `crsids` TINYTEXT NOT NULL;
ALTER TABLE `room_ballot` MODIFY `priority` TINYINT(1) unsigned NOT NULL;
ALTER TABLE `room_ballot` MODIFY `order` TINYINT(3) unsigned NULL;
ALTER TABLE `room_ballot` MODIFY `rooms` TINYTEXT NULL DEFAULT NULL;
ALTER TABLE `room_ballot` ADD `proxy` VARCHAR(7) NULL DEFAULT NULL;
ALTER TABLE `room_ballot` ADD `date` DATETIME NULL DEFAULT NULL


ALTER TABLE `users` CHANGE `crsid` `id` VARCHAR(7) NOT NULL;
ALTER TABLE `users` CHANGE `room_ballot` `ballot` TINYINT(1) unsigned NOT NULL;
ALTER TABLE `users` DROP `access`;
ALTER TABLE `users` CHANGE `proxy` `proxies` TINYTEXT NULL DEFAULT NULL;
ALTER TABLE `users` MODIFY `priority` TINYINT(1) unsigned NOT NULL;
