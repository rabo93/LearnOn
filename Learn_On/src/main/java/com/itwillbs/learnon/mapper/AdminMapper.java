package com.itwillbs.learnon.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.learnon.vo.AdminVO;

@Mapper
public interface AdminMapper {

	int insertClass(AdminVO VO);

	List<AdminVO> getCategory();

	List<AdminVO> getSubCategory();
}
