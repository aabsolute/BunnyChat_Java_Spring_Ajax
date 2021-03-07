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
		return sqlSession.insert("memberMapper.insert",memberDTO); 
	}
}
