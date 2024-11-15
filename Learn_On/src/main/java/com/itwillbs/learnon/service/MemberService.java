package com.itwillbs.learnon.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.learnon.mapper.MemberMapper;
import com.itwillbs.learnon.vo.MailAuthInfo;
import com.itwillbs.learnon.vo.MemberVO;

@Service
public class MemberService {
	@Autowired
	private MemberMapper mapper;

	public int registMember(MemberVO member) {
		return mapper.insertMember(member);
	}

	public MemberVO getMember(MemberVO member) {
		return mapper.selectMember(member);

	}

	public int modifyMember(Map<String, String> map) {
		return mapper.updateMember(map);
	}

	public void registMemberAuthInfo(MailAuthInfo mailauthInfo) {
		MailAuthInfo dbMailAuthInfo = mapper.selectMailAuthInfo(mailauthInfo);
		if (dbMailAuthInfo == null) {
			mapper.insertMailAuthInfo(mailauthInfo);
		} else {
			mapper.updateMailAuthInfo(mailauthInfo);
		}

	}

	public boolean requestEmailAuth(MailAuthInfo mailAuthInfo) {
		boolean isAuthsuccess = false;

		// MamnerMapper- select .. () 호출하려 인증정보 조회 수행

		MailAuthInfo dbMailAuthInfo = mapper.selectMailAuthInfo(mailAuthInfo);
		System.out.println("조회된 인증 정보" + dbMailAuthInfo);

		// 인증정보 조회결과 판별
		if (dbMailAuthInfo != null) {
			if (mailAuthInfo.getAuth_code().equals(dbMailAuthInfo.getAuth_code())) { // 인증코드가 일치
				mapper.updateMailAuthStatus(mailAuthInfo); //인증상태 업데이트
				mapper.deleteMailAuthInfo(mailAuthInfo);

				isAuthsuccess = true;
			}
		}

		return isAuthsuccess;
	}

	public String getMemberPasswd(String id) {
		return mapper.selectMemberPasswd(id);
	}
}
