package com.itwillbs.learnon.service;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.learnon.mapper.PayMapper;
import com.itwillbs.learnon.mapper.PrePaymentMapper;
import com.itwillbs.learnon.vo.MemberVO;
import com.itwillbs.learnon.vo.PayVO;
import com.itwillbs.learnon.vo.PurchaseVO;
import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.request.PrepareData;
import com.siot.IamportRestClient.response.Payment;

@Service
public class PayService {
	private IamportClient api; //선언한 api를 이용하여 아임포트에서 제공되는 다양한 API 를 사용할 수 있음
	public PayService() {
//    	this.api = new IamportClient("REST API KEY", "REST API SECRET");
		this.api = new IamportClient("1582333057803703", "Xeql20bTzSYAkeu3qPVXGoU3GEn0Ve4WKSmXsZViEAIrMFoJKE8n8q78DJlZMXkconSi5Nd3JpfpUX7h");
	}
	
//	@Autowired
//	private PrePaymentMapper prePaymentMapper;
	
	@Autowired
	private PayMapper mapper;
	//------------------------------------------------------------------------
	//결제 상품 목록 조회
	public List<PurchaseVO> getSelectedCart(List<String> checkItems) {
		System.out.println("Service checkItems: " + checkItems);  // checkItems 값 확인
		return mapper.selectedCart(checkItems);
	}
	//주문 정보 조회
	public MemberVO getMemberInfo(String sId) {
		return mapper.selectMember(sId);
	}
	
	//결제 사전 검증 - 결제예상 주문번호와 주문금액을 DB에 저장
//	public void postPrepare(PayVO pay) throws IamportResponseException, IOException {
//		PrepareData prepareData = new PrepareData(pay.getMerchantUid(), pay.getPrice());
//		System.out.println("서비스 넘겨줄 사전데이터: " + prepareData);
//		
//		api.postPrepare(prepareData);  // 사전 등록 API 
//		
//		prePaymentMapper.save(pay); // 주문번호와 결제예정 금액 DB 저장
//	}
	
	
	//결제 사후 검증 - 포트원에서 받은 결제 정보
//	public Payment validatePayment(PayVO pay) throws IamportResponseException, IOException {
//		PrePaymentEntity prePayment = PrePaymentMapper.findById(pay.getMerchantUid()).orElseThrow();
//		return null;
//	}
	
	
}
