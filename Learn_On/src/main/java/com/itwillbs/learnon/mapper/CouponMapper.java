package com.itwillbs.learnon.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.learnon.vo.CouponVO;

@Mapper
public interface CouponMapper {
	// 보유한 쿠폰 조회 (목록 List객체로 리턴)
	List<Map<String, Object>> selectCoupon(String sId);
	
	// 보유한 쿠폰 갯수 조회 (갯수 리턴)
	int selectCouponCount(String sId);
	
	// 쿠폰 발급 (성공여부 갯수 리턴)
	int insertCoupon(Map<String, String> params);
	
	//	========= 관리자용 쿠폰 ===========================
	//	총 쿠폰 리스트 조회
	List<CouponVO> selectAdmCoupon(@Param("startRow") int startRow,
								   @Param("listLimit") int listLimit,
								   @Param("searchKeyword") String searchKeyword,
								   @Param("searchType") String searchType);
	//	쿠폰 총 개수 조회
	int selectAdmCouponCount(@Param("searchKeyword") String searchKeyword,
							 @Param("searchType") String searchType);
	//	사용 가능한 쿠폰 리스트 조회
	List<CouponVO> selectAdmIssueCoupon(@Param("startRow") int startRow,
										@Param("listLimit") int listLimit,
										@Param("searchKeyword") String searchKeyword,
										@Param("searchType") String searchType);
	
	//	사용 가능한 쿠폰 개수 조회
	int selectAdmIssueCouponCount(@Param("searchKeyword") String searchKeyword,
							 	  @Param("searchType") String searchType);
	
	CouponVO selectAdmIdxCoupon(int coupon_id);

	int insertAdmCoupon(CouponVO coupon);

	int deleteAdmCoupon(int coupon_id);

	int updateCouponInfo(CouponVO coupon);

	int deleteAdmMyCoupon(int coupon_id);

	int updateCouponStatus(CouponVO coupon);



	
}
