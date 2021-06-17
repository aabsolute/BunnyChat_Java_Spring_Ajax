package com.bunny.main.controller;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;

/**
 * Handles requests for the application home page.
 */
@Controller
@Slf4j
public class MainController {
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		log.info("Welcome home! The client locale is {}.", locale);
		
		
		
		return "index";
	}
	
	@RequestMapping(value = "/language_kr", method = RequestMethod.GET)
	public String setKorean(@ModelAttribute("lang") String languaguage, HttpServletRequest request, HttpServletResponse response) {
		
		HttpSession session = request.getSession();
		session.setAttribute("lang", languaguage);
		return "index";
	}
	
	@RequestMapping(value = "/language_jp", method = RequestMethod.GET)
	public String setJapan(@ModelAttribute("lang") String languaguage, HttpServletRequest request, HttpServletResponse response) {
		
		HttpSession session = request.getSession();
		session.setAttribute("lang", languaguage);
		return "index";
	}
	
//   
	
}
