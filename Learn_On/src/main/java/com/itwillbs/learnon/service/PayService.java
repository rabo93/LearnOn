package com.itwillbs.learnon.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.learnon.mapper.PayMapper;
import com.itwillbs.learnon.vo.CouponVO;
import com.itwillbs.learnon.vo.MemberVO;
import com.itwillbs.learnon.vo.PurchaseVO;
import com.siot.IamportRestClient.IamportClient;

@Service
public class PayService {
//	private IamportClient api; //선언한 api를 이용하여 아임포트에서 제공되는 다양한 API 를 사용할 수 있음
	
//	@Autowired
//	private PrePaymentRepository prePaymentRepository;
//    
//    public PayService() {
////    	this.api = new IamportClient("REST API KEY", "REST API SECRET");
//        this.api = new IamportClient("1582333057803703", "Xeql20bTzSYAkeu3qPVXGoU3GEn0Ve4WKSmXsZViEAIrMFoJKE8n8q78DJlZMXkconSi5Nd3JpfpUX7h");
//    }
	
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
	
	
	
}
