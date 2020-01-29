-- phpMyAdmin SQL Dump
-- version 3.0.1.1
-- http://www.phpmyadmin.net
--
-- �������汾: 5.1.29
-- PHP �汾: 5.2.6

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

-- --------------------------------------------------------

-- ----------------------------
-- Table structure for `admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `username` varchar(20) NOT NULL DEFAULT '',
  `password` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_admin
-- ----------------------------
INSERT INTO `admin` VALUES ('a', 'a'); 

CREATE TABLE IF NOT EXISTS `t_department` (
  `departmentId` int(11) NOT NULL AUTO_INCREMENT COMMENT '����id',
  `departmentName` varchar(20)  NOT NULL COMMENT '��������',
  `departmentDesc` varchar(5000)  NULL COMMENT '���ҽ���',
  `birthDate` varchar(20)  NULL COMMENT '��������',
  `chargeMan` varchar(20)  NULL COMMENT '������',
  PRIMARY KEY (`departmentId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_doctor` (
  `doctorNumber` varchar(20)  NOT NULL COMMENT 'doctorNumber',
  `password` varchar(20)  NULL COMMENT '��¼����',
  `departmentObj` int(11) NOT NULL COMMENT '���ڿ���',
  `doctorName` varchar(20)  NOT NULL COMMENT 'ҽ������',
  `sex` varchar(4)  NOT NULL COMMENT '�Ա�',
  `doctorPhoto` varchar(60)  NOT NULL COMMENT 'ҽ����Ƭ',
  `birthDate` varchar(20)  NULL COMMENT '��������',
  `position` varchar(20)  NOT NULL COMMENT 'ҽ��ְλ',
  `experience` varchar(20)  NOT NULL COMMENT '��������',
  `contactWay` varchar(20)  NULL COMMENT '��ϵ��ʽ',
  `goodAt` varchar(200)  NULL COMMENT '�ó�',
  `doctorDesc` varchar(8000)  NOT NULL COMMENT 'ҽ������',
  PRIMARY KEY (`doctorNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `t_patient` (
  `patientId` int(11) NOT NULL AUTO_INCREMENT COMMENT '����id',
  `doctorObj` varchar(20)  NOT NULL COMMENT 'ҽ��',
  `patientName` varchar(20)  NOT NULL COMMENT '��������',
  `sex` varchar(4)  NOT NULL COMMENT '�Ա�',
  `cardNumber` varchar(30)  NOT NULL COMMENT '���֤��',
  `telephone` varchar(20)  NOT NULL COMMENT '��ϵ�绰',
  `illnessCase` varchar(8000)  NOT NULL COMMENT '���˲���',
  `addTime` varchar(20)  NULL COMMENT '�Ǽ�ʱ��',
  PRIMARY KEY (`patientId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_orderInfo` (
  `orderId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ԤԼid',
  `userObj` varchar(30)  NOT NULL COMMENT 'ԤԼ�û�',
  `doctorObj` varchar(20)  NOT NULL COMMENT 'ԤԼҽ��',
  `orderDate` varchar(20)  NULL COMMENT 'ԤԼ����',
  `timeInterval` varchar(20)  NOT NULL COMMENT 'ʱ��',
  `telephone` varchar(20)  NOT NULL COMMENT '��ϵ�绰',
  `orderTime` varchar(20)  NULL COMMENT '�µ�ʱ��',
  `checkState` varchar(20)  NOT NULL COMMENT '����״̬',
  `replyContent` varchar(800)  NOT NULL COMMENT 'ҽ���ظ�',
  PRIMARY KEY (`orderId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_news` (
  `newsId` int(11) NOT NULL AUTO_INCREMENT COMMENT '����id',
  `newsTitle` varchar(100)  NOT NULL COMMENT '���ű���',
  `newsPhoto` varchar(60)  NOT NULL COMMENT '����ͼƬ',
  `newsContent` varchar(8000)  NOT NULL COMMENT '��������',
  `newsDate` varchar(20)  NULL COMMENT '��������',
  `newsFrom` varchar(30)  NULL COMMENT '������Դ',
  PRIMARY KEY (`newsId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_leaveword` (
  `leaveWordId` int(11) NOT NULL AUTO_INCREMENT COMMENT '����id',
  `leaveTitle` varchar(80)  NOT NULL COMMENT '���Ա���',
  `leaveContent` varchar(2000)  NOT NULL COMMENT '��������',
  `userObj` varchar(30)  NOT NULL COMMENT '������',
  `leaveTime` varchar(20)  NULL COMMENT '����ʱ��',
  `replyContent` varchar(1000)  NULL COMMENT '����ظ�',
  `replyTime` varchar(20)  NULL COMMENT '�ظ�ʱ��',
  PRIMARY KEY (`leaveWordId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_userInfo` (
  `user_name` varchar(30)  NOT NULL COMMENT 'user_name',
  `password` varchar(30)  NOT NULL COMMENT '��¼����',
  `name` varchar(20)  NOT NULL COMMENT '����',
  `gender` varchar(4)  NOT NULL COMMENT '�Ա�',
  `birthDate` varchar(20)  NULL COMMENT '��������',
  `userPhoto` varchar(60)  NOT NULL COMMENT '�û���Ƭ',
  `telephone` varchar(20)  NOT NULL COMMENT '��ϵ�绰',
  `email` varchar(50)  NOT NULL COMMENT '����',
  `address` varchar(80)  NULL COMMENT '��ͥ��ַ',
  `regTime` varchar(20)  NULL COMMENT 'ע��ʱ��',
  PRIMARY KEY (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE t_doctor ADD CONSTRAINT FOREIGN KEY (departmentObj) REFERENCES t_department(departmentId);
ALTER TABLE t_patient ADD CONSTRAINT FOREIGN KEY (doctorObj) REFERENCES t_doctor(doctorNumber);
ALTER TABLE t_orderInfo ADD CONSTRAINT FOREIGN KEY (userObj) REFERENCES t_userInfo(user_name);
ALTER TABLE t_orderInfo ADD CONSTRAINT FOREIGN KEY (doctorObj) REFERENCES t_doctor(doctorNumber);
ALTER TABLE t_leaveword ADD CONSTRAINT FOREIGN KEY (userObj) REFERENCES t_userInfo(user_name);


