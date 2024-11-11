package com.itwillbs.learnon.mapper;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.learnon.vo.NoticeBoardVO;

@Mapper
public interface NoticeBoardMapper {

	NoticeBoardVO selectNoticeBoard(int notice_idx);

	List<NoticeBoardVO> selectBoardList(@Param("startRow") int startRow,
										@Param("listLimit") int listLimit,
										@Param("sort") String sort);

	int selectBoardListCount();

	int insertNoticeBoard(NoticeBoardVO board);
	
	
}
