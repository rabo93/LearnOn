package com.itwillbs.learnon.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.learnon.mapper.AdminMapper;
import com.itwillbs.learnon.vo.AdminVO;

@Service
public class adminService {
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

}
