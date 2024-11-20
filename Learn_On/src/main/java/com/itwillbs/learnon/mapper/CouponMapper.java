package com.itwillbs.learnon.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CouponMapper {
	// 보유한 쿠폰 조회 (목록 List객체로 리턴)
	List<Map<String, Object>> selectCoupon(String sId);
	
	// 보유한 쿠폰 갯수 조회 (갯수 리턴)
	int selectCouponCount(String sId);
	
	// 쿠폰 발급 (성공여부 갯수 리턴)
	int insertCoupon(Map<String, String> params);
	
}
