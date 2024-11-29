package com.itwillbs.learnon.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.learnon.vo.AdminVO;
import com.itwillbs.learnon.vo.CourseSupportVO;
import com.itwillbs.learnon.vo.MemberVO;
import com.itwillbs.learnon.vo.MyPaymentVO;

@Mapper
public interface AdminMapper {
	
	// 카테고리
	List<Map<String, String>> getCategory();
	List<Map<String, String>> getMainCate();
	List<Map<String, String>> getSubCate();
	List<Map<String, Object>> selectSubCate(AdminVO admin);
	int deleteMainCate(String CODEID);
	int deleteSubCate(String old_codetype_subcate);
	int updateMainCate(AdminVO updateVO);
	int updateSubCate(AdminVO updateVO);
	int insertMainCate(AdminVO vO);
	int insertSubCate(AdminVO vO);

	// ============== 클래스 ==============
	// 클래스 조회
	AdminVO getClass(AdminVO vO);
	//클래스 목록 조회
	List<AdminVO> getClassList();
	// 커리큘럼 조회
	List<Map<String, Object>> getCurriculum(int class_id);
	// 커리큘럼 등록
	int insertCurriculum(AdminVO insertCur);
	// 클래스 등록
	int insertClass(AdminVO vO);
	// 클래스 썸네일 등록
	int insertClassPic(AdminVO vO);
	// 커리큘럼 영상 등록
	int insertCurVideo(AdminVO vO);
	// 클래스 아이디 조회
	int getClassId();
	// 클래스 삭제
	int deleteClass(int i);
	// 커리큘럼 삭제
	int deleteCurriculum(int i);
	// 커리큘럼 히스토리 삭제
	int deleteCurHistory(Object cur_id);
	// 클래스 수정
	int updateClass(AdminVO vO);
	// 커리큘럼 수정
	int updateCurriculum(AdminVO vO);
	
	// ============== 멤버 ==========================
	//	멤버 리스트 조회(일반회원)
	List<MemberVO> getNomalMemberList(@Param("startRow") int startRow,
									  @Param("listLimit") int listLimit,
									  @Param("searchKeyword") String searchKeyword,
									  @Param("searchType") String searchType,
									  @Param("sort") String sort);
	//	멤버 리스트 카운트(일반회원)
	int getNomalMemberListCount(@Param("startRow") String searchKeyword,
								@Param("startRow") String searchType);
	//	멤버 리스트 조회(강사회원)
	List<MemberVO> getInstructorMemberList();
	//	멤버 리스트 조회(탈퇴회원)
	List<MemberVO> getWithdrawMemberList();
	//	멤버 수정용 리스트 조회
	MemberVO getMemberList(String mem_id);
	//	멤버 상태변경(정상, 휴먼, 탈퇴)
	int changeMemStatus(Map<String, String> map);
	//	회원 정보 수정
	int updateMember(Map<String, Object> map);
	//	회원 삭제
	int deleteMember(String mem_id);
	//	회원 등급변경
	int updateGrade(MemberVO member);
	//	회원 모든 등급 변경(일반회원, 강사회원, 관리자)
	int updateAllGrade(Map<String, String> map);
	//	쿠폰 발급
	int insertCoupon(@Param("coupon_id") int coupon_id,
					 @Param("mem_id") String mem_id);
	//	쿠폰 발급용 회원 목록 조회
	List<MemberVO> selectCouponMember(int coupon_id);
	
	// ===== 수강문의 게시판
	// 강의 문의 조회 요청
	List<CourseSupportVO> selectCourseSupportList(@Param("startRow") int startRow, @Param("listLimit") int listLimit);
	
	// 강의 답변 작성/수정
	int updateCourseSupport(CourseSupportVO cSupport);
	
	//	임시
	AdminVO getClass(int class_id);
	
	// 관리자 - 결제내역 개수 조회
	int selectPaymentListCount();
	
	// 관리자 - 결제내역 전체 조회
	List<MyPaymentVO> selectPaymentListToAdm(@Param("startRow") int startRow, @Param("listLimit") int listLimit);

	


}
