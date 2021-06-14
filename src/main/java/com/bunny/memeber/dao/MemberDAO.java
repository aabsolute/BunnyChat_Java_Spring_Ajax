package com.bunny.memeber.dao;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.bunny.memeber.dto.MemberDTO;

@Repository
public class MemberDAO {

	@Inject
    private SqlSession sqlSession;
	
	public int memberInsert(MemberDTO memberDTO) throws Exception
	{
		return sqlSession.insert("memberMapper.insertMember",memberDTO); 
	}
	
	public MemberDTO memberLogIn(MemberDTO memberDTO) throws Exception
	{
		return sqlSession.selectOne("memberMapper.memberLogIn", memberDTO);
	}
	
	public int memberCheck(String userId) throws Exception
	{
		return sqlSession.selectOne("memberMapper.memberCheck", userId);
	}
	
}
