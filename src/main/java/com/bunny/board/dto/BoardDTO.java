package com.bunny.board.dto;

import java.time.LocalDate;

import javax.validation.constraints.NotEmpty;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("board")
public class BoardDTO {

	private String userId;
	@NotEmpty 
	int boardId;
	String boardTitle;
	String boardContent;
	LocalDate boardDate;
	int boardHit;
	String boardFile;
	String boardRealFile;
	int boardGroup;
	int boardSequence;
	int boardLevel;
}
