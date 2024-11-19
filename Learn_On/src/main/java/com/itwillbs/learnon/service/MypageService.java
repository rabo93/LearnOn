package com.itwillbs.learnon.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.itwillbs.learnon.mapper.MypageMapper;
import com.itwillbs.learnon.vo.AttendanceVO;
import com.itwillbs.learnon.vo.MyCourseVO;
import com.itwillbs.learnon.vo.MyCurriculumVO;
import com.itwillbs.learnon.vo.MyDashboardVO;
import com.itwillbs.learnon.vo.MyReviewVO;
import com.itwillbs.learnon.vo.SupportBoardVO;
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

	// 수강 후기 삭제
	public int removeReview(MyReviewVO review) {
		return myMapper.deleteReview(review);
	}

	// 쿠폰 목록 조회
	public List<Map<String, Object>> getMyCouponList(String id) {
		return myMapper.selectCoupon(id);
	}
	
	// 쿠폰 개수 조회
	public int getMyCouponCount(String id) {
		return myMapper.selectCouponCount(id);
	}

	// 1:1문의 글쓰기
	public int registSupport(SupportBoardVO support) {
		return myMapper.insertSupport(support);
	}

	// 1:1문의 전체 게시물 수
	public int getSupportListCount() {
		return myMapper.selectSupportListCount();
	}

	// 1:1문의 전체 게시물 목록
	public List<SupportBoardVO> getSupportList(int startRow, int listLimit) {
		return myMapper.selectSupportList(startRow, listLimit);
	}

	// 1:1문의 게시물 상세내용
	public SupportBoardVO getSupportDetail(int support_idx) {
		return myMapper.selectSupportDetail(support_idx);
	}

	// 1:1 문의 게시물 수정
	public int modifySupport(SupportBoardVO support) {
		return myMapper.updateSupport(support);
	}

	// 1:1 문의 게시물 삭제
	public int removeSupport(int support_idx) {
		return myMapper.deleteSupport(support_idx);
	}

	// 1:1 문의 게시물 수정 - 첨부파일 삭제 및 업데이트
	public int getSupportFileUpdate(int support_idx, String file) {
		return myMapper.updateSupportFile(support_idx, file);
	}

	// 출석체크 가져오기
	public AttendanceVO getAttendance(String id) {
		return myMapper.selectAttendance(id);
	}

	// 나의 강의실 - 강의 시청 조회
	public MyDashboardVO getMyDashboard(MyDashboardVO myDashboard) {
		return myMapper.selectMyDashboard(myDashboard);
	}

	// 나의 강의실 - 커리큘럼 목록 조회
	public List<MyCurriculumVO> getMyCurList(MyDashboardVO myDashboard) {
		return myMapper.selectMyCurList(myDashboard);
	}
	
	// 커리큘럼 시청 완료 업데이트 및 시청기록 업데이트
	@Transactional
	public int completedVideo(MyCurriculumVO myCurriculum) {
		myMapper.updateCurStatus(myCurriculum);
		myMapper.updateStudyTime(myCurriculum);
		return myMapper.updateCourseStatus(myCurriculum);
	}

}
