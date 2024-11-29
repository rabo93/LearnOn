package com.itwillbs.learnon.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.learnon.handler.ChatGPTClient;
import com.itwillbs.learnon.mapper.ChatGPTMapper;

@Service
public class ChatGPTService {
	@Autowired
	private ChatGPTMapper chatGPTMapper;
	
	@Autowired
	private ChatGPTClient client;
	
	// 해시태그 요청
	public String requestHashtag(Map<String, String> classInfo) {
		return client.requestHashtag(classInfo);
	}
	
	
}
