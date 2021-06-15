package com.bunny.chat.controller;


import java.net.URLEncoder;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bunny.chat.dto.ChatDTO;
import com.bunny.chat.service.ChatService;
import com.bunny.memeber.dto.MemberDTO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value = "/chat")
public class ChatController {

	@Inject
	ChatService chatService;
	
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String getCharInfo(Model model, HttpServletRequest request)
	{
		log.debug("char START");
		HttpSession session = request.getSession();
		MemberDTO loginUser = (MemberDTO) session.getAttribute("login");
		log.info(loginUser.getUserId());
		
		
		log.debug("char END");
		
		return "chat/chat";
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/chatSubmit", method = RequestMethod.POST)
	public int chatSubmit(ChatDTO chatDTO, HttpServletRequest request)
	{
		log.debug("chatSubmit POST START");
		
		int result = 0;
		try {
			result = chatService.submit(chatDTO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		
		log.debug("chatSubmit POST END");
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value = "/chatList", method = RequestMethod.POST)
	public String getChatList(ChatDTO chatDTO, HttpServletRequest request)
	{
		log.debug("chatList POST START");
		
		String result ="";
		try {
			if("ten".equals(chatDTO.getListType()))
				result = chatService.getTen(chatDTO);
			else {
				result = chatService.getId(chatDTO);
			}
			result = URLEncoder.encode(result, "UTF-8");
		} catch (Exception e) {
		}
		
		log.debug("chatList POST END");
		return result;
	}
	
	
	
}
