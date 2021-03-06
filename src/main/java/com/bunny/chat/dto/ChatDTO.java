package com.bunny.chat.dto;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Alias("chat")
public class ChatDTO {

	private int chatId;
	private String fromUserId;
	private String toUserId;
	private String chatContent;
	private Date chatTime; 
	private String listType; //listType
	private int number; // count of call list
	private int chatRead;
	private String myProfile;
	private String yourProfile;
	
	public void setFromUserId(String fromUserId) {
		this.fromUserId = fromUserId.toLowerCase();
	}
	
	public void setToUserId(String toUserId) {
		this.toUserId = toUserId.toLowerCase();
	}
}
