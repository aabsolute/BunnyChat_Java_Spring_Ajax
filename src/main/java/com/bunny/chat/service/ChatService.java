package com.bunny.chat.service;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

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
		charList = chatDAO.getChatRecentInfo(chatDTO, number);
		if(charList == null || charList.size() == 0)
			return new ArrayList<ChatDTO>();
		return charList;
	}
	
	public int submit(ChatDTO chatDTO) throws Exception
	{
		int result = chatDAO.submit(chatDTO);
		return result;
	}
	
	public String getTen(ChatDTO chatDTO) throws Exception
	{
		List<ChatDTO> charList = new ArrayList<ChatDTO>();
		charList = chatDAO.getChatRecentInfo(chatDTO, 10);
		
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
	
}
