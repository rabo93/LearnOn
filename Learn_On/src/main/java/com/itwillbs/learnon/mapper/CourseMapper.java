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
			@Param("course") CourseVO course
							);

	List<CourseVO> selectCourse(int classId);

	List<CommonCodeTypeVO> selectCommonCodeType(String codetype);

	List<MyReviewVO> selectReviewList(int class_id);

	int insertCourseSupport(CourseSupportVO cSupport);

	List<CourseSupportVO> selectCourseSupportList();

}
