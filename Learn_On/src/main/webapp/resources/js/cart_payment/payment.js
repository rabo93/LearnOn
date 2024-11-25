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
	- () 결제 완료시 인서트 해야할 테이블 => 결제 내역(PAY_INFO), 주문 내역(ORDER_INFO), 마이페이지 
*/
$(document).ready(function() {
	console.log("초기 결제 상품 금액(totalAmount):", $("#totalAmount").data("value"));
	console.log("초기 결제 금액(totalPrice):", $("#totalPrice").data("value"));
	//=============================================================================
	// [할인 구현]
	function setCouponHandler(coupon) {
		if(!coupon) return;
		
		// 결제 상품 금액 가져오기
		let totalAmount = parseInt($("#totalAmount").data("value"), 10); //10진수 정수형으로 변환
		console.log("결제상품금액: "+ totalAmount);
		// 금액 초기화
		let discountAmount = 0;
		let payAmount = totalAmount;
		
		// 선택한 쿠폰 정보 저장(나중에 DB에 저장하기 위해)
		$("#couponSelect").data({
			couponId: coupon.COUPON_ID,
			discountType: coupon.DISCOUNT_TYPE,
			discouontValue: coupon.DISCOUNT_TYPE == 1 ? 
						   coupon.DISCOUNT_PERCENT : coupon.DISCOUNT_AMOUNT
		});
		
		// 선택한 쿠폰의 할인금액 또는 할인률에 따른 계산
		// 계산한 할인 금액을 결제 페이지에 반영
		if(coupon.DISCOUNT_TYPE == 1) { //퍼센트 할인
			let discountPercent = coupon.DISCOUNT_PERCENT; // 쿠폰에서 퍼센트 값 가져오기
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
		$("#totalPrice").data("value", payAmount).attr("data-value", payAmount); // HTML 속성도 추가로 업데이트
		
		console.log("쿠폰 적용 후 결제 금액(totalPrice):", $("#totalPrice").data("value"));
		
	}//setCouponHandler() 함수 끝
	//-------------------------------------------------------------
	// "쿠폰선택" 버튼 클릭 이벤트
	$("#couponSelect").click(function() {
		// 새 창으로 열기
    	window.open("myCouponList", "_blank", "width=600,height=600,scrollbars=yes");
		
		// 새 창에 쿠폰정보를 저장
		window.setCoupon = setCouponHandler;
		
	});
	//-------------------------------------------------------------
	// "쿠폰발급" 버튼 클릭 이벤트
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
	// [결제 구현]
	// "결제하기" 클릭시 '약관동의 필수' 체크 여부 확인
	$("#btnSubmit").click(function (event)  {
//		console.log("체크박스 상태:", $("#notice").is(":checked")); //false
		if(!$("#notice").is(":checked")) {
			alert("결제를 진행하려면 이용약관 동의에 체크하시기 바랍니다.");
			event.preventDefault(); // 기본 동작(폼 제출) 방지
			return;
		}
		// 약관 동의가 체크된 경우 결제 요청
		requestPay(); 
	});
	//=============================================================================
	// "결제하기" 클릭시 포트원 결제 API 연동 구현 (v1) - kg이니시스 이용함
	//https://developers.portone.io/opi/ko/integration/start/v1/auth?v=v1
	function requestPay() {
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
		
		//회원정보 가져오기(MemberVO를 jsp에 model로 받아서 data속성으로 값 가져옴)
		let memberInfo = $("#memberInfo");
		let memName = memberInfo.data("name");
		console.log("회원 이름:", memName);
		let phone = memberInfo.data("phone");
		console.log("회원 전화번호:", phone);
		let email = memberInfo.data("email");
		console.log("회원 이메일:", email);
		
	    //모든 클래스명 [배열]에 담기
		let classTitles = [];
	    $(".class-box").each(function() {
			classTitles.push($(this).data("class-title")); // data-class-title에서 가져오기
//			items.push({
//				class_id: $(this).data("class-id"), // data-class-id에서 가져오기
//				class_price: $(this).data("class-price") // data-class-price에서 가져오기
//			});
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
		
		//---------------------------------------------
		// 결제 흐름 : 결제 요청 > 사후 검증 > 결제완료(DB저장)
		//---------------------------------------------
		// 결제하기 클릭시 호출되는 결제창 (생략가능)
		let IMP = window.IMP;
		// 가맹점 식별 코드(포트원에서 발급받음)
		IMP.init("imp43247883");
		//IMP.request_pay(param, callback) 결제창 호출
	    IMP.request_pay(
			{	//--------전달할 파라미터--------
				pg: "html5_inicis",			// 등록된 pg사 (적용된 pg사는 KG이니시스)
				pay_method: payMethod, 		// 결제 방식 : card (신용카드) / vbank(가상계좌) / naverpay(네이버페이)..
				merchant_uid: merchantUid,	// 주문 고유 번호
				name: className,			// 상품명
				amount: price,				// 주문 금액
				buyer_name: memName,		// 주문자명
				buyer_tel: phone,			// 전화번호
				buyer_email: email,			// 이메일
				
				//아래는 추가적인 파라미터(가상계좌에 필요할 수도 있음)
	//			vbank_due: "YYYY-MM-DD" //가상계좌 입금기한 : YYYY-MM-DD, YYYYMMDD, YYYY-MM-DD HH:mm:ss, YYYYMMDDHHmmss
	    	}, 
	    	//-------------결제 결과 처리-------------
	    	function(rsp) {
				console.log("결제성공시 응답 (JSON): "+ JSON.stringify(rsp)); //결제금액이 들어있음
				//{success: true, imp_uid: 'imp_598208212134', pay_method: 'card', merchant_uid: '2024112288980', name: '자바 고급 강의 1편', …}
				
				//결제완료후 후속 검증 실행(주문금액과 일치하는지 확인)
				if(rsp.success){
					// [사후 검증] 
					// - AJAX로 결제고유번호(imp_uid)를 통해 실결제금액 조회할 수 있으므로 서버 전달.
					// - DB에 저장된 결제요청 금액을 조회하기 위해 주문번호인 merchant_uid 도 서버로 전달.
					// AJAX 요청할 파라미터 가져와서 변수에 담기
					let data = {
						imp_uid: rsp.imp_uid,			//결제 고유 번호
						merchant_uid: rsp.merchant_uid,	//주문 고유 번호
						amount: rsp.paid_amount			//결제된 금액
					}
					// 사후검증을 위한 AJAX 비동기 요청
					$.ajax({
						type: "Post",
						url: "/payments/verification",
						dataType: "json",
						contentType: "application/json; charset=utf-8",
						data: JSON.stringify(data) 
						//위의 rsp.paid_amount 와 data.response.price를 비교한후 로직 실행 (import 서버검증)
					}).done(function(data) {
						console.log("data: "+ JSON.stringify(data));//주문금액이 들어있음
						if(rsp.paid_amount == data.response.amount) {
							alert("결제가 완료되었습니다.");
							
							//검증 완료----------------------------------------------
							// 결제&주문 결과 저장 
							// 결제 정보 & 주문 정보를 따로 저장한 이유는 여러 개의 상품을 결제 했을 때 
							// 결제정보에는 '자바클래스 외 2개' 200000원 으로 저장하고 
							// 주문정보에는 '자바클래스1', 100000원 , '자바클래스2', 100000원 
							// 이렇게 주문한 상품 리스트를 하나씩 저장하기 위해 테이블을 2개를 두고 저장하는 로직으로 구성함
							savePayinfo(rsp);
							saveOrderinfo(rsp);
							
							//저장 후 해당상품 장바구니 목록에서 삭제 처리
//							deleteCart(rsp);
							//저장 후 쿠폰 상태 변경
//							updateCoupon();
							
							//일단 성공했을때 바로 결제취소를 위한 테스트(테스트 완료후 삭제할 것)
							cancelPay(rsp);
							
						//-------------------------------------------	
						} else { //rsp.paid_amount != data.response.amount
							alert("결제 실패");
							//결제 취소
							cancelPay(rsp);
						}
			    	
					});
				} else {
					console.log("결제 에러 내용: "+ rsp.error_msg);
					alert("결제를 실패하였습니다.");
				}
			} //function(rsp) 함수 끝
			
	    );//IMP.request_pay끝
	}//requestPay() 함수 끝
	
	//-------------------------------------------------------------------------------------
	// 1. 결제정보 저장(결제 테이블에 저장)
	function savePayinfo(rsp) {
		let payInfo = {
			merchant_uid: rsp.merchant_uid,
			class_name : rsp.name,
			mem_name : rsp.buyer_name,
			price	: rsp.paid_amount,		
			pay_method : rsp.pay_method,
			pay_status : rsp.status,		//주문상태: paid(결제완료), failed(결제실패), ready(미결제)
			imp_uid : rsp.imp_uid,
			card_name	: rsp.card_name,
			card_num : rsp.card_number,
			bank_name	: rsp.vbank_name,
			bank_num	: rsp.vbank_num,
			apply_num : rsp.apply_num,
			receipt_url	: rsp.receipt_url
			}
		
		$.ajax({
			type: "Post",
			url: "payinfoSave",
			contentType: "application/json",
			data: JSON.stringify(payInfo),
			success: function(response) {
				console.log("결제정보 저장 완료", response);
			},
			error: function(error) {
				console.log("결제정보 저장 실패", error);
			}
		});
		
	}
	//-------------------------------------------------------------------------------------
	// 2. 주문정보 저장(주문 테이블에 저장)
	function saveOrderinfo(rsp) {
		//저장할 데이터 가져오기
		let memId = $("#memberInfo").data("id");
		let items = [];
	    $(".class-box").each(function() {
			items.push({
				class_id: $(this).data("class-id"), // data-class-id에서 가져오기
				class_price: $(this).data("class-price") // data-class-price에서 가져오기
			});
	    });
		let couponData = $("#couponSelect").data();
		
		
		let orderInfo = {
//			order_idx : order_idx,				//상품별 주문 ID
			merchant_uid : rsp.merchant_uid,	
			mem_id : memId,						
			items : [],							//상품별 정보 배열			
//			class_id : classIds,				//상품별 id
//			class_price : classPrices,			//상품별 가격
			coupon_code : couponData.couponId,	//사용한쿠폰아이디 
		}
		console.log("저장할 주문 정보 : " + JSON.stringify(orderInfo));
		
		// 주문 정보를 AJAX 비동기로 서버 전송	
		$.ajax({
			type: "Post",
			url: "orderinfoSave",
			contentType: "application/json",
			data: JSON.stringify(orderInfo),
			success: function(response) {
				console.log("주문정보 저장 및 장바구니 내역 삭제 완료", response);
			},
			error: function(error) {
				console.log("주문정보 저장 실패", error);
			}
			
		});
	} //saveOrderinfo()함수끝
	
	
	//-------------------------------------------------------------------------------------
	// 결제 취소 
	function cancelPay(rsp) {
		$.ajax({
			type: "Post",
			url: "/payments/cancel",
			dataType: "json",
			contentType: "application/json; charset=utf-8",
			data: JSON.stringify({
				"imp_uid": rsp.imp_uid,
				"reason": "결제 검증 실패",
				"checksum": rsp.paid_amount
				//checksum을 넣어주는 이유 : 서버와 포트원 서버간의 환불 가능 금액을 검증하기 위해서 필수 입력			
			})
		}).done(function() {
			alert("결제 검증 실패로 결제가 취소되었습니다.");
		}).fail(function(error) {
			alert(JSON.stringify(error));
		});
	}//canclePay() 함수 끝  
	//-------------------------------------------------------------------------------------
	  
	  
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
	
	
	
	
});// 페이지 로드 이벤트 끝



