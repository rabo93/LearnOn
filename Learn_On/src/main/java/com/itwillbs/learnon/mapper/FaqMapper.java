package com.itwillbs.learnon.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.learnon.vo.FaqVO;

@Mapper
public interface FaqMapper {

	int insertFaq(FaqVO faq);

	List<FaqVO> selectBoardList();
	
	List<FaqVO> selectAdmBoardList(@Param("startRow") int startRow,
								   @Param("listLimit") int listLimit,
								   @Param("searchKeyword") String searchKeyword,
								   @Param("searchType") String searchType);

	int selectBoardListCount(@Param("searchKeyword") String searchKeyword,
							 @Param("searchType") String searchType);

	FaqVO selectIdxBoardList(int faq_idx);

	int updateFaqBoard(FaqVO board);

	int deleteFaqBoard(int faq_idx);
	
}
