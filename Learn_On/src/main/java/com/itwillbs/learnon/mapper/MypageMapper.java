package com.itwillbs.learnon.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.learnon.vo.AttendanceVO;
import com.itwillbs.learnon.vo.MyCourseVO;
import com.itwillbs.learnon.vo.MyCurriculumVO;
import com.itwillbs.learnon.vo.MyDashboardVO;
import com.itwillbs.learnon.vo.MyReviewVO;
import com.itwillbs.learnon.vo.SupportBoardVO;
import com.itwillbs.learnon.vo.WishlistVO;

@Mapper
public interface MypageMapper {

	// 관심목록 조회
	List<WishlistVO> selectWishlist(
			@Param("id") String id, 
			@Param("filterType") String filterType);

	// 관심목록 조회 - 카테고리 목록
	List<Map<String, Object>> selectWishlistForCategoryList(String id);
	
	// 관심목록 삭제
	int deleteWish(String class_id);

	// 나의 강의실 목록 조회
	List<MyCourseVO> selectMyCourse(
			@Param("id") String id, 
			@Param("filterType") String filterType, 
			@Param("statusType") String statusType);

	// 수강평 등록
	int insertReview(MyReviewVO review);

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

	// 1:1 문의 글 등록
	int insertSupport(SupportBoardVO support);

	// 1:1 문의글 전체 게시물 수 조회
	int selectSupportListCount(String id);

	// 1:1 문의글 전체 게시물 조회
	List<SupportBoardVO> selectSupportList(
				@Param("startRow") int startRow, 
				@Param("listLimit") int listLimit,
				@Param("id") String id);

	// 1:1 문의글 게시글 상세내용 조회
	SupportBoardVO selectSupportDetail(int support_idx);

	// 1:1 문의글 수정
	int updateSupport(SupportBoardVO support);

	// 1:1 문의글 삭제
	int deleteSupport(int support_idx);

	// 1:1 문의글 수정 - 첨부파일 삭제
	int deleteSupportFile(Map<String, String> map);

	// 출석체크 가져오기
	AttendanceVO selectAttendance(String id);

	// 나의 강의실 - 강의 수강 화면
	MyDashboardVO selectMyDashboard(MyDashboardVO myDashboard);

	// 수강률 업데이트
	void updateCurStatus(MyCurriculumVO myCurriculum);

	// 나의 수강목록
	List<MyCurriculumVO> selectMyCurList(MyDashboardVO myDashboard);

	// 나의 학습시간 업데이트
	int updateStudyTime(MyCurriculumVO myCurriculum);

	// 클래스 상태 변경
	int updateCourseStatus(MyCurriculumVO myCurriculum);

	// 관심목록 추가
	int insertWish(WishlistVO wish);

	// ======================================================================
	// 관리자 - 1:1 목록
	List<SupportBoardVO> selectSupportListToAdm(
				@Param("startRow") int startRow, 
				@Param("listLimit") int listLimit);

	// 관리자 - 1:1 답변 작성/수정
	int updateSupportAnswer(SupportBoardVO support);

	//출석체크
	int insertAttendance(AttendanceVO attendance);
//	int insertAttendance(String mem_id);


	
	

}
