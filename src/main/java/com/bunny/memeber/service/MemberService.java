package com.bunny.memeber.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.bunny.memeber.dao.MemberDAO;
import com.bunny.memeber.dto.MemberDTO;

@Service
public class MemberService {

	@Inject
	MemberDAO memberDAO;
	
	public int memberRegist(MemberDTO memberDTO) throws Exception
	{
		int result = 0;
		if(memberDTO == null) return -1;
		
		memberDAO.memberInsert(memberDTO);
		
		return result;
	}
	
	public MemberDTO memberLogIn(MemberDTO memberDTO) throws Exception
	{
		MemberDTO member = memberDAO.memberLogIn(memberDTO);
		
		if(member == null) return null;
		
		return member;
	}
	
	public int memberCheck(String userID) throws Exception
	{
		return memberDAO.memberCheck(userID);
	}
	
	public MemberDTO getMemberById(String userID) throws Exception
	{
		MemberDTO memberDTO = new MemberDTO();
		memberDTO = memberDAO.getMemberById(userID); 
		
		return memberDTO;
	}
	
	public int setMemberUpdate(MemberDTO member) throws Exception
	{
		return memberDAO.setMemberUpdate(member);
	}
	
	public int setMemberProfileUpdate(MemberDTO member) throws Exception
	{
		return memberDAO.setMemberProfileUpdate(member);
	}
	
}
