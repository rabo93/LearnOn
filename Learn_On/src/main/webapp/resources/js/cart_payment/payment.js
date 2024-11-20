/*
	결제 기능 구현
	- (V) 결제 목록 불러오기 : 장바구니에서 넘겨받은 선택된 상품들의 클래스제목, 강사이름, 클래스가격, 총 주문금액/갯수
	- (V) 쿠폰선택 클릭시 목록 불러오기(mypage_coupon 참고하기) => 쿠폰선택창 열기 
	- () 선택한 쿠폰 금액 표출 : 
	- (V) 쿠폰 코드 입력시 MYCOUPON 테이블에 인서트
	- (V) 주문금액 - 할인금액 = 결제 금액 표출
	---------------------------------------------------------------------------
	- () 결제하기 클릭시 이용약관 동의(필수) 체크 확인 : 클릭 안되어있으면 진행X
	- () 결제하기 클릭시 결제 API에 데이터 넘겨주기 : 넘겨줄 데이터 (주문번호, 결제금액, 결제수단, 회원id, 회원연락처)
	- () 결제 완료시 결제 테이블에 인서트 => 주문테이블에 같이 넣어야할지 고민해보자
*/
$(document).ready(function() {
	//=============================================================================
	// "쿠폰선택" 클릭 시 쿠폰창 생성 이벤트
	$("#couponSelect").click(function() {
		// 새 창으로 열기
    	window.open("myCouponList", "_blank", "width=600,height=600,scrollbars=yes");
		
		//새창에 있는 쿠폰정보를 설정
		window.setCoupon = function(coupon) {
//		    console.log("쿠폰창에서 선택한 쿠폰정보 받은거:", coupon);
		    //{COUPON_ID: 1, DISCOUNT_STATUS: 2, DISCOUNT_PERCENT: '', DISCOUNT_AMOUNT: 5000}
		    
			//결제 상품 금액 가져오기
			let totalAmount = parseInt($("#totalAmount").data("value"), 10); //10진수 정수형으로 변환
//			console.log("결제상품금액: "+ totalAmount);
			//초기화
			let discountAmount = 0;
			let payAmount = totalAmount;
			
			// 선택한 쿠폰의할인 금액 또는 할인률에 따른 계산
			// 계산한 할인 금액을 결제 페이지에 반영
			if(coupon.DISCOUNT_STATUS == 1) { //퍼센트 할인
				let discountPercent = parseInt(coupon.DISCOUNT_PERCENT, 10);
				discountAmount = Math.floor(totalAmount * (discountPercent / 100));
				payAmount = totalAmount - discountAmount;
				
				$(".coupon-price").text(discountPercent +  " %");
				
			} else if(coupon.DISCOUNT_STATUS == 2){ //금액할인
				discountAmount = parseInt(coupon.DISCOUNT_AMOUNT, 10);
				payAmount = totalAmount - discountAmount;
				
				$(".coupon-price").text(discountAmount + " 원");
			} 
			
			// 할인 금액 및 최종 결제 금액 결제 페이지에 반영
			$(".discount-amount").text("- " + discountAmount.toLocaleString() + " 원"); 
			$(".total-pay-amount").text(payAmount.toLocaleString() + " 원"); 
		}
	
	});
	
	
	
	
});






//=============================================================================
// "쿠폰발급" 클릭 시 couponCreate() 함수 실행
// 입력된 쿠폰코드 서버로 확인/생성 후 응답 => AJAX
function couponCreate() {
	const couponCode = $("#couponCode").val().trim(); // 쿠폰 코드 입력 값 가져오기(양쪽 공백 제거)
	
	if (!couponCode) {
        alert("쿠폰 코드를 입력해 주세요.");
        return;
    }
    
    $.ajax({
		method: 'GET',
		url: 'CouponCreate',
		dataType : "json",
		data: {couponCode : couponCode},
		success: function(response) {
			console.log("서버응답:", response); //{success: true}
			if(response.success) {
				alert("쿠폰이 발급되었습니다.\n지금 바로 사용해보세요!");
			} else {
				alert("쿠폰이 발급되지 않았습니다.\n쿠폰코드를 다시 확인해주세요.");
			}
			location.reload();//페이지 새로 고침
		},
		error: function(jqXHR) {
		    console.log("jqXHR 오류:", jqXHR); 
		}
	});
}


















//=============================================================================
//https://developers.portone.io/opi/ko/integration/start/v1/auth?v=v1
//참고하세요!!!!!!!!!!!!
//결제하기 클릭시 호출되는 결제창
//var IMP = window.IMP; 
//IMP.init("imp43247883"); //고객사 식별 코드(포트원에서 발급받음)
//
//function requestPay() {
//    IMP.request_pay( 
//	{
//	    channelKey: "{콘솔 내 연동 정보의 채널키}",
//	    pay_method: "card",
//	    merchant_uid: `payment-${crypto.randomUUID()}`, // 주문 고유 번호
//	    name: "노르웨이 회전 의자",
//	    amount: 64900,
//	    buyer_email: "gildong@gmail.com",
//	    buyer_name: "홍길동",
//	    buyer_tel: "010-4242-4242",
////	    buyer_addr: "서울특별시 강남구 신사동",
////	    buyer_postcode: "01181",
//    }, 
//    function (response) { // callback
//    // 결제 종료 시 호출되는 콜백 함수
//    // response.imp_uid 값으로 결제 단건조회 API를 호출하여 결제 결과를 확인하고,
//    // 결제 결과를 처리하는 로직을 작성합니다.
//    });
//  }
  
//주문 고유 번호(merchant_uid) 관련 유의사항
//주문 고유 번호는 개별 결제 요청을 구분하기 위해 사용되는 문자열입니다.
//따라서 주문 고유 번호는 결제 요청 시 항상 고유한 값으로 채번되어야 하며, 
//결제 완료 이후 결제 기록 조회나 위변조 대사 작업 시 사용되기 때문에 고객사 DB 상에 별도로 저장해야 합니다.

//결제 결과 처리하기
//IMP.request_pay(
//  {
//    /* 파라미터 생략 */
//  },
//  async (response) => {
//    if (response.error_code != null) {
//      return alert(`결제에 실패하였습니다. 에러 내용: ${response.error_msg}`);
//    }
//
//    // 고객사 서버에서 /payment/complete 엔드포인트를 구현해야 합니다.
//    // (다음 목차에서 설명합니다)
//    const notified = await fetch(`${SERVER_BASE_URL}/payment/complete`, {
//      method: "POST",
//      headers: { "Content-Type": "application/json" },
//      // imp_uid와 merchant_uid, 주문 정보를 서버에 전달합니다
//      body: JSON.stringify({
//        imp_uid: response.imp_uid,
//        merchant_uid: response.merchant_uid,
//        // 주문 정보...
//      }),
//    });
//  },
//);