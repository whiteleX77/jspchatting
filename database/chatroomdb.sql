/*
MySQL Data Transfer
Source Host: localhost
Source Database: chatroomdb
Target Host: localhost
Target Database: chatroomdb
Date: 2014-1-12 19:50:57
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` smallint(10) NOT NULL auto_increment,
  `username` varchar(10) default NULL,
  `password` varchar(10) default NULL,
  `name` varchar(15) default NULL,
  `sex` varchar(2) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records 
-- ----------------------------
INSERT INTO `user` VALUES ('1', '101', '123', '张大侠', '男');
INSERT INTO `user` VALUES ('2', '102', '123', '李晓丽', '女');
INSERT INTO `user` VALUES ('3', '103', '123', '周晓晨', '女');
INSERT INTO `user` VALUES ('4', '104', '123', '王亚军', '男');
