package com.itwillbs.learnon.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.learnon.mapper.CouponMapper;
import com.itwillbs.learnon.vo.CouponVO;


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
	
	// 쿠폰 발급
	public boolean createCoupon(String memId, String couponCode) {
		// 매퍼로 전달할 파라미터 Map으로 담기
		Map<String, String> params = new HashMap<String, String>();
		params.put("mem_id", memId);
		params.put("coupon_code", couponCode);
		
		//인서트 매퍼 호출(결과 int로 받기)
		int result = mapper.insertCoupon(params); 
		
		return result > 0; //결과 성공시 true 리턴
	}
	
	// =========== 관리자용 쿠폰 =======================
	//	쿠폰 리스트 조회
	public List<CouponVO> getAdmCoupon(int startRow, int listLimit, String searchKeyword, String searchType) {
		return mapper.selectAdmCoupon(startRow, listLimit, searchKeyword, searchType);
	}
	
	//	쿠폰 리스트 카운트 조회
	public int getCouponListCount(String searchKeyword, String searchType) {
		return mapper.selectAdmCouponCount(searchKeyword, searchType);
	}
	
	//	사용가능한 쿠폰 리스트 조회
	public List<CouponVO> getAdmIssueCoupon(int startRow, int listLimit, String searchKeyword, String searchType) {
		return mapper.selectAdmIssueCoupon(startRow, listLimit, searchKeyword, searchType);
	}
	
	//	사용가능한 쿠폰 개수 조회
	public int getCouponIssueListCount(String searchKeyword, String searchType) {
		return mapper.selectAdmIssueCouponCount(searchKeyword, searchType);
	}
	
	//	쿠폰 ID로 목록 조회
	public CouponVO getIdxCoupon(int coupon_id) {
		return mapper.selectAdmIdxCoupon(coupon_id);
	}
	
	//	쿠폰 생성
	public int createAdmCoupon(CouponVO coupon) {
		return mapper.insertAdmCoupon(coupon);
		
	}
	
	//	CouponInfo 테이블 쿠폰 삭제
	public int removeCoupon(int coupon_id) {
		return mapper.deleteAdmCoupon(coupon_id);
	}
	
	//	MyCoupon 테이블 쿠폰 삭제
	public int removeMyCoupon(int coupon_id) {
		return mapper.deleteAdmMyCoupon(coupon_id);
	}
	
	//	쿠폰 정보 변경
	public int modifyCouponInfo(CouponVO coupon) {
		return mapper.updateCouponInfo(coupon);
	}

	
	//	MyCoupon 테이블 쿠폰상태 변경
	public int changeStatus(CouponVO coupon) {
		return mapper.updateCouponStatus(coupon);
	}


	
	
	
	
}
