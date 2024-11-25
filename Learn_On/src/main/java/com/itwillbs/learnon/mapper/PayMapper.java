package com.itwillbs.learnon.mapper;

import java.util.List;

import com.itwillbs.learnon.vo.MemberVO;
import com.itwillbs.learnon.vo.PayVO;
import com.itwillbs.learnon.vo.OrderVO;

public interface PayMapper {
	//결제 상품 목록 조회 (SELECT한 주문VO 리스트로 리턴)
	List<OrderVO> selectedCart(List<String> checkItems);
	
	//주문자 정보 조회
	MemberVO selectMember(String sId);
	
	//결제 정보 저장
	void insertPayInfo(PayVO payVO);
	
	//주문 정보 저장
	void insertOrderInfo(OrderVO orderVO);
	
	//장바구니 내역 삭제
	void deleteCart(int cartItemIdx);
	
}
