package com.itwillbs.learnon.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.learnon.mapper.ChatGPTMapper;

@Service
public class ChatGPTService {
	@Autowired
	private ChatGPTMapper chatGPTMapper;
	
}
