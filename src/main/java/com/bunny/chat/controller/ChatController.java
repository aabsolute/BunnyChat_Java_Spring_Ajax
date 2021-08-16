package com.bunny.chat.controller;


import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bunny.chat.dto.ChatDTO;
import com.bunny.chat.service.ChatService;
import com.bunny.common.MessageUtils;
import com.bunny.memeber.dto.MemberDTO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value = "/chat")
public class ChatController {

	@Inject
	ChatService chatService;
	
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String getCharInfo(Model model,@ModelAttribute("toId") String friendId, HttpServletRequest request)
	{
		log.debug("char START");
		HttpSession session = request.getSession();
		MemberDTO loginUser = (MemberDTO) session.getAttribute("login");
		log.info(loginUser.getUserId());
		if(StringUtils.isEmpty(friendId))
		{
			session.setAttribute("messageType", "errorMessage");
			session.setAttribute("messageContent", MessageUtils.getMessage("label.chat.notouch.friend"));
		}else {
			model.addAttribute("toId", friendId);
		}
		log.debug("char END");
		
		return "chat/chat";
	}
	
	@RequestMapping(value = "/findFriend", method = RequestMethod.GET)
	public String searchFriend(Model model)
	{
		log.debug("searchFriend START");
		
		log.debug("searchFriend END");
			
		return "chat/findFriend";
	}
	
	@RequestMapping(value = "/chatWithFindFriend", method = RequestMethod.GET)
	public String chatWithFriend(Model model)
	{
		log.debug("chatWithFriend START");
		
		log.debug("chatWithFriend END");
		
		return "chat/chat";
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/chatSubmit", method = RequestMethod.POST)
	public int chatSubmit(@ModelAttribute ChatDTO chatDTO, HttpServletRequest request)
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
	public String getChatList(@ModelAttribute ChatDTO chatDTO, HttpServletRequest request)
	{
		log.debug("chatList POST START");  
		//  C:\workspace7\.metadata\.plugins\org.eclipse.wst.server.core\tmp1\wtpwebapps\BunnyChat\resources\\upload
		String savePath = request.getSession().getServletContext().getRealPath("\\resources\\upload") + "/";
		String result ="";
		try {
			if("ten".equals(chatDTO.getListType()))
				result = chatService.getTen(chatDTO,savePath);
			else {
				result = chatService.getId(chatDTO,savePath);
			}
			result = URLEncoder.encode(result, "UTF-8");
			if(!"".equals(result)) {
				chatService.setReadFlag(chatDTO);
			}
		} catch (Exception e) {
		}
		
		log.debug("chatList POST END");
		return result;
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/getUnread", method = RequestMethod.POST)
	public int getUnreadMessage(@ModelAttribute("userId") String userId)
	{
		log.debug("getUnreadMessage POST START");
		
		int result = 0;
		try {
			result = chatService.getUnReadMessage(userId);
		} catch (Exception e) {
		}
		
		log.debug("getUnreadMessage POST END");
		return result;
	}
	
	
	@RequestMapping(value = "/messageBox", method = RequestMethod.POST)
	public void getMessageBox(@ModelAttribute("userId") String userId, Model model)
	{
		log.debug("messageBox POST START");
		
		List<ChatDTO> messageBoxList = new ArrayList<ChatDTO>();
		try {
			messageBoxList = chatService.getMessageBox(userId);
		} catch (Exception e) {
		}
		
		model.addAttribute("messageBoxList", messageBoxList);
		log.debug("messageBox POST END");
	}
	
	@ResponseBody
	@RequestMapping(value = "/messageBoxAjax", method = RequestMethod.POST)
	public String getMessageBoxAjax(@ModelAttribute("userId") String userId)
	{
		log.debug("messageBoxAjax POST START");
		String result = "";
		try {
			result = chatService.getMessageBox(userId, true);
			result = URLEncoder.encode(result, "UTF-8");
		} catch (Exception e) {
		}
		
		log.debug("messageBoxAjax POST END");
		
		return result;
	}
	
	
}
