package com.itwillbs.learnon.service;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import java.time.LocalDate;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.itwillbs.learnon.mapper.MypageMapper;
import com.itwillbs.learnon.vo.AttendanceVO;
import com.itwillbs.learnon.vo.MyCourseVO;
import com.itwillbs.learnon.vo.MyCurriculumVO;
import com.itwillbs.learnon.vo.MyDashboardVO;
import com.itwillbs.learnon.vo.MyPaymentVO;
import com.itwillbs.learnon.vo.MyReviewVO;
import com.itwillbs.learnon.vo.SupportBoardVO;
import com.itwillbs.learnon.vo.WishlistVO;

@Service
public class MypageService {
	@Autowired
	private MypageMapper myMapper;

	// 관심목록 가져오기
	public List<WishlistVO> getWishlist(String id, String filterType) {
		return myMapper.selectWishlist(id, filterType);
	}
	
	// 관심목록 가져오기 - 카테고리 목록
	public List<Map<String, Object>> getWishlistForCategoryList(String id){
		return myMapper.selectWishlistForCategoryList(id);
	}

	// 관심목록 삭제하기
	public int cancelMyFav(String class_id) {
		return myMapper.deleteWish(class_id);
	}

	// 관심목록 추가하기
	public int registMyFav(WishlistVO wish) {
		return myMapper.insertWish(wish);
	}
	
	// 나의 강의실 목록 가져오기
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

	// 결제내역 목록 조회
	public Map<String, List<MyPaymentVO>> getMyPaymentList(String id) {
		// 전체 결제내역 list에 담은 후
		List<MyPaymentVO> list = myMapper.selectPaymentList(id);
		// 결제번호를 key값으로 중복 제거 후 value 값으로 주문내역 배열 저장
		Map<String, List<MyPaymentVO>> result = list.stream()
													.collect(Collectors.groupingBy(MyPaymentVO::getMerchant_uid));
		return result;
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
	public int getSupportListCount(String id) {
		return myMapper.selectSupportListCount(id);
	}
	
	// 1:1문의 전체 게시물 목록
	public List<SupportBoardVO> getSupportList(int startRow, int listLimit, String id) {
		return myMapper.selectSupportList(startRow, listLimit, id);
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
	public int removeSupportFile(Map<String, String> map) {
		return myMapper.deleteSupportFile(map);
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

	// 관리자 1:1 문의 전체 목록
	public List<SupportBoardVO> getSupportListToAdm(int startRow, int listLimit) {
		return myMapper.selectSupportListToAdm(startRow, listLimit);
	}

	// 관리자 1:1 문의 - 답변 작성/수정
	public int answerSupport(SupportBoardVO support) {
		return myMapper.updateSupportAnswer(support);
	}
	
	// 회원가입시 attendance 테이블에 mem_id 추가
	public int addMemId(String mem_id) {
		return myMapper.insertMemId(mem_id);
	}


	//출석체크
	public int addDate(AttendanceVO attendance) {
		AttendanceVO lastAttendance = myMapper.selectAttendance(attendance.getMem_id());
		System.out.println("@@@@@@@@@@@@"+attendance.getMem_id()); //아이디값 받아옴
		
		System.out.println("lastAttendance :       " + lastAttendance);
		LocalDate today = LocalDate.now();

		if(lastAttendance != null){ // mem_id 있으면 
			LocalDate lastCheckIn = lastAttendance.getCheck_in_date();
			if (lastCheckIn == null) {
				attendance.setStreak_days(1); // 첫 출석
				attendance.setCheck_in_date(today);
			} 
		
			if(lastCheckIn.plusDays(1).equals(today)) { //연속출석 성공
				attendance.setStreak_days(lastAttendance.getStreak_days()+1);
				
			}else if(!lastCheckIn.equals(today)) { //연속 출석 실패시 1로 초기화
				attendance.setStreak_days(1);
			}
		} else {
			return myMapper.insertAttendance(attendance);
		}
		
		attendance.setCheck_in_date(today);
		
		return myMapper.updateAttendance(attendance);
	}

}
