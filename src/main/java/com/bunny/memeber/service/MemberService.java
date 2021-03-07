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
	
}
