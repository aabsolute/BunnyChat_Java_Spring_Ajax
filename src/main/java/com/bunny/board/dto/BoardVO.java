package com.bunny.board.dto;

import java.time.LocalDateTime;

import javax.validation.constraints.NotEmpty;

import org.apache.ibatis.type.Alias;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;


@ToString
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Builder(builderMethodName = "boardVOBuilder")
@Alias("board2")
public class BoardVO {

	@NotEmpty 
	private String userId;
	int boardId;
	String boardTitle;
	String boardContent;
	//@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
	@DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss")
	@Builder.Default
	LocalDateTime boardDate = LocalDateTime.now();
	@Builder.Default
	int boardHit = 0;
	String boardFile;
	MultipartFile boardRealFile;
	@Builder.Default
	int boardGroup = 0;
	@Builder.Default
	int boardSequence = 0;
	@Builder.Default 
	int boardLevel=0;
	
	@Builder
	public BoardVO(String userId, String boardTitle) {
		this.userId = userId;
		this.boardTitle = boardTitle;
	}

}
