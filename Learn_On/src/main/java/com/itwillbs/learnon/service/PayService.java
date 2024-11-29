package com.itwillbs.learnon.service;

import java.util.HashMap;
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
	//주문자정보 조회
	public MemberVO getMemberInfo(String sId) {
		return mapper.selectMember(sId);
	}
	
	//결제할 상품 정보 조회
	public List<OrderVO> getSelectedCart(List<String> checkItems) {
//		System.out.println("결제할 상품 : " + checkItems);
		return mapper.selectedCart(checkItems);
	}

	//------------------------------------------------------------------------
	//결제 완료시)
	//결제 정보 저장
	public void savePayInfo(PayVO payVO) {
		mapper.insertPayInfo(payVO);
	}
	
	//주문 정보 저장
	@Transactional
	public void saveOrderInfo(OrderVO orderVO) {
		// DB에 각 상품별로 주문 정보 저장
		for(OrderItemVO orderitemVO : orderVO.getItems()) {
			//주문 정보 데이터 생성
			Map<String, Object> orderData = new HashMap<String, Object>();
			orderData.put("merchant_uid", orderVO.getMerchant_uid());
			orderData.put("mem_id", orderVO.getMem_id());
			orderData.put("coupon_id", orderVO.getCoupon_id());
			orderData.put("price", orderVO.getPrice());
			orderData.put("class_id", orderitemVO.getClass_id());
			orderData.put("class_price", orderitemVO.getClass_price());
			//주문 정보 인서트
			mapper.insertOrderInfo(orderData);
			
			//위에서 인서트된 order_idx를 저장
			int order_idx = (int) orderData.get("order_idx");
			//----------------------
			//나의 클래스 데이터 생성
			Map<String, Object> mycourseData = new HashMap<String, Object>();
			mycourseData.put("mem_id", orderVO.getMem_id());
			mycourseData.put("class_id", orderitemVO.getClass_id());
			mycourseData.put("order_idx", order_idx);
			//나의 클래스 인서트
			mapper.insertMycourse(mycourseData);
			
			//----------------------
			//커리큘럼 시청기록 데이터 생성
			Map<String, Object> curHistory = new HashMap<String, Object>();
			curHistory.put("mem_id", orderVO.getMem_id());
			curHistory.put("class_id", orderitemVO.getClass_id());
			//커리큘럼 시청기록 인서트
			mapper.insertCurHistory(curHistory);
			
		}
		
	}
	
	//쿠폰 사용 상태 업데이트
	public void couponUsed(String mem_id, int coupon_id) {
		mapper.updateCoupon(mem_id, coupon_id);
	}
	
	//------------------------------------------------------------------------
	//결제완료 페이지에 전달할 결제 정보 조회
	public PayVO getPayInfo(String merchant_uid) {
		return mapper.selectPayInfo(merchant_uid);
	}
	
	//------------------------------------------------------------------------
	//결제 취소)
	//결제 취소에 필요한 impUid에 해당하는 회원ID 조회
	public String getMem_id(String impUid) {
		return mapper.selectMemId(impUid);
	}
	
	//결제 취소 후 결제상태 변경 및 쿠폰 복구
	@Transactional
	public void cancelAddProcess(String imp_uid, String memId) {
		//1. 결제 상태 업데이트
		mapper.updatePayStatus(imp_uid, memId);
		
		//2. 쿠폰 복구
		mapper.updateCouponUsed(imp_uid, memId);
		
		//3. 나의클래스 & 커리큘럼시청기록 데이터 삭제하기
		mapper.deleteMycourse(imp_uid, memId);
		mapper.deleteCurhistory(imp_uid, memId);
		
	}
	
}
