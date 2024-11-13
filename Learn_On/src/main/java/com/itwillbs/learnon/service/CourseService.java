package com.itwillbs.learnon.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.learnon.mapper.CourseMapper;
import com.itwillbs.learnon.vo.CommonCodeTypeVO;
import com.itwillbs.learnon.vo.CourseVO;
import com.itwillbs.learnon.vo.MyReviewVO;

@Service
public class CourseService {
	@Autowired
	CourseMapper mapper;
	
//	public List<CourseVO> getCourseList(CourseVO course, String searchType) {
//	public List<CourseVO> getCourseList(CourseVO course) {
	public List<CourseVO> getCourseList(CourseVO course, String searchType) {
		return mapper.selectCourseList(searchType, course);
	}

	public List<CourseVO> getCourse(int class_id) {
		return mapper.selectCourse(class_id);
	}

	public List<CommonCodeTypeVO> getCodeType(String codeType) {
		return mapper.selectCommonCodeType(codeType);
	}

	public  List<MyReviewVO> getReviewList(int class_id) {
		return mapper.selectReviewList(class_id);
	}
	


}
