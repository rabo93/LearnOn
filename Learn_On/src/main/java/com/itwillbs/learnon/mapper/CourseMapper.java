package com.itwillbs.learnon.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.learnon.vo.CommonCodeTypeVO;
import com.itwillbs.learnon.vo.CourseSupportVO;
import com.itwillbs.learnon.vo.CourseVO;
import com.itwillbs.learnon.vo.FaqVO;
import com.itwillbs.learnon.vo.MyReviewVO;

@Mapper
public interface CourseMapper {

	List<CourseVO> selectCourseList(
			@Param("searchType") String searchType,
			@Param("codetype") String codetype,
			@Param("course") CourseVO course
							);

	List<CourseVO> selectCourse(int classId);

	List<CommonCodeTypeVO> selectCommonCodeType(String codetype);
	List<CommonCodeTypeVO> selectCommonCodeTypeAll();
	List<CommonCodeTypeVO> selectCommonCode();

	List<MyReviewVO> selectReviewList(int class_id);

	int insertCourseSupport(CourseSupportVO cSupport);

	List<CourseSupportVO> selectCourseSupportList(
			@Param("class_id") int class_id,
			@Param("startRow") int startRow,
			@Param("listLimit") int listLimit
		);


	int selectCSupportListCount(int class_id);

	CourseSupportVO selectCourseSupport(int class_id);

	List<Map<String, String>> selectMenuList();

	int updateCourseSupport(CourseSupportVO cSupport);

	int deleteBoardFile(Map<String, String> map);

	int deleteCourseSupport(int c_support_idx);

	List<CourseVO> selectCourseTeacher(
			@Param("class_id") int class_id, 
			@Param("teacher_id") String teacher_id);

	int insertApplyForCourse(
			@Param("class_id") int class_id, 
			@Param("id") String id);


}
