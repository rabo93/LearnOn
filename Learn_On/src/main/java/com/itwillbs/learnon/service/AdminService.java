package com.itwillbs.learnon.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.learnon.mapper.AdminMapper;
import com.itwillbs.learnon.vo.AdminVO;
import com.itwillbs.learnon.vo.MemberVO;

@Service
public class AdminService {
	@Autowired
	private AdminMapper mapper;
	
	public List<AdminVO> getCategory() {
		return mapper.getCategory();
	}
	public List<AdminVO> getSubCategory() {
		return mapper.getSubCategory();
	}

	public int registClass(AdminVO vO) {
		return mapper.insertClass(vO);
	}
	public List<AdminVO> getClassList() {
		return mapper.getClassList();
	}
	public List<MemberVO> getMemberList() {
		return mapper.getMemberList();
	}
	public int getClass(String class_id) {
		return mapper.getClass(class_id);
	}
	public int updateClass(String class_id) {
		return mapper.updateClass(class_id);
	}

}
