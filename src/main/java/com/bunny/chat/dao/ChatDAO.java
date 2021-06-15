package com.bunny.chat.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.bunny.chat.dto.ChatDTO;

@Repository
public class ChatDAO {


	@Inject
    private SqlSession sqlSession;
	
	public List<ChatDTO> getChatInfo(ChatDTO chatDTO) throws Exception
	{
		return sqlSession.selectList("chatMapper.chatInfo", chatDTO);
	}
	
	public List<ChatDTO> getChatRecentInfo(ChatDTO chatDTO) throws Exception
	{
		return sqlSession.selectList("chatMapper.chatRecentInfo", chatDTO);
	}
	
	public int submit(ChatDTO chatDTO) throws Exception
	{
		return sqlSession.insert("chatMapper.submit", chatDTO);
	}
}
