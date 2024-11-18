package com.itwillbs.learnon.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.learnon.vo.AdminVO;
import com.itwillbs.learnon.vo.MemberVO;

@Mapper
public interface AdminMapper {

	int insertMainCate(AdminVO vO);
	
	int insertSubCate(AdminVO vO);

	int insertClass();

	List<Map<String, String>> getCategory();

	List<AdminVO> getClassList();

	List<MemberVO> getMemberList();

	int updateClass(String class_id);

	List<AdminVO> getClass(int class_id);

	List<Map<String, String>> getMainCate();

	List<Map<String, String>> getSubCate();

	int deleteMainCate(String CODEID);

	int deleteSubCate(String old_codetype_subcate);

	int updateMainCate(AdminVO updateVO);

	int updateSubCate(AdminVO updateVO);

}
