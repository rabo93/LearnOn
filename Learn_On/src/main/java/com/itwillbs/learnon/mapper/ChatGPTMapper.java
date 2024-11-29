package com.itwillbs.learnon.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ChatGPTMapper {
	
	int insertClass(Map<String, String> map);

	List<Map<String, String>> selectClassList();

	Map<String, String> selectClassInfo(String class_id);
	
}
