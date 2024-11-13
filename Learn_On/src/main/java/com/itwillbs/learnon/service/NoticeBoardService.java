package com.itwillbs.learnon.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.learnon.mapper.NoticeBoardMapper;
import com.itwillbs.learnon.vo.NoticeBoardVO;

@Service
public class NoticeBoardService {
	@Autowired
	private NoticeBoardMapper noticeMapper;
	
	//	글 등록
	public int registBoard(NoticeBoardVO board) {
		return noticeMapper.insertNoticeBoard(board);
	}
	
	public List<NoticeBoardVO> getBoardList(int startRow, int listLimit, String sort, String searchKeyword, String searchType) {
		return noticeMapper.selectBoardList(startRow, listLimit, sort, searchKeyword, searchType);
	}

	public int getBoardListCount(String searchKeyword, String searchType) {
		return noticeMapper.selectBoardListCount(searchKeyword, searchType);
	}
	
	public NoticeBoardVO getNoticeBoard(int notice_idx) {
		return noticeMapper.selectNoticeBoard(notice_idx);
	}
	
	
	//	글 삭제
	public int removeNotice(int notice_idx) {
		return noticeMapper.deleteBoard(notice_idx);
	}
	
}
