package com.itwillbs.learnon.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.learnon.mapper.MemberMapper;
import com.itwillbs.learnon.vo.MemberVO;

@Service
public class MemberService {
	@Autowired
	private MemberMapper mapper;

	public int registMember(MemberVO member) {
		// TODO Auto-generated method stub
		return mapper.insertMember(member);
	}

	public MemberVO getMember(MemberVO member) {
		// TODO Auto-generated method stub
		return mapper.selectMember(member);
		//ㄹㄹㄹ
	}


}
