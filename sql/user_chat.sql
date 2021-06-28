SELECT * FROM vivienne.user_chat_table;


update vivienne.user_chat_table set to_user_id = 'Hikari A', chat_content = 'where are you' where chat_id = 1;

SELECT * FROM USER_CHAT_TABLE where (from_user_id = 'hana5' and to_user_id = 'mimi') or (from_user_id = 'mimi' and to_user_id = 'hana5');

SELECT * FROM USER_CHAT_TABLE where (from_user_id = 'IM' and to_user_id = 'aya55') or (from_user_id = 'IM' and to_user_id = 'aya55' and chat_id > 0 ) order by chat_time;

SELECT * FROM USER_CHAT_TABLE where (from_user_id = ? and to_user_id = ?) or (from_user_id = ? and to_user_id = ? and chat_id > ? ) order by chat_time;


SELECT * 
FROM USER_CHAT_TABLE 
where (    (from_user_id = 'IM' and to_user_id = 'aya55') or  (from_user_id = 'aya55' and to_user_id = 'IM')  ) and chat_id > (select MAX(chat_id) - 10 from USER_CHAT_TABLE) order by chat_time;

desc vivienne.user_chat_table;

alter table vivienne.user_chat_table add column chat_read int default 0 after chat_content;

alter table vivienne.user_chat_table change column chat_read chat_read int default 1 ; #name and property 

alter table vivienne.user_chat_table modify column chat_read int default 1 ; # property 

alter table vivienne.user_chat_table drop column chat_read;

select * from vivienne.user_chat_table where to_user_id = 'aya55' and chat_read = 0;

select *  from user_chat_table where chat_id in ( select Max(chat_id)  from USER_CHAT_TABLE  where to_user_id = 'mimi' or from_user_id = 'mimi' group by from_user_id, to_user_id );




 SELECT * FROM USER_CHAT_TABLE where( (from_user_id = 'mimi' and to_user_id = 'im') or (from_user_id = 'im' and to_user_id = 'mimi')) and chat_id > 0 order by chat_time ;


 truncate vivienne.user_chat_table;