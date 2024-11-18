package com.itwillbs.learnon.mapper;

import java.util.List;
import java.util.Map;

public interface CouponMapper {
	// 보유한 쿠폰 조회
	List<Map<String, Object>> selectCoupon(String sId);
	// 보유한 쿠폰 갯수 조회
	int selectCouponCount(String sId);
	
}
