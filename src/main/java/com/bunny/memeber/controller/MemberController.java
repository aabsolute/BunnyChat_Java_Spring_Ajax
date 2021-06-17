package com.bunny.memeber.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bunny.common.MessageUtils;
import com.bunny.memeber.dto.MemberDTO;
import com.bunny.memeber.service.MemberService;

import lombok.extern.slf4j.Slf4j;

//@Controller
@Slf4j
@Controller
@RequestMapping(value = "/member")
public class MemberController {

	@Inject
	MemberService memberService;

	// @Autowired
	// BCryptPasswordEncoder passEncoder;
	// String pass = passEncoder.encode(inputPass);

	// use cookie
//	   @RequestMapping(value="/login", method=RequestMethod.GET)
//	    public ModelAndView loginForm(LoginCommand loginCommand,
//	                    @CookieValue(value="REMEMBER", required=false) Cookie rememberCookie) throws Exception {
//	        if(rememberCookie!=null) {
//	            loginCommand.setId(rememberCookie.getValue());
//	            loginCommand.setRememberId(true);
//	        }
//	        ModelAndView mv = new ModelAndView("user/login/loginForm");
//	        return mv;
//	    }

	// 1. LogInPage
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String memberLogIn(Model model) {
		log.debug("memberLogIn START");

		log.debug("memberLogIn END");
		return "member/log-in";
	}

	// 2. member logIn
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String memberLogInPost(@ModelAttribute("memberDTO") MemberDTO memberDTO, HttpServletRequest request) {
		log.debug("MEMBER_REGIST_POST START");
		HttpSession session = request.getSession();

		MemberDTO loginUser = null;
		try {
			loginUser = memberService.memberLogIn(memberDTO);
		} catch (Exception e) {
			e.printStackTrace();
		}

		if (loginUser != null) {
			session.setAttribute("login", loginUser);
			session.setAttribute("messageType", "successMessage");
			session.setAttribute("messageContent", MessageUtils.getMessage("label.member.login.message.success"));
		} else {
			session.setAttribute("messageType", "errorMessage");
			session.setAttribute("messageContent", MessageUtils.getMessage("label.member.login.message.fail"));
			return "member/log-in";
		}

		log.debug("MEMBER_REGIST_POST END");
		return "redirect:/";
	}

	// 3. registPage
	@RequestMapping(value = "/regist", method = RequestMethod.GET)
	public String memberRegistGet(Model model, HttpServletRequest request) {
		log.debug("MEMBER_REGIST_GET START");

		model.addAttribute("memberDTO", new MemberDTO());

		log.debug("MEMBER_REGIST_GET END");
		return "member/regist";
	}

	// 4. member regist
	@RequestMapping(value = "/regist", method = RequestMethod.POST)
	public String memberRegistPost(@ModelAttribute("memberDTO") MemberDTO memberDTO, HttpServletRequest request) {
		log.debug("MEMBER_REGIST_POST START");

		HttpSession session = request.getSession();
		try {
			memberService.memberRegist(memberDTO);
		} catch (Exception e) {
			session.setAttribute("messageType", "errorMessage");
			session.setAttribute("messageContent", MessageUtils.getMessage("label.message.error.useid"));
			return "member/regist";
		}

		session.setAttribute("login", memberDTO);
		session.setAttribute("messageType", "successMessage");
		session.setAttribute("messageContent", MessageUtils.getMessage("label.message.success.regist"));
		log.debug("MEMBER_REGIST_POST END");
		return "redirect:/";
	}

	// 5. member check
	@ResponseBody
	@RequestMapping(value = "/memberCheck", method = RequestMethod.POST)
	public int memberCheckPOST(MemberDTO dto, HttpServletRequest request) throws Exception {
		log.debug("ID_CHECK_POST START");
		String userId = dto.getUserId();
		HttpSession session = request.getSession();
		MemberDTO loginUser = (MemberDTO) session.getAttribute("login");
		if(loginUser != null && userId.toLowerCase().equals(loginUser.getUserId().toLowerCase())) {
			return -1;
		}
		int resultNum = memberService.memberCheck(userId);
		if (resultNum == 0) {
			session.setAttribute("messageType", "successMessage");
			session.setAttribute("messageContent", MessageUtils.getMessage("label.message.success.useid"));
		} else {
			session.setAttribute("messageType", "errorMessage");
			session.setAttribute("messageContent", MessageUtils.getMessage("label.message.error.useid"));
		}
		return resultNum;
	}

	// 6. LogOut
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String memberLogOut(Model model, HttpServletRequest request) {
		log.debug("memberLogOut GET START");

		HttpSession session = request.getSession();
		session.invalidate();
		log.debug("memberLogOut GET END");
		return "redirect:/";
	}
	

}
