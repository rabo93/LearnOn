package com.itwillbs.learnon.service;


import java.util.HashMap;
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
	
//	public List<Map<String, String>> getCategory() {
	public String getCategory() {
		System.out.println(mapper.getCategory());
//		return mapper.getCategory();
		return "";
	}
//	public List<AdminVO> getSubCategory() {
//		return mapper.getSubCategory();
//	}
	public int registClass(AdminVO vO) {
		return mapper.insertClass(vO);
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


}
