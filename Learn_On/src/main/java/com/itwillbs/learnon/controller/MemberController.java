package com.itwillbs.learnon.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
@Controller
public class MemberController {

	@Autowired
	
	@GetMapping("MemberLogin")
	public String login() {
		
		return "member/member_login";
	}
	
	@GetMapping("MemberJoin")
	public String memberJoin() {
		return"member/member_join";
	}
	
	
	@PostMapping("MemberJoin")
	public String join() {
		return"member_join_success"; //성공실패 나누는 if문
	}
}
