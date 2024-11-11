package com.itwillbs.learnon.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.learnon.vo.MemberVO;


@Mapper
public interface MemberMapper {

	MemberVO selectMember(MemberVO member);

	int insertMember(MemberVO member);

	
}
