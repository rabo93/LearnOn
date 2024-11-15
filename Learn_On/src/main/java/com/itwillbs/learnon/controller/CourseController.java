package com.itwillbs.learnon.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.learnon.service.CourseService;
import com.itwillbs.learnon.vo.CommonCodeTypeVO;
import com.itwillbs.learnon.vo.CourseSupportVO;
import com.itwillbs.learnon.vo.CourseVO;
import com.itwillbs.learnon.vo.MyReviewVO;

@Controller
public class CourseController {
	@Autowired
	CourseService courseService;
	
	@GetMapping("Category")
	public String courseList(CourseVO course 
							,@RequestParam(defaultValue = "") String searchType
							, Model model) {
		List<CommonCodeTypeVO> codeType = courseService.getCodeType(course.getCodetype());
		List<CourseVO> courseList = courseService.getCourseList(course, searchType);
		
		model.addAttribute("courseList", courseList);	
		model.addAttribute("codeType", codeType);
		return "course/course_list"; 
	}
	
	@GetMapping("CourseDetail")
	public String courseDetail(
				
				int class_id, 
				Model model) {
		List<CourseVO> course = courseService.getCourse(class_id);
		List<MyReviewVO> myReviewList = courseService.getReviewList(class_id);
		List<CourseSupportVO> courseSupportList = courseService.getCourseSupportList(class_id);
		
//		// -------------------------------------------------------------------
//		// [ 페이징 처리 ]
//		// 1. 페이징 처리를 위해 조회 목록 갯수 조절에 사용될 변수 선언 및 계산
//		int listLimit = 5; // 페이지 당 게시물 수
//		int startRow = (pageNum - 1) * listLimit; // 조회할 게시물의 DB 행 번호(row 값)
//		
//		// 2. 실제 뷰페이지에서 페이징 처리를 위한 계산 작업
//		// BoardService - getBoardListCount() 메서드 호출하여 전체 게시물 수 조회 요청
//		// => 파라미터 : 검색타입, 검색어   리턴타입 : int(listCount)
//		int listCount = CourseService.getCourseListCount();
////				System.out.println("전체 게시물 수 : " + listCount);
//		
//		// 임시) 페이지 당 페이지 번호 갯수를 2개로 지정(1 2 or 3 4...)
//		int pageListLimit = 2; 
//		// 최대 페이지 번호 계산(전체 게시물 수를 페이지 당 게시물 수로 나눔)
//		// => 이 때, 나머지가 0보다 크면 페이지 수 + 1
//		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0);
//		// => 단, 최대 페이지 번호가 0 일 경우 1페이지로 변경
//		if(maxPage == 0) {
//			maxPage = 1;
//		}
//		
//		// 현재 페이지에서 보여줄 시작 페이지 번호 계산(1, 3, 5, 7, 9)
//		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1;
//		// 현재 페이지에서 보여줄 마지막 페이지 번호 계산(2, 4, 6, 8, 10)
//		int endPage = startPage + pageListLimit - 1;
//		
//		// 단, 마지막 페이지번호(endPage) 값이 최대 페이지번호(maxPage)보다 클 경우
//		// 마지막 페이지 번호를 최대 페이지번호로 교체
//		if(endPage > maxPage) {
//			endPage = maxPage;
//		}
//		
//		// 전달받은 페이지번호가 1보다 작거나 최대 페이지 번호보다 클 경우
//		// fail.jsp 페이지 포워딩을 통해 "해당 페이지는 존재하지 않습니다!" 출력하고
//		// 1페이지로 이동하도록 처리
//		if(pageNum < 1 || pageNum > maxPage) {
//			model.addAttribute("msg", "해당 페이지는 존재하지 않습니다!");
//			model.addAttribute("targetURL", "BoardList?pageNum=1");
//			return "result/fail";
//		}
//		
//		// 페이징 정보 관리하는 PageInfo 객체 생성 및 계산 결과 저장
//		PageInfo pageInfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage);
//		
//		// Model 객체에 페이징 정보 저장
//		model.addAttribute("pageInfo", pageInfo);
		// -------------------------------------------------------------------
		
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
	public String faqWrite(CourseSupportVO cSupport, int class_id, HttpSession session, Model model) {
		String id = (String)session.getAttribute("sId");
		cSupport.setMem_id(id);
		cSupport.setC_class_id(class_id);
		System.out.println("클래스아이디#########$$$$$$$$$$$$  %%%%%%%%%%% " + class_id);
//		int insertCount = courseService.registCourseSupport(cSupport, class_id);
		int insertCount = courseService.registCourseSupport(cSupport);
		
		
		
		if(insertCount > 0) { // 등록 성공
			
			model.addAttribute("class_id", class_id);
			return "redirect:/CourseDetail";
		} else {
			model.addAttribute("msg", "문의글쓰기실패");
			return "result/fail";
		}
	}
}
