package com.itwillbs.learnon.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.learnon.mapper.CourseMapper;
import com.itwillbs.learnon.vo.CommonCodeTypeVO;
import com.itwillbs.learnon.vo.CourseVO;

@Service
public class CourseService {
	@Autowired
	CourseMapper mapper;
	
//	public List<CourseVO> getCourseList(CourseVO course, String searchType) {
	public List<CourseVO> getCourseList(CourseVO course) {
		return mapper.selectCourseList(course);
	}

	public List<CourseVO> getCourse(int classId) {
		return mapper.selectCourse(classId);
	}

	public List<CommonCodeTypeVO> getCodeType(String codeType) {
		return mapper.selectCommonCodeType(codeType);
	}
	


}
