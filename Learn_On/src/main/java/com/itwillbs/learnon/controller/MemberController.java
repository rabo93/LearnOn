package com.itwillbs.learnon.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.itwillbs.learnon.handler.MailAuthenticator;
import com.itwillbs.learnon.service.MailService;
import com.itwillbs.learnon.service.MemberService;
import com.itwillbs.learnon.vo.MailAuthInfo;
import com.itwillbs.learnon.vo.MemberVO;

@Controller
public class MemberController {

	@Autowired
	private MemberService memberService;
	@Autowired
	private MailService mailService;
	
	
	private String uploadPath = "/resources/upload";
	
	@GetMapping("MemberLogin")
	public String loginForm() {
		
		return "member/member_login";
	}
	
	
	@PostMapping("MemberLogin")
	public String login(MemberVO member,Model model,HttpSession session,BCryptPasswordEncoder passwordEncoder) {
		MemberVO dbMember = memberService.getMember(member);
		System.out.println(dbMember);
		
		if(dbMember == null || !passwordEncoder.matches(member.getMem_passwd(), dbMember.getMem_passwd())) {		
			model.addAttribute("msg", "로그인 실패!\\n아이디와 패스워드를 다시 확인해주세요");
			System.out.println("유저"+dbMember);
			return "result/fail";
		}else if(dbMember.getMem_status() == 3) { // 로그인 성공이지만, 탈퇴 회원일 경우
			model.addAttribute("msg", "탈퇴한 회원입니다!");
			return "result/fail";
		}else { //로그인 성공
			session.setAttribute("sId", dbMember.getMem_name());
			session.setAttribute("sId", member.getMem_id());
			return "redirect:/";
		}
		
	}	
	
	@GetMapping("MemberJoin")
	public String memberJoin() {
		
		return"member/member_join";
	}
	
	
	@PostMapping("MemberJoin")
	public String join(MemberVO member , Model model , BCryptPasswordEncoder passwordEncoder,HttpSession session ,HttpServletRequest request) {
		
		String securePasswd = passwordEncoder.encode(member.getMem_passwd());
		member.setMem_passwd(securePasswd);
		
		
		/************ 파일 업로드 ************/
		
		
		String realPath = session.getServletContext().getRealPath(uploadPath);
		System.out.println("실제 경로: " + realPath);

		String subDir = "";
		LocalDate today = LocalDate.now();
		String datePattern = "yyyy/MM/dd";
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern(datePattern);

		subDir = today.format(dtf);
		realPath += "/" + subDir;

		// 서버에 파일을 저장할 디렉토리 생성
		try {
		    Path path = Paths.get(realPath);
		    Files.createDirectories(path);  // 하위 디렉토리 생성
		} catch (IOException e) {
		    e.printStackTrace();
		}
		
		MultipartFile mFile = member.getMem_pp_file();  // 업로드된 파일 가져오기
		String originalFileName = mFile.getOriginalFilename();  // 원본 파일 이름
		String saveFileName = UUID.randomUUID().toString() + "_" + originalFileName;  // UUID로 중복 방지
		String filePath = realPath + "/" + saveFileName;  // 전체 파일 경로
		member.setFile_pp(subDir + "/" + saveFileName); // String 파일명 저장
		

		// 파일을 서버에 저장
		try {
			Path path = Paths.get(realPath);
			Files.createDirectories(path);  // 하위 디렉토리 생성
		} catch (IOException e) {
		    e.printStackTrace();
		    model.addAttribute("msg", "파일 업로드 중 오류가 발생했습니다.");
		    return "result/fail";
		}

		int insertCount = memberService.registMember(member);
		if(insertCount > 0) {
			session.setAttribute("sId", member.getMem_name());
			
			if (!mFile.getOriginalFilename().equals("")){
	        	try {
					mFile.transferTo(new File (realPath,saveFileName));
				} catch (IOException e) {
					e.printStackTrace();
				}
	        	
	        	//**************인증메일 발송작업 추가*************
	        	//ReSendAuthMail post
//	        	MailAuthInfo mailauthInfo = mailService.sendAuthMail(member);
	        	
			}
	        	
			return "redirect:/MemberJoinSuccess";
			
		} else {
			model.addAttribute("msg", "회원가입 실패//n항목을 다시 확인해주세요");
			return "result/fail";
		}
	}
	
	@GetMapping("MemberJoinSuccess")
	public String memberJoinSuccess() {
		
		return "result/success";
	}
	
	@GetMapping("MemberLogout")
	public String memberLogout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	
	
//	@GetMapping("MemberModify")
//	public String memberModify(Map<String, String>map, BCryptPasswordEncoder passwordEncoder , HttpSession session , Model model , HttpServletRequest request ,MemberVO member) {
//		String id = (String)session.getAttribute("sId");
//		member.setMEM_ID(id);
//		map.put("id", id);
//		
//		String dbPasswd = memberService.modifyMember(map);
//		
//		return"";
//	}
	
	//*************아이디/닉네임 중복체크***************
	@ResponseBody
	@GetMapping("MemberCheckId")
	public String memberCheckId(MemberVO member) {
		member = memberService.getMember(member);
		boolean isDuplicate = false;
		if(member != null) { //아이디 중복
			isDuplicate= true;
		}
		return isDuplicate+"";
	}
	
}