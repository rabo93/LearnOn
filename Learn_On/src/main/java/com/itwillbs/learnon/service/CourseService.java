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
	
	
	public int getCourseListCount(CourseVO course, String codetype, String searchType) {
		return mapper.selectCourseListCount(course, codetype, searchType);
	}
	public List<CourseVO> getCourseList(CourseVO course, String codetype, String searchType, int startRow, int pageListLimit) {
		return mapper.selectCourseList(searchType, codetype, course, startRow, pageListLimit);
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

	public  List<MyReviewVO> getReviewList(int class_id, String searchType) {
		return mapper.selectReviewList(class_id, searchType);
	}

	public int registCourseSupport(CourseSupportVO cSupport) {
		return mapper.insertCourseSupport(cSupport);
	}
	
	public List<CourseSupportVO> getCourseSupportList(int class_id, int startRow, int listLimit) {
		return mapper.selectCourseSupportList(class_id,startRow,listLimit);
	}

	public int getCourseSupportListCount(int class_id) {
		return mapper.selectCourseSupportListCount(class_id);
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

	public int getCourseTeacherCount(int class_id, String teacher_id) {
		return mapper.selectCourseTeacherCount(class_id, teacher_id);
	}
	public List<CourseVO> getCourseTeacher(int class_id, String teacher_id, int startRow, int listLimit) {
		return mapper.selectCourseTeacher(class_id, teacher_id,startRow,listLimit);
	}

	public int registApplyForCourse(int class_id, String id) {
		return mapper.insertApplyForCourse(class_id, id);
	}

	public List<CourseVO> getFindCourseList(String find_title, int startRow, int pageListLimit) {
		return mapper.selectFindCourseList(find_title, startRow, pageListLimit);
	}

	public List<CourseVO> getCourseBestList(int startRow, int pageListLimit, String searchType) {
		return mapper.selectCourseBestList(startRow, pageListLimit, searchType);
	}
	public int getCourseBestListCount() {
		return mapper.selectCourseBestListCount();
	}
	

	


	

	
	


}
