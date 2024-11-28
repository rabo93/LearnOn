package com.itwillbs.learnon.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.learnon.mapper.MainMapper;

@Service
public class MainService {
	@Autowired
	private MainMapper mainMapper;

	// 인기 강의 목록
	public List<Map<String, String>> getBestClassList() {
		return mainMapper.selectBestClassList();
	}

	// 최신 오픈 강의 목록
	public List<Map<String, String>> getNewClassList() {
		return mainMapper.selectNewClassList();
	}

}
