package com.itwillbs.learnon.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.itwillbs.learnon.service.AdminService;
import com.itwillbs.learnon.service.CouponService;
import com.itwillbs.learnon.service.FaqService;
import com.itwillbs.learnon.service.MypageService;
import com.itwillbs.learnon.service.NoticeBoardService;
import com.itwillbs.learnon.vo.AdminVO;
import com.itwillbs.learnon.vo.CouponVO;
import com.itwillbs.learnon.vo.FaqVO;
import com.itwillbs.learnon.vo.NoticeBoardVO;
import com.itwillbs.learnon.vo.PageInfo;
import com.itwillbs.learnon.vo.SupportBoardVO;

@Controller
public class AdminController {
	@Autowired
	private AdminService adminService;
	@Autowired
	private NoticeBoardService noticeService;
	@Autowired
	private FaqService faqService;
	@Autowired
	private CouponService couponService;
	@Autowired
	private MypageService myService;
	
	
	private String uploadPath = "/resources/upload";
	
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
	// ======================================================================================================
	
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
		
		// 업데이트 로직
		String[] oldSubCodetype = VO.getOld_codetype_subcate().split(",");
		String[] oldSubCodeTypeId = VO.getOld_codetype_id_subcate().split(",");
		String[] oldSubName = VO.getOld_name_subcate().split(",");
		String[] oldSubDescription = VO.getOld_description_subcate().split(",");
		String[] oldSubOrder = VO.getOld_order_subcate().split(",");
		String[] sub_checkCodeid = VO.getSub_checkCodeid().split(",");
		
		String[] oldMainCodeId = VO.getOld_codeid_maincate().split(",");
		String[] oldMainCodeType = VO.getOld_codetype_maincate().split(",");
		String[] oldMainCodeName = VO.getOld_codename_maincate().split(",");
		String[] oldMainDescription = VO.getOld_description_maincate().split(",");
		String[] mainCheckCodeId = VO.getMain_checkCodeid().split(",");
		
		AdminVO UpdateVO = new AdminVO();
		int updateMainRowCnt = oldMainCodeId.length;
		int updateSubRowCnt = oldSubCodetype.length;
		
		for (int i = 0; i < updateMainRowCnt; i++) {
			UpdateVO.setOld_codeid_maincate(oldMainCodeId[i]);
			UpdateVO.setOld_codetype_maincate(oldMainCodeType[i]);;
			UpdateVO.setOld_codename_maincate(oldMainCodeName[i]);;
			UpdateVO.setOld_description_maincate(oldMainDescription[i]);
			UpdateVO.setMain_checkCodeid(mainCheckCodeId[i]);
			
			adminService.updateMainCate(UpdateVO);
		}
		
		for (int i = 0; i < updateSubRowCnt; i++) {
			UpdateVO.setOld_codetype_subcate(oldSubCodetype[i]);
			UpdateVO.setOld_codetype_id_subcate(oldSubCodeTypeId[i]);
			UpdateVO.setOld_name_subcate(oldSubName[i]);
			UpdateVO.setOld_description_subcate(oldSubDescription[i]);
			UpdateVO.setOld_order_subcate(oldSubOrder[i]);
			UpdateVO.setSub_checkCodeid(sub_checkCodeid[i]);
			
			adminService.updateSubCate(UpdateVO);
		}
		
		// 행 추가 로직
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
	
	// ======================================================================================================
	
	// 어드민 클래스 등록 페이지 매핑
	@GetMapping("AdmClassAdd")
	public String admin_class_add(Model model) {
		model.addAttribute("getMainCate", adminService.getMainCate());
		return "admin/class_add";
	}
	
	@PostMapping("AdmClassAdd")
	public String admin_class_add1(AdminVO VO, HttpSession session, Model model) {
		int classId = adminService.getClassId();
		VO.setClass_id(classId);
		
		System.out.println("!@#!@#");
		for (int i = 0; i < VO.getCur_video_get().length; i++) {
			System.out.println(VO.getCur_video_get()[i].getOriginalFilename());
		}
		
//		AdminVO insertCur = new AdminVO();
		
		String[] arrCurTitle = VO.getCur_title().split(",");
		String[] arrCurRunTime = VO.getCur_runtime().split(",");
		int totalRunTime = VO.getClass_runtime();
		// 실제 경로
		String realPath = getRealPath(session);
		//	서브 디렉토리 생성
		String subDir = createDirectories(classId, realPath);
		realPath += "/" + subDir;
		
		for (int i = 0; i < arrCurTitle.length; i++) {
			
			String videoName = addVideoProcess(VO.getCur_video_get()[i], realPath, subDir);
			
			VO.setCur_video(videoName);
			VO.setCur_title(arrCurTitle[i]);
			VO.setCur_runtime(arrCurRunTime[i]);
			totalRunTime += Integer.parseInt(arrCurRunTime[i]);
			System.out.println("누적 ======" + totalRunTime);
			adminService.curriculum(VO);
			
			adminService.insertCurVideo(VO);
		}
		System.out.println("결과 ======" + totalRunTime);
		VO.setClass_runtime(totalRunTime);
		
		//	첨부파일 업로드
		String fileName = addFileProcess(VO, realPath, subDir);
		VO.setClass_pic1(fileName);
		
		adminService.insertClassPic(VO);
		int insertCountCla = adminService.registClass(VO);
		
		if (insertCountCla < 0) {
			model.addAttribute("msg", "클래스 등록 실패!");
			return "admin/fail";
		}
		
		return "redirect:/AdmClassList";
	}
	
	//	실제 업로드 경로 메서드
	public String getRealPath(HttpSession session) {
		String realPath = session.getServletContext().getRealPath(uploadPath);
		return realPath;
	}
	// 서브 디렉토리 생성
	public String createDirectories(int classId, String realPath) {
		
		//	기존 실제 업로드 경로
		realPath += "/" + classId;
		//	실제 경로 전달
//		Path path = Paths.get(realPath);
		
		return Integer.toString(classId);
	}
	
	public String addFileProcess(AdminVO VO, String realPath, String subDir) {
		MultipartFile multis = VO.getClass_pic1_get();
		
		VO.setClass_pic1("");
		String fileName = "";
		
		try {
			String origin = multis.getOriginalFilename();
			if (!origin.equals("")) {
				String temp = UUID.randomUUID().toString().substring(0, 8) + "_" + origin;
				multis.transferTo(new File(realPath, temp));
				fileName += subDir + "/" + temp + ",";
			}
		} catch (Exception e) {
			e.printStackTrace();
		} 
		
		if (!fileName.equals("")) {
			fileName = fileName.substring(0, fileName.length() - 1);
		}
		
		return fileName;
	}
	
	public String addVideoProcess(MultipartFile multi, String realPath, String subDir) {
		String fileName = "";
		String origin = multi.getOriginalFilename();
		String temp = "";
		try {
			if (!origin.equals("")) {
				temp = UUID.randomUUID().toString().substring(0, 8) + "_" + origin;
				fileName += subDir + "/" + temp + ",";
				
				multi.transferTo(new File(realPath, temp));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} 
		
		if (!fileName.equals("")) {
			fileName = fileName.substring(0, fileName.length() - 1);
		}
		
		return fileName;
	}
	
	@ResponseBody
	@GetMapping("SelectCategory")
	public String selectCategory(AdminVO admin) {
		List<Map<String, Object>> adminArr = adminService.selectSubCate(admin);
//		System.out.println("admin : " + adminArr);
		
		JSONArray joArr = new JSONArray(adminArr);
		
		return joArr.toString();
	}
	
	
	// 어드민 클래스 목록 페이지 매핑
	@GetMapping("AdmClassList")
	public String admin_class_list(Model model) {
		model.addAttribute("getClassList", adminService.getClassList());
		model.addAttribute("getMainCate", adminService.getMainCate());
		
		return "admin/class_list";
	}
	
	// 어드민 클래스 수정 페이지 매핑
	@GetMapping("AdmClassListModify")
	public String admin_class_list_modi(AdminVO VO, Model model) {
		model.addAttribute("getMainCate", adminService.getMainCate());
		model.addAttribute("getCurriculum", adminService.getCurriculum(VO));
		List<AdminVO> classLoad = adminService.getClass(VO);
		System.out.println(VO);
		model.addAttribute("getClass", classLoad);
		
		
		if (classLoad == null) {
			model.addAttribute("msg", "클래스 불러오기 실패!");
			return "admin/fail";
		} else {
			return "admin/class_list_modify";
		}
		
	}
	
	@PostMapping("AdmClassListModify")
	public String admin_class_list_modi_submit(AdminVO VO, Model model) {
		model.addAttribute("updateClass", adminService.updateClass(VO));
		
		return "redirect:/class_list";
	}
	
	// ======================================================================================================
	
	// 어드민 회원 목록 페이지 매핑
	@GetMapping("AdmMemList")
	public String admin_member_list(@RequestParam(defaultValue = "1") int pageNum,
									@RequestParam(defaultValue = "latest") String sort,
									@RequestParam(defaultValue = "") String searchKeyword,
									@RequestParam(defaultValue = "") String searchType,
									Model model) {
		
		int listLimit = 5;
		int startRow = (pageNum - 1) * listLimit;
		
		int listCount = adminService.getNomalMemberListCount(searchKeyword, searchType);
		
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
			model.addAttribute("targetURL", "AdmMemList?pageNum=1");
			return "result/fail";
		}
		
		PageInfo pageInfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage);
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("getMemberList", adminService.getNomalMemberList(startRow, listLimit, searchKeyword, searchType));
		return "admin/member_list";
	}
	
	// 어드민 강사 회원 목록 페이지 매핑
	@GetMapping("AdmMemInstructor")
	public String admin_member_list_instructor(Model model) {
		model.addAttribute("getMemberList", adminService.getInstructorMemberList());
		return "admin/member_list_instructor";
	}
	
	// 어드민 탈퇴한 회원 목록 페이지 매핑
	@GetMapping("AdmMemListDelete")
	public String admin_member_list_delete(Model model) {
		model.addAttribute("getMemberList", adminService.getWithdrawMemberList());
	return "admin/member_list_delete";
	}

	//	어드민 회원상태 변경
	@ResponseBody
	@PostMapping("AdmChangeMemStatus")
	public String admChangeMemStatus(@RequestParam Map<String, String> map) {
//		System.out.println("++++++++++++mem_status: " +  map.get("mem_status"));
//		System.out.println("map? ==============" + map);
		adminService.changeMemStatus(map);
		
		String mem_status = "";
		switch (map.get("mem_status")) {
		case "1": mem_status = "승인";break;
		case "2": mem_status = "대기";break;
		case "3": mem_status = "탈퇴";break;
		}
		
		JSONObject json = new JSONObject();
		json.put("mem_id", map.get("mem_id"));
		json.put("mem_status", mem_status);
		
//		System.out.println("Response JSON: " + json.toString());
		
		return json.toString();
	}
	
	
	// =======================================================================
	
	// 어드민 결제 내역 관리 페이지 매핑
	@GetMapping("AdmPayList")
	public String admin_payment_list() {
	return "admin/payment_list";
	}
	
	// 어드민 쿠폰 관리 페이지 매핑
	@GetMapping("AdmPayListCoupon")
	public String admin_payment_list_coupon(@RequestParam(defaultValue = "1") int pageNum,
			  								@RequestParam(defaultValue = "latest") String sort,
			  								@RequestParam(defaultValue = "") String searchKeyword,
			  								@RequestParam(defaultValue = "") String searchType,
			  								Model model) {
		
		int listLimit = 5;
		int startRow = (pageNum - 1) * listLimit;
		
		int listCount = couponService.getCouponListCount(searchKeyword, searchType);
		
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
		List<CouponVO> couponList = couponService.getAdmCoupon(startRow, listLimit, searchKeyword, searchType);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("couponList", couponList);
		return "admin/payment_list_coupon";
	}
	
	@GetMapping("AdmCouponWrite")
	public String admCouponWriteForm () {
		return "admin/coupon_write_form";
	}
	
	@PostMapping("AdmCouponWrite")
	public String admCouponWrite(CouponVO coupon, Model model) {
		System.out.println("coupon : " + coupon);
		
		int insertCount = couponService.createAdmCoupon(coupon);
		
		if(insertCount > 0) {
			return "redirect:/AdmPayListCoupon";
		} else {
			model.addAttribute("msg", "쿠폰등록에 실패했습니다");
			return "result/fail";
		}
	}
	
	@GetMapping("AdmCouponDelete")
	public String admCouponDelete(int[] coupon_ids, Model model) {
		for (int coupon_id : coupon_ids) {
			CouponVO coupon = couponService.getIdxCoupon(coupon_id);
			
			if (coupon.equals(null)) {
				model.addAttribute("msg", "존재하지 않는 쿠폰입니다");
				return "result/fail";
			}
			
			int deleteCount = couponService.removeCoupon(coupon.getCoupon_id());
			
			if (deleteCount < 0) {
				model.addAttribute("msg", "삭제 실패");
				return "result/fail";
			}
		}
		return "redirect:/AdmPayListCoupon";
	}
	
	@GetMapping("AdmCouponModify")
	public String admCouponModifyForm(int coupon_id, Model model) {
		CouponVO coupon = couponService.getIdxCoupon(coupon_id);
		model.addAttribute("coupon", coupon);
		return "admin/coupon_modify_form";
	}
	
	@PostMapping("AdmCouponModify")
	public String admCouponModify(CouponVO coupon, Model model) {
		System.out.println("coupon : " + coupon);
		int updateCount = couponService.modifyCouponInfo(coupon);
		if(updateCount < 0) {
			model.addAttribute("msg", "수정에 실패했습니다");
			return "result/fail";
		}
		return "redirect:/AdmPayListCoupon";
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
	
	// 어드민 1:1 문의 관리 목록
	@GetMapping("AdmSupport")
	public String adminSupportList(@RequestParam(defaultValue = "1") int pageNum, HttpServletRequest request, HttpSession session, Model model) {
//		System.out.println("페이지번호: " + pageNum);
		// 세션아이디 체크
		String id = (String)session.getAttribute("sId");
		if(id == null) {
			model.addAttribute("msg", "로그인 필수!\\n 로그인 페이지로 이동합니다!");
			model.addAttribute("targetURL", "MemberLogin");
			savePreviousUrl(request, session);
			
			return "result/fail";
		}
		
		// 페이징 설정
		int listLimit = 10; // 한 페이지당 게시물 수
		int startRow = (pageNum - 1) * listLimit;
		int listCount = myService.getSupportListCount(id);
		
		int pageListLimit = 5; // 페이징 개수 
		int maxPage = (listCount / listLimit) + (listCount % listLimit > 0 ? 1 : 0);
		
		if(maxPage == 0) {
			maxPage = 1;
		}
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1;
		System.out.println("maxPage = " + maxPage);
		int endPage = startPage + pageListLimit - 1;
		
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		
		if(pageNum < 1 || pageNum > maxPage) {
			model.addAttribute("msg", "해당 페이지는 존재하지 않습니다!");
			model.addAttribute("targetURL", "MySupport?pageNum=1");
			return "result/fail";
		}
		PageInfo pageInfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage);
		
		// Model 객체에 페이징 정보 저장
		model.addAttribute("pageInfo", pageInfo);
		
		// 게시물 목록 조회
		List<SupportBoardVO> supportList = myService.getSupportListToAdm(startRow, listLimit);
		
		
		// 첨부파일 정보 저장
		for(SupportBoardVO support : supportList) {
			String originalFileName = "";
			
			if(support.getSupport_file1() != null) {
				originalFileName = support.getSupport_file1().substring(support.getSupport_file1().indexOf("_") + 1);
			} else {
				originalFileName = null;
			}
			
			support.setOriginal_file1(originalFileName);
		}
		
		System.out.println(supportList);
		
		model.addAttribute("supportList", supportList);
		
		return "admin/support_management2";
	}
	
	// 관리자 1:1 문의 답변 작성/수정(업데이트)
	@PostMapping("AdmSupportUpdate")
	public String admSupportUpdate(@RequestParam(defaultValue = "1") int pageNum, SupportBoardVO support, HttpServletRequest request, HttpSession session, Model model) {
		System.out.println("pageNum : " + pageNum);
		// 세션아이디 체크
		String id = (String)session.getAttribute("sId");
		if(id == null) {
			model.addAttribute("msg", "로그인 필수!\\n 로그인 페이지로 이동합니다!");
			model.addAttribute("targetURL", "MemberLogin");
			savePreviousUrl(request, session);
			
			return "result/fail";
		}
		
		int updateCount = myService.answerSupport(support);
		
		if(updateCount > 0) {
			return "redirect:/AdmSupport?pageNum=" + pageNum;
		} else {
			model.addAttribute("msg", "수정 실패!");
			return "result/fail";
		}
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
	
	// 관리자 - 강의 문의
	
	
	
	// =======================================================================
	// 페이지 정보 저장
	public PageInfo pageInfoMethod(int pageNum, int listLimit, int listCount , int pageListLimit) {
		int startRow = (pageNum - 1) * listLimit;
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0);
		if (maxPage == 0) {
			maxPage = 1;
		}
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1;
		int endPage = startPage + pageListLimit - 1;
		if (endPage > maxPage) {
			endPage = maxPage;
		}
		PageInfo pageInfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage);
		return pageInfo;
	}
	
	// 이전 페이지 이동 저장
	private void savePreviousUrl(HttpServletRequest request, HttpSession session) {
		String prevURL = request.getServletPath();
		String queryString = request.getQueryString();
		
		if (queryString != null) {
			prevURL += "?" + queryString;
		}
		
		session.setAttribute("prevURL", prevURL);
	}
	
	
	
	
}
