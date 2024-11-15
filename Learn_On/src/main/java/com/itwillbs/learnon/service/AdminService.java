package com.itwillbs.learnon.service;


import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.learnon.mapper.AdminMapper;
import com.itwillbs.learnon.vo.AdminVO;
import com.itwillbs.learnon.vo.MemberVO;

@Service
public class AdminService {
	@Autowired
	private AdminMapper mapper;
	
	public List<Map<String, String>> getCategory() {
		return mapper.getCategory();
	}
	public int registClass() {
		return mapper.insertClass();
	}
	public int insertMainCate(AdminVO VO) {
		return mapper.insertMainCate(VO);
	}
	public int insertSubCate(AdminVO VO) {
		return mapper.insertSubCate(VO);
	}
	public List<AdminVO> getClassList() {
		return mapper.getClassList();
	}
	public List<MemberVO> getMemberList() {
		return mapper.getMemberList();
	}
	public int updateClass(String class_id) {
		return mapper.updateClass(class_id);
	}
	public List<AdminVO> getClass(int class_id) {
		return mapper.getClass(class_id);
	}
	public List<Map<String, String>> getMainCate() {
		return mapper.getMainCate();
	}
	public List<Map<String, String>> getSubCate() {
		return mapper.getSubCate();
	}
	public int deleteMainCate(String CODEID) {
		return mapper.deleteMainCate(CODEID);
	}
	public int deleteSubCate(String old_codetype_subcate) {
		return mapper.deleteSubCate(old_codetype_subcate);
	}
	public int updateCate(AdminVO updateVO) {
		return mapper.updateCate(updateVO);
	}


}
