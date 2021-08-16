package com.bunny.board.controller;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.bunny.board.dto.BoardDTO;
import com.bunny.board.service.BoardService;
import com.bunny.memeber.dto.MemberDTO;

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
		
		
		List<BoardDTO> allBoardList = new ArrayList<>();
		try {
			allBoardList = boardService.searchAllBoard();
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("boardList", allBoardList);
		log.debug("boardMain GET END");
		return "board/boardview";
	}
	 
	@GetMapping("/write")
	public String writeChat(Model model, HttpServletRequest request)
	{
		log.debug("writeChat GET START");
		
		
		HttpSession session = request.getSession();
		MemberDTO member = (MemberDTO)session.getAttribute("login");
		
		BoardDTO board = BoardDTO.builder(member.getUserId(), "title").build();
		model.addAttribute("board",board);
		log.debug("writeChat GET END");
		return "board/boardwrite";
	}
	
	@PostMapping("/write")
	public String writeChatRegist(BoardDTO board, Model model)
	{
		int result = 0;
		try {
			MultipartFile file = board.getBoardRealFile();
			String fileName = file.getOriginalFilename();
			board.setBoardFile(fileName);
			board.setBoardDate(LocalDateTime.now());
			result = boardService.insertBoard(board);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if(result != 1) {
			return "board/boardwrite"; 
		}
		
		return "redirect:/board/main";
	}
	
	@GetMapping("/readview")
	public String readOneBoard(Model model,@ModelAttribute("boardId") int boardId)
	{
		try {
			BoardDTO board = boardService.searchOneBoard(boardId);
			model.addAttribute("board", board);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return "board/readview";
	}
}
