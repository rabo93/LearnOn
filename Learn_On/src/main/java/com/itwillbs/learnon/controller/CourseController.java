package com.itwillbs.learnon.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.stream.Collectors;

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

import com.itwillbs.learnon.service.CourseService;
import com.itwillbs.learnon.service.MemberService;
import com.itwillbs.learnon.service.MypageService;
import com.itwillbs.learnon.vo.CommonCodeTypeVO;
import com.itwillbs.learnon.vo.CourseSupportVO;
import com.itwillbs.learnon.vo.CourseVO;
import com.itwillbs.learnon.vo.MemberVO;
import com.itwillbs.learnon.vo.MyReviewVO;
import com.itwillbs.learnon.vo.NoticeBoardVO;
import com.itwillbs.learnon.vo.PageInfo;
import com.itwillbs.learnon.vo.WishlistVO;

import netscape.javascript.JSObject;

@Controller
public class CourseController {
	@Autowired
	CourseService courseService;
	@Autowired
	MemberService memberService;
	@Autowired
	MypageService myService;
	
	
	// 이클립스 상의 가상의 업로드 경로명 저장(프로젝트 상에서 보이는 경ㅇ로)
	private String uploadPath = "/resources/upload";

	@ResponseBody
	@GetMapping("TopMenu")
	public String topMenu (Model model) {
//		List<CommonCodeTypeVO> codeTypeAll = courseService.getCodeTypeAll();
//		List<CommonCodeTypeVO> commonCode = courseService.getCommonCode();
//
//		model.addAttribute("commonCode", commonCode);
//		model.addAttribute("codeTypeAll", codeTypeAll);
		
//		return "inc/top";
		// =========================================
		List<Map<String, String>> menuList = courseService.getMenuList();
//		System.out.println(menuList);
		JSONArray jo = new JSONArray(menuList);
		
		return jo.toString();
	}
	
	
	@GetMapping("Category")
	public String courseList(CourseVO course 
							,@RequestParam(defaultValue = "") String searchType
							, HttpSession session
							, HttpServletRequest request
							, Model model) {
		String id = (String)session.getAttribute("sId");
		
		List<CommonCodeTypeVO> codeType = courseService.getCodeType(course.getCodetype());
		List<CourseVO> courseList = courseService.getCourseList(course, searchType);
		List<CommonCodeTypeVO> codeTypeAll = courseService.getCodeTypeAll();
		List<CommonCodeTypeVO> commonCode = courseService.getCommonCode();
		
		// 관심목록 조회
		List<Map<String, Object>> wishList = myService.getWishlistForCategoryList(id);
		JSONArray jsonToWishList = new JSONArray(wishList);
		System.out.println("jsonToWishList : " + jsonToWishList);
		model.addAttribute("wishList", jsonToWishList);

		model.addAttribute("commonCode", commonCode);
		model.addAttribute("codeTypeAll", codeTypeAll);
		
		model.addAttribute("courseList", courseList);	
		model.addAttribute("codeType", codeType);
		
		// 현재페이지 prevURL로 저장
		String prevURL = request.getServletPath();
		String queryString = request.getQueryString();
		if(queryString != null) {
			prevURL += "?" + queryString;
		} 
		session.setAttribute("prevURL", prevURL);
		
		return "course/course_list"; 
	}
	
	@GetMapping("CourseDetail")
	public String courseDetail(
				@RequestParam(defaultValue = "1") int pageNum,
				int class_id, 
				Model model) {
		List<CourseVO> course = courseService.getCourse(class_id);
		List<MyReviewVO> myReviewList = courseService.getReviewList(class_id);
		
		List<CommonCodeTypeVO> codeTypeAll = courseService.getCodeTypeAll();
		List<CommonCodeTypeVO> commonCode = courseService.getCommonCode();

		// [ 페이징 처리 ]		
		int startRow = (pageNum - 1) * paging(pageNum).getPageListLimit();
		if(pageNum < 1 || pageNum > paging(pageNum).getMaxPage()) {
			model.addAttribute("msg", "해당 페이지는 존재하지 않습니다!");
			model.addAttribute("targetURL", "CourseDetail?pageNum=1");
			return "result/fail";
		}
		// 페이징 처리한 문의사항 항목가져옴. 
		List<CourseSupportVO> courseSupportList = courseService.getCourseSupportList(class_id, startRow, paging(pageNum).getPageListLimit());

		// -------------------------------------------------------------------
		// Model 객체에 페이징 정보 저장
		model.addAttribute("pageInfo", paging(pageNum));
		// -------------------------------------------------------------------
		
		model.addAttribute("commonCode", commonCode);
		model.addAttribute("codeTypeAll", codeTypeAll);
		model.addAttribute("course", course);
		model.addAttribute("myReview", myReviewList);
		
		
		model.addAttribute("courseSupportList", courseSupportList);
		
		return "course/course_detail";
	}
	
	
	@GetMapping("CourseSupport")
	public String courseSupportWriteForm(HttpSession session, Model model, HttpServletRequest request) {
		String id = (String)session.getAttribute("sId");
		if(id == null) {
			model.addAttribute("msg", "로그인 필수!\\n로그인 페이지로 이동합니다.");
			model.addAttribute("targetURL", "MemberLogin");
			
			String prevURL = request.getServletPath();
			String queryString = request.getQueryString();
			System.out.println("prevURL: " + prevURL);
			System.out.println("요청 파라미터: " + request.getQueryString());
			
			if(queryString != null) {
				prevURL += "?" + queryString;
			} 
			
			session.setAttribute("prevURL", prevURL);
			return "result/fail";
		}
		return "course/course_support_write_form";
	}
	
	@PostMapping("CourseSupportWrite") 
	public String courseSupportWrite(CourseSupportVO cSupport, 
			int class_id,
			@RequestParam(defaultValue = "1") String pageNum,
			HttpSession session, 
			Model model) {
		String id = (String)session.getAttribute("sId");
		cSupport.setMem_id(id);
		cSupport.setC_class_id(class_id);

		// --------------------------------------------------------
		// [ 답글등록 과정에서 파일 업로드 처리 ]
		String realPath = session.getServletContext().getRealPath(uploadPath); // request대신 session을 써도 똑같은 메서드가 존재함.
		String subDir = "";// 서브 디렉토리명을 저장할 변수 선언
		LocalDate today = LocalDate.now();//현재 시스템의 날짜 정보 생성
		String datePattern ="yyyy/MM/dd"; // 날짜 포맷 변경에 사용할 패턴 문자열 지정
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern(datePattern);
		subDir = today.format(dtf);  // LocalDate - DateTimeFormatter
		realPath += "/" + subDir;
		
		try {
			Path path = Paths.get(realPath); // 파라미터로 실제 업로드 경로전달
			Files.createDirectories(path); // IOException 예외 처리 필요(임시로 현재 클래스에서 처리) - 이거쓰면 그냥 10월29일 날짜 폴더 만들어져 있으면 알아서 안만든다. exist*() 메서드로 폴더있나 없나 확인안해도 됨.
		} catch(Exception e) {
			e.printStackTrace();
		}
		// ------------------------------------
		// [업로드 되는 실제 파일 처리]
		// 실제 파일은 BoardVO 객체의 MultipartFile 타입 객체로 관리함(멤버변수명 fileXXX)
		MultipartFile mFile1 = cSupport.getFile(); 
		cSupport.setC_support_file("");
		
		String fileName1 = "";
		
		// 업로드 파일명이 널스트링이 아닐 경우를 판별하여 파일명 저장
		if(!mFile1.getOriginalFilename().equals("")) {
			fileName1 = UUID.randomUUID().toString().substring(0, 8) + "_" + mFile1.getOriginalFilename();
			cSupport.setC_support_file(fileName1);
		}
		
		//----------------------------
		 // BoradService - registReplyBoard() 메서드 호출하여 게시물 등록 작업요청
		 // => 파라미터: BoardVO 객체, 리턴타입 : int(insrtCount)
		int insertCount = courseService.registCourseSupport(cSupport);
		if(insertCount > 0) { // 등록 성공
			
			model.addAttribute("class_id", class_id);
			return "redirect:/CourseDetail";
		} else {
			model.addAttribute("msg", "문의글쓰기실패");
			return "result/fail";
		}
	}
	
	@GetMapping("CourseSupportDetail")
	public String courseSupportDetail(
					int c_support_idx,
					int class_id,
					@RequestParam(defaultValue = "1") int pageNum,
					Model model) {

		CourseSupportVO courseSupport = courseService.getCourseSupport(c_support_idx);
		model.addAttribute("courseSupport", courseSupport);
		return "course/course_support_detail"; 
		
	}
	
	@GetMapping("CourseSupportModifyForm")
	public String courseSupportModifyForm(
			int c_support_idx,
			Model model) {
		CourseSupportVO courseSupport = courseService.getCourseSupport(c_support_idx);

		model.addAttribute("courseSupport", courseSupport);
		return "course/course_support_modify_form"; 
	}
	
	@PostMapping("CourseSupportModify")
	public String courseSupportModify(
			int c_support_idx,
			CourseSupportVO cSupport,
			@RequestParam(defaultValue = "1") int pageNum,
			Model model, HttpSession session, HttpServletRequest request
			) {
		
		
		String id = (String)session.getAttribute("sId");
		
		//		미 로그인 시
		if (id == null) {
			model.addAttribute("msg", "로그인이 필요합니다\\n로그인 페이지로 이동합니다.");
			model.addAttribute("targetURL", "MemberLogin");
			
			String prevURL = request.getServletPath();
			String queryString = request.getQueryString();
			System.out.println("prevURL : " + prevURL);
			System.out.println("queryString : " + queryString);
			
			if (queryString != null) {
				prevURL += "?" + queryString;
			}
			
			session.setAttribute("prevURL", prevURL);
			
			return "result/fail";
		}
		CourseSupportVO courseSupport = courseService.getCourseSupport(c_support_idx);
		if(id != courseSupport.getMem_id()) {
			model.addAttribute("msg", "수정 권한이 없습니다!");
			return "result/fail";
		}
		
	
		
		// 자기 아이디 아니면 로그인 안되도록
		cSupport.setC_support_idx(c_support_idx);
		
		
//		System.out.println("idx 번호 받아오나@$!@%#@%^@$^#    :   " + cSupport.getC_support_idx()); // 잘받아옴.
		
		
//		return "redirect:/BoardDetail?board_num=" + board.getBoard_num() + "&pageNum=" + pageNum;
//		@RequestParam(defaultValue = "1") int pageNum, int class_id, Model model) {
//		return "redirect:/CourseDetail?";
		
		return "";
	}
	
	
	
	public PageInfo paging(@RequestParam(defaultValue = "1") int pageNum) {
		// -------------------------------------------------------------------
		// [ 페이징 처리 ]
		int listLimit = 5; // 페이지 당 게시물 수
		int listCount = courseService.getCSupportListCount();
		int pageListLimit = 5; 
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0);
		if(maxPage == 0) {
			maxPage = 1;
		}
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1;
		int endPage = startPage + pageListLimit - 1;
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		// 페이징 정보 관리하는 PageInfo 객체 생성 및 계산 결과 저장
		PageInfo pageInfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage);
		return pageInfo;
	}
}
