/*
SQLyog Ultimate v12.09 (64 bit)
MySQL - 5.5.45 : Database - seeddms
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`seeddms` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `seeddms`;

/*Table structure for table `tblacls` */

DROP TABLE IF EXISTS `tblacls`;

CREATE TABLE `tblacls` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `target` int(11) NOT NULL DEFAULT '0',
  `targetType` tinyint(4) NOT NULL DEFAULT '0',
  `userID` int(11) NOT NULL DEFAULT '-1',
  `groupID` int(11) NOT NULL DEFAULT '-1',
  `mode` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tblacls` */

/*Table structure for table `tblattributedefinitions` */

DROP TABLE IF EXISTS `tblattributedefinitions`;

CREATE TABLE `tblattributedefinitions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `objtype` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0all 1folder 2doc 3content',
  `type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '1int 2float 3string 4bool 5url 6email 7date',
  `multiple` tinyint(4) NOT NULL DEFAULT '0',
  `minvalues` int(11) NOT NULL DEFAULT '0',
  `maxvalues` int(11) NOT NULL DEFAULT '0',
  `valueset` text,
  `regex` text,
  `usingfolder` int(11) DEFAULT '0' COMMENT '属性应用的文件夹',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8


/*Data for the table `tblattributedefinitions` */

/*Table structure for table `tblcategory` */

DROP TABLE IF EXISTS `tblcategory`;

CREATE TABLE `tblcategory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tblcategory` */

/*Table structure for table `tbldocumentapprovelog` */

DROP TABLE IF EXISTS `tbldocumentapprovelog`;

CREATE TABLE `tbldocumentapprovelog` (
  `approveLogID` int(11) NOT NULL AUTO_INCREMENT,
  `approveID` int(11) NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `comment` text NOT NULL,
  `date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `userID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`approveLogID`),
  KEY `tblDocumentApproveLog_approve` (`approveID`),
  KEY `tblDocumentApproveLog_user` (`userID`),
  CONSTRAINT `tblDocumentApproveLog_approve` FOREIGN KEY (`approveID`) REFERENCES `tbldocumentapprovers` (`approveID`) ON DELETE CASCADE,
  CONSTRAINT `tblDocumentApproveLog_user` FOREIGN KEY (`userID`) REFERENCES `tblusers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tbldocumentapprovelog` */

/*Table structure for table `tbldocumentapprovers` */

DROP TABLE IF EXISTS `tbldocumentapprovers`;

CREATE TABLE `tbldocumentapprovers` (
  `approveID` int(11) NOT NULL AUTO_INCREMENT,
  `documentID` int(11) NOT NULL DEFAULT '0',
  `version` smallint(5) unsigned NOT NULL DEFAULT '0',
  `type` tinyint(4) NOT NULL DEFAULT '0',
  `required` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`approveID`),
  UNIQUE KEY `documentID` (`documentID`,`version`,`type`,`required`),
  CONSTRAINT `tblDocumentApprovers_document` FOREIGN KEY (`documentID`) REFERENCES `tbldocuments` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tbldocumentapprovers` */

/*Table structure for table `tbldocumentattributes` */

DROP TABLE IF EXISTS `tbldocumentattributes`;

CREATE TABLE `tbldocumentattributes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `document` int(11) DEFAULT NULL,
  `attrdef` int(11) DEFAULT NULL,
  `value` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `document` (`document`,`attrdef`),
  KEY `tblDocumentAttributes_attrdef` (`attrdef`),
  CONSTRAINT `tblDocumentAttributes_attrdef` FOREIGN KEY (`attrdef`) REFERENCES `tblattributedefinitions` (`id`),
  CONSTRAINT `tblDocumentAttributes_document` FOREIGN KEY (`document`) REFERENCES `tbldocuments` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tbldocumentattributes` */

/*Table structure for table `tbldocumentcategory` */

DROP TABLE IF EXISTS `tbldocumentcategory`;

CREATE TABLE `tbldocumentcategory` (
  `categoryID` int(11) NOT NULL DEFAULT '0',
  `documentID` int(11) NOT NULL DEFAULT '0',
  KEY `tblDocumentCategory_category` (`categoryID`),
  KEY `tblDocumentCategory_document` (`documentID`),
  CONSTRAINT `tblDocumentCategory_category` FOREIGN KEY (`categoryID`) REFERENCES `tblcategory` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tblDocumentCategory_document` FOREIGN KEY (`documentID`) REFERENCES `tbldocuments` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tbldocumentcategory` */

/*Table structure for table `tbldocumentcontent` */

DROP TABLE IF EXISTS `tbldocumentcontent`;

CREATE TABLE `tbldocumentcontent` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `document` int(11) NOT NULL DEFAULT '0',
  `version` smallint(5) unsigned NOT NULL,
  `comment` text,
  `date` int(12) DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `dir` varchar(255) NOT NULL DEFAULT '',
  `orgFileName` varchar(150) NOT NULL DEFAULT '',
  `fileType` varchar(10) NOT NULL DEFAULT '',
  `mimeType` varchar(100) NOT NULL DEFAULT '',
  `fileSize` bigint(20) DEFAULT NULL,
  `checksum` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `document` (`document`,`version`),
  CONSTRAINT `tblDocumentContent_document` FOREIGN KEY (`document`) REFERENCES `tbldocuments` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tbldocumentcontent` */

/*Table structure for table `tbldocumentcontentattributes` */

DROP TABLE IF EXISTS `tbldocumentcontentattributes`;

CREATE TABLE `tbldocumentcontentattributes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` int(11) DEFAULT NULL,
  `attrdef` int(11) DEFAULT NULL,
  `value` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content` (`content`,`attrdef`),
  KEY `tblDocumentContentAttributes_attrdef` (`attrdef`),
  CONSTRAINT `tblDocumentContentAttributes_attrdef` FOREIGN KEY (`attrdef`) REFERENCES `tblattributedefinitions` (`id`),
  CONSTRAINT `tblDocumentContentAttributes_document` FOREIGN KEY (`content`) REFERENCES `tbldocumentcontent` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tbldocumentcontentattributes` */

/*Table structure for table `tbldocumentfiles` */

DROP TABLE IF EXISTS `tbldocumentfiles`;

CREATE TABLE `tbldocumentfiles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `document` int(11) NOT NULL DEFAULT '0',
  `userID` int(11) NOT NULL DEFAULT '0',
  `comment` text,
  `name` varchar(150) DEFAULT NULL,
  `date` int(12) DEFAULT NULL,
  `dir` varchar(255) NOT NULL DEFAULT '',
  `orgFileName` varchar(150) NOT NULL DEFAULT '',
  `fileType` varchar(10) NOT NULL DEFAULT '',
  `mimeType` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `tblDocumentFiles_document` (`document`),
  KEY `tblDocumentFiles_user` (`userID`),
  CONSTRAINT `tblDocumentFiles_document` FOREIGN KEY (`document`) REFERENCES `tbldocuments` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tblDocumentFiles_user` FOREIGN KEY (`userID`) REFERENCES `tblusers` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tbldocumentfiles` */

/*Table structure for table `tbldocumentlinks` */

DROP TABLE IF EXISTS `tbldocumentlinks`;

CREATE TABLE `tbldocumentlinks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `document` int(11) NOT NULL DEFAULT '0',
  `target` int(11) NOT NULL DEFAULT '0',
  `userID` int(11) NOT NULL DEFAULT '0',
  `public` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `tblDocumentLinks_document` (`document`),
  KEY `tblDocumentLinks_target` (`target`),
  KEY `tblDocumentLinks_user` (`userID`),
  CONSTRAINT `tblDocumentLinks_document` FOREIGN KEY (`document`) REFERENCES `tbldocuments` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tblDocumentLinks_target` FOREIGN KEY (`target`) REFERENCES `tbldocuments` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tblDocumentLinks_user` FOREIGN KEY (`userID`) REFERENCES `tblusers` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tbldocumentlinks` */

/*Table structure for table `tbldocumentlocks` */

DROP TABLE IF EXISTS `tbldocumentlocks`;

CREATE TABLE `tbldocumentlocks` (
  `document` int(11) NOT NULL DEFAULT '0',
  `userID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`document`),
  KEY `tblDocumentLocks_user` (`userID`),
  CONSTRAINT `tblDocumentLocks_document` FOREIGN KEY (`document`) REFERENCES `tbldocuments` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tblDocumentLocks_user` FOREIGN KEY (`userID`) REFERENCES `tblusers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tbldocumentlocks` */

/*Table structure for table `tbldocumentreviewers` */

DROP TABLE IF EXISTS `tbldocumentreviewers`;

CREATE TABLE `tbldocumentreviewers` (
  `reviewID` int(11) NOT NULL AUTO_INCREMENT,
  `documentID` int(11) NOT NULL DEFAULT '0',
  `version` smallint(5) unsigned NOT NULL DEFAULT '0',
  `type` tinyint(4) NOT NULL DEFAULT '0',
  `required` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`reviewID`),
  UNIQUE KEY `documentID` (`documentID`,`version`,`type`,`required`),
  CONSTRAINT `tblDocumentReviewers_document` FOREIGN KEY (`documentID`) REFERENCES `tbldocuments` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tbldocumentreviewers` */

/*Table structure for table `tbldocumentreviewlog` */

DROP TABLE IF EXISTS `tbldocumentreviewlog`;

CREATE TABLE `tbldocumentreviewlog` (
  `reviewLogID` int(11) NOT NULL AUTO_INCREMENT,
  `reviewID` int(11) NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `comment` text NOT NULL,
  `date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `userID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`reviewLogID`),
  KEY `tblDocumentReviewLog_review` (`reviewID`),
  KEY `tblDocumentReviewLog_user` (`userID`),
  CONSTRAINT `tblDocumentReviewLog_review` FOREIGN KEY (`reviewID`) REFERENCES `tbldocumentreviewers` (`reviewID`) ON DELETE CASCADE,
  CONSTRAINT `tblDocumentReviewLog_user` FOREIGN KEY (`userID`) REFERENCES `tblusers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tbldocumentreviewlog` */

/*Table structure for table `tbldocuments` */

DROP TABLE IF EXISTS `tbldocuments`;

CREATE TABLE `tbldocuments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) DEFAULT NULL,
  `comment` text,
  `date` int(12) DEFAULT NULL,
  `expires` int(12) DEFAULT NULL,
  `owner` int(11) DEFAULT NULL,
  `folder` int(11) DEFAULT NULL,
  `folderList` text NOT NULL,
  `inheritAccess` tinyint(1) NOT NULL DEFAULT '1',
  `defaultAccess` tinyint(4) NOT NULL DEFAULT '0',
  `locked` int(11) NOT NULL DEFAULT '-1',
  `keywords` text NOT NULL,
  `sequence` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `tblDocuments_folder` (`folder`),
  KEY `tblDocuments_owner` (`owner`),
  CONSTRAINT `tblDocuments_folder` FOREIGN KEY (`folder`) REFERENCES `tblfolders` (`id`),
  CONSTRAINT `tblDocuments_owner` FOREIGN KEY (`owner`) REFERENCES `tblusers` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tbldocuments` */

/*Table structure for table `tbldocumentstatus` */

DROP TABLE IF EXISTS `tbldocumentstatus`;

CREATE TABLE `tbldocumentstatus` (
  `statusID` int(11) NOT NULL AUTO_INCREMENT,
  `documentID` int(11) NOT NULL DEFAULT '0',
  `version` smallint(5) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`statusID`),
  UNIQUE KEY `documentID` (`documentID`,`version`),
  CONSTRAINT `tblDocumentStatus_document` FOREIGN KEY (`documentID`) REFERENCES `tbldocuments` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tbldocumentstatus` */

/*Table structure for table `tbldocumentstatuslog` */

DROP TABLE IF EXISTS `tbldocumentstatuslog`;

CREATE TABLE `tbldocumentstatuslog` (
  `statusLogID` int(11) NOT NULL AUTO_INCREMENT,
  `statusID` int(11) NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `comment` text NOT NULL,
  `date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `userID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`statusLogID`),
  KEY `statusID` (`statusID`),
  KEY `tblDocumentStatusLog_user` (`userID`),
  CONSTRAINT `tblDocumentStatusLog_status` FOREIGN KEY (`statusID`) REFERENCES `tbldocumentstatus` (`statusID`) ON DELETE CASCADE,
  CONSTRAINT `tblDocumentStatusLog_user` FOREIGN KEY (`userID`) REFERENCES `tblusers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tbldocumentstatuslog` */

/*Table structure for table `tblevents` */

DROP TABLE IF EXISTS `tblevents`;

CREATE TABLE `tblevents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) DEFAULT NULL,
  `comment` text,
  `start` int(12) DEFAULT NULL,
  `stop` int(12) DEFAULT NULL,
  `date` int(12) DEFAULT NULL,
  `userID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tblevents` */

/*Table structure for table `tblfolderattributes` */

DROP TABLE IF EXISTS `tblfolderattributes`;

CREATE TABLE `tblfolderattributes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `folder` int(11) DEFAULT NULL,
  `attrdef` int(11) DEFAULT NULL,
  `value` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `folder` (`folder`,`attrdef`),
  KEY `tblFolderAttributes_attrdef` (`attrdef`),
  CONSTRAINT `tblFolderAttributes_attrdef` FOREIGN KEY (`attrdef`) REFERENCES `tblattributedefinitions` (`id`),
  CONSTRAINT `tblFolderAttributes_folder` FOREIGN KEY (`folder`) REFERENCES `tblfolders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tblfolderattributes` */

/*Table structure for table `tblfolders` */

DROP TABLE IF EXISTS `tblfolders`;

CREATE TABLE `tblfolders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(70) DEFAULT NULL,
  `parent` int(11) DEFAULT NULL,
  `folderList` text NOT NULL,
  `comment` text,
  `date` int(12) DEFAULT NULL,
  `owner` int(11) DEFAULT NULL,
  `inheritAccess` tinyint(1) NOT NULL DEFAULT '1',
  `defaultAccess` tinyint(4) NOT NULL DEFAULT '0',
  `sequence` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `parent` (`parent`),
  KEY `tblFolders_owner` (`owner`),
  CONSTRAINT `tblFolders_owner` FOREIGN KEY (`owner`) REFERENCES `tblusers` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `tblfolders` */

insert  into `tblfolders`(`id`,`name`,`parent`,`folderList`,`comment`,`date`,`owner`,`inheritAccess`,`defaultAccess`,`sequence`) values (1,'DMS',0,'','DMS root',1495606259,1,0,2,0);

/*Table structure for table `tblgroupmembers` */

DROP TABLE IF EXISTS `tblgroupmembers`;

CREATE TABLE `tblgroupmembers` (
  `groupID` int(11) NOT NULL DEFAULT '0',
  `userID` int(11) NOT NULL DEFAULT '0',
  `manager` smallint(1) NOT NULL DEFAULT '0',
  UNIQUE KEY `groupID` (`groupID`,`userID`),
  KEY `tblGroupMembers_user` (`userID`),
  CONSTRAINT `tblGroupMembers_group` FOREIGN KEY (`groupID`) REFERENCES `tblgroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tblGroupMembers_user` FOREIGN KEY (`userID`) REFERENCES `tblusers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tblgroupmembers` */

/*Table structure for table `tblgroups` */

DROP TABLE IF EXISTS `tblgroups`;

CREATE TABLE `tblgroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `comment` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tblgroups` */

/*Table structure for table `tblkeywordcategories` */

DROP TABLE IF EXISTS `tblkeywordcategories`;

CREATE TABLE `tblkeywordcategories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `owner` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tblkeywordcategories` */

/*Table structure for table `tblkeywords` */

DROP TABLE IF EXISTS `tblkeywords`;

CREATE TABLE `tblkeywords` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` int(11) NOT NULL DEFAULT '0',
  `keywords` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tblKeywords_category` (`category`),
  CONSTRAINT `tblKeywords_category` FOREIGN KEY (`category`) REFERENCES `tblkeywordcategories` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tblkeywords` */

/*Table structure for table `tblmandatoryapprovers` */

DROP TABLE IF EXISTS `tblmandatoryapprovers`;

CREATE TABLE `tblmandatoryapprovers` (
  `userID` int(11) NOT NULL DEFAULT '0',
  `approverUserID` int(11) NOT NULL DEFAULT '0',
  `approverGroupID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`userID`,`approverUserID`,`approverGroupID`),
  CONSTRAINT `tblMandatoryApprovers_user` FOREIGN KEY (`userID`) REFERENCES `tblusers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tblmandatoryapprovers` */

/*Table structure for table `tblmandatoryreviewers` */

DROP TABLE IF EXISTS `tblmandatoryreviewers`;

CREATE TABLE `tblmandatoryreviewers` (
  `userID` int(11) NOT NULL DEFAULT '0',
  `reviewerUserID` int(11) NOT NULL DEFAULT '0',
  `reviewerGroupID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`userID`,`reviewerUserID`,`reviewerGroupID`),
  CONSTRAINT `tblMandatoryReviewers_user` FOREIGN KEY (`userID`) REFERENCES `tblusers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tblmandatoryreviewers` */

/*Table structure for table `tblnotify` */

DROP TABLE IF EXISTS `tblnotify`;

CREATE TABLE `tblnotify` (
  `target` int(11) NOT NULL DEFAULT '0',
  `targetType` int(11) NOT NULL DEFAULT '0',
  `userID` int(11) NOT NULL DEFAULT '-1',
  `groupID` int(11) NOT NULL DEFAULT '-1',
  PRIMARY KEY (`target`,`targetType`,`userID`,`groupID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tblnotify` */

/*Table structure for table `tblsessions` */

DROP TABLE IF EXISTS `tblsessions`;

CREATE TABLE `tblsessions` (
  `id` varchar(50) NOT NULL DEFAULT '',
  `userID` int(11) NOT NULL DEFAULT '0',
  `lastAccess` int(11) NOT NULL DEFAULT '0',
  `theme` varchar(30) NOT NULL DEFAULT '',
  `language` varchar(30) NOT NULL DEFAULT '',
  `clipboard` text,
  `su` int(11) DEFAULT NULL,
  `splashmsg` text,
  PRIMARY KEY (`id`),
  KEY `tblSessions_user` (`userID`),
  CONSTRAINT `tblSessions_user` FOREIGN KEY (`userID`) REFERENCES `tblusers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tblsessions` */

insert  into `tblsessions`(`id`,`userID`,`lastAccess`,`theme`,`language`,`clipboard`,`su`,`splashmsg`) values ('eca5fdda885ea9662c29aadf44225ecb',1,1495606549,'bootstrap','zh_CN',NULL,0,NULL);

/*Table structure for table `tbluserimages` */

DROP TABLE IF EXISTS `tbluserimages`;

CREATE TABLE `tbluserimages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userID` int(11) NOT NULL DEFAULT '0',
  `image` blob NOT NULL,
  `mimeType` varchar(10) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `tblUserImages_user` (`userID`),
  CONSTRAINT `tblUserImages_user` FOREIGN KEY (`userID`) REFERENCES `tblusers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tbluserimages` */

/*Table structure for table `tbluserpasswordhistory` */

DROP TABLE IF EXISTS `tbluserpasswordhistory`;

CREATE TABLE `tbluserpasswordhistory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userID` int(11) NOT NULL DEFAULT '0',
  `pwd` varchar(50) DEFAULT NULL,
  `date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `tblUserPasswordHistory_user` (`userID`),
  CONSTRAINT `tblUserPasswordHistory_user` FOREIGN KEY (`userID`) REFERENCES `tblusers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tbluserpasswordhistory` */

/*Table structure for table `tbluserpasswordrequest` */

DROP TABLE IF EXISTS `tbluserpasswordrequest`;

CREATE TABLE `tbluserpasswordrequest` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userID` int(11) NOT NULL DEFAULT '0',
  `hash` varchar(50) DEFAULT NULL,
  `date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `tblUserPasswordRequest_user` (`userID`),
  CONSTRAINT `tblUserPasswordRequest_user` FOREIGN KEY (`userID`) REFERENCES `tblusers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tbluserpasswordrequest` */

/*Table structure for table `tblusers` */

DROP TABLE IF EXISTS `tblusers`;

CREATE TABLE `tblusers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `login` varchar(50) DEFAULT NULL,
  `pwd` varchar(50) DEFAULT NULL,
  `fullName` varchar(100) DEFAULT NULL,
  `email` varchar(70) DEFAULT NULL,
  `language` varchar(32) NOT NULL,
  `theme` varchar(32) NOT NULL,
  `comment` text NOT NULL,
  `role` smallint(1) NOT NULL DEFAULT '0',
  `hidden` smallint(1) NOT NULL DEFAULT '0',
  `pwdExpiration` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `loginfailures` tinyint(4) NOT NULL DEFAULT '0',
  `disabled` smallint(1) NOT NULL DEFAULT '0',
  `quota` bigint(20) DEFAULT NULL,
  `homefolder` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `login` (`login`),
  KEY `tblUsers_homefolder` (`homefolder`),
  CONSTRAINT `tblUsers_homefolder` FOREIGN KEY (`homefolder`) REFERENCES `tblfolders` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `tblusers` */

insert  into `tblusers`(`id`,`login`,`pwd`,`fullName`,`email`,`language`,`theme`,`comment`,`role`,`hidden`,`pwdExpiration`,`loginfailures`,`disabled`,`quota`,`homefolder`) values (1,'admin','21232f297a57a5a743894a0e4a801fc3','Administrator','address@server.com','zh_CN','bootstrap','',1,0,'0000-00-00 00:00:00',0,0,0,NULL),(2,'guest',NULL,'Guest User',NULL,'','','',2,0,'0000-00-00 00:00:00',0,0,0,NULL);

/*Table structure for table `tblversion` */

DROP TABLE IF EXISTS `tblversion`;

CREATE TABLE `tblversion` (
  `date` datetime NOT NULL,
  `major` smallint(6) DEFAULT NULL,
  `minor` smallint(6) DEFAULT NULL,
  `subminor` smallint(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tblversion` */

insert  into `tblversion`(`date`,`major`,`minor`,`subminor`) values ('2017-05-24 14:10:59',5,0,0);

/*Table structure for table `tblworkflowactions` */

DROP TABLE IF EXISTS `tblworkflowactions`;

CREATE TABLE `tblworkflowactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tblworkflowactions` */

/*Table structure for table `tblworkflowdocumentcontent` */

DROP TABLE IF EXISTS `tblworkflowdocumentcontent`;

CREATE TABLE `tblworkflowdocumentcontent` (
  `parentworkflow` int(11) DEFAULT '0',
  `workflow` int(11) DEFAULT NULL,
  `document` int(11) DEFAULT NULL,
  `version` smallint(5) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  KEY `tblWorkflowDocument_document` (`document`),
  KEY `tblWorkflowDocument_workflow` (`workflow`),
  KEY `tblWorkflowDocument_state` (`state`),
  CONSTRAINT `tblWorkflowDocument_document` FOREIGN KEY (`document`) REFERENCES `tbldocuments` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tblWorkflowDocument_state` FOREIGN KEY (`state`) REFERENCES `tblworkflowstates` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tblWorkflowDocument_workflow` FOREIGN KEY (`workflow`) REFERENCES `tblworkflows` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tblworkflowdocumentcontent` */

/*Table structure for table `tblworkflowlog` */

DROP TABLE IF EXISTS `tblworkflowlog`;

CREATE TABLE `tblworkflowlog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `document` int(11) DEFAULT NULL,
  `version` smallint(5) DEFAULT NULL,
  `workflow` int(11) DEFAULT NULL,
  `userid` int(11) DEFAULT NULL,
  `transition` int(11) DEFAULT NULL,
  `date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `comment` text,
  PRIMARY KEY (`id`),
  KEY `tblWorkflowLog_document` (`document`),
  KEY `tblWorkflowLog_workflow` (`workflow`),
  KEY `tblWorkflowLog_userid` (`userid`),
  KEY `tblWorkflowLog_transition` (`transition`),
  CONSTRAINT `tblWorkflowLog_document` FOREIGN KEY (`document`) REFERENCES `tbldocuments` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tblWorkflowLog_transition` FOREIGN KEY (`transition`) REFERENCES `tblworkflowtransitions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tblWorkflowLog_userid` FOREIGN KEY (`userid`) REFERENCES `tblusers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tblWorkflowLog_workflow` FOREIGN KEY (`workflow`) REFERENCES `tblworkflows` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tblworkflowlog` */

/*Table structure for table `tblworkflowmandatoryworkflow` */

DROP TABLE IF EXISTS `tblworkflowmandatoryworkflow`;

CREATE TABLE `tblworkflowmandatoryworkflow` (
  `userid` int(11) DEFAULT NULL,
  `workflow` int(11) DEFAULT NULL,
  UNIQUE KEY `userid` (`userid`,`workflow`),
  KEY `tblWorkflowMandatoryWorkflow_workflow` (`workflow`),
  CONSTRAINT `tblWorkflowMandatoryWorkflow_userid` FOREIGN KEY (`userid`) REFERENCES `tblusers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tblWorkflowMandatoryWorkflow_workflow` FOREIGN KEY (`workflow`) REFERENCES `tblworkflows` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tblworkflowmandatoryworkflow` */

/*Table structure for table `tblworkflows` */

DROP TABLE IF EXISTS `tblworkflows`;

CREATE TABLE `tblworkflows` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  `initstate` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tblWorkflow_initstate` (`initstate`),
  CONSTRAINT `tblWorkflow_initstate` FOREIGN KEY (`initstate`) REFERENCES `tblworkflowstates` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tblworkflows` */

/*Table structure for table `tblworkflowstates` */

DROP TABLE IF EXISTS `tblworkflowstates`;

CREATE TABLE `tblworkflowstates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  `visibility` smallint(5) DEFAULT '0',
  `maxtime` int(11) DEFAULT '0',
  `precondfunc` text,
  `documentstatus` smallint(5) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tblworkflowstates` */

/*Table structure for table `tblworkflowtransitiongroups` */

DROP TABLE IF EXISTS `tblworkflowtransitiongroups`;

CREATE TABLE `tblworkflowtransitiongroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `transition` int(11) DEFAULT NULL,
  `groupid` int(11) DEFAULT NULL,
  `minusers` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tblWorkflowTransitionGroups_transition` (`transition`),
  KEY `tblWorkflowTransitionGroups_groupid` (`groupid`),
  CONSTRAINT `tblWorkflowTransitionGroups_groupid` FOREIGN KEY (`groupid`) REFERENCES `tblgroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tblWorkflowTransitionGroups_transition` FOREIGN KEY (`transition`) REFERENCES `tblworkflowtransitions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tblworkflowtransitiongroups` */

/*Table structure for table `tblworkflowtransitions` */

DROP TABLE IF EXISTS `tblworkflowtransitions`;

CREATE TABLE `tblworkflowtransitions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `workflow` int(11) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `action` int(11) DEFAULT NULL,
  `nextstate` int(11) DEFAULT NULL,
  `maxtime` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `tblWorkflowTransitions_workflow` (`workflow`),
  KEY `tblWorkflowTransitions_state` (`state`),
  KEY `tblWorkflowTransitions_action` (`action`),
  KEY `tblWorkflowTransitions_nextstate` (`nextstate`),
  CONSTRAINT `tblWorkflowTransitions_action` FOREIGN KEY (`action`) REFERENCES `tblworkflowactions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tblWorkflowTransitions_nextstate` FOREIGN KEY (`nextstate`) REFERENCES `tblworkflowstates` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tblWorkflowTransitions_state` FOREIGN KEY (`state`) REFERENCES `tblworkflowstates` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tblWorkflowTransitions_workflow` FOREIGN KEY (`workflow`) REFERENCES `tblworkflows` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tblworkflowtransitions` */

/*Table structure for table `tblworkflowtransitionusers` */

DROP TABLE IF EXISTS `tblworkflowtransitionusers`;

CREATE TABLE `tblworkflowtransitionusers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `transition` int(11) DEFAULT NULL,
  `userid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tblWorkflowTransitionUsers_transition` (`transition`),
  KEY `tblWorkflowTransitionUsers_userid` (`userid`),
  CONSTRAINT `tblWorkflowTransitionUsers_transition` FOREIGN KEY (`transition`) REFERENCES `tblworkflowtransitions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tblWorkflowTransitionUsers_userid` FOREIGN KEY (`userid`) REFERENCES `tblusers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tblworkflowtransitionusers` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
