package com.itwillbs.learnon.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.learnon.mapper.CouponMapper;


@Service
public class CouponService {
	@Autowired
	private CouponMapper mapper;
	
	//-------------------------------------------------
	// 보유한 쿠폰 조회
	public List<Map<String, Object>> getCoupon(String sId) {
		return mapper.selectCoupon(sId);
	}
	// 보유한 쿠폰 갯수 조회
	public int getCouponCount(String sId) {
		return mapper.selectCouponCount(sId);
	}
	
	
	
	
}
