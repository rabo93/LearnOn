package com.itwillbs.learnon.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.learnon.mapper.MypageMapper;
import com.itwillbs.learnon.vo.MyCourseVO;
import com.itwillbs.learnon.vo.MyReviewVO;
import com.itwillbs.learnon.vo.WishlistVO;

@Service
public class MypageService {
	@Autowired
	private MypageMapper myMapper;

	public List<WishlistVO> getWishlist(String id, String filterType) {
		return myMapper.selectWishlist(id, filterType);
	}

	public int cancelMyFav(String class_id) {
		return myMapper.deleteWish(class_id);
	}

	public List<MyCourseVO> getMyCourse(String id, String filterType, String statusType) {
		return myMapper.selectMyCourse(id, filterType, statusType);
	}

	// 수강후기 등록
	public int registReview(MyReviewVO review) {
		return myMapper.insertReview(review);
	}

	// 수강 후기 목록 조회
	public List<MyReviewVO> getMyReview(MyReviewVO review) {
		return myMapper.selectReview(review);
	}
	
	// 수강 후기 개수 조회
	public int getMyReviewCount(MyReviewVO review) {
		return myMapper.selectReviewCount(review);
	}
	
	
	// 수강 후기 상세 조회
	public MyReviewVO getMyReviewDetail(MyReviewVO review) {
		return myMapper.selectReviewDetail(review);
	}

	// 수강 후기 수정
	public int modifyMyReview(MyReviewVO review) {
		return myMapper.updateReview(review);
	}

	public int removeReview(MyReviewVO review) {
		return myMapper.deleteReview(review);
	}

	public List<Map<String, Object>> getMyCouponList(String id) {
		return myMapper.selectCoupon(id);
	}

	public int getMyCouponCount(String id) {
		return myMapper.selectCouponCount(id);
	}
	
	

}
