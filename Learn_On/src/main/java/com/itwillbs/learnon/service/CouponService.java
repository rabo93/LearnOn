package com.itwillbs.learnon.service;

import java.util.HashMap;
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
	
	//쿠폰 발급
	public boolean createCoupon(String memId, String couponCode) {
		System.out.println("서비스에서 받은 memId: " + memId);
		//서비스에서 받은 memId: bborara
		
		Map<String, String> params = new HashMap<String, String>();
		params.put("mem_id", memId);
		params.put("coupon_code", couponCode);
		
		// 확인: 제대로 설정된 값을 출력
	    System.out.println("param.mem_id: " + params.get("mem_id"));
		
		
		//매퍼 호출
		int result = mapper.insertCoupon(params); 
		
		return result > 0; //결과 성공시 true 리턴
	}
	
	
	
	
}
