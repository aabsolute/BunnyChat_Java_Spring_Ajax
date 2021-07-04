package com.bunny.memeber.dto;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotEmpty;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Alias("member")
public class MemberDTO {

	@NotEmpty
	private String userId;
	private String userPassword;
	private String userPassword2;
	private String userName;
	@Min(0)
	private int userAge;
	private String userGender;
	private String userEmail;
	private String userInfomation;
	
	public void setUserId(String userId) {
		this.userId = userId.toLowerCase();
	}
}
