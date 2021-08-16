package com.bunny.mail.controller;

import java.security.SecureRandom;
import java.util.Date;
import java.util.UUID;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value = "/mail")
public class MailingController {

	@Autowired
	private JavaMailSender mailSender;

	@PostMapping("/toAdministration")
	public void sendMailToAdminist(@RequestParam("from") String from, @RequestParam("title") String title,
			@RequestParam("content") String content) {
		log.info("sendmail 들어온다! ");

		String setfrom = ""; // 보내는 사람
		String settitle = title; // 제목
		String setcontent = content; // 내용

		String tomail = ""; // 받을 주소

		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

			messageHelper.setFrom(setfrom); // 보내는사람 (필수)
			messageHelper.setTo(tomail); // 받는사람 이메일
			messageHelper.setSubject(title); // 메일제목은
			messageHelper.setText(content); // 메일 내용

			mailSender.send(message);
		} catch (Exception e) {
			System.out.println(e);
		}
	}

	@GetMapping("/toUser")
	public void sendMailToUserForNewPass() {
		log.info("sendmail 들어온다! ");

		String setfrom = ""; // 보내는 사람
		String settitle = ""; // 제목
		String setcontent = ""; // 내용

		String tomail = ""; // 받을 주소

		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

			messageHelper.setFrom(setfrom); // 보내는사람 (필수)
			messageHelper.setTo(tomail); // 받는사람 이메일
			messageHelper.setSubject(""); // 메일제목은
			messageHelper.setText(""); // 메일 내용

			mailSender.send(message);
		} catch (Exception e) {
			System.out.println(e);
		}
	}

	private String makeNewPassword(int size) {
		char[] charSet = UUID.randomUUID().toString().toCharArray();
		StringBuffer sb = new StringBuffer();
		SecureRandom sr = new SecureRandom();
		sr.setSeed(new Date().getTime());
		int idx = 0;
		int len = charSet.length;

		for (int i = 0; i < size; i++) { // idx = (int) (len * Math.random());
			idx = sr.nextInt(len); // 강력한 난수를 발생시키기 위해 SecureRandom을 사용한다.
			sb.append(charSet[idx]);
		}

		return sb.toString();
	}
}
