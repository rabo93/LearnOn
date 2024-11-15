package com.itwillbs.learnon.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.learnon.vo.MyCourseVO;
import com.itwillbs.learnon.vo.MyReviewVO;
import com.itwillbs.learnon.vo.WishlistVO;

@Mapper
public interface MypageMapper {

	// 관심목록 조회
	List<WishlistVO> selectWishlist(@Param("id") String id, @Param("filterType") String filterType);

	// 관심목록 삭제
	int deleteWish(String class_id);

	// 나의 강의실 목록 조회
	List<MyCourseVO> selectMyCourse(@Param("id") String id, @Param("filterType") String filterType, @Param("statusType") String statusType);

	// 수강평 등록
	int insertReview(MyReviewVO review);

	// 수강률 계산
	int selectCompletionRate(@Param("id") String id, @Param("class_id") String class_id);

	// 수강후기 작성 여부 조회
	Boolean selectIsReviewed(@Param("id") String id, @Param("class_id") String class_id);

	// 작성된 수강 후기 목록 조회
	List<MyReviewVO> selectReview(MyReviewVO review);
	
	// 작성된 수강 후기 개수 조회
	int selectReviewCount(MyReviewVO review);

	// 작성된 수강 후기 조회
	MyReviewVO selectReviewDetail(MyReviewVO review);

	// 작성된 수강 후기 수정 요청
	int updateReview(MyReviewVO review);

	// 수강 후기 삭제
	int deleteReview(MyReviewVO review);

	// 쿠폰 목록 조회
	List<Map<String, Object>> selectCoupon(String id);

	// 쿠폰 개수 조회
	int selectCouponCount(String id);
	
	

}
