package com.bunny.chat.service;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.bunny.chat.dao.ChatDAO;
import com.bunny.chat.dto.ChatDTO;
import com.google.gson.Gson;

@Service
public class ChatService {

	@Inject
	ChatDAO chatDAO;
	
	public List<ChatDTO> getChatInfo(ChatDTO chatDTO) throws Exception
	{
		List<ChatDTO> charList = new ArrayList<ChatDTO>();
		charList = chatDAO.getChatInfo(chatDTO);
		if(charList == null || charList.size() == 0)
			return new ArrayList<ChatDTO>();
		return charList;
	}
	
	public List<ChatDTO> getChatRecentInfo(ChatDTO chatDTO, int number) throws Exception
	{
		List<ChatDTO> charList = new ArrayList<ChatDTO>();
		charList = chatDAO.getChatRecentInfo(chatDTO);
		if(charList == null || charList.size() == 0)
			return new ArrayList<ChatDTO>();
		return charList;
	}
	
	public int submit(ChatDTO chatDTO) throws Exception
	{
		String toId = chatDTO.getToUserId();
		String fromId = chatDTO.getFromUserId();
		int result = 0;
		
		if(StringUtils.isEmpty(toId) || StringUtils.isEmpty(fromId))
			return -1;
		else if (toId.equals(fromId))
			return -1;
		else result = chatDAO.submit(chatDTO);
		
		return result;
	}
	
	public String getTen(ChatDTO chatDTO) throws Exception
	{
		List<ChatDTO> charList = new ArrayList<ChatDTO>();
		chatDTO.setNumber(100); 
		charList = chatDAO.getChatRecentInfo(chatDTO);
		
		Gson gson = new Gson();
		String jsonString = gson.toJson(charList);
		
		return jsonString;
	}
	
	public String getId(ChatDTO chatDTO) throws Exception
	{
		List<ChatDTO> charList = new ArrayList<ChatDTO>();
		charList = chatDAO.getChatInfo(chatDTO);
		
		Gson gson = new Gson();
		String jsonString = gson.toJson(charList);
		
		return jsonString;
	}
	
	public int setReadFlag(ChatDTO chatDTO) throws Exception
	{
		return chatDAO.setReadFlag(chatDTO);
	}
	
	public int getUnReadMessage(String userId) throws Exception
	{
		//check my unreadMessage 
		return chatDAO.getUnreadMessage(userId);
	}
	
}
