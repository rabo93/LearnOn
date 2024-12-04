package com.itwillbs.learnon.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.itwillbs.learnon.service.AdminService;
import com.itwillbs.learnon.service.CouponService;
import com.itwillbs.learnon.service.CourseService;
import com.itwillbs.learnon.service.FaqService;
import com.itwillbs.learnon.service.MypageService;
import com.itwillbs.learnon.service.NoticeBoardService;
import com.itwillbs.learnon.vo.AdminVO;
import com.itwillbs.learnon.vo.CouponVO;
import com.itwillbs.learnon.vo.CourseSupportVO;
import com.itwillbs.learnon.vo.FaqVO;
import com.itwillbs.learnon.vo.MemberVO;
import com.itwillbs.learnon.vo.MyPaymentVO;
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
	@Autowired
	private CourseService courseService;
	
	
	
	private String uploadPath = "/resources/upload";
	
	// 어드민 메인페이지 매핑
	@GetMapping("AdmIndex")
	public String admin_home(HttpSession session, Model model) {
		//	로그인 ID 가져오기
		String id = (String)session.getAttribute("sId");
		//	로그인한 회원등급 가져오기
		String grade = (String)session.getAttribute("sGrade");
		if(id == null) {
			model.addAttribute("msg", "로그인이 필요합니다");
			model.addAttribute("targetURL", "MemberLogin");
			return "admin/fail";
		}
		if(grade.equals("MEM01")) {
			model.addAttribute("msg", "접근 권한이 없습니다");
			model.addAttribute("targetURL", "/");
			return "admin/fail";
		}
		if(grade.equals("MEM02")) {
			
			return "admin/index_instructor";
		}
		//	오늘 날짜 불러오기
		LocalDate today = LocalDate.now();
		//	통계를 위한 날짜구하기 - 4일전 날짜 계산
		LocalDate fiveDaysAgo = today.minusDays(4);
		//	통계를 위한 해당 주의 월요일 구하기
		LocalDate mondayWeek = today.minusDays(today.getDayOfWeek().getValue() - 1);
		//	3주 전의 월요일
		LocalDate fourWeekAgo = mondayWeek.minusWeeks(3);
		//	년-월-일 형식으로 포맷
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		//	날짜별 매출합을 담기위한 List 생성
		List<Integer> payFiveDayTotals = new ArrayList<>();
		//	주간별 매출합을 담기위한 List 생성
		List<Integer> payFourWeekTotals = new ArrayList<>();
		
		//	요일별 매출
		for (int i = 0; i <= 4; i++) {
			//	5일 전부터 차례대로 1일씩 증가
			LocalDate date = fiveDaysAgo.plusDays(i);
			//	포맷한 형식 넣기
			String formattedDate = date.format(formatter);
			//	날짜 별 매출 합 조회
			int payTotalForDay = adminService.getTodayPayTotal(formattedDate);
			//	List에 하나씩 add
			payFiveDayTotals.add(payTotalForDay);
		}
		
		//	주간별 매출
		for (int i = 0; i <= 3; i++) {
			//	3주 전부터 차례대로 1주씩 증가
			LocalDate startOfWeek = fourWeekAgo.plusWeeks(i);
			//	포맷한 형식 넣기
			String formattedDate = startOfWeek.format(formatter);
			//	각 주별 매출 합 조회
			int payTotalFourWeek = adminService.getWeekPayTotal(formattedDate);
			//	List에 하나씩 add
			payFourWeekTotals.add(payTotalFourWeek);
		}
		
		//	오늘날짜에 포맷한 형식 넣기
		String formattedDate = today.format(formatter);
		//	일반 회원 수 조회
		int nomalMemberCount = adminService.getNomalMemberCount();
		//	강사 회원 수 조회
		int instrucMemberCount = adminService.getInstrucMemberCount();
		//	오늘 결제된 매출 조회
		int todayPayTotal = adminService.getTodayPayTotal(formattedDate);
		//	주간 총 매출 조회
		int weekPayTotal = adminService.getWeekPayTotal(formattedDate);
		
		//	일반회원
		model.addAttribute("nomalMemberCount", nomalMemberCount);
		//	강사회원
		model.addAttribute("instrucMemberCount", instrucMemberCount);
		//	오늘 매출
		model.addAttribute("todayPayTotal", todayPayTotal);
		//	주간 매출
		model.addAttribute("weekPayTotal", weekPayTotal);
		//	5일 각각의 매출
		model.addAttribute("payFiveDayTotals", payFiveDayTotals);
		//	4주 각각의 매출
		model.addAttribute("payFourWeekTotals", payFourWeekTotals);
		return "admin/index";
		
	}
	// ======================================================================================================
	
	// 어드민 카테고리 편집 페이지 매핑
	@GetMapping("AdmClassCategory")
	public String admin_class_categoryModify(Model model, HttpSession session) {
		//	로그인 ID 가져오기
		String id = (String)session.getAttribute("sId");
		//	로그인한 회원등급 가져오기
		String grade = (String)session.getAttribute("sGrade");
		if(id == null) {
			model.addAttribute("msg", "로그인이 필요합니다");
			model.addAttribute("targetURL", "MemberLogin");
			return "admin/fail";
		}
		if(grade.equals("MEM01") || grade.equals("MEM02")) {
			model.addAttribute("msg", "접근 권한이 없습니다");
			model.addAttribute("targetURL", "/");
			return "admin/fail";
		}
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
	public String admin_class_add(Model model, HttpSession session) {
		//		로그인 ID 가져오기
		String id = (String)session.getAttribute("sId");
		//	로그인한 회원등급 가져오기
		String grade = (String)session.getAttribute("sGrade");
		if(id == null) {
			model.addAttribute("msg", "로그인이 필요합니다");
			model.addAttribute("targetURL", "MemberLogin");
			return "admin/fail";
		}
		if(grade.equals("MEM01")) {
			model.addAttribute("msg", "접근 권한이 없습니다");
			model.addAttribute("targetURL", "/");
			return "admin/fail";
		}
		model.addAttribute("getMainCate", adminService.getMainCate());
		model.addAttribute("getInstructor", adminService.getInstructor());
		return "admin/class_add";
	}
	
	@PostMapping("AdmClassAdd")
	public String admin_class_add1(AdminVO VO, HttpSession session, Model model) {
		int classId = adminService.getClassId();
		VO.setClass_id(classId);
		// 커리큘럼 내용 가져오기
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
			adminService.insertCurriculum(VO);
			
			adminService.insertCurVideo(VO);
		}
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
	
	// 클래스 썸네일 첨부파일 난수 이름 설정
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
	
	// 클래스 커리큘럼 영상 첨부파일 난수 이름 설정
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
	
	// 서브카테고리 조회 & 설정
	@ResponseBody
	@GetMapping("SelectCategory")
	public String selectCategory(AdminVO admin) {
//		System.out.println("=========================================================" + admin);
		List<Map<String, Object>> adminArr = adminService.selectSubCate(admin);
		JSONArray joArr = new JSONArray(adminArr);
		
		return joArr.toString();
	}
	
	
	// 어드민 클래스 목록 페이지 매핑
	@GetMapping("AdmClassList")
	public String admin_class_list(Model model, HttpSession session) {
		//	로그인 ID 가져오기
		String id = (String)session.getAttribute("sId");
		//	로그인한 회원등급 가져오기
		String grade = (String)session.getAttribute("sGrade");
		if(id == null) {
			model.addAttribute("msg", "로그인이 필요합니다");
			model.addAttribute("targetURL", "MemberLogin");
			return "admin/fail";
		}
		if(grade.equals("MEM01") || grade.equals("MEM02")) {
			model.addAttribute("msg", "접근 권한이 없습니다");
			model.addAttribute("targetURL", "/");
			return "admin/fail";
		}
		model.addAttribute("getClassList", adminService.getClassList());
		
		return "admin/class_list";
	}
	
	// 어드민 클래스 수정 페이지 매핑
	@GetMapping("AdmClassListModify")
	public String admin_class_list_modi(int class_id, Model model) {
		AdminVO classLoad = adminService.getClass(class_id);
		
		model.addAttribute("getClass", classLoad);
		model.addAttribute("getMainCate", adminService.getMainCate());
		model.addAttribute("getCurriculum", adminService.getCurriculum(class_id));
		model.addAttribute("getInstructor", adminService.getInstructor());
		
		if (classLoad == null) {
			model.addAttribute("msg", "클래스 불러오기 실패!");
			return "admin/fail";
		} else {
			return "admin/class_list_modify";
		}
	}
	
	// 어드민 클래스 수정 로직
	@PostMapping("AdmClassListModify")
	public String adm_class_modify(int class_id, AdminVO adm,  HttpSession session, Model model) {
		
		AdminVO classInfo = adminService.getIdClass(class_id);
		List<Map<String, Object>> curList = adminService.getCurriculum(class_id);
		
		// 커리큘럼 내용 가져오기
		System.out.println("============================================================" + adm.getCur_title());
		String[] arrCurTitle = adm.getCur_title().split(",");
		String[] arrCurRunTime = adm.getCur_runtime().split(",");
		
		int totalRunTime = adm.getClass_runtime();
		
		String realPath = getRealPath(session);
		String subDir = createDirectories(class_id, realPath);
		String delRealPath = session.getServletContext().getRealPath(uploadPath);
		realPath += "/" + subDir;
		
		// 커리큘럼 업데이트 for
		for (int i = 0; i < arrCurTitle.length; i++) {
			String videoName = addVideoProcess(adm.getCur_video_get()[i], realPath, subDir);
			if (videoName.equals("")) {
				adm.setCur_video(classInfo.getCur_video());
			} else {
				adm.setCur_video(videoName);
			}
			adm.setCur_id(Integer.parseInt(curList.get(i).get("CUR_ID").toString()));
			adm.setCur_title(arrCurTitle[i]);
			adm.setCur_runtime(arrCurRunTime[i]);
			totalRunTime += Integer.parseInt(arrCurRunTime[i]);
			adminService.updateCurriculum(adm);
		}
		
		adm.setClass_runtime(totalRunTime);
		
		// 첨부파일 업로드
		String fileName = addFileProcess(adm, realPath, subDir);
		
		if (fileName.equals("")) {
			adm.setClass_pic1(classInfo.getClass_pic1());
		} else {
			adm.setClass_pic1(fileName);
			Path picPath = Paths.get(delRealPath, classInfo.getClass_pic1());
			try {
				Files.deleteIfExists(picPath);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		int updateCount = adminService.updateClass(adm);
		
		if (updateCount < 0) {
			model.addAttribute("msg", "클래스 수정 실패!");
			return "admin/fail";
		}
		
		return "redirect:/AdmClassList";
	}

	// 클래스 삭제 페이징
	@GetMapping("AdmClassListDelete")
	public String admin_class_list_delete(int class_id, Model model, HttpSession session) {
		
		AdminVO classIndex = adminService.getIdClass(class_id);
		List<Map<String, Object>> curIndex = adminService.getCurriculum(class_id);
		String realPath = session.getServletContext().getRealPath(uploadPath);
		
		// 썸네일 실제 파일 삭제
		if(!(classIndex.getClass_pic1() == null)) {
			Path picPath = Paths.get(realPath, classIndex.getClass_pic1());
			try {
				Files.deleteIfExists(picPath);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		// 커리큘럼 실제 파일 삭제
		if (!(curIndex.get(0).get("CUR_VIDEO") == null)) {
			for (int i = 0; i < curIndex.size(); i++) {
				if (curIndex.get(i).get("CUR_VIDEO") == null) {
					break;
				}
				Path curPath = Paths.get(realPath, curIndex.get(i).get("CUR_VIDEO").toString());
				try {
					Files.deleteIfExists(curPath);
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
			
		int deleteCount = adminService.deleteClass(class_id);
		int deleteCurriculum = adminService.deleteCurriculum(class_id);
		if (deleteCount < 0 || deleteCurriculum < 0) {
			model.addAttribute("msg", "클래스 삭제 실패하였습니다");
			return "admin/fail";
		}
		
		for (int i = 0; i < curIndex.size(); i++) {
			Object cur_id = curIndex.get(i).get("CUR_ID");
			int deleteCurHistory = adminService.deleteCurHistory(cur_id);
			if (deleteCurHistory < 0) {
				model.addAttribute("msg", "클래스 삭제 실패하였습니다");
				return "admin/fail";
			}
		}
		
		return "redirect:/AdmClassList";
	}
	
	// ======================================================================================================
	
	// 어드민 회원 목록 페이지 매핑
	@GetMapping("AdmMemList")
	public String admin_member_list(@RequestParam(defaultValue = "1") int pageNum,
									@RequestParam(defaultValue = "reg_latest") String sort,
									@RequestParam(defaultValue = "") String searchKeyword,
									@RequestParam(defaultValue = "") String searchType,
									HttpSession session,
									Model model) {
		//	로그인 ID 가져오기
		String id = (String)session.getAttribute("sId");
		//	로그인한 회원등급 가져오기
		String grade = (String)session.getAttribute("sGrade");
		if(id == null) {
			model.addAttribute("msg", "로그인이 필요합니다");
			model.addAttribute("targetURL", "MemberLogin");
			return "admin/fail";
		}
		if(grade.equals("MEM01") || grade.equals("MEM02")) {
			model.addAttribute("msg", "접근 권한이 없습니다");
			model.addAttribute("targetURL", "/");
			return "admin/fail";
		}
		
		int listLimit = 10;
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
		List<MemberVO> memberList = adminService.getNomalMemberList(startRow, listLimit, searchKeyword, searchType, sort);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("getMemberList", memberList);
		model.addAttribute("sort", sort);
		return "admin/member_list";
	}
	
	// 어드민 강사 회원 목록 페이지 매핑
	@GetMapping("AdmMemInstructor")
	public String admin_member_list_instructor(@RequestParam(defaultValue = "") String searchKeyword,
											   @RequestParam(defaultValue = "allMember") String sort,
											   Model model,
											   HttpSession session) {
		//	로그인 ID 가져오기
		String id = (String)session.getAttribute("sId");
		//	로그인한 회원등급 가져오기
		String grade = (String)session.getAttribute("sGrade");
		if(id == null) {
			model.addAttribute("msg", "로그인이 필요합니다");
			model.addAttribute("targetURL", "MemberLogin");
			return "admin/fail";
		}
		if(grade.equals("MEM01") || grade.equals("MEM02")) {
			model.addAttribute("msg", "접근 권한이 없습니다");
			model.addAttribute("targetURL", "/");
			return "admin/fail";
		}
		model.addAttribute("getMemberList", adminService.getInstructorMemberList(searchKeyword, sort));
		return "admin/member_list_instructor";
	}
	
	// 어드민 탈퇴한 회원 목록 페이지 매핑
	@GetMapping("AdmMemListDelete")
	public String admin_member_list_delete(Model model, HttpSession session) {
		//	로그인 ID 가져오기
		String id = (String)session.getAttribute("sId");
		//	로그인한 회원등급 가져오기
		String grade = (String)session.getAttribute("sGrade");
		if(id == null) {
			model.addAttribute("msg", "로그인이 필요합니다");
			model.addAttribute("targetURL", "MemberLogin");
			return "admin/fail";
		}
		if(grade.equals("MEM01") || grade.equals("MEM02")) {
			model.addAttribute("msg", "접근 권한이 없습니다");
			model.addAttribute("targetURL", "/");
			return "admin/fail";
		}
		model.addAttribute("getMemberList", adminService.getWithdrawMemberList());
		return "admin/member_list_delete";
	}
	
	//	어드민 회원정보 수정
	@GetMapping("AdmMemberModify")
	public String admMemberModifyForm(String mem_id, Model model, HttpSession session) {
		//	로그인 ID 가져오기
		String id = (String)session.getAttribute("sId");
		//	로그인한 회원등급 가져오기
		String grade = (String)session.getAttribute("sGrade");
		if(id == null) {
			model.addAttribute("msg", "로그인이 필요합니다");
			model.addAttribute("targetURL", "MemberLogin");
			return "admin/fail";
		}
		if(grade.equals("MEM01") || grade.equals("MEM02")) {
			model.addAttribute("msg", "접근 권한이 없습니다");
			model.addAttribute("targetURL", "/");
			return "admin/fail";
		}
		MemberVO member = adminService.getMemberList(mem_id);
		model.addAttribute("member", member);
		return "admin/member_modify_form";
	}
	
	//	어드민 회원정보 수정
	@PostMapping("AdmMemberModify")
	public String admMemberModify(@RequestParam Map<String, Object> map, Model model) {
		int updateCount = adminService.modifyMember(map);
		if (updateCount < 0) {
			model.addAttribute("msg", "수정에 실패했습니다");
			return "admin/fail";
		}
		return "redirect:/AdmMemList";
	}
	//	어드민 회원 삭제
	@GetMapping("AdminMemberDelete")
	public String adminMemberDelete(String[] mem_ids, Model model) {
		for(String mem_id : mem_ids) {
			int deleteCount = adminService.removeMember(mem_id);
			if(deleteCount < 0) {
				model.addAttribute("msg", "회원 삭제 실패");
				return "result/fail";
			}
		}
		return "redirect:/AdmMemList";
	}
	
	//	어드민 강사회원 승인
	@GetMapping("AdmMemGradeChange")
	public String admMemGradeChange(String mem_id, Model model) {
		//	mem_id 파라미터로 받아와서 memberVO 에 저장
		MemberVO member = adminService.getMemberList(mem_id);
		//	MemberVO를 통해서 MEM_GRADE 여부에 따라 업데이트 처리
		//	ex) MEM_GRADE = 'MEM01'일 시 'MEM02'로 업데이트
		//	ex) MEM_GRADE = 'MEM02'일 시 'MEM01'로 업데이트
		int updateCount = adminService.changeGradeMember(member);
		if (updateCount < 0) {
			model.addAttribute("msg", "회원 등급 변경 실패");
			return "result/fail";
		}
		
		return "redirect:/AdmMemInstructor";
	}
	
	//	어드민 회원등급 변경
	@ResponseBody
	@PostMapping("AdmChangeMemGrade")
	public String admChangeMemGrade(@RequestParam Map<String, String> map) {
		adminService.changeAllGradeMember(map);
//		
		String mem_grade = "";
		switch (map.get("mem_grade")) {
		case "MEM01": mem_grade = "일반회원";break;
		case "MEM02": mem_grade = "강사회원";break;
		case "MEM03": mem_grade = "관리자";break;
		}
		
		JSONObject json = new JSONObject();
		json.put("mem_id", map.get("mem_id"));
		json.put("mem_grade", mem_grade);
		
		
		return json.toString();
	}
	
	//	어드민 회원상태 변경
	@ResponseBody
	@PostMapping("AdmChangeMemStatus")
	public String admChangeMemStatus(@RequestParam Map<String, String> map) {
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
		
		
		return json.toString();
	}
	
	
	// =======================================================================
	
	// 어드민 결제 내역 관리 페이지 매핑
	@GetMapping("AdmPayList")
	public String admin_payment_list(@RequestParam(defaultValue = "1") int pageNum, Model model) {
		
		int listLimit = 10;
		int startRow = (pageNum - 1) * listLimit;
		
		int listCount = adminService.getPaymentListCount();
		
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
			model.addAttribute("targetURL", "AdmPayList?pageNum=1");
			return "result/fail";
		}
		
		// 페이지 정보
		PageInfo pageInfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage);
		
		// 결제내역
		Map<String, List<MyPaymentVO>> paymentList = adminService.getMyPaymentListToAdm(startRow, listLimit);
		
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("pageInfo", pageInfo);
		
		model.addAttribute("paymentList", paymentList);
		
		return "admin/payment_list";
	}
	
	// 어드민 쿠폰 관리 페이지 매핑
	@GetMapping("AdmPayListCoupon")
	public String admin_payment_list_coupon(@RequestParam(defaultValue = "1") int pageNum,
			  								@RequestParam(defaultValue = "latest") String sort,
			  								@RequestParam(defaultValue = "") String searchKeyword,
			  								@RequestParam(defaultValue = "") String searchType,
			  								HttpSession session,
			  								Model model) {
		//	로그인 ID 가져오기
		String id = (String)session.getAttribute("sId");
		//	로그인한 회원등급 가져오기
		String grade = (String)session.getAttribute("sGrade");
		if(id == null) {
			model.addAttribute("msg", "로그인이 필요합니다");
			model.addAttribute("targetURL", "MemberLogin");
			return "admin/fail";
		}
		if(grade.equals("MEM01") || grade.equals("MEM02")) {
			model.addAttribute("msg", "접근 권한이 없습니다");
			model.addAttribute("targetURL", "/");
			return "admin/fail";
		}
		
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
	public String admCouponWriteForm (HttpSession session, Model model) {
		//	로그인 ID 가져오기
		String id = (String)session.getAttribute("sId");
		//	로그인한 회원등급 가져오기
		String grade = (String)session.getAttribute("sGrade");
		if(id == null) {
			model.addAttribute("msg", "로그인이 필요합니다");
			model.addAttribute("targetURL", "MemberLogin");
			return "admin/fail";
		}
		if(grade.equals("MEM01") || grade.equals("MEM02")) {
			model.addAttribute("msg", "접근 권한이 없습니다");
			model.addAttribute("targetURL", "/");
			return "admin/fail";
		}
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
			//	CouponInfo(쿠폰정보)에서 삭제
			int deleteCount = couponService.removeCoupon(coupon.getCoupon_id());
			//	MyCoupon(가지고있는 쿠폰)에서 삭제
			int deleteCount2 = couponService.removeMyCoupon(coupon.getCoupon_id());
			if (deleteCount < 0) {
				model.addAttribute("msg", "삭제 실패");
				return "result/fail";
			}
			if (deleteCount2 < 0) {
				model.addAttribute("msg", "삭제 실패");
				return "result/fail";
			}
		}
		return "redirect:/AdmPayListCoupon";
	}
	
	@GetMapping("AdmCouponModify")
	public String admCouponModifyForm(int coupon_id, Model model, HttpSession session) {
		//	로그인 ID 가져오기
		String id = (String)session.getAttribute("sId");
		//	로그인한 회원등급 가져오기
		String grade = (String)session.getAttribute("sGrade");
		if(id == null) {
			model.addAttribute("msg", "로그인이 필요합니다");
			model.addAttribute("targetURL", "MemberLogin");
			return "admin/fail";
		}
		if(grade.equals("MEM01") || grade.equals("MEM02")) {
			model.addAttribute("msg", "접근 권한이 없습니다");
			model.addAttribute("targetURL", "/");
			return "admin/fail";
		}
		CouponVO coupon = couponService.getIdxCoupon(coupon_id);
		model.addAttribute("coupon", coupon);
		return "admin/coupon_modify_form";
	}
	
	@PostMapping("AdmCouponModify")
	public String admCouponModify(CouponVO coupon, Model model) {
		int updateCount = couponService.modifyCouponInfo(coupon);
		if(updateCount < 0) {
			model.addAttribute("msg", "수정에 실패했습니다");
			return "result/fail";
		}
		int updateCount2 = couponService.changeStatus(coupon);
		if(updateCount2 < 0) {
			model.addAttribute("msg", "수정에 실패했습니다");
			return "result/fail";
		}
		return "redirect:/AdmPayListCoupon";
	}
	
	//	쿠폰 발급 페이지
	@GetMapping("AdmCouponIssue")
	public String admCouponIssue(@RequestParam(defaultValue = "1") int pageNum,
								 @RequestParam(defaultValue = "latest") String sort,
								 @RequestParam(defaultValue = "") String searchKeyword,
								 @RequestParam(defaultValue = "") String searchType,
								 HttpSession session,
								 Model model) {
		
		//	로그인 ID 가져오기
		String id = (String)session.getAttribute("sId");
		//	로그인한 회원등급 가져오기
		String grade = (String)session.getAttribute("sGrade");
		if(id == null) {
			model.addAttribute("msg", "로그인이 필요합니다");
			model.addAttribute("targetURL", "MemberLogin");
			return "admin/fail";
		}
		if(grade.equals("MEM01") || grade.equals("MEM02")) {
			model.addAttribute("msg", "접근 권한이 없습니다");
			model.addAttribute("targetURL", "/");
			return "admin/fail";
		}
		
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
		
		
		return "admin/payment_coupon_issue";
	}
	
	//	쿠폰 발급
	@PostMapping("AdmCouponIssue")
	public String admCouponIssue(int coupon_id, String[] mem_ids, Model model) {
		
		for(String mem_id : mem_ids) {
			int insertCount = adminService.issueCoupon(coupon_id, mem_id);
			if (insertCount < 0) {
				model.addAttribute("msg", "쿠폰발급에 실패했습니다");
				return "result/fail";
			}
		}
		
		return "redirect:/AdmCouponIssue";
	}
	
	//	어드민 쿠폰발급 AJAX
	@PostMapping("AdmShowCouponMembers")
	@ResponseBody
	public List<MemberVO> admShowCouponMembers(int coupon_id) {
		
		List<MemberVO> memberList = adminService.getMyCoupon(coupon_id);
		
		return memberList;
	}
	
	
	// =======================================================================
	
	// 어드민 공지사항 관리 페이지 매핑
	@GetMapping("AdmNotice")
	public String admin_notice_management(@RequestParam(defaultValue = "1") int pageNum,
										  @RequestParam(defaultValue = "latest") String sort,
										  @RequestParam(defaultValue = "") String searchKeyword,
										  @RequestParam(defaultValue = "") String searchType,
										  HttpSession session,
										  Model model) {
		
		//	로그인 ID 가져오기
		String id = (String)session.getAttribute("sId");
		//	로그인한 회원등급 가져오기
		String grade = (String)session.getAttribute("sGrade");
		if(id == null) {
			model.addAttribute("msg", "로그인이 필요합니다");
			model.addAttribute("targetURL", "MemberLogin");
			return "admin/fail";
		}
		if(grade.equals("MEM01") || grade.equals("MEM02")) {
			model.addAttribute("msg", "접근 권한이 없습니다");
			model.addAttribute("targetURL", "/");
			return "admin/fail";
		}
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
		int listCount = adminService.getSupportListCountToAdm();
		
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
			model.addAttribute("targetURL", "AdmSupport?pageNum=1");
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
			  					  HttpSession session,
			  					  Model model) {
		//	로그인 ID 가져오기
		String id = (String)session.getAttribute("sId");
		//	로그인한 회원등급 가져오기
		String grade = (String)session.getAttribute("sGrade");
		if(id == null) {
			model.addAttribute("msg", "로그인이 필요합니다");
			model.addAttribute("targetURL", "MemberLogin");
			return "admin/fail";
		}
		if(grade.equals("MEM01") || grade.equals("MEM02")) {
			model.addAttribute("msg", "접근 권한이 없습니다");
			model.addAttribute("targetURL", "/");
			return "admin/fail";
		}
		
		
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
	
	// 관리자 - 강의 별 문의 게시판 목록 
	@GetMapping("AdmCourseSupport")
	public String admCourseSupport(@RequestParam(defaultValue = "1") int pageNum, HttpServletRequest request, HttpSession session, Model model) {
		// 세션아이디 체크
//		String id = (String)session.getAttribute("sId");
//		if(id == null) {
//			model.addAttribute("msg", "로그인 필수!\\n 로그인 페이지로 이동합니다!");
//			model.addAttribute("targetURL", "MemberLogin");
//			savePreviousUrl(request, session);
//			
//			return "result/fail";
//		}
		
		// 페이징 설정
		int listLimit = 10; // 한 페이지당 게시물 수
		int startRow = (pageNum - 1) * listLimit;
		int listCount = courseService.getCourseSupportListCount(0);
		
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
			model.addAttribute("targetURL", "AdmCourseSupport?pageNum=1");
			return "result/fail";
		}
		PageInfo pageInfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage);
		
		// Model 객체에 페이징 정보 저장
		model.addAttribute("pageInfo", pageInfo);
		
		// 게시물 목록 조회
		List<CourseSupportVO> courseSupportList = adminService.getCourserSupportListToAdm(startRow, listLimit);
		
		
		// 첨부파일 정보 저장
//		for(CourseSupportVO cSupport : courseSupportList) {
//			String originalFileName = "";
//			
//			if(cSupport.getC_support_file() != null) {
//				originalFileName = cSupport.getC_support_file().substring(cSupport.getC_support_file().indexOf("_") + 1);
//			} else {
//				originalFileName = null;
//			}
			
//			cSupport.setC_support_file(originalFileName);
//		}
		
		System.out.println(courseSupportList);
		
		model.addAttribute("courseSupportList", courseSupportList);
		
		return "admin/course_support_list";
	}
	
	// 관리자 - 강의 문의 답변 작성/수정(업데이트)
	@PostMapping("AdmCourseSupportUpdate")
	public String admCourseSupportUpdate(@RequestParam(defaultValue = "1") int pageNum, CourseSupportVO cSupport, HttpServletRequest request, HttpSession session, Model model) {
		System.out.println("pageNum : " + pageNum);
		// 세션아이디 체크
//		String id = (String)session.getAttribute("sId");
//		if(id == null) {
//			model.addAttribute("msg", "로그인 필수!\\n 로그인 페이지로 이동합니다!");
//			model.addAttribute("targetURL", "MemberLogin");
//			savePreviousUrl(request, session);
//			
//			return "result/fail";
//		}
		
		int updateCount = adminService.answerSupport(cSupport);
		
		if(updateCount > 0) {
			return "redirect:/AdmCourseSupport?pageNum=" + pageNum;
		} else {
			model.addAttribute("msg", "수정 실패!");
			return "result/fail";
		}
	}
	
	
	
	// =======================================================================
	// 페이지 정보 저장
	public PageInfo pageInfoMethod(int pageNum, int listLimit, int listCount , int pageListLimit) {
//		int startRow = (pageNum - 1) * listLimit;
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
