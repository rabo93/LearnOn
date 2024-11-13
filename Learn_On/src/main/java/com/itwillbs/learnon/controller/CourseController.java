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
import com.itwillbs.learnon.vo.CourseVO;
import com.itwillbs.learnon.vo.FaqVO;
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
		
		model.addAttribute("course", course);
		model.addAttribute("myReview", myReviewList);
		
		return "course/course_detail";
	}
	
	@GetMapping("CourseFaq")
	public String faqWriteForm(HttpSession session, Model model, HttpServletRequest request) {
		String id = (String)session.getAttribute("sId");
		if(id == null) {
			model.addAttribute("msg", "로그인 필수!\\n로그인 페이지로 이동합니다.");
			model.addAttribute("targetURL", "MemberLogin");
			
			// 로그인 성공 후 다시 현재페이지로 돌아오기 위해 prevURL 세션 속성값 설정
			// => 경로를 직접 입력하지 않고 request 객체의 getServletPath() 메서드로 서블릿 주소 추출 가능
			String prevURL = request.getServletPath();
			String queryString = request.getQueryString();
			System.out.println("prevURL: " + prevURL);
			System.out.println("요청 파라미터: " + request.getQueryString());
			
			// UTL 파라미터(쿼리)가 null이 아닐 경우 prevURL에 결합(?포함
			if(queryString != null) {
				prevURL += "?" + queryString;
			} 
			
			// 세션 객체에 prevURL 갑 저장
			session.setAttribute("prevURL", prevURL);
			return "result/fail";
		}
		return "course/course_faq_write_form";
	}
	
	
	
	@PostMapping("CourseFaqWrite") 
	public String faqWrite(FaqVO faq, Model model) {
		System.out.println("에프이이큐!!!!!!!!!!!!!!!!! " + faq);
		System.out.println("에프이이큐!!!!!!!!!!!!!!!!! @@@@@@@@@@@@@@@@@@@22222222222222222222");
//		System.out.println("에프에이큐!!!!!!! " + faq + " && 클래스아이디!!" + class_id);
//		
//		int insertCount = courseService.registFaq(faq);
//		if(insertCount > 0) { // 등록 성공
//			return "redirect:/CourseDetail";
//		} else {
//			model.addAttribute("msg", "문의글쓰기실패");
//			return "result/fail";
//		}
		return "";
	}
}
