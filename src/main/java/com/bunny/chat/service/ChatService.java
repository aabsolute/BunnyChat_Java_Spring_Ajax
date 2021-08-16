package com.bunny.chat.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.bunny.chat.dao.ChatDAO;
import com.bunny.chat.dto.ChatDTO;
import com.bunny.memeber.dao.MemberDAO;
import com.google.gson.Gson;

@Service
public class ChatService {

	@Autowired
	ChatDAO chatDAO;
	@Autowired
	MemberDAO memberDAO;	
	
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
	
	public String getTen(ChatDTO chatDTO, String savePath) throws Exception
	{
		List<ChatDTO> chatList = new ArrayList<ChatDTO>();
		chatDTO.setNumber(100); 
		
		String myProfile = memberDAO.getMemberProfileInfo(chatDTO.getFromUserId());
		String yourProfile = memberDAO.getMemberProfileInfo(chatDTO.getToUserId());
		chatList = chatDAO.getChatRecentInfo(chatDTO);
		setProfile(chatList, savePath, myProfile, yourProfile);
		Gson gson = new Gson();
		String jsonString = gson.toJson(chatList);
		
		return jsonString;
	}
	
	public String getId(ChatDTO chatDTO, String savePath) throws Exception
	{
		List<ChatDTO> chatList = new ArrayList<ChatDTO>();
		chatList = chatDAO.getChatInfo(chatDTO);
		
		String myProfile = memberDAO.getMemberProfileInfo(chatDTO.getFromUserId());
		String yourProfile = memberDAO.getMemberProfileInfo(chatDTO.getToUserId());
		setProfile(chatList, savePath, myProfile, yourProfile);
		Gson gson = new Gson();
		String jsonString = gson.toJson(chatList);
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
	
	public List<ChatDTO> getMessageBox(String userId) throws Exception
	{
		//my all list
		List<ChatDTO> chatList = new ArrayList<ChatDTO>();
		chatList = chatDAO.getMessageBox(userId);
		deleteDuplication(chatList);
		return chatList;
	}
	
	public String getMessageBox(String userId, boolean jsonflg) throws Exception
	{
		//my all list
		List<ChatDTO> chatList = new ArrayList<ChatDTO>();
		chatList = chatDAO.getMessageBox(userId);
		
		
		deleteDuplication(chatList);
		
		Gson gson = new Gson();
		String jsonString = gson.toJson(chatList);
		
		return jsonString;
	}
	
	private void deleteDuplication(List<ChatDTO> result)
	{
		for(int i = 0; i < result.size(); i++)
		{
			ChatDTO chati = result.get(i);
			DELETE_FLAG:
			for(int j = 0; j < result.size(); j++)
			{
				ChatDTO chatj = result.get(j);
				if(chati.getFromUserId().equals(chatj.getToUserId()) 
						&& chati.getToUserId().equals(chatj.getFromUserId())){
					if(chati.getChatId() < chatj.getChatId()){
						result.remove(chati);
						i--;
						break DELETE_FLAG;
					}else {
						result.remove(chatj);
						j--;
						break DELETE_FLAG;
					}
				}
			}
		}
	}
	
	private void setProfile(List<ChatDTO> chatList, String savePath, String myProfile, String yourProfile) {
		
		for(ChatDTO chat : chatList)
		{
			if(StringUtils.isEmpty(myProfile))
			{
				chat.setMyProfile("/resources/images/rabbit.png");
			}else {
				chat.setMyProfile(savePath + myProfile);
			}
			
			if(StringUtils.isEmpty(yourProfile))
			{
				chat.setYourProfile("/resources/images/man.png");
			}else {
				chat.setYourProfile(savePath + yourProfile);
			}
		}
		
	}
	
}
