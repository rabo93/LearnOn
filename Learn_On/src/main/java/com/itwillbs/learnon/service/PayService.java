package com.itwillbs.learnon.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.itwillbs.learnon.mapper.PayMapper;
import com.itwillbs.learnon.vo.MemberVO;
import com.itwillbs.learnon.vo.OrderItemVO;
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
	//결제 정보 저장
	@Transactional
	public void savePayInfo(PayVO payVO) {
		mapper.insertPayInfo(payVO);
	}
	//주문 정보 저장
	@Transactional
	public void saveOrderInfo(OrderVO orderVO) {
	    // 주문 정보 저장
	    String merchantUid = orderVO.getMerchant_uid();
	    String memId = orderVO.getMem_id();
	    int couponId = orderVO.getCoupon_id(); // 쿠폰 코드

	    // 상품 정보 저장할 리스트 생성
	    List<OrderItemVO> items = new ArrayList<>();
	    
	    // items 배열을 반복 처리하여 주문 아이템 생성
	    for (OrderItemVO item : orderVO.getItems()) {
	        // OrderItemVO 객체에 데이터 저장 (class_id, class_price 등)
	        OrderItemVO orderItem = new OrderItemVO();
	        orderItem.setClass_id(item.getClass_id());
	        orderItem.setClass_price(item.getClass_price());

	        // items 리스트에 추가
	        items.add(orderItem);
	    }

	    // orderVO에 상품 정보 추가
	    orderVO.setItems(items);

	    // DB에 주문 정보 저장
	    mapper.insertOrderInfo(orderVO);
	}
//	public void saveOrderInfo(OrderVO orderVO) {
//		String merchant_uid = orderVO.getMerchant_uid();
//		String mem_id = orderVO.getMem_id();
//		int coupon_id = orderVO.getCoupon_id();
//		
//		//상품별 주문 정보 담을 리스트 객체 생성
//		List<OrderItemVO> items = new ArrayList<>();
//		
//		//상품별 주문 내역을 저장하려면 items 배열에 대해 반복 처리
//		for(Map<String, Object> item : orderVO.getItems()) {
//			
//			//Map에서 값을 꺼내 OrderItemVO 객체 생성 후 저장
//			OrderItemVO orderItem = new OrderItemVO();
//			orderItem.setClass_id((Integer) item.get("class_id"));
//			orderItem.setClass_price((Integer) item.get("class_price"));
//	        
//			items.add(orderItem);
//			
//		}
//		
//		orderVO.setItems(items);
//		
//		
//		// 각 상품 정보를 DB에 저장
//		mapper.insertOrderInfo(orderVO);
//		
//	}
	
	//쿠폰 사용 상태 업데이트
	@Transactional
	public void couponUsed(int coupon_code) {
		System.out.println("업데이트할 쿠폰코드: " + coupon_code);
		mapper.updateCoupon(coupon_code);
	}
	
	
}
