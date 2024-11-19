package com.itwillbs.learnon.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.learnon.vo.MailAuthInfo;
import com.itwillbs.learnon.vo.MemberVO;


@Mapper
public interface MemberMapper {

	MemberVO selectMember(MemberVO member);

	int insertMember(MemberVO member);

	int updateMember(Map<String, String> map);
	
	void insertMailAuthInfo(MailAuthInfo mailauthInfo);

	void updateMailAuthInfo(MailAuthInfo mailauthInfo);

	MailAuthInfo selectMailAuthInfo(MailAuthInfo mailauthInfo);

	
	void updateMailAuthStatus(MailAuthInfo mailAuthInfo);

	void deleteMailAuthInfo(MailAuthInfo mailAuthInfo);

	String selectMemberPasswd(String id);

	MemberVO selectMemberNick(MemberVO member);



	
}
