package com.itwillbs.learnon.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ChatGPTMapper {

	// 사용자 정보 조회
	Map<String, String> selectName(String id);

	// 전체 회원 해시태그 조회
	String selectHashtags();

}
