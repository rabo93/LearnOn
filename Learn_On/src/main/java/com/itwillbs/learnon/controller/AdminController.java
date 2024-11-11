package com.itwillbs.learnon.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import com.itwillbs.learnon.service.adminService;
import com.itwillbs.learnon.vo.AdminVO;

@Controller
public class AdminController {
	private static final AdminVO VO = null;

	@Autowired
	private adminService adminService;
	
	private String uploadPath = "/resources/upload";
	
	// 어드민 메인페이지 매핑
	@GetMapping("admin_index")
	public String admin_home() {
//	public String admin_home(HttpSession session, Model model, HttpServletRequest request) {
		
		//로그인 감지
//		String id = (String)session.getAttribute("sId");
//		if(id == null) {
//			model.addAttribute("msg", "접근 권한이 없습니다");
//			model.addAttribute("targetURL", "MemberLogin");
//			
//			// 로그인 성공 후 다시 현재 페이지로 돌아오기 위해 prevURL 세션 속성값 설정
//			String prevURL = request.getServletPath();
//			String queryString = request.getQueryString();
//			
//			if(queryString != null) {
//				prevURL += "?" + queryString;
//			}
//			
//			// 세션 객체에 prevURL 값 저장
//			session.setAttribute("prevURL", prevURL);
//			
//			return "admin/fail";
//		}
		
		return "admin/admin_index";
		
	}
	// =======================================================================
	
	// 어드민 클래스 등록 페이지 매핑
	@GetMapping("admin_class_add")
	public String admin_class_add(Model model) {
		model.addAttribute("getSubCategory", adminService.getSubCategory());
		model.addAttribute("getCategory", adminService.getCategory());
		
		
		return "admin/admin_class_add";
	}
	
	@PostMapping("admin_class_add")
	public String admin_class_add(AdminVO VO, HttpServletRequest request, HttpSession session, Model model) {
		System.out.println(VO);
//		
		int insertCount = adminService.registClass(VO);
		
		if (insertCount < 0) {
			model.addAttribute("msg", "글쓰기 실패!");
			return "admin/fail";
		}
		return "admin/admin_class_add";
	}
	
	// 어드민 클래스 목록 페이지 매핑
	@GetMapping("admin_class_list")
	public String admin_class_list() {
		
		
		
		
		return "admin/admin_class_list";
	}
	
	// 어드민 삭제된 클래스 목록 페이지 매핑
	@GetMapping("admin_class_delete")
	public String admin_class_delete() {
		return "admin/admin_class_delete";
	}
	
	// =======================================================================
	
	// 어드민 회원 목록 페이지 매핑
	@GetMapping("admin_member_list")
	public String admin_member_list() {
		return "admin/admin_member_list";
	}
	
	// 어드민 강사 회원 목록 페이지 매핑
	@GetMapping("admin_member_list_instructor")
	public String admin_member_list_instructor() {
		return "admin/admin_member_list_instructor";
	}
	
	// 어드민 탈퇴한 회원 목록 페이지 매핑
	@GetMapping("admin_member_list_delete")
	public String admin_member_list_delete() {
	return "admin/admin_member_list_delete";
	}

	// =======================================================================
	
	// 어드민 결제 내역 관리 페이지 매핑
	@GetMapping("admin_payment_list")
	public String admin_payment_list() {
	return "admin/admin_payment_list";
	}
	
	// 어드민 쿠폰 관리 페이지 매핑
	@GetMapping("admin_payment_list_coupon")
	public String admin_payment_list_coupon() {
		return "admin/admin_payment_list_coupon";
	}
	
	// =======================================================================
	
	// 어드민 게시판 관리 페이지 매핑
	@GetMapping("admin_board_management")
	public String admin_board_management() {
		return "admin/admin_board_management";
	}
	
	// 어드민 FAQ 관리 페이지 매핑
	@GetMapping("admin_board_faq")
	public String admin_board_faq() {
		return "admin/admin_board_faq";
	}
	
	// 어드민 수강 후기 관리 페이지 매핑
	@GetMapping("admin_board_review")
	public String admin_board_review() {
		return "admin/admin_board_review";
	}
	
	// =======================================================================
	
	
	
	
	
	
	
}
