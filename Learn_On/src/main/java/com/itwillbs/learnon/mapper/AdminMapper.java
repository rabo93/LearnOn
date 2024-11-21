package com.itwillbs.learnon.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.learnon.vo.AdminVO;
import com.itwillbs.learnon.vo.CourseVO;
import com.itwillbs.learnon.vo.MemberVO;

@Mapper
public interface AdminMapper {
	
	// 카테고리
	List<Map<String, String>> getCategory();
	List<Map<String, String>> getMainCate();
	List<Map<String, String>> getSubCate();
	List<Map<String, Object>> selectSubCate(AdminVO admin);
	int deleteMainCate(String CODEID);
	int deleteSubCate(String old_codetype_subcate);
	int updateMainCate(AdminVO updateVO);
	int updateSubCate(AdminVO updateVO);
	int insertMainCate(AdminVO vO);
	int insertSubCate(AdminVO vO);

	// 클래스
	List<AdminVO> getClass(AdminVO class_id);
	List<AdminVO> getClassList();
	List<CourseVO> getCurriculum(AdminVO class_id);
	List<CourseVO> updateClass(AdminVO vO);
	int curriculum(AdminVO insertCur);
	int insertClass(AdminVO vO);
	int insertClassPic(AdminVO vO);
	int insertCurVideo(AdminVO vO);
	int getClassId();
	
	// 멤버
	List<MemberVO> getMemberList();
	


}
