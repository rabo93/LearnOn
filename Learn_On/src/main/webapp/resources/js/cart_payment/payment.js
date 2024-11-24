/*
	결제 기능 구현
	- (V) 결제 목록 불러오기 : 장바구니에서 넘겨받은 선택된 상품들의 클래스제목, 강사이름, 클래스가격, 총 주문금액/갯수
	- (V) 쿠폰선택 클릭시 목록 불러오기(mypage_coupon 참고하기) => 쿠폰선택창 열기 
	- (V) 선택한 쿠폰 금액 표출
	- (V) 쿠폰 코드 입력시 MYCOUPON 테이블에 인서트
	- (V) 주문금액 - 할인금액 = 결제 금액 표출
	- (V) 결제하기 클릭시 이용약관 동의(필수) 체크 확인 : 클릭 안되어있으면 진행X
	---------------------------------------------------------------------------
	- (V) 결제하기 클릭시 결제 API에 데이터 넘겨주기 : 넘겨줄 데이터 (주문번호, 결제금액, 결제수단, 회원id, 회원연락처)
	- () 결제 완료시 결제 테이블에 인서트 => 주문테이블에 같이 넣어야할지 고민해보자
	- () 결제 완료시 인서트 해야할 테이블 => 주문 내역(PURCHASE), 결제 내역(PAYMENT), 마이페이지 
*/
$(document).ready(function() {
	console.log("초기 결제 상품 금액(totalAmount):", $("#totalAmount").data("value"));
	console.log("초기 결제 금액(totalPrice):", $("#totalPrice").data("value"));
	//=============================================================================
	// "쿠폰선택" 클릭 시 쿠폰창 생성 이벤트
	$("#couponSelect").click(function() {
		// 새 창으로 열기
    	window.open("myCouponList", "_blank", "width=600,height=600,scrollbars=yes");
		
		// 새 창에 있는 쿠폰정보를 설정
		window.setCoupon = function(coupon) {
//		    console.log("쿠폰창에서 선택한 쿠폰정보 받은거:", coupon);
		    //{COUPON_ID: 1, DISCOUNT_TYPE: 2, DISCOUNT_PERCENT: '', DISCOUNT_AMOUNT: 5000}
		    
			// 결제 상품 금액 가져오기
			let totalAmount = parseInt($("#totalAmount").data("value"), 10); //10진수 정수형으로 변환
//			console.log("결제상품금액: "+ totalAmount);
			
			// 금액 초기화
			let discountAmount = 0;
			let payAmount = totalAmount;
			
			// 선택한 쿠폰의할인 금액 또는 할인률에 따른 계산
			// 계산한 할인 금액을 결제 페이지에 반영
			if(coupon.DISCOUNT_TYPE == 1) { //퍼센트 할인
				let discountPercent = parseInt(coupon.DISCOUNT_PERCENT, 10);
				discountAmount = Math.floor(totalAmount * (discountPercent / 100));
				//상품금액-할인금액 계산은 밖으로 뺌(중복되므로)
				$(".coupon-price").text(discountPercent +  " %");
				
			} else if(coupon.DISCOUNT_TYPE == 2){ //금액할인
				discountAmount = parseInt(coupon.DISCOUNT_AMOUNT, 10);
				//상품금액-할인금액 계산은 밖으로 뺌(중복되므로)
				$(".coupon-price").text(discountAmount + " 원");
			} 
			// 할인금액이 결제할 금액보다 클경우 결제금액 0원으로 처리
			if(discountAmount >= totalAmount) {
				payAmount = 0;
			} else { //상품금액-할인금액 계산
				payAmount = totalAmount - discountAmount;
			}
			
			// 할인 금액 및 최종 결제 금액 결제 페이지에 반영
			$(".discount-amount").text("- " + discountAmount.toLocaleString() + " 원"); 
			$(".total-pay-amount").text(payAmount.toLocaleString() + " 원"); 
			
			// 최종 결제 금액의 data-value 속성 동기화(결제 API에 넘기기 위해)
			$("#totalPrice").data("value", payAmount);
			$("#totalPrice").attr("data-value", payAmount); // HTML 속성도 업데이트
			
			console.log("쿠폰 적용 후 결제 금액(totalPrice):", $("#totalPrice").data("value"));
		}
	});
	
	//=============================================================================
	// "쿠폰발급" 클릭 시 입력된 쿠폰코드 서버로 확인/생성 후 응답 => AJAX
	$("#couponRegist").click(function() {
		// 쿠폰 코드 입력 값 가져오기(양쪽 공백 제거)
		let couponCode = $("#couponCode").val().trim(); 
		
		if (!couponCode) { //쿠폰코드를 입력하지 않았을 때
	        alert("쿠폰 코드를 입력해 주세요.");
	        return;
	    }
	    
	    $.ajax({
			method: 'GET',
			url: 'CouponCreate',
			dataType : "json",
			data: {couponCode : couponCode},
			success: function(response) {
//				console.log("서버응답:", response); //{success: true}
				if(response.success) {
					alert("쿠폰이 발급되었습니다.\n지금 바로 사용해보세요!");
				} else {
					alert("쿠폰이 발급되지 않았습니다.\n쿠폰코드를 다시 확인해주세요.");
				}
				location.reload();//페이지 새로 고침
			}
		});
		
	});
	
	//=============================================================================
	// "결제하기" 클릭시 약관동의 필수 체크 여부 (아래코드와 중복될 수도 있으니 나중에 보고 합칠것)
	$("#btnSubmit").off("click").on("click", function(event)  {
		console.log("체크박스 상태:", $("#notice").is(":checked")); //false
		if(!$("#notice").is(":checked")) {
			alert("결제를 진행하려면 이용약관 동의에 체크하시기 바랍니다.");
			event.preventDefault(); // 기본 동작(폼 제출) 방지
			return;
		}
		
		// 약관 동의가 체크된 경우 결제 요청
		kg_requestPay(); 
	});
});
//===================================================================================================
// "결제하기" 클릭시 포트원 결제 API 연동 구현 (v1)
//https://developers.portone.io/opi/ko/integration/start/v1/auth?v=v1
function kg_requestPay() {
	//-----------------------------------------------------------------------------------
	// 결제페이지에서 전달할 데이터값 (주문번호, 결제금액, 결제수단, 회원ID, 클래스ID 등등...) 가져와서 변수 저장
	// * 주문고유번호 생성(형식: yyyyMMdd+랜덤숫자5개)
	//- date() : 오늘날짜
	//- toISOString() : 2024-11-21T00:00:00.000Z을 반환
	//- slice(0, 10)으로 2024-11-21만 추출
	//- replace(/-/g, '')로 -를 제거해 20241121 형식으로 변환
	//- Math.floor(10000 + Math.random() * 90000)로 10000~99999 사이의 랜덤 숫자를 생성
	let merchantUid = new Date().toISOString().slice(0,10).replace(/-/g, '')
					 + Math.floor(10000 + Math.random()*90000);
	console.log("주문고유번호: " + merchantUid);
	let price = parseInt($("#totalPrice").data("value"), 10);
	console.log("결제금액: " + price);
	let payMethod = $('input:radio[name=pay-method]:checked').val();
	console.log("결제수단:"  + payMethod);
	
	//모든 클래스명 가져와서 [배열]에 담기(classTitle)
	let classTitles = [];
	$(".class-box").each(function() {
		classTitles.push($(this).data("class-title")); // data-class-title에서 가져오기
    });
    //결제 파라미터에 사용할 상품명 설정 
    //=> 상품이 여러개일 경우 '첫번째 상품명 외 n개'로 설정
    let className = "";
	if (classTitles.length > 1) {
		className = `${classTitles[0]} 외 ${classTitles.length - 1}개`;
	} else if (classTitles.length === 1) {
		className = classTitles[0];
	} else {
		className = "상품 없음";
	}
	console.log("결제 상품명:", className);
	
	//회원정보 가져오기(MemberVO를 jsp에 model로 받아서 data속성으로 값 가져옴)
	let memberInfo = $("#memberInfo")
	let memName = memberInfo.data("name");
	console.log("회원 이름:", memName);
	let phone = memberInfo.data("phone");
	console.log("회원 전화번호:", phone);
	let email = memberInfo.data("email");
	console.log("회원 이메일:", email);
	
	//---------------------------------------------
	// 결제 흐름 : 사전검증 > 결제 요청 > 사후 검증
	//----------------------------------------------------
	// [결제하기 사전검증]
	// 주문테이블에 결제 전에 DB저장 (결제 후 비교 검증)
	$.ajax({
		type: "Post",
		url: "payments/prepare",
		contentType: "application/json",
		data: JSON.stringify({
			merchantUid: merchantUid,	// 주문 번호
			className: className,		// 주문상품명
			memName: memName,			// 주문자명
			price: price,				// 결제 예정 금액
			payMethod: payMethod,		// 결제수단
		})
	});
	//---------------------------------------------
	// 결제하기 클릭시 호출되는 결제창 (생략가능)
	let IMP = window.IMP;
	// 가맹점 식별 코드(포트원에서 발급받음)
	IMP.init("imp43247883");
	//IMP.request_pay(param, callback) 결제창 호출
    IMP.request_pay(
		{	//--------전달할 파라미터--------
			//이니시스 결제창 일반결제 테스트 채널키(pg사 구분 없어지고 채널키로 대체 됐다고 하지만 일단 pg적어봄)
//			channelKey: "{channel-key-5ed4eb60-9a3c-4fa3-947f-9bbe61a042aa}",
			pg: "html5_inicis",			// 등록된 pg사 (적용된 pg사는 KG이니시스)
			pay_method: payMethod, 		// 결제 방식 : card (신용카드) / vbank(가상계좌) / naverpay(네이버페이)..
			merchant_uid: merchantUid,	// 주문 번호
			name: className,			// 상품명
			amount: price,				// 주문 금액
			buyer_name: memName,		// 주문자명
			buyer_tel: phone,			// 전화번호
			buyer_email: email,			// 이메일
			
			//아래는 추가적인 파라미터(가상계좌시 필요할 수도 있음)
//			vbank_due: "YYYY-MM-DD" //가상계좌 입금기한 : YYYY-MM-DD, YYYYMMDD, YYYY-MM-DD HH:mm:ss, YYYYMMDDHHmmss
    	}, 
    	//-------------결제 결과 처리-------------
    	function(rsp) {
			console.log("결제성공시 응답 (JSON): "+rsp); //결제금액이 들어있음
			//{success: true, imp_uid: 'imp_598208212134', pay_method: 'card', merchant_uid: '2024112288980', name: '자바 고급 강의 1편', …}
			if(rsp.success){
				// [사후 검증] 
				// - AJAX로 결제고유번호(imp_uid)를 통해 실결제금액 조회할 수 있으므로 서버 전달.
				// - DB에 저장된 결제요청 금액을 조회하기 위해 주문번호인 merchant_uid 도 서버로 전달.
				
				// AJAX 요청할 파라미터 가져와서 변수에 담기
				let data = {
					imp_uid: rsp.imp_uid,
					merchantUid: rsp.merchant_uid,
					price: rsp.paid_amount
				}
				// 사후검증을 위한 AJAX 비동기 요청
				$.ajax({
					type: "Post",
					url: "/payment/verification",
					dataType: "json",
					contentType: "application/json; charset=utf-8",
					data: JSON.stringify(data) 
					//위의 rsp.paid_amount 와 data.response.price를 비교한후 로직 실행 (import 서버검증)
				}).done(function(data) {
					console.log("data: "+ data);//주문금액이 들어있음
					if(rsp.paid_amount == data.response.price) {
						alert("결제 및 결제 검증완료");
					} else {
						alert("결제 실패");
					}
					
					//결제 정보 DB저장
					//주문상품 정보 DB저장
				});
	
				//검증 완료하면----------------------------------------------
				// 1. 결제정보 저장
				// alert("결제가 완료되었습니다. \n마이페이지에서 확인하세요.");
				// let buyerInfo = {
				//	"merchant_uid": rsp.merchant_uid,
				//	"userid": rsp.buyer_name, 
				//   ...
				//	}
		    	//======================================================================
		    	// 결제&주문 결과 저장 
		    	// 결제 정보 & 주문 정보를 따로 저장한 이유는 여러 개의 상품을 결제 했을 때 
		    	// 결제정보에는 '자바클래스 외 2개' 200000원 으로 저장하고 
		    	// 주문정보에는 '자바클래스1', 100000원 , '자바클래스2', 100000원 
		    	// 이렇게 주문한 상품 리스트를 하나씩 저장하기 위해 테이블을 2개를 두고 저장하는 로직으로 구성함
		    	// 1. 결제정보 저장
		    	
		    	//https://velog.io/@gangintheremark/SpringBoot-%ED%8F%AC%ED%8A%B8%EC%9B%90%EC%95%84%EC%9E%84%ED%8F%AC%ED%8A%B8-%EA%B2%B0%EC%A0%9C-API-%EC%82%AC%EC%9A%A9%ED%95%98%EC%97%AC-%EC%83%81%ED%92%88-%EA%B2%B0%EC%A0%9C-%EC%84%9C%EB%B9%84%EC%8A%A4
		    	//참고 할것
		    	
		    	
				// 2. 주문정보 저장(상품별)
				
				
				
				
				
				
				
				
				
				
				
			} else {
				console.log("결제 에러 내용: "+ rsp.error_msg);
				alert("결제를 실패하였습니다.");
			}
		} //function(rsp) 함수 끝
    );//IMP.request_pay끝
}//kg_requestPay() 함수 끝
  
  
  
  
  //결제 응답 파라미터 (callback)
  /*
  	success (boolean) : 결제승인 혹은 가상계좌발급이 성공한 경우 true(또는 imp_success)
  	error_code (string) : 결제 실패 코드
  	error_msg (string) : 결제 실패 메세지
  	imp_uid (string) : 포트원 고유번호 (success가 false이고 사전 validation에 실패한 경우, imp_uid는 null일 수 있음)
  	merchant_uid (string) : 주문번호
  	pay_method (string) : 결제수단
  	paid_amount (number) : 결제 금액
  	status (string) : 결제상태
  	 => ready(브라우저 창 이탈, 가상계좌 발급 완료 등 미결제 상태)
		paid(결제완료)
		failed(신용카드 한도 초과, 체크카드 잔액 부족, 브라우저 창 종료 또는 취소 버튼 클릭 등 결제실패 상태)
	name (string) : 주문자명
	pg_provider (string) : pg사 구분코드
	...
	https://developers.portone.io/sdk/ko/v1-sdk/javascript-sdk/payrt?v=v1
	페이지 참고..
  */
  /*
  	결제 응답 sample object
	{
	  "apply_num": "42827474",
	  "bank_name": null,
	  "buyer_addr": "서울특별시 강남구 삼성동",
	  "buyer_email": "test@portone.io",
	  "buyer_name": "포트원 기술지원팀",
	  "buyer_postcode": "123-456",
	  "buyer_tel": "010-1234-5678",
	  "CARD_NAME": "신한카드",
	  "card_number": "5428790000000294",
	  "card_quota": 0,
	  "currency": "KRW",
	  "custom_data": null,
	  "imp_uid": "imp_347242536261",
	  "merchant_uid": "57008833-33004",
	  "name": "당근 10kg",
	  "paid_amount": 1004,
	  "paid_at": 1648344363,
	  "pay_method": "card",
	  "pg_provider": "kcp",
	  "pg_tid": "22336466628585",
	  "pg_type": "payment",
	  "receipt_url": "https://admin8.kcp.co.kr/assist/bill.BillActionNew.do?cmd=card_bill&tno=22336466628585&order_no=imp_347242536261&trade_mony=1004",
	  "status": "paid",
	  "success": true
	}
  */
  
  
  
  
  
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


//결제정보 저장
//IMP.request_pay({
//    ...
//}, function (rsp) {
//    if (rsp.success) {
//           ... 
//        }).done(function (data) {
//            let mesg = '결제가 완료되었습니다.';
//            let buyerInfo = {
//                "merchant_uid": rsp.merchant_uid,
//                "userid": rsp.buyer_name,
//                "pay_method": rsp.pay_method,
//                "name": rsp.name,
//                "amount": rsp.paid_amount,
//                "phone": rsp.buyer_tel,
//                "addr": rsp.buyer_addr,
//                "post": rsp.buyer_postcode,
//                "recipient": recipient
//            }
//
//            $.ajax({
//                type: "post",
//                url: "save_buyerInfo",
//                contentType: "application/json",
//                data: JSON.stringify(buyerInfo),
//                success: function (response) {
//                    console.log("결제정보 저장 완료");
//                }
//            });
//        });
//    } else {
//        let mesg = '결제를 실패하였습니다.';
//        alert(mesg);
//    }
//});



