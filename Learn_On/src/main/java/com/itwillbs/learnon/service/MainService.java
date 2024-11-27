package com.itwillbs.learnon.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.learnon.mapper.MainMapper;

@Service
public class MainService {
	@Autowired
	private MainMapper mainMapper;

}
