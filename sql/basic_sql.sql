drop table Member_Info;
SET SQL_SAFE_UPDATES = 0;

create table Member_Info_table (
	user_ID  varchar(64) primary key,
    user_EMAIL varchar(64) ,
	user_Name varchar(64)  not null,
    user_Password varchar(64) not null,
    user_age int,
    user_INFOMATION varchar(64) ,
    user_regdate TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    user_lastLogin TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


create table user_chat_table (
	chat_id int primary key auto_increment,
    from_user_id varchar(64),
    to_user_id varchar(64),
	chat_content varchar(128),
    chat_read int,
    chat_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

create table board_table(
	user_id varchar(64),
    board_id int primary key,
    board_title varchar(64) not null,
    board_content varchar(2048),
    board_date datetime default now(),
    board_hit int,
    board_file varchar(64),
    board_realFile varchar(64),
    board_group int,
    board_sequence int,
    board_level int
);

insert into MEMBER_INFO_TABLE(user_ID,user_EMAIL,user_Name,user_Password,user_age,user_Gender,user_INFOMATION) values('GTmember_infomember_info','naver@naver.com','name','password',19,'m','i am manager');

ALTER TABLE Member_Info_table ADD COLUMN user_Gender char(2) AFTER user_age;

ALTER table Member_Info change user_Gender user_Gender char(1);

insert into Member_Info values ("admin","zxcv1234","aabsolute87@yahoo.co.jp","admin", 0,"M", "i am admin \r\n 나는 관리자 입니다  \r\n 私は管理者です。", CURRENT_DATE);

delete from Member_Info where user_id = "admin";

update Member_Info set user_Password = "0000" where user_id = "admin"; 

update Member_Info set user_country = "KO" where user_id = "admin"; 

alter table member_info drop column user_Profile;


alter table Member_Info_table change user_regdate user_regdate TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

SELECT count(user_ID) FROM MEMBER_INFO_TABLE where user_ID = 'tmep';


select @@global.time_zone, @@session.time_zone;
SET GLOBAL time_zone='Asia/Tokyo';
SET GLOBAL time_zone='Asia/Seoul';

SET time_zone='Asia/Seoul';
