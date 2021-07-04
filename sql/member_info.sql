SELECT * FROM vivienne.member_info_table;

call alterNameLow();



INSERT INTO MEMBER_INFO_TABLE   ( USER_ID   , USER_EMAIL   , USER_NAME   , USER_PASSWORD   , USER_AGE   , USER_INFOMATION    , USER_regdate   , USER_lastLogin) 
VALUES(      'Ema'   , 'EmaYuina@naver.com'   , '結菜えま'   , '1'    , 22    , 'm'      , DEFAULT    , DEFAULT );



delete FROM vivienne.member_info_table where USER_ID = 'ef'



https://wt-img.com/bbs/board.php?bo_table=review&wr_id=433&page=7



delete from MEMBER_INFO_TABLE where user_Id <> 'GT' or  user_Id <> 'sans'


 SELECT count(user_id) FROM MEMBER_INFO_TABLE where USER_ID = 's'
 
 
 alter table MEMBER_INFO_TABLE set user_id = 
 
 
desc MEMBER_INFO_TABLE


select count(user_infomation) FROM vivienne.member_info_table;

select * from all_ind_columns where table_name='member_info_table';


alter table  vivienne.member_info_table modify user_gender  char(1) default 'm' not null;


update member_info_table set user_gender= 'f' ;


update member_info_table set (user_gender, user_name) = ('m', 'hhhhhhhhhh') where user_id = 'buffalo22' ;