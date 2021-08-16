package com.bunny.board.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.bunny.board.dto.BoardDTO;

@Repository
public class BoardDAO {

	@Autowired
	SqlSession sqlsession;
	
	public int insertBoard(BoardDTO boardDTO) {
		return sqlsession.insert("boardMapper.registBoard", boardDTO);
	}
	
	public List<BoardDTO> searchAllBoard() {
		return sqlsession.selectList("boardMapper.searchAllBoard");
	}
	
	public BoardDTO searchOneBoard(int boardId) {
		return sqlsession.selectOne("boardMapper.searchOneBoard", boardId);
	}
	
	public List<BoardDTO> searchKeywordBoard(BoardDTO boardDTO) {
		return sqlsession.selectList("boardMapper.searchKeywordBoard", boardDTO);
	}
}
