//=============================================================================
// "쿠폰선택" 클릭 시 쿠폰 모달창 생성 이벤트(지금은 쿠폰 페이지로 이동)
function couponSelect() {
	location.href = "Coupon"; //Coupon 매핑주소 포워딩 해야함
}

// "쿠폰발급" 클릭 시 입력된 쿠폰번호 코드 확인 후 생성
function couponCreate() {
	
}













//=============================================================================
//https://developers.portone.io/opi/ko/integration/start/v1/auth?v=v1
//참고하세요!!!!!!!!!!!!
//결제하기 클릭시 호출되는 결제창
var IMP = window.IMP; 
IMP.init("imp43247883"); //고객사 식별 코드(포트원에서 발급받음)

function requestPay() {
    IMP.request_pay( 
	{
	    channelKey: "{콘솔 내 연동 정보의 채널키}",
	    pay_method: "card",
	    merchant_uid: `payment-${crypto.randomUUID()}`, // 주문 고유 번호
	    name: "노르웨이 회전 의자",
	    amount: 64900,
	    buyer_email: "gildong@gmail.com",
	    buyer_name: "홍길동",
	    buyer_tel: "010-4242-4242",
	    buyer_addr: "서울특별시 강남구 신사동",
	    buyer_postcode: "01181",
    }, 
    function (response) { // callback
    // 결제 종료 시 호출되는 콜백 함수
    // response.imp_uid 값으로 결제 단건조회 API를 호출하여 결제 결과를 확인하고,
    // 결제 결과를 처리하는 로직을 작성합니다.
    });
  }
  
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