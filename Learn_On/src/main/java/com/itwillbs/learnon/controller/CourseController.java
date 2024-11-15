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
	public String courseDetail(int class_id, Model model) {
		List<CourseVO> course = courseService.getCourse(class_id);
		List<MyReviewVO> myReviewList = courseService.getReviewList(class_id);
		List<CourseSupportVO> courseSupportList = courseService.getCourseSupportList(class_id);
		
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
