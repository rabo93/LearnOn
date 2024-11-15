package com.itwillbs.learnon.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.learnon.mapper.PayMapper;

@Service
public class PayService {
	@Autowired
	private PayMapper mapper;
	
	
	
}
