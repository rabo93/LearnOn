package com.itwillbs.learnon.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.learnon.vo.AdminVO;
import com.itwillbs.learnon.vo.CourseSupportVO;
import com.itwillbs.learnon.vo.CourseVO;
import com.itwillbs.learnon.vo.MemberVO;

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

	// 클래스
	List<AdminVO> getClass(AdminVO vO);
	List<AdminVO> getClassList();
	List<CourseVO> getCurriculum(AdminVO class_id);
	int insertCurriculum(AdminVO insertCur);
	int insertClass(AdminVO vO);
	int insertClassPic(AdminVO vO);
	int insertCurVideo(AdminVO vO);
	int getClassId();
	int deleteClass(int i);
	int deleteCurriculum(int i);
	int updateClass(AdminVO vO);
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
	//	회원 삭제
	int deleteMember(String mem_id);
	//	회원 등급변경
	int updateGrade(MemberVO member);
	
	
	// ===== 수강문의 게시판
	// 강의 문의 조회 요청
	List<CourseSupportVO> selectCourseSupportList(@Param("startRow") int startRow, @Param("listLimit") int listLimit);
	
	// 강의 답변 작성/수정
	int updateCourseSupport(CourseSupportVO cSupport);
	


}
