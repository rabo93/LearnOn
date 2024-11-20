package com.itwillbs.learnon.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.learnon.vo.AdminVO;
import com.itwillbs.learnon.vo.MemberVO;

@Mapper
public interface AdminMapper {
	
	// 카테고리
	List<Map<String, String>> getCategory();
	List<Map<String, String>> getMainCate();
	List<Map<String, String>> getSubCate();
	List<AdminVO> selectSubCate(AdminVO admin);
	int deleteMainCate(String CODEID);
	int deleteSubCate(String old_codetype_subcate);
	int updateMainCate(AdminVO updateVO);
	int updateSubCate(AdminVO updateVO);
	int insertMainCate(AdminVO vO);
	int insertSubCate(AdminVO vO);

	// 클래스
	List<AdminVO> getClass(int class_id);
	List<AdminVO> getClassList();
	int curriculum(AdminVO insertCur);
	int insertClass(AdminVO vO);
	int updateClass(String class_id);
	
	// 멤버
	List<MemberVO> getMemberList();
	
	int insertClassPic(AdminVO vO);
	int insertCurVideo(AdminVO vO);


}
