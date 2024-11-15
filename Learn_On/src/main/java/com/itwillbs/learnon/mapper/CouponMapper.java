package com.itwillbs.learnon.mapper;

import java.util.List;

import com.itwillbs.learnon.vo.CouponVO;

public interface CouponMapper {
	// 쿠폰 조회
	List<CouponVO> selectCoupon(String memId);

}
