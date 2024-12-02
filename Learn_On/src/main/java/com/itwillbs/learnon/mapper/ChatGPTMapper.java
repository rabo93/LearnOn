package com.itwillbs.learnon.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ChatGPTMapper {
	
	int insertClass(Map<String, String> map);

	// 사용자 정보 조회
	Map<String, String> selectName(String id);

	// 전체 회원 해시태그 조회
	String selectHashtags();
	
	// 클래스 아이디와 클래스 해시태그 목록 조회
	List<Map<String, String>> selectHashtagsByClass();
	
	// 추천 클래스 목록 조회
	List<Map<String, Object>> selectClassList(String class_ids);

	Map<String, String> selectClassInfo(String class_id);

	
}
