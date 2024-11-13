package com.itwillbs.learnon.service;

import java.security.GeneralSecurityException;

import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.learnon.handler.GenerateRandomCode;
import com.itwillbs.learnon.handler.SendMailClient;
import com.itwillbs.learnon.vo.MailAuthInfo;
import com.itwillbs.learnon.vo.MemberVO;

@Service
public class MailService {
	@Autowired
	private SendMailClient sendMailClient;
	
	public MailAuthInfo sendAuthMail(MemberVO member) {
		String auth_code = GenerateRandomCode.getRandomCode(50);
		
		String subject = "[런온]가입 인증코드 입니다.";
		String content =
				"<a href=\"http://localhost:8081/mvc_board/MemberEmailAuth?email="+ member.getEmail() + "&auth_code=" + auth_code +"\">[클릭]이메일 인증하기</a>";
				//주소 수정해야함
	
//		new Thread(new Runnable() {
//			
//			@Override
//			public void run() {
//				sendMailClient.sendMail()
//			}
//		}).start();
		
		MailAuthInfo mailAuthInfo = new MailAuthInfo(member.getEmail(),auth_code);
		
		return mailAuthInfo;
//		
	}

}
