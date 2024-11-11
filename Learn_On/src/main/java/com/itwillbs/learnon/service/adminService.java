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

	public List<AdminVO> getClassList(String searchType, String searchKeyword, int startRow, int listLimit) {
		return mapper.selectClassList(searchType, searchKeyword, startRow, listLimit);
	}

	public int getClassListCount(String searchType, String searchKeyword) {
		return mapper.selectClassListCount(searchType, searchKeyword);
	}

	public int registClass(AdminVO vO) {
		return mapper.insertClass(vO);
	}

}
