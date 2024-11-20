package com.itwillbs.learnon.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.learnon.service.AdminService;
import com.itwillbs.learnon.service.FaqService;
import com.itwillbs.learnon.service.NoticeBoardService;
import com.itwillbs.learnon.vo.AdminVO;
import com.itwillbs.learnon.vo.FaqVO;
import com.itwillbs.learnon.vo.NoticeBoardVO;
import com.itwillbs.learnon.vo.PageInfo;

@Controller
public class AdminController {
	@Autowired
	private AdminService adminService;
	@Autowired
	private NoticeBoardService noticeService;
	@Autowired
	private FaqService faqService;
	
	// 어드민 메인페이지 매핑
	@GetMapping("AdmIndex")
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
		
		return "admin/index";
		
	}
	// =======================================================================
	
	// 어드민 카테고리 편집 페이지 매핑
	@GetMapping("AdmClassCategory")
	public String admin_class_categoryModify(Model model) {
		model.addAttribute("getMainCate", adminService.getMainCate());
		model.addAttribute("getSubCate", adminService.getSubCate());
		
		return "admin/class_category";
	}
	
	// 어드민 카테고리 편집 저장
	@PostMapping("AdmClassCategory")
	public String admin_class_categorySubmit(AdminVO VO, Model model) {
//		String[] oldArrSubCodetype = VO.getOld_codetype_subcate().split(",");
//		String[] oldArrSubCodeTypeId = VO.getOld_codetype_id_subcate().split(",");
//		String[] oldArrSubName = VO.getOld_name_subcate().split(",");
//		String[] oldArrSubDescription = VO.getOld_description_subcate().split(",");
//		String[] oldArrSubOrder = VO.getOld_order_subcate().split(",");
//		
//		AdminVO UpdateVO = new AdminVO();
//		int updateRowCnt = oldArrSubCodetype.length;
//		
//		for (int i = 0; i < updateRowCnt; i++) {
//			UpdateVO.setOld_codetype_subcate(oldArrSubCodetype[i]);
//			UpdateVO.setOld_codetype_id_subcate(oldArrSubCodeTypeId[i]);
//			UpdateVO.setOld_name_subcate(oldArrSubName[i]);
//			UpdateVO.setOld_description_subcate(oldArrSubDescription[i]);
//			UpdateVO.setOld_order_subcate(oldArrSubOrder[i]);
//			
//			adminService.updateCate(UpdateVO);
//		}
		
		AdminVO insertVO = new AdminVO();
		
		if (VO.getCodeid_maincate() != null) {
			String[] arrCodeId = VO.getCodeid_maincate().split(",");
			String[] arrCodeType = VO.getCodetype_maincate().split(",");
			String[] arrCodeName = VO.getCodename_maincate().split(",");
			String[] arrDescription = VO.getDescription_maincate().split(",");
			
			int mainRowCnt = arrCodeId.length;
			
			for (int i = 0; i < mainRowCnt; i++) {
				insertVO.setCodeid_maincate(arrCodeId[i]);
				insertVO.setCodetype_maincate(arrCodeType[i]);
				insertVO.setCodename_maincate(arrCodeName[i]);
				insertVO.setDescription_maincate(arrDescription[i]);
				
				adminService.insertMainCate(insertVO);
			}
			
			if (mainRowCnt < 0) {
				model.addAttribute("msg", "대분류 등록 실패!");
				return "admin/fail";
			}
			
		}
		
		if (VO.getCodetype_id_subcate() != null) {
			String[] arrSubCodetype = VO.getCodetype_subcate().split(",");
			String[] arrSubCodeTypeId = VO.getCodetype_id_subcate().split(",");
			String[] arrSubName = VO.getName_subcate().split(",");
			String[] arrSubDescription = VO.getDescription_subcate().split(",");
			String[] arrSubOrder = VO.getOrder_subcate().split(",");
			
			int subRowCnt = arrSubCodeTypeId.length;
			
			for (int i = 0; i < subRowCnt; i++) {
				insertVO.setCodetype_subcate(arrSubCodetype[i]);
				insertVO.setCodetype_id_subcate(arrSubCodeTypeId[i]);
				insertVO.setName_subcate(arrSubName[i]);
				insertVO.setDescription_subcate(arrSubDescription[i]);
				insertVO.setOrder_subcate(arrSubOrder[i]);
				
				adminService.insertSubCate(insertVO);
			}
			
			if (subRowCnt < 0) {
				model.addAttribute("msg", "소분류 등록 실패!");
				return "admin/fail";
			}
			
		}
		
		return "redirect:/AdmClassCategory";
	}
	
	// 어드민 카테고리 삭제 로직
	@GetMapping("mainCateDelete")
	public String mainCateDelete(String CODEID) {
		adminService.deleteMainCate(CODEID);
		return "redirect:/AdmClassCategory";
	}
	@GetMapping("subCateDelete")
	public String subCateDelete(String old_codetype_subcate) {
		adminService.deleteSubCate(old_codetype_subcate);
		return "redirect:/AdmClassCategory";
	}
	
	// 어드민 클래스 등록 페이지 매핑
	@GetMapping("AdmClassAdd")
	public String admin_class_add(Model model) {
		model.addAttribute("getCategory", adminService.getCategory());
		
		
		return "admin/class_add";
		
	}
	
	@PostMapping("AdmClassAdd")
	public String admin_class_add1(Model model) {
		int insertCount = adminService.registClass();
		
		if (insertCount < 0) {
			model.addAttribute("msg", "클래스 등록 실패!");
			return "admin/fail";
		}
		
		return "admin/class_add";
	}
	
	// 어드민 클래스 목록 페이지 매핑
	@GetMapping("AdmClassList")
	public String admin_class_list(Model model) {
		model.addAttribute("getClassList", adminService.getClassList());
		
		return "admin/class_list";
	}
	
	// 어드민 클래스 수정 페이지 매핑
	@GetMapping("AdmClassListModify")
	public String admin_class_list_modi(int class_id, Model model) {
		model.addAttribute("getClass", adminService.getClass(class_id));
		
//		if (loadClass < 0) {
//			model.addAttribute("msg", "클래스 불러오기 실패!");
//			return "admin/fail";
//		}
		
		return "admin/class_list_modify";
	}
	
	// 어드민 삭제된 클래스 목록 페이지 매핑
//	@GetMapping("admin_class_delete")
//	public String admin_class_delete(Model model) {
//		model.addAttribute("getClassList", adminService.getClassList());
//		
//		return "admin/class_delete";
//	}
	
	// =======================================================================
	
	// 어드민 회원 목록 페이지 매핑
	@GetMapping("AdmMemList")
	public String admin_member_list(Model model) {
		model.addAttribute("getMemberList", adminService.getMemberList());
		return "admin/member_list";
	}
	
	// 어드민 강사 회원 목록 페이지 매핑
	@GetMapping("AdmMemInstructor")
	public String admin_member_list_instructor(Model model) {
		model.addAttribute("getMemberList", adminService.getMemberList());
		return "admin/member_list_instructor";
	}
	
	// 어드민 탈퇴한 회원 목록 페이지 매핑
	@GetMapping("AdmMemListDelete")
	public String admin_member_list_delete(Model model) {
		model.addAttribute("getMemberList", adminService.getMemberList());
	return "admin/member_list_delete";
	}

	// =======================================================================
	
	// 어드민 결제 내역 관리 페이지 매핑
	@GetMapping("AdmPayList")
	public String admin_payment_list() {
	return "admin/payment_list";
	}
	
	// 어드민 쿠폰 관리 페이지 매핑
	@GetMapping("AdmPayListCoupon")
	public String admin_payment_list_coupon() {
		return "admin/payment_list_coupon";
	}
	
	// =======================================================================
	
	// 어드민 공지사항 관리 페이지 매핑
	@GetMapping("AdmNotice")
	public String admin_notice_management(@RequestParam(defaultValue = "1") int pageNum,
										  @RequestParam(defaultValue = "latest") String sort,
										  @RequestParam(defaultValue = "") String searchKeyword,
										  @RequestParam(defaultValue = "") String searchType,
										  Model model) {
		
		int listLimit = 5;
		int startRow = (pageNum - 1) * listLimit;
		
		int listCount = noticeService.getBoardListCount(searchKeyword, searchType);
		
		int pageListLimit = 5;
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0);
		
		if (maxPage == 0) {
			maxPage = 1;
		}
		
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1;
		int endPage = startPage + pageListLimit - 1;
		
		if (endPage > maxPage) {
			endPage = maxPage;
		}
		
		if(pageNum < 1 || pageNum > maxPage) {
			model.addAttribute("msg", "해당 페이지는 존재하지 않습니다!");
			model.addAttribute("targetURL", "AdmNotice?pageNum=1");
			return "result/fail";
		}
		
		
		PageInfo pageInfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage);
		List<NoticeBoardVO> noticeList = noticeService.getBoardList(startRow, listLimit, sort, searchKeyword, searchType);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("sort", sort);
		
		return "admin/notice_management";
	}
	
	// 어드민 1:1 문의 관리 페이지 매핑
	@GetMapping("AdmSupport")
	public String admin_support_management2() {
		return "admin/support_management2";
	}
	
	
	
	
	// 어드민 FAQ 관리 페이지 매핑
	@GetMapping("AdmFaq")
	public String admin_board_faq(@RequestParam(defaultValue = "1") int pageNum,
			  					  @RequestParam(defaultValue = "") String searchKeyword,
			  					  @RequestParam(defaultValue = "") String searchType,
			  					  Model model) {
		int listLimit = 5;
		int startRow = (pageNum - 1) * listLimit;
		
		int listCount = faqService.getBoardListCount(searchKeyword, searchType);
		
		int pageListLimit = 5;
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0);
		
		if (maxPage == 0) {
			maxPage = 1;
		}
		
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1;
		int endPage = startPage + pageListLimit - 1;
		
		if (endPage > maxPage) {
			endPage = maxPage;
		}
		
		if(pageNum < 1 || pageNum > maxPage) {
			model.addAttribute("msg", "해당 페이지는 존재하지 않습니다!");
			model.addAttribute("targetURL", "AdmFaq?pageNum=1");
			return "result/fail";
		}
		
		PageInfo pageInfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage);
		List<FaqVO> faqList = faqService.getAdmBoardList(startRow, listLimit, searchKeyword, searchType);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("faqList", faqList);
		return "admin/board_faq";
	}
	
	// 어드민 수강 후기 관리 페이지 매핑
	@GetMapping("AdmReview")
	public String admin_board_review() {
		return "admin/board_review";
	}
	
	// =======================================================================
	
	
	
	
	
	
	
}
