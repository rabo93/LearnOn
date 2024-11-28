package com.itwillbs.learnon.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MainMapper {

	// 인기 강의
	List<Map<String, String>> selectBestClassList();

	// 최신 오픈 강의
	List<Map<String, String>> selectNewClassList();

}
