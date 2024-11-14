package com.itwillbs.learnon.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.learnon.mapper.CouponMapper;
import com.itwillbs.learnon.vo.CouponVO;


@Service
public class CouponService {
	@Autowired
	private CouponMapper mapper;
	
	//-------------------------------------------------
	// 쿠폰 조회
	public List<CouponVO> getCoupon(String memId) {
		return mapper.selectCoupon(memId);
	}
	
	
	
	
}
