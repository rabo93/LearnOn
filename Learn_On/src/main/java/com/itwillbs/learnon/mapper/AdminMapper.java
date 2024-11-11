package com.itwillbs.learnon.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.learnon.vo.AdminVO;

@Mapper
public interface AdminMapper {

	List<AdminVO> selectClassList(
			@Param("searchType") String searchType, 
			@Param("searchKeyword") String searchKeyword, 
			@Param("startRow") int startRow, 
			@Param("listLimit") int listLimit);

	int selectClassListCount(
			@Param("searchType") String searchType, 
			@Param("searchKeyword") String searchKeyword);

	int insertClass(AdminVO VO);

}
