package com.itwillbs.learnon.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.learnon.vo.CommonCodeTypeVO;
import com.itwillbs.learnon.vo.CourseVO;

@Mapper
public interface CourseMapper {

//	List<CourseVO> selectCourseList(CourseVO course, String searchType);
	List<CourseVO> selectCourseList(CourseVO course);

	List<CourseVO> selectCourse(int classId);

	List<CommonCodeTypeVO> selectCommonCodeType(String CODETYPE);

}
