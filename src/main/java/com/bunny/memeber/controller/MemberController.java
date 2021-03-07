package com.bunny.memeber.controller;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bunny.main.controller.MainController;
import com.bunny.memeber.dto.MemberDTO;
import com.bunny.memeber.service.MemberService;

@Controller
@RequestMapping(value = "/member")
public class MemberController {

	private static final Logger log = LoggerFactory.getLogger(MainController.class);

	@Inject
	MemberService memberService;
	
	// 1. LogInPage
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String memberLogIn(Model model) {
		log.debug("memberLogIn START");

		log.debug("memberLogIn END");
		return "member/log-in";
	}

	// 2. registPage
	@RequestMapping(value = "/regist", method = RequestMethod.GET)
	public String memberRegistGet(Model model) {
		log.debug("MEMBER_REGIST_GET START");

		log.debug("MEMBER_REGIST_GET END");
		return "member/join";
	}

	// 3. member regist
	@RequestMapping(value = "/regist", method = RequestMethod.POST)
	public String memberRegistPost(@ModelAttribute MemberDTO memberDTO) throws Exception 
	{
		log.debug("MEMBER_REGIST_POST START");

		int result = memberService.memberRegist(memberDTO);
		if(result < 0) return "member/regist";
		
		
		log.debug("MEMBER_REGIST_POST END");
		return "redirect:/";
	}
}
