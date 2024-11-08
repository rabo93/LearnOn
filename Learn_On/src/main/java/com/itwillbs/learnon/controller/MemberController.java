package com.itwillbs.learnon.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.itwillbs.learnon.service.MemberService;
import com.itwillbs.learnon.vo.MemberVO;
@Controller
public class MemberController {

	@Autowired
	private MemberService memberService;
	
	@GetMapping("MemberLogin")
	public String loginForm() {
		
		return "member/member_login";
	}
	
	
	@PostMapping("MemberLogin")
	public String login(MemberVO member,Model model,HttpSession session) {
		
		MemberVO user = memberService.memberSelect(member);
		System.out.println(user);
		
		if(user == null) {		
			model.addAttribute("msg", "로그인 실패!\\n아이디와 패스워드를 다시 확인해주세요");
			System.out.println("유저"+user);
			return "result/fail";
		} else { //로그인 성공
			session.setAttribute("sId", user.getMEM_NAME());
			
			return "redirect:/";
		}
	
	}
	
	
	@GetMapping("MemberJoin")
	public String memberJoin() {
		
		return"member/member_join";
	}
	
	
	@PostMapping("MemberJoin")
	public String join(MemberVO member , Model model , BCryptPasswordEncoder passwordEncoder,HttpSession session) {
		
//		String securePasswd = passwordEncoder.encode(member.getMEM_PASSWD());
//		member.setMEM_PASSWD(securePasswd);
		
		int insertCount = memberService.registMember(member);
		
		if(insertCount > 0) {
			session.setAttribute("sId", member.getMEM_NAME());
			return "redirect:/MemberJoinSuccess";
			
		}else {
			model.addAttribute("msg", "회원가입 실패//n항목을 다시 확인해주세요");
			return "result/fail";
		}
		
	}
	
	@GetMapping("MemberJoinSuccess")
	public String memberJoinSuccess() {
		
		return "result/success";
	}
}
