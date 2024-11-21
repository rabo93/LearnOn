package com.itwillbs.learnon.mapper;

import java.util.List;

import com.itwillbs.learnon.vo.MemberVO;
import com.itwillbs.learnon.vo.PurchaseVO;

public interface PayMapper {
	//결제 상품 목록 조회 (SELECT한 주문VO 리스트로 리턴)
	List<PurchaseVO> selectedCart(List<String> checkItems);
	
	//주문자 정보 조회
	MemberVO selectMember(String sId);
	
	
}
