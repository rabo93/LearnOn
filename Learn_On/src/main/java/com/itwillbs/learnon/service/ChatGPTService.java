package com.itwillbs.learnon.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.learnon.mapper.ChatGPTMapper;

@Service
public class ChatGPTService {
	@Autowired
	private ChatGPTMapper mapper;

	// 사용자 정보 조회
	public Map<String, String> getName(String id) {
		return mapper.selectName(id);
	}
	
	// 회원 전체 해시태그 조회
	public String getHashtags() {
		return mapper.selectHashtags();
	}
	
}
