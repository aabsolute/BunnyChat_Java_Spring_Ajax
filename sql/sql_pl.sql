DELIMITER $$
create procedure tempProc()
begin
	SELECT * FROM vivienne.member_info_table;
end$$
DELIMITER;
 

 call tempProc();
 SHOW CREATE PROCEDURE tempProc; 
 
 
DELIMITER $$
create procedure alterNameLow()
begin
	/* 종료 구분 변수 */
	DECLARE _done INT DEFAULT FALSE;
    /* user 변수 */
	declare _userId varchar(64);
    /* new user 변수 */
	declare _new_userId varchar(64);
	/* 커서 변수 */
    DECLARE cursor_userId cursor for SELECT user_id FROM vivienne.MEMBER_INFO_TABLE;
    /* 커서 종료조건 : 더이상 없다면 종료 */
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET _done = TRUE;
    
    open cursor_userId;
    REPEAT
		FETCH cursor_userId into _userId;
		if not _done then
			set _new_userId = lower(_userId);
            update vivienne.MEMBER_INFO_TABLE set user_id = _new_userId where user_id = _userId;
        end if;
	UNTIL _done END REPEAT;
    /* 커서를 닫아준다. */
	CLOSE cursor_userId;
end$$
DELIMITER;


drop procedure  IF EXISTS  alterUserChat;


DELIMITER %%
create procedure alterUserChat()
begin
	declare _chatId int;
	declare _fromUser varchar(64);
	declare _touser varchar(64);
    declare _new_FromUser varchar(64);
    declare _new_toUser varchar(64);
	declare _done int default false;
    declare cursor_ids cursor for select from_user_id, to_user_id, chat_id from vivienne.user_chat_table;
    declare continue handler for not found set _done = true;
    
    open cursor_ids;
    repeat
		fetch cursor_ids into _fromUser, _touser, _chatId;
        if not _done then
			set _new_FromUser = lower(_fromUser);
            set _new_toUser = lower(_touser);
            update vivienne.user_chat_table set from_user_id = _new_FromUser where chat_Id = _chatId;
            update vivienne.user_chat_table set to_user_id = _new_toUser where chat_Id = _chatId;
        end if;
    until _done end repeat;
    close cursor_ids;
end %%
DELIMITER;

desc vivienne.user_chat_table;

SELECT * FROM vivienne.user_chat_table;

call alterUserChat();