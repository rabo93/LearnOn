package com.itwillbs.learnon.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class Admin_Controller {
	
	// 어드민 메인페이지 매핑
	@RequestMapping(value = "/admin", method = RequestMethod.GET)
	public String admin_home() {
		return "admin/admin_index";
	}
	// =======================================================================
	
	// 어드민 클래스 등록 페이지 매핑
	@RequestMapping(value = "/admin_class_add", method = RequestMethod.GET)
	public String admin_class_add() {
		return "admin/admin_class_add";
	}
	
	// 어드민 클래스 목록 페이지 매핑
	@RequestMapping(value = "/admin_class_list", method = RequestMethod.GET)
	public String admin_class_list() {
		return "admin/admin_class_list";
	}
	
	// 어드민 삭제된 클래스 목록 페이지 매핑
	@RequestMapping(value = "/admin_class_delete", method = RequestMethod.GET)
	public String admin_class_delete() {
		return "admin/admin_class_delete";
	}
	
	// =======================================================================
	
	// 어드민 회원 목록 페이지 매핑
	@RequestMapping(value = "/admin_member_list", method = RequestMethod.GET)
	public String admin_member_list() {
		return "admin/admin_member_list";
	}
	
	// 어드민 강사 회원 목록 페이지 매핑
	@RequestMapping(value = "/admin_member_list_instructor", method = RequestMethod.GET)
	public String admin_member_list_instructor() {
		return "admin/admin_member_list_instructor";
	}
	
	// 어드민 탈퇴한 회원 목록 페이지 매핑
	@RequestMapping(value = "/admin_member_list_delete", method = RequestMethod.GET)
	public String admin_member_list_delete() {
	return "admin/admin_member_list_delete";
	}

	// =======================================================================
	
	// 어드민 결제 내역 관리 페이지 매핑
	@RequestMapping(value = "/admin_payment_list", method = RequestMethod.GET)
	public String admin_payment_list() {
	return "admin/admin_payment_list";
	}
	
	// 어드민 쿠폰 관리 페이지 매핑
	@RequestMapping(value = "/admin_payment_list_coupon", method = RequestMethod.GET)
	public String admin_payment_list_coupon() {
		return "admin/admin_payment_list_coupon";
	}
	
	// =======================================================================
	
	// 어드민 게시판 관리 페이지 매핑
	@RequestMapping(value = "/admin_board_management", method = RequestMethod.GET)
	public String admin_board_management() {
		return "admin/admin_board_management";
	}
	
	// 어드민 FAQ 관리 페이지 매핑
	@RequestMapping(value = "/admin_board_faq", method = RequestMethod.GET)
	public String admin_board_faq() {
		return "admin/admin_board_faq";
	}
	
	// 어드민 수강 후기 관리 페이지 매핑
	@RequestMapping(value = "/admin_board_review", method = RequestMethod.GET)
	public String admin_board_review() {
		return "admin/admin_board_review";
	}
	
}
