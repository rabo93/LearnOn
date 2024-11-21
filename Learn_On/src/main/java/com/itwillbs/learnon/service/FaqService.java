package com.itwillbs.learnon.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.learnon.mapper.FaqMapper;
import com.itwillbs.learnon.vo.FaqVO;

@Service
public class FaqService {

	@Autowired
	private FaqMapper faqMapper;
	
	public int registFaq(FaqVO faq) {
		return faqMapper.insertFaq(faq);
	}

	public List<FaqVO> getBoardList() {
		return faqMapper.selectBoardList();
	}
	
	//	관리자용 faq 게시판 조회
	public List<FaqVO> getAdmBoardList(int startRow, int listLimit, String searchKeyword, String searchType) {
		return faqMapper.selectAdmBoardList(startRow, listLimit, searchKeyword, searchType);
	}

	public int getBoardListCount(String searchKeyword, String searchType) {
		return faqMapper.selectBoardListCount(searchKeyword, searchType);
	}
	public FaqVO getIdxBoardList(int faq_idx) {
		return faqMapper.selectIdxBoardList(faq_idx);

	}

	public int modifyFaqBoard(FaqVO board) {
		return faqMapper.updateFaqBoard(board);
	}

	public int removeFaq(int faq_idx) {
		return faqMapper.deleteFaqBoard(faq_idx);
	}

}
