package com.bunny.board.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bunny.board.service.BoardService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value = "/board")
public class BoardController {

	@Autowired
	BoardService boardService;
	
	@GetMapping("/main")
	public String boardMain(Model model)
	{
		log.debug("boardMain GET START");
		
		
		log.debug("boardMain GET END");
		
		return "board/boardview";
	}
	 
	@GetMapping("/write")
	public String writeChat(Model model)
	{
		log.debug("writeChat GET START");
		
		
		log.debug("writeChat GET END");
		
		
		return "board/boardwrite";
	}
}
