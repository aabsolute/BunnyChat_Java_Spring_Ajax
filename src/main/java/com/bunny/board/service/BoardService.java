package com.bunny.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bunny.board.dao.BoardDAO;
import com.bunny.board.dto.BoardDTO;

@Service
public class BoardService {

	@Autowired
	BoardDAO boardDAO;
	
	public int insertBoard(BoardDTO board) throws Exception{
		return boardDAO.insertBoard(board);
	}
	
	public List<BoardDTO> searchAllBoard() throws Exception{
		return boardDAO.searchAllBoard();
	}
	
	public BoardDTO searchOneBoard(int boardId) throws Exception{
		return boardDAO.searchOneBoard(boardId);
	}
	
	public List<BoardDTO> searchKeywordBoard(BoardDTO board) throws Exception{
		return boardDAO.searchKeywordBoard(board);
	}
}
