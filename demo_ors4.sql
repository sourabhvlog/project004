/*
SQLyog Ultimate v9.02 
MySQL - 5.0.24-community-nt : Database - demo_ors4
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`demo_ors4` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `demo_ors4`;

/*Table structure for table `st_college` */

DROP TABLE IF EXISTS `st_college`;

CREATE TABLE `st_college` (
  `ID` BIGINT(20) NOT NULL,
  `NAME` VARCHAR(255) DEFAULT NULL,
  `ADDRESS` VARCHAR(255) DEFAULT NULL,
  `STATE` VARCHAR(255) DEFAULT NULL,
  `CITY` VARCHAR(255) DEFAULT NULL,
  `PHONE_NO` VARCHAR(255) DEFAULT NULL,
  `CREATED_BY` VARCHAR(255) DEFAULT NULL,
  `MODIFIED_BY` VARCHAR(255) DEFAULT NULL,
  `CREATED_DATETIME` DATETIME DEFAULT NULL,
  `MODIFIED_DATETIME` DATETIME DEFAULT NULL,
  PRIMARY KEY  (`ID`),
  KEY `NAME_IDX` (`NAME`)
) ENGINE=INNODB DEFAULT CHARSET=latin1;

/*Data for the table `st_college` */

INSERT  INTO `st_college`(`ID`,`NAME`,`ADDRESS`,`STATE`,`CITY`,`PHONE_NO`,`CREATED_BY`,`MODIFIED_BY`,`CREATED_DATETIME`,`MODIFIED_DATETIME`) VALUES (7,'SIT','Vidisha','MP','Vidisha','7887878787','admin@gmail.com','pratiksolanki64@gmail.com','2017-11-28 13:23:45','2018-08-22 19:25:08'),(8,'IPS','Indore','MP','Indore','7887878787','admin@gmail.com','admin@gmail.com','2017-11-28 13:24:19','2017-11-28 13:24:19'),(9,'TIT','Bhopal','MP','Bhopal','7887878787','admin@gmail.com','admin@gmail.com','2017-11-28 13:24:43','2017-11-28 13:24:43'),(12,'SVCE','umrikheda','MP','Indore','8888888888','admin@gmail.com','admin@gmail.com','2018-07-10 12:11:06','2018-07-10 12:11:06'),(15,'CDGI','Tejaji Nagar','MP','Indore','8989898989','admin@gmail.com','admin@gmail.com','2018-07-19 15:21:02','2018-07-19 15:21:22'),(16,'GSITS','indore','MP','Indore','8989898989','pratiksolanki64@gmail.com','pratiksolanki64@gmail.com','2018-09-01 12:26:51','2018-09-06 12:37:03');

/*Table structure for table `st_course` */

DROP TABLE IF EXISTS `st_course`;

CREATE TABLE `st_course` (
  `ID` BIGINT(20) NOT NULL,
  `NAME` VARCHAR(50) DEFAULT NULL,
  `DESCRIPTION` VARCHAR(200) DEFAULT NULL,
  `DURATION` VARCHAR(50) DEFAULT NULL,
  `CREATED_BY` VARCHAR(50) DEFAULT NULL,
  `MODIFIED_BY` VARCHAR(50) DEFAULT NULL,
  `CREATED_DATETIME` DATETIME DEFAULT NULL,
  `MODIFIED_DATETIME` DATETIME DEFAULT NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=INNODB DEFAULT CHARSET=latin1;

/*Data for the table `st_course` */

INSERT  INTO `st_course`(`ID`,`NAME`,`DESCRIPTION`,`DURATION`,`CREATED_BY`,`MODIFIED_BY`,`CREATED_DATETIME`,`MODIFIED_DATETIME`) VALUES (1,'BE','Bachelor of Engineering','4 years','admin@gmail.com','pratiksolanki64@gmail.com','2017-11-06 22:58:40','2018-08-22 19:26:30'),(4,'BCA','Bachelor of Computer Application','3 years','admin@gmail.com','admin@gmail.com','2017-11-06 23:00:02','2017-11-06 23:00:02'),(5,'B.Sc','Bachelor of Science','3 years','admin@gmail.com','admin@gmail.com','2017-11-06 23:00:38','2017-11-06 23:00:38'),(6,'M.Sc','Master in Science','2 years','pratiksolanki64@gmail.com','pratiksolanki64@gmail.com','2018-09-07 13:20:55','2018-09-07 13:20:55'),(7,'ME','Masters in Engineering','2 years','pratiksolanki64@gmail.com','pratiksolanki64@gmail.com','2018-09-20 13:32:37','2018-09-20 13:34:45');

/*Table structure for table `st_faculty` */

DROP TABLE IF EXISTS `st_faculty`;

CREATE TABLE `st_faculty` (
  `ID` BIGINT(20) NOT NULL,
  `FIRST_NAME` VARCHAR(50) DEFAULT NULL,
  `LAST_NAME` VARCHAR(50) DEFAULT NULL,
  `GENDER` VARCHAR(10) DEFAULT NULL,
  `DOB` DATETIME DEFAULT NULL,
  `QUALIFICATION` VARCHAR(50) DEFAULT NULL,
  `EMAIL_ID` VARCHAR(80) DEFAULT NULL,
  `MOBILE_NO` VARCHAR(30) DEFAULT NULL,
  `COLLEGE_ID` BIGINT(20) DEFAULT NULL,
  `COLLEGE_NAME` VARCHAR(100) DEFAULT NULL,
  `COURSE_ID` BIGINT(20) DEFAULT NULL,
  `COURSE_NAME` VARCHAR(20) DEFAULT NULL,
  `SUBJECT_ID` BIGINT(20) DEFAULT NULL,
  `SUBJECT_NAME` VARCHAR(20) DEFAULT NULL,
  `CREATED_BY` VARCHAR(50) DEFAULT NULL,
  `MODIFIED_BY` VARCHAR(50) DEFAULT NULL,
  `CREATED_DATETIME` DATETIME DEFAULT NULL,
  `MODIFIED_DATETIME` DATETIME DEFAULT NULL,
  PRIMARY KEY  (`ID`),
  KEY `FK_st_faculty` (`COLLEGE_ID`),
  KEY `FK1_st_faculty` (`COURSE_ID`),
  KEY `FK2_st_faculty` (`SUBJECT_ID`),
  CONSTRAINT `FK1_st_faculty` FOREIGN KEY (`COURSE_ID`) REFERENCES `st_course` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK2_st_faculty` FOREIGN KEY (`SUBJECT_ID`) REFERENCES `st_subject` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_st_faculty` FOREIGN KEY (`COLLEGE_ID`) REFERENCES `st_college` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=INNODB DEFAULT CHARSET=latin1;

/*Data for the table `st_faculty` */

INSERT  INTO `st_faculty`(`ID`,`FIRST_NAME`,`LAST_NAME`,`GENDER`,`DOB`,`QUALIFICATION`,`EMAIL_ID`,`MOBILE_NO`,`COLLEGE_ID`,`COLLEGE_NAME`,`COURSE_ID`,`COURSE_NAME`,`SUBJECT_ID`,`SUBJECT_NAME`,`CREATED_BY`,`MODIFIED_BY`,`CREATED_DATETIME`,`MODIFIED_DATETIME`) VALUES (1,'Sachin','Tendulkar','Male','1970-01-24 00:00:00','ME','sachin@abc.com','8989898989',15,'CDGI',1,'BE',20,'ADA','pratiksolanki64@gmail.com','pratiksolanki64@gmail.com','2018-09-06 10:49:38','2018-09-06 10:49:57'),(2,'Virat','Kohli','Male','1974-01-17 00:00:00','MCA','virat@kohli.com','7878787878',16,'GSITS',4,'BCA',19,'DS','pratiksolanki64@gmail.com','pratiksolanki64@gmail.com','2018-09-06 10:53:06','2018-09-20 13:29:09'),(4,'Mahendra Singh','Dhoni','Male','1948-01-16 00:00:00','ME','mahendra@dhoni.com','8989898989',16,'GSITS',1,'BE',11,'CD','pratiksolanki64@gmail.com','pratiksolanki64@gmail.com','2018-09-07 13:37:20','2018-09-07 13:37:20');

/*Table structure for table `st_marksheet` */

DROP TABLE IF EXISTS `st_marksheet`;

CREATE TABLE `st_marksheet` (
  `ID` BIGINT(20) NOT NULL,
  `ROLL_NO` VARCHAR(255) DEFAULT NULL,
  `STUDENT_ID` BIGINT(20) DEFAULT NULL,
  `NAME` VARCHAR(50) DEFAULT NULL,
  `PHYSICS` INT(11) DEFAULT NULL,
  `CHEMISTRY` INT(11) DEFAULT NULL,
  `MATHS` INT(11) DEFAULT NULL,
  `CREATED_BY` VARCHAR(255) DEFAULT NULL,
  `MODIFIED_BY` VARCHAR(255) DEFAULT NULL,
  `CREATED_DATETIME` DATETIME DEFAULT NULL,
  `MODIFIED_DATETIME` DATETIME DEFAULT NULL,
  PRIMARY KEY  (`ID`),
  KEY `fk_STUDENT_ID_idx` (`STUDENT_ID`),
  CONSTRAINT `FK_st_marksheet` FOREIGN KEY (`STUDENT_ID`) REFERENCES `st_student` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=INNODB DEFAULT CHARSET=latin1;

/*Data for the table `st_marksheet` */

INSERT  INTO `st_marksheet`(`ID`,`ROLL_NO`,`STUDENT_ID`,`NAME`,`PHYSICS`,`CHEMISTRY`,`MATHS`,`CREATED_BY`,`MODIFIED_BY`,`CREATED_DATETIME`,`MODIFIED_DATETIME`) VALUES (1,'0822cs121001',7,'Hardik Pandya',78,23,68,'pratiksolanki64@gmail.com','pratiksolanki64@gmail.com','2018-10-05 23:49:49','2018-10-05 23:49:49'),(2,'0822cs121002',2,'Mahendra Singh Dhoni',89,78,69,'pratiksolanki64@gmail.com','pratiksolanki64@gmail.com','2018-10-08 12:16:48','2018-10-08 12:16:48'),(3,'0822cs121003',1,'Pratik Solanki',45,56,64,'pratiksolanki64@gmail.com','pratiksolanki64@gmail.com','2018-10-08 12:17:07','2018-10-08 12:17:07'),(4,'0822cs121004',5,'Suresh Raina',50,35,12,'pratiksolanki64@gmail.com','pratiksolanki64@gmail.com','2018-10-08 12:17:47','2018-10-08 12:31:57'),(5,'0822cs121005',6,'Virat Kohli',23,32,30,'pratiksolanki64@gmail.com','pratiksolanki64@gmail.com','2018-10-08 12:18:14','2018-10-08 12:18:19'),(6,'0822cs12322',1,'Pratik Solanki',78,78,78,'pratiksolanki64@gmail.com','pratiksolanki64@gmail.com','2018-10-12 13:23:17','2018-10-12 13:23:35');

/*Table structure for table `st_role` */

DROP TABLE IF EXISTS `st_role`;

CREATE TABLE `st_role` (
  `ID` BIGINT(20) NOT NULL,
  `NAME` VARCHAR(255) DEFAULT NULL,
  `DESCRIPTION` VARCHAR(255) DEFAULT NULL,
  `CREATED_BY` VARCHAR(255) DEFAULT NULL,
  `MODIFIED_BY` VARCHAR(255) DEFAULT NULL,
  `CREATED_DATETIME` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `MODIFIED_DATETIME` TIMESTAMP NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY  (`ID`),
  KEY `NAME_IDX` (`NAME`)
) ENGINE=INNODB DEFAULT CHARSET=latin1;

/*Data for the table `st_role` */

INSERT  INTO `st_role`(`ID`,`NAME`,`DESCRIPTION`,`CREATED_BY`,`MODIFIED_BY`,`CREATED_DATETIME`,`MODIFIED_DATETIME`) VALUES (1,'Admin','Administrator Role','Admin','admin@gmail.com','2014-07-19 17:13:36','2017-10-13 18:27:08'),(2,'Student','Student Role','admin@gmail.com','admin@gmail.com','2017-11-06 17:14:33','2017-11-25 14:32:23'),(3,'Faculty','Faculty Role','admin@gmail.com','admin@gmail.com','2017-11-28 13:00:07','2017-11-28 13:00:07'),(4,'KIOSK','Kiosk','pratiksolanki64@gmail.com','pratiksolanki64@gmail.com','2018-09-05 13:28:29','2018-10-03 12:15:57'),(5,'College','Colleg','pratiksolanki64@gmail.com','pratiksolanki64@gmail.com','2018-09-28 15:18:08','2018-10-06 19:51:44');

/*Table structure for table `st_student` */

DROP TABLE IF EXISTS `st_student`;

CREATE TABLE `st_student` (
  `ID` BIGINT(20) NOT NULL,
  `COLLEGE_ID` BIGINT(20) DEFAULT NULL,
  `COLLEGE_NAME` VARCHAR(255) DEFAULT NULL,
  `FIRST_NAME` VARCHAR(255) DEFAULT NULL,
  `LAST_NAME` VARCHAR(255) DEFAULT NULL,
  `DATE_OF_BIRTH` DATE DEFAULT NULL,
  `MOBILE_NO` VARCHAR(255) DEFAULT NULL,
  `EMAIL` VARCHAR(255) DEFAULT NULL,
  `CREATED_BY` VARCHAR(255) DEFAULT NULL,
  `MODIFIED_BY` VARCHAR(255) DEFAULT NULL,
  `CREATED_DATETIME` DATETIME DEFAULT NULL,
  `MODIFIED_DATETIME` DATETIME DEFAULT NULL,
  PRIMARY KEY  (`ID`),
  KEY `MOBILE_NO_IDX` (`MOBILE_NO`),
  KEY `fk_COLLEGE_ID_idx` (`COLLEGE_ID`),
  KEY `FIRST_LAST_NAME_IDX` (`FIRST_NAME`,`LAST_NAME`),
  CONSTRAINT `fk_COLLEGE_ID` FOREIGN KEY (`COLLEGE_ID`) REFERENCES `st_college` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=INNODB DEFAULT CHARSET=latin1;

/*Data for the table `st_student` */

INSERT  INTO `st_student`(`ID`,`COLLEGE_ID`,`COLLEGE_NAME`,`FIRST_NAME`,`LAST_NAME`,`DATE_OF_BIRTH`,`MOBILE_NO`,`EMAIL`,`CREATED_BY`,`MODIFIED_BY`,`CREATED_DATETIME`,`MODIFIED_DATETIME`) VALUES (1,12,'SVCE','Pratik','Solanki','1994-07-15','8889597302','pratiksolanki64@gmail.com','admin@gmail.com','pratiksolanki64@gmail.com','2018-07-22 16:43:53','2018-08-22 19:25:51'),(2,15,'CDGI','Mahendra Singh','Dhoni','1991-03-12','7896541236','mahendra@gmail.com','abc@gmail.com','pratiksolanki64@gmail.com','2018-07-22 16:45:24','2018-09-06 12:35:11'),(5,8,'IPS','Suresh','Raina','1982-01-21','9696969696','suresh@raina.com','pratiksolanki64@gmail.com','pratiksolanki64@gmail.com','2018-09-01 12:27:41','2018-09-01 12:27:41'),(6,8,'IPS','Virat','Kohli','1985-01-17','8989898989','virat@gmail.com','pratiksolanki64@gmail.com','pratiksolanki64@gmail.com','2018-09-05 12:11:12','2018-09-05 12:11:12'),(7,12,'SVCE','Hardik','Pandya','1990-01-25','8989898989','hardik@pandya.com','pratiksolanki64@gmail.com','pratiksolanki64@gmail.com','2018-09-06 12:10:06','2018-09-06 12:10:06');

/*Table structure for table `st_subject` */

DROP TABLE IF EXISTS `st_subject`;

CREATE TABLE `st_subject` (
  `ID` BIGINT(20) NOT NULL,
  `NAME` VARCHAR(255) DEFAULT NULL,
  `DESCRIPTION` VARCHAR(255) DEFAULT NULL,
  `COURSE_ID` BIGINT(20) DEFAULT NULL,
  `COURSE_NAME` VARCHAR(50) DEFAULT NULL,
  `CREATED_BY` VARCHAR(255) DEFAULT NULL,
  `MODIFIED_BY` VARCHAR(255) DEFAULT NULL,
  `CREATED_DATETIME` DATETIME DEFAULT NULL,
  `MODIFIED_DATETIME` DATETIME DEFAULT NULL,
  PRIMARY KEY  (`ID`),
  KEY `FK_subject` (`COURSE_ID`),
  CONSTRAINT `FK_subject` FOREIGN KEY (`COURSE_ID`) REFERENCES `st_course` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=INNODB DEFAULT CHARSET=latin1;

/*Data for the table `st_subject` */

INSERT  INTO `st_subject`(`ID`,`NAME`,`DESCRIPTION`,`COURSE_ID`,`COURSE_NAME`,`CREATED_BY`,`MODIFIED_BY`,`CREATED_DATETIME`,`MODIFIED_DATETIME`) VALUES (11,'CD','Compiler Design',1,'BE','admin@gmail.com','admin@gmail.com','2017-11-28 13:19:39','2017-11-28 13:19:39'),(16,'WN','Wireless Network',1,'BE','admin@gmail.com','admin@gmail.com','2018-07-17 13:54:27','2018-07-17 13:54:27'),(17,'DBMS','DataBase Management system',1,'BE','admin@gmail.com','admin@gmail.com','2018-07-17 14:36:10','2018-07-17 14:36:10'),(18,'WS','Web Security',1,'BE','admin@gmail.com','admin@gmail.com','2018-07-18 14:45:52','2018-07-18 14:45:52'),(19,'DS','Data Structure',1,'BE','admin@gmail.com','admin@gmail.com','2018-07-21 22:34:31','2018-07-21 22:34:31'),(20,'ADA','Analysis And Design Of Algorithms',1,'BE','admin@gmail.com','admin@gmail.com','2018-07-21 22:35:31','2018-07-21 22:35:31'),(21,'TOC','Theory of Computation',1,'BE','admin@gmail.com','admin@gmail.com','2018-07-22 16:29:29','2018-07-22 16:29:29'),(24,'English','English',5,'B.Sc','pratiksolanki64@gmail.com','pratiksolanki64@gmail.com','2018-09-20 13:37:30','2018-09-20 13:37:48'),(25,'HIndi','Hindi',5,'B.Sc','pratiksolanki64@gmail.com','pratiksolanki64@gmail.com','2018-09-20 13:37:57','2018-09-20 13:37:57'),(26,'Chemistry','Chemistry',5,'B.Sc','pratiksolanki64@gmail.com','pratiksolanki64@gmail.com','2018-09-25 12:17:39','2018-09-25 12:17:39'),(27,'Mathematics','Mathematics',5,'B.Sc','pratiksolanki64@gmail.com','pratiksolanki64@gmail.com','2018-09-25 12:18:19','2018-09-25 12:18:19');

/*Table structure for table `st_timetable` */

DROP TABLE IF EXISTS `st_timetable`;

CREATE TABLE `st_timetable` (
  `ID` BIGINT(20) NOT NULL,
  `SUBJECT_ID` BIGINT(20) DEFAULT NULL,
  `SUBJECT_NAME` VARCHAR(30) DEFAULT NULL,
  `COURSE_ID` BIGINT(20) DEFAULT NULL,
  `COURSE_NAME` VARCHAR(30) DEFAULT NULL,
  `SEMESTER` VARCHAR(10) DEFAULT NULL,
  `EXAM_DATE` DATE NOT NULL DEFAULT '0000-00-00',
  `EXAM_TIME` VARCHAR(50) DEFAULT NULL,
  `CREATED_BY` VARCHAR(50) DEFAULT NULL,
  `MODIFIED_BY` VARCHAR(50) DEFAULT NULL,
  `CREATED_DATETIME` TIMESTAMP NULL DEFAULT '0000-00-00 00:00:00',
  `MODIFIED_DATETIME` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY  (`ID`,`EXAM_DATE`),
  KEY `FK_timetable` (`SUBJECT_ID`),
  KEY `FK_timetable1` (`COURSE_ID`),
  CONSTRAINT `FK_timetable` FOREIGN KEY (`SUBJECT_ID`) REFERENCES `st_subject` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_timetable1` FOREIGN KEY (`COURSE_ID`) REFERENCES `st_course` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=INNODB DEFAULT CHARSET=latin1;

/*Data for the table `st_timetable` */

INSERT  INTO `st_timetable`(`ID`,`SUBJECT_ID`,`SUBJECT_NAME`,`COURSE_ID`,`COURSE_NAME`,`SEMESTER`,`EXAM_DATE`,`EXAM_TIME`,`CREATED_BY`,`MODIFIED_BY`,`CREATED_DATETIME`,`MODIFIED_DATETIME`) VALUES (1,20,'ADA',1,'BE','II','2018-11-01','10:00 am to 01:00pm','pratiksolanki64@gmail.com','pratiksolanki64@gmail.com','2018-09-25 12:15:29','2018-09-25 12:15:29'),(2,11,'CD',1,'BE','VI','2018-11-02','10:00 am to 01:00pm','pratiksolanki64@gmail.com','pratiksolanki64@gmail.com','2018-09-25 12:16:04','2018-09-25 12:16:04'),(3,21,'TOC',1,'BE','V','2018-11-01','10:00 am to 01:00pm','pratiksolanki64@gmail.com','pratiksolanki64@gmail.com','2018-09-25 12:16:28','2018-09-25 12:16:28'),(4,16,'WN',1,'BE','III','2018-11-03','10:00 am to 01:00pm','pratiksolanki64@gmail.com','pratiksolanki64@gmail.com','2018-09-25 12:17:16','2018-09-25 12:17:16'),(5,26,'Chemistry',5,'B.Sc','II','2018-11-12','08:00 am to 11:00am','pratiksolanki64@gmail.com','pratiksolanki64@gmail.com','2018-09-25 12:17:58','2018-09-25 12:17:58'),(6,27,'Mathematics',5,'B.Sc','III','2018-11-13','08:00 am to 11:00am','pratiksolanki64@gmail.com','pratiksolanki64@gmail.com','2018-09-25 12:18:38','2018-09-25 12:18:38'),(7,17,'DBMS',4,'BCA','V','2018-11-01','01:00 pm to 04:00pm','pratiksolanki64@gmail.com','pratiksolanki64@gmail.com','2018-09-25 12:19:21','2018-09-25 12:19:21'),(8,26,'Chemistry',6,'M.Sc','II','2018-11-12','08:00 am to 11:00am','pratiksolanki64@gmail.com','pratiksolanki64@gmail.com','2018-09-25 12:19:42','2018-09-25 12:19:42'),(9,27,'Mathematics',1,'BE','I','2018-10-18','10:00 am to 01:00pm','pratiksolanki64@gmail.com','pratiksolanki64@gmail.com','2018-10-11 14:39:54','2018-10-11 14:39:54');

/*Table structure for table `st_user` */

DROP TABLE IF EXISTS `st_user`;

CREATE TABLE `st_user` (
  `ID` BIGINT(20) NOT NULL,
  `FIRST_NAME` VARCHAR(255) DEFAULT NULL,
  `LAST_NAME` VARCHAR(255) NOT NULL,
  `LOGIN` VARCHAR(255) DEFAULT NULL,
  `PASSWORD` VARCHAR(255) DEFAULT NULL,
  `DOB` DATETIME DEFAULT NULL,
  `MOBILE_NO` VARCHAR(255) DEFAULT NULL,
  `ROLE_ID` BIGINT(20) DEFAULT NULL,
  `UNSUCCESSFUL_LOGIN` INT(11) DEFAULT NULL,
  `GENDER` VARCHAR(255) DEFAULT NULL,
  `LAST_LOGIN` DATETIME DEFAULT NULL,
  `USER_LOCK` VARCHAR(255) DEFAULT NULL,
  `REGISTERED_IP` VARCHAR(255) DEFAULT NULL,
  `LAST_LOGIN_IP` VARCHAR(255) DEFAULT NULL,
  `CREATED_BY` VARCHAR(255) DEFAULT NULL,
  `MODIFIED_BY` VARCHAR(255) DEFAULT NULL,
  `CREATED_DATETIME` DATETIME DEFAULT NULL,
  `MODIFIED_DATETIME` DATETIME DEFAULT NULL,
  PRIMARY KEY  (`ID`),
  KEY `fk_ROLE_ID_idx` (`ROLE_ID`),
  KEY `MOBILE_NO_IDX` (`MOBILE_NO`),
  KEY `FIRST_LAST_NAME_IDX` (`FIRST_NAME`,`LAST_NAME`),
  CONSTRAINT `fk_ROLE_ID` FOREIGN KEY (`ROLE_ID`) REFERENCES `st_role` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=INNODB DEFAULT CHARSET=latin1;

/*Data for the table `st_user` */

INSERT  INTO `st_user`(`ID`,`FIRST_NAME`,`LAST_NAME`,`LOGIN`,`PASSWORD`,`DOB`,`MOBILE_NO`,`ROLE_ID`,`UNSUCCESSFUL_LOGIN`,`GENDER`,`LAST_LOGIN`,`USER_LOCK`,`REGISTERED_IP`,`LAST_LOGIN_IP`,`CREATED_BY`,`MODIFIED_BY`,`CREATED_DATETIME`,`MODIFIED_DATETIME`) VALUES (1,'Rahul','Sahu','rahul.sahu@nenosystems.com','rr','2014-07-18 00:00:00','8120871155',1,0,'Male','2014-09-29 19:30:52','Inactive','0:0:0:0:0:0:0:1','192.168.1.17','Rahul Sahu','Rahul Sahu','2014-07-19 17:39:20','2014-07-19 18:29:23'),(36,'Sunil','Barfa','admin@gmail.com','Pass000','1991-09-26 00:00:00','8889597302',1,0,'Male','2014-09-29 19:34:18','Inactive','192.168.1.17','192.168.1.17','rahul.sahu@nenosystems.com','rahul.sahu@nenosystems.com','2014-09-29 19:14:10',NULL),(51,'Neeta','Singh','neeta@sachin.com','Pass000','1997-11-11 00:00:00','7878787878',1,0,'Female',NULL,'Inactive',NULL,NULL,'admin@gmail.com','admin@gmail.com','2017-11-09 19:24:07','2017-11-09 19:25:50'),(55,'Neha','Sharma','rhit@gmail.com','Pass000','1992-02-12 00:00:00','9785455585',3,0,'Female',NULL,'Inactive',NULL,NULL,'admin@gmail.com','admin@gmail.com','2017-12-02 21:00:26','2017-12-02 21:24:58'),(57,'Khushboo','Sharma','khushboo@gmail.com','Pass000','1999-05-12 00:00:00','8544411112',1,0,'Female',NULL,'Inactive',NULL,NULL,'admin@gmail.com','admin@gmail.com','2017-12-02 21:20:42','2017-12-02 21:20:57'),(58,'Rahul','Dravid','dravid@gmail.com','Pass000','1999-02-04 00:00:00','9658554555',1,0,'Male',NULL,'Inactive',NULL,NULL,'admin@gmail.com','pratiksolanki64@gmail.com','2017-12-02 21:22:04','2018-08-02 16:04:52'),(62,'Narendra','Modi','nm1212o@gmail.com','Pass000','2000-03-12 00:00:00','9856565858',2,0,'Male',NULL,'Inactive',NULL,NULL,'root','root','2017-12-09 13:59:04','2017-12-09 13:59:04'),(63,'Amit','Shah','sssssamits@gmail.com','Pass000','1999-05-12 00:00:00','9826541414',2,0,'Male',NULL,'Inactive',NULL,NULL,'root','pratiksolanki64@gmail.com','2017-12-11 12:41:47','2018-09-06 13:18:16'),(68,'Pratik','Solanki','pratiksolanki64@gmail.com','Pass000','1994-07-15 00:00:00','8889597302',1,0,'Male',NULL,'Inactive',NULL,NULL,'root','pratiksolanki64@gmail.com','2018-05-23 18:39:05','2018-08-02 16:04:18'),(69,'asdfghjkl','asdfghjkl','sdfg@asdfghj.com','Pass000','1982-01-14 00:00:00','8989898989',2,0,'Male',NULL,'Inactive',NULL,NULL,'root','pratiksolanki64@gmail.com','2018-09-07 14:07:50','2018-09-10 18:04:45'),(70,'poiu','qwer','poiu@qwer.com','Pass000','1982-01-15 00:00:00','8889597302',2,0,'Male',NULL,'Inactive',NULL,NULL,'root','root','2018-09-13 14:17:21','2018-09-13 14:17:21'),(71,'asdfghj','poiuytre','sdfghj@uygh.com','PAss000','1982-01-22 00:00:00','8889597302',2,0,'Male',NULL,'Inactive',NULL,NULL,'root','root','2018-09-19 17:33:01','2018-09-19 17:33:50'),(72,'pratik','solanki','solanki@pratik.com','Pass000','1994-07-15 00:00:00','8889597302',2,0,'Male',NULL,'Inactive',NULL,NULL,'root','root','2018-09-21 10:54:31','2018-09-21 10:54:47'),(73,'jgjg','yjvhvnb','fg@gmail.com','Pass000','1982-01-14 00:00:00','8889597302',2,0,'Male',NULL,'Inactive',NULL,NULL,'root','root','2018-09-25 15:33:24','2018-09-25 15:34:23'),(74,'jgjg','yjvhvnb','poiuabcd@qwer.com','Pass000','1982-01-14 00:00:00','8889597302',2,0,'Male',NULL,'Inactive',NULL,NULL,'root','root','2018-09-25 15:33:24','2018-09-25 15:34:54'),(75,'Apoorva','Goyal','apoorva.rathore9@gmail.com','Pass000','1982-01-16 00:00:00','8989898989',1,0,'Female',NULL,'Inactive',NULL,NULL,'pratiksolanki64@gmail.com','pratiksolanki64@gmail.com','2018-09-28 16:55:29','2018-09-28 16:55:29');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
