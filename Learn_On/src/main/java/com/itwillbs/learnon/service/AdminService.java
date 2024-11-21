package com.itwillbs.learnon.service;


import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.learnon.mapper.AdminMapper;
import com.itwillbs.learnon.vo.AdminVO;
import com.itwillbs.learnon.vo.CourseVO;
import com.itwillbs.learnon.vo.MemberVO;

@Service
public class AdminService {
	@Autowired
	private AdminMapper mapper;
	
	
	
	// 카테고리
	public List<Map<String, String>> getCategory() {
		return mapper.getCategory();
	}
	public List<Map<String, String>> getMainCate() {
		return mapper.getMainCate();
	}
	public List<Map<String, String>> getSubCate() {
		return mapper.getSubCate();
	}
	public List<Map<String, Object>> selectSubCate(AdminVO admin) {
		return mapper.selectSubCate(admin);
	}
	public int insertMainCate(AdminVO VO) {
		return mapper.insertMainCate(VO);
	}
	public int insertSubCate(AdminVO VO) {
		return mapper.insertSubCate(VO);
	}
	public int deleteMainCate(String CODEID) {
		return mapper.deleteMainCate(CODEID);
	}
	public int deleteSubCate(String old_codetype_subcate) {
		return mapper.deleteSubCate(old_codetype_subcate);
	}
	public int updateMainCate(AdminVO updateVO) {
		return mapper.updateMainCate(updateVO);
	}
	public int updateSubCate(AdminVO updateVO) {
		return mapper.updateSubCate(updateVO);
	}
	
	// 클래스
	public int registClass(AdminVO vO) {
		return mapper.insertClass(vO);
	}
	public int curriculum(AdminVO insertCur) {
		System.out.println("==================서비스 작동함");
		return mapper.curriculum(insertCur);
	}
	public List<AdminVO> getClassList() {
		return mapper.getClassList();
	}
	public List<AdminVO> getClass(AdminVO class_id) {
		return mapper.getClass(class_id);
	}
	public List<CourseVO> updateClass(AdminVO vO) {
		return mapper.updateClass(vO);
	}
	
	// 멤버
	public List<MemberVO> getMemberList() {
		return mapper.getMemberList();
	}
	public int insertClassPic(AdminVO vO) {
		return mapper.insertClassPic(vO);
		
	}
	public int insertCurVideo(AdminVO vO) {
		return mapper.insertCurVideo(vO);
	}
	public List<CourseVO> getCurriculum(AdminVO class_id) {
		return mapper.getCurriculum(class_id);
	}
	public int getClassId() {
		return mapper.getClassId();
	}


}
