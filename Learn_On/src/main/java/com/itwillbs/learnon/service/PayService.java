package com.itwillbs.learnon.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.itwillbs.learnon.mapper.PayMapper;
import com.itwillbs.learnon.vo.MemberVO;
import com.itwillbs.learnon.vo.OrderVO;
import com.itwillbs.learnon.vo.PayVO;

@Service
public class PayService {
	@Autowired
	private PayMapper mapper;
	
	//------------------------------------------------------------------------
	//결제 상품 목록 조회
	public List<OrderVO> getSelectedCart(List<String> checkItems) {
//		System.out.println("결제할 상품 : " + checkItems);
		return mapper.selectedCart(checkItems);
	}
	
	//------------------------------------------------------------------------
	//주문 정보 조회
	public MemberVO getMemberInfo(String sId) {
		return mapper.selectMember(sId);
	}

	//------------------------------------------------------------------------
	//결제 정보 저장 (리턴값 없음)
	@Transactional
	public void savePayInfo(PayVO payVO) {
		mapper.insertPayInfo(payVO);
	}
	//주문 정보 저장
	@Transactional
	public void saveOrderInfo(OrderVO orderVO) {
		mapper.insertOrderInfo(orderVO);
	}
	//장바구니 내역 삭제
	@Transactional
	public void deleteCart(int cartItemIdx) {
		mapper.deleteCart(cartItemIdx);
	}

	
	
}
