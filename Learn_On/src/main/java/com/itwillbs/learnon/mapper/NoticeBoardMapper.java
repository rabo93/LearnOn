package com.itwillbs.learnon.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.learnon.vo.NoticeBoardVO;

@Mapper
public interface NoticeBoardMapper {

	NoticeBoardVO selectNoticeBoard(int notice_idx);

	List<NoticeBoardVO> selectBoardList(@Param("startRow") int startRow,
										@Param("listLimit") int listLimit,
										@Param("sort") String sort,
										@Param("searchKeyword") String searchKeyword,
										@Param("searchType") String searchType);

	int selectBoardListCount(@Param("searchKeyword") String searchKeyword,
							 @Param("searchType") String searchType);

	int insertNoticeBoard(NoticeBoardVO board);

	int deleteBoard(int notice_idx);
	
	
}
