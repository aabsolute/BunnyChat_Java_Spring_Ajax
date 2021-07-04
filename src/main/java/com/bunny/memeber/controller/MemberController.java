
package com.bunny.memeber.controller;

import java.io.File;
import java.io.IOException;
import java.util.Arrays;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.bunny.common.ImageExtends;
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
		if (loginUser != null && userId.toLowerCase().equals(loginUser.getUserId().toLowerCase())) {
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

	// 7. member management
	@RequestMapping(value = "/management", method = RequestMethod.GET)
	public String memberManagement(Model model, HttpServletRequest request) {
		log.debug("memberManagement GET START");

		HttpSession session = request.getSession();
		MemberDTO member = (MemberDTO) session.getAttribute("login");
		String savePath = request.getSession().getServletContext().getRealPath("/upload/");
		MemberDTO memberView = new MemberDTO();
		try {
			memberView = memberService.getMemberById(member.getUserId());
			if(!StringUtils.isEmpty(memberView.getUserInfomation()))
				memberView.setUserInfomation(savePath + memberView.getUserInfomation());
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		model.addAttribute("member", memberView);
		log.debug("memberManagement GET END");
		return "member/update";
	}

	// 7. member management
	@RequestMapping(value = "/management", method = RequestMethod.POST)
	public String memberManagementUpdate(@ModelAttribute("member") MemberDTO member) {
		log.debug("memberManagement POST START");

		int temp = 0;
		try {
			temp = memberService.setMemberUpdate(member);
		} catch (Exception e) {
			e.printStackTrace();
		}

		if (temp != 1) {
			// error
		}

		log.debug("memberManagement POST END");
		return "redirect:/";
	}

	// 8. member profile management
	@RequestMapping(value = "/profileManagement", method = RequestMethod.GET)
	public String memberProfileManagement(Model model, HttpServletRequest request) {
		log.debug("profileManagement GET START");

		HttpSession session = request.getSession();
		MemberDTO member = (MemberDTO) session.getAttribute("login");

		model.addAttribute("member", member);
		log.debug("profileManagement GET END");
		return "member/profileUpdate";
	}

	@PostMapping("/profileManagement")
	public String memberManagementUpdatePost(MultipartHttpServletRequest request,@SessionAttribute("login") MemberDTO sessionVal) {

		MemberDTO memberForSave = new MemberDTO();
		
		
		String userId = request.getParameter("userId");
		// 업로드 파일이 저장될 경로
		//String contextRoot = new HttpServletRequestWrapper(request).getRealPath("/");
        String savePath = request.getSession().getServletContext().getRealPath("/upload");
        // 파일 이름
        MultipartFile report = request.getFile("userInfomation");
        String fileName = report.getOriginalFilename();
        String fileExtension = fileName.substring(fileName.lastIndexOf(".")+1).toLowerCase();
        
        memberForSave.setUserId(userId);
        memberForSave.setUserInfomation(fileName);
        // 파일 전송
        try {
        	ImageExtends [] ex = ImageExtends.values();
        	if(Arrays.stream(ex).anyMatch(name-> name.word(fileExtension))) {
        		String prev = memberService.getMemberById(userId).getUserInfomation();
				if (!StringUtils.isEmpty(prev)) {
					File prevFile = new File(savePath + "\\" + prev);
					if (prevFile.exists()) {
						prevFile.delete();
					}
				}
        		
        		report.transferTo(new File(savePath + fileName));
        		int result = memberService.setMemberProfileUpdate(memberForSave);
				if (result == 1) {
					log.debug("#############################################success");
				}
        	}
        	
        } catch(Exception e) {
            System.out.println("업로드 오류");
        }
        return "redirect:/";
	}
	
	
	@RequestMapping("/download")
	@ResponseBody
	public byte[] downlod(HttpServletResponse response, HttpServletRequest request) throws IOException{
		
		HttpSession session = request.getSession();
		MemberDTO member = (MemberDTO) session.getAttribute("login");
		MemberDTO memberView = new MemberDTO();
		try {
			memberView = memberService.getMemberById(member.getUserId());
		} catch (Exception e) {
			e.printStackTrace();
		}
		byte[] bytes = null;
		if(!StringUtils.isEmpty(memberView.getUserInfomation()))
		{
			String savePath = request.getSession().getServletContext().getRealPath("/upload");
			File file = new File(savePath, memberView.getUserInfomation());
			
			bytes = FileCopyUtils.copyToByteArray(file);
			
			String fn = new String(file.getName().getBytes(), "utf-8");
			response.setHeader("Content-Disposition", "attachment;filename=\"" + fn + "\"");
			response.setContentLength(bytes.length);
		}
		
		return bytes;
	}
	
	
	// 9. member profile management
	// @PostMapping("/profileManagement")
	// public String memberManagementUpdatePost(MemberDTO memberDTO, HttpServletRequest request) {
	// 	log.debug("memberManagement POST START");

	// 	MemberDTO memberForSave = new MemberDTO();
	// 	memberForSave.setUserId(userId);
	// 	memberForSave.setUserInfomation(userInfo);
	// 	MultipartRequest multi = null;
	// 	int fileMaxSize = 10 * 1024 * 1024;
	// 	String savePath = request.getSession().getServletContext().getRealPath("/upload");
	// 	HttpSession session = request.getSession();
	// 	try {
	// 		multi = new MultipartRequest(request, savePath, fileMaxSize, "UTF-8", new DefaultFileRenamePolicy());
	// 	}catch(Exception e){
	// 		e.printStackTrace();
	// 		session.setAttribute("messageType", "errorMessage");
	// 		session.setAttribute("messageContent", MessageUtils.getMessage("file needs under 10MB"));
	// 	}
	// 	MemberDTO sessionUserId = (MemberDTO) session.getAttribute("login");
	// 	if(!userId.equals(sessionUserId.getUserId()))
	// 	{
	// 		session.setAttribute("messageType", "errorMessage");
	// 		session.setAttribute("messageContent", MessageUtils.getMessage("just change your profile"));
	// 	}


	// 	File file = multi.getFile("userProfile");
	// 	if(file != null) {
	// 		String extendName = file.getName().substring(file.getName().lastIndexOf(".")-1).toLowerCase();

	// 		if(extendName.equals("jpg") || extendName.equals("png") || extendName.equals("gif")) {
	// 			try {
	// 				String prev = memberService.getMemberById(userId).getUserInfomation();
	// 				if(!StringUtils.isEmpty(prev)) {
	// 					File prevFile = new File(savePath + "\\" + prev);
	// 					if(prevFile.exists()) {
	// 						prevFile.delete();
	// 					}
	// 				}

	// 				int result = memberService.setMemberProfileUpdate(memberForSave);
	// 				if(result ==1) {
	// 					session.setAttribute("messageType", "successMessage");
	// 					session.setAttribute("messageContent", MessageUtils.getMessage("label.message.member.profile.update.success"));
	// 				}

	// 			} catch (Exception e) {
	// 				e.printStackTrace();
	// 			}
	// 		}else {
	// 			session.setAttribute("messageType", "errorMessage");
	// 			session.setAttribute("messageContent", MessageUtils.getMessage("jpg png gif only"));
	// 			return "member/profileUpdate";
	// 		}
	// 	}

	// 	log.debug("memberManagement POST END");
	// 	return "redirect:/";
	// }

}
