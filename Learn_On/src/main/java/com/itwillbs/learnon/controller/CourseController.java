package com.itwillbs.learnon.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

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
		
//		Map <String, List<MyReviewVO>> myReviewList = courseService.getReviewList(class_id);
		List<MyReviewVO> myReviewList = courseService.getReviewList(class_id);
//		List<MyReviewVO> myReviewList = new ArrayList<MyReviewVO>();
		System.out.println("course 가지고오나????????? " + course);
		
		model.addAttribute("course", course);
		model.addAttribute("myReview", myReviewList);
		
		return "course/course_detail";
	}
	
	@GetMapping("CourseFaq")
	public String faqWriteForm() {
		return "course/course_faq_write_form";
	}
	
	@PostMapping("CourseFaqWrite") 
	public String faqWrite(FaqVO faq) {
		System.out.println(faq);
		
		
		return "";
	}
	
	
	
}
