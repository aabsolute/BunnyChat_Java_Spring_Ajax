package com.bunny.memeber.dto;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Alias("member")
public class MemberDTO {

	private String userId;
	private String userPassword;
	private String userPassword2;
	private String userName;
	private int userAge;
	private String userGender;
	private String userEmail;
	private String userInfomation;
	
	//private String status;
	
	public void setUserId(String userId) {
		this.userId = userId.toLowerCase();
	}
}
