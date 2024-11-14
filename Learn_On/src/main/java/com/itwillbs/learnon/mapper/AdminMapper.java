package com.itwillbs.learnon.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.learnon.vo.AdminVO;
import com.itwillbs.learnon.vo.CourseVO;
import com.itwillbs.learnon.vo.MemberVO;

@Mapper
public interface AdminMapper {

	int insertClass(AdminVO VO);

	List<Map<String, String>> getCategory();
//	List<AdminVO> getSubCategory();

	List<AdminVO> getClassList();

	List<MemberVO> getMemberList();

	int updateClass(String class_id);

	List<AdminVO> getClass(int class_id);


}
