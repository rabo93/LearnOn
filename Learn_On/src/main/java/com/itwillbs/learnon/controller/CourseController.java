package com.itwillbs.learnon.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.itwillbs.learnon.service.CourseService;
import com.itwillbs.learnon.vo.CommonCodeTypeVO;
import com.itwillbs.learnon.vo.CourseVO;

@Controller
public class CourseController {
	@Autowired
	CourseService courseService;
	
	@GetMapping("Category")
	public String courseList(CourseVO course 
//			,@RequestParam(defaultValue = "") String searchType
			, Model model) {
		List<CommonCodeTypeVO> codeType = courseService.getCodeType(course.getCODETYPE());
		List<CourseVO> courseList = courseService.getCourseList(course);
		System.out.println("course --------- " + course);
		model.addAttribute("courseList", courseList);	
		model.addAttribute("codeType", codeType);
		return "course/course_list"; 
	}
	
	@GetMapping("CourseDetail")
	public String courseDetail(int CLASS_ID, Model model) { 
		List<CourseVO> course = courseService.getCourse(CLASS_ID);
		model.addAttribute("course", course);
		
		return "course/course_detail";
	}
	
	
	
}
