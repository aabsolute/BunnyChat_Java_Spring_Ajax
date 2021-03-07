package com.bunny.memeber.dto;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Alias("memberDTO")
public class MemberDTO {

	private String userID;
	private String userPassword;
	private String userName;
	private int userAge;
	private String userGender;
	private String userEmail;
	private String userInfomation;
}
