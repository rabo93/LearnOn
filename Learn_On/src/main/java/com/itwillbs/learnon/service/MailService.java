package com.itwillbs.learnon.service;

import java.net.MulticastSocket;
import java.util.Date;

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
	
//	@Autowired
//	private MemberService memberService;

	
//	public MailAuthInfo sendAuthMail(MemberVO member) {
//		System.out.println("memberService : " + member);
//		
//		if (member == null || member.getEmail() == null) {
//			System.out.println("Member 객체 또는 이메일이 null, 인증 메일을 보낼수없음");
//			return null;
//		}
//		
////		System.out.println("@@@@member----------------------"+member.getEmail());
//		
////		MemberVO dbMember = memberService.getMember(member);
//		//String fullEmail = dbMember.getMem_email1() + "@" + dbMember.getMem_email2();
//		
//		String auth_code = GenerateRandomCode.getRandomCode(50);
//		
//		String subject = "[런온]가입 인증코드 입니다.";
//		String content =
////				"<a href=\"http://localhost:8081/MemberEmailAuth?email="+ fullEmail + "&auth_code=" + auth_code +"\">[클릭]이메일 인증하기</a>";
////			"<a href=\"http://localhost:8081/MemberEmailAuth?email="+ "hello3o__@naver.com" + "&auth_code=" + auth_code +"\">[클릭]이메일 인증하기</a>";
//				"<a href=\"http://localhost:8081/MemberEmailAuth?mem_email="+ member.getEmail() + "&auth_code=" + auth_code +"\">[클릭]이메일 인증하기</a>";
//		//주소 수정해야함
//		
//		new Thread(new Runnable() {
//			
//			@Override
//			public void run() {
////				sendMailClient.sendMail("hello3o__@naver.com" , subject, content);
////				sendMailClient.sendMail(dbMember.getEmail() , subject, content);
//				sendMailClient.sendMail(member.getEmail(), subject, content);
//				System.out.println("메일 발송 쓰레드 작업 완료되야하는데 getMail null이라서 안되는중" + new Date());
//			}
//		}).start();
//		
//		System.out.println("메일 발송 쓰레드 작업 시작" + new Date());
////		System.out.println("member.getEmail() 값: "+member.getEmail());
////		System.out.println("member.getEmail() 값: "+fullEmail);
//		System.out.println("memverVO" + member.getEmail());
//		
////		MailAuthInfo mailAuthInfo = new MailAuthInfo(fullEmail, auth_code);
//		MailAuthInfo mailAuthInfo = new MailAuthInfo(member.getEmail(), auth_code);
////		MailAuthInfo mailAuthInfo = new MailAuthInfo("hello3o__@naver.com", auth_code);
////		MailAuthInfo mailAuthInfo = new MailAuthInfo(dbMember.getEmail(),auth_code);
//		
//		return mailAuthInfo;
////		
//	}
	
	
	//	========================================================================
	public MailAuthInfo sendAuthMail(MemberVO member, String email1, String email2) {
		System.out.println("memberService : " + member);
		
		
		String email = email1 + '@' +  email2;
		String auth_code = GenerateRandomCode.getRandomCode(50);
		
		String subject = "[런온]가입 인증코드 입니다.";
		String content =
				"<a href=\"http://localhost:8081/MemberEmailAuth?mem_email="+ email + "&auth_code=" + auth_code +"\">[클릭]이메일 인증하기</a>";
				//주소 수정해야함
	
		new Thread(new Runnable() {
			
			@Override
			public void run() {
				sendMailClient.sendMail(email, subject, content);
				System.out.println("메일 발송 쓰레드 작업 완료!" + new Date());
			}
		}).start();
		
		System.out.println("메일 발송 쓰레드 작업 시작" + new Date());
		System.out.println("memverVO" + member.getEmail());
		
		MailAuthInfo mailAuthInfo = new MailAuthInfo(email, auth_code);
		
		return mailAuthInfo;
//		
	}

}
