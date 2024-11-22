package com.itwillbs.learnon.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.learnon.mapper.CourseMapper;
import com.itwillbs.learnon.vo.CommonCodeTypeVO;
import com.itwillbs.learnon.vo.CourseSupportVO;
import com.itwillbs.learnon.vo.CourseVO;
import com.itwillbs.learnon.vo.FaqVO;
import com.itwillbs.learnon.vo.MyReviewVO;

@Service
public class CourseService {
	@Autowired
	CourseMapper mapper;
	
//	public List<CourseVO> getCourseList(CourseVO course, String searchType) {
//	public List<CourseVO> getCourseList(CourseVO course) {
//	public List<CourseVO> getCourseList(CourseVO course, String searchType) {
//		return mapper.selectCourseList(searchType, course);
//	}
	public List<CourseVO> getCourseList(CourseVO course, String codetype, String searchType) {
		return mapper.selectCourseList(searchType, codetype, course);
	}

	public List<CourseVO> getCourse(int class_id) {
		return mapper.selectCourse(class_id);
	}

	public List<CommonCodeTypeVO> getCodeType(String codeType) {
		return mapper.selectCommonCodeType(codeType);
	}
	public List<CommonCodeTypeVO> getCodeTypeAll() {
		return mapper.selectCommonCodeTypeAll();
	}
	public List<CommonCodeTypeVO> getCommonCode() {
		return mapper.selectCommonCode();
	}

	public  List<MyReviewVO> getReviewList(int class_id) {
		return mapper.selectReviewList(class_id);
	}

	public int registCourseSupport(CourseSupportVO cSupport) {
		return mapper.insertCourseSupport(cSupport);
	}

	public List<CourseSupportVO> getCourseSupportList(int class_id, int startRow, int listLimit) {
		return mapper.selectCourseSupportList(class_id,startRow,listLimit);
	}

	public int getCSupportListCount() {
		return mapper.selectCSupportListCount();
	}

	public CourseSupportVO getCourseSupport(int class_id) {
		return mapper.selectCourseSupport(class_id);
	}

	public List<Map<String, String>> getMenuList() {
		return mapper.selectMenuList();
	}

	public int modifyCourseSupport(CourseSupportVO cSupport) {
		return mapper.updateCourseSupport(cSupport);
	}

	public int removeBoardFile(Map<String, String> map) {
		return mapper.deleteBoardFile(map);
	}

	public int removeCourseSupport(int c_support_idx) {
		return mapper.deleteCourseSupport(c_support_idx);
	}

	public List<CourseVO> getCourseTeacher(int class_id, String teacher_id) {
		return mapper.selectCourseTeacher(class_id, teacher_id);
	}

	public int registApplyForCourse(int class_id, String id) {
		return mapper.insertApplyForCourse(class_id, id);
	}


	

	
	


}
