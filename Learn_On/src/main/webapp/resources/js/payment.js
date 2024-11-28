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
	- (V) 결제 완료시 인서트 해야할 테이블 => 결제 내역(PAY_INFO), 주문 내역(ORDER_INFO), 나의클래스(MYCOURSE) 
	- (V) 결제 완료시 장바구니 내역 삭제
	- (V) 사용한 쿠폰 상태값 변경
	- (V) 결제 취소시 결제 상태값 변경
	
*/
$(document).ready(function() {
	
	console.log("초기 결제 상품 금액(totalAmount):", $("#totalAmount").data("value"));
	console.log("초기 결제 금액(totalPrice):", $("#totalPrice").data("value"));
	
	//쿠폰 할인금액 결제 완료 페이지로 넘기기 위해 전역변수 초기화
	let discountAmount = 0;
	
	//=============================================================================
	// [할인 구현]
	function setCouponHandler(coupon) {
		if(!coupon) return;
		
		// 결제 상품 금액 가져오기
		let totalAmount = parseInt($("#totalAmount").data("value"), 10); //10진수 정수형으로 변환
		console.log("결제상품금액: "+ totalAmount);
		// 금액 초기화
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
		
		//전역변수로 쓰기위해 return
		return discountAmount;
		
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
		
	}); //쿠폰끝
	
	
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
		// 결제페이지에서 전달할 데이터값 (주문번호, 결제금액, 결제수단, 회원ID, 클래스ID 등등...) 가져오기
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
	    	}, 
	    	//-------------결제 결과 처리-------------
	    	function(rsp) {
				console.log("결제 성공/실패 응답 (JSON): "+ JSON.stringify(rsp)); //결제금액이 들어있음
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
					
					// 사후검증을 위한 AJAX 요청
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
//							alert("결제가 완료되었습니다.");
							
							//검증 완료----------------------------------------------
							// 결제&주문 결과 저장 
							// 결제 정보 & 주문 정보를 따로 저장한 이유는 여러 개의 상품을 결제 했을 때 
							// 결제정보에는 '자바클래스 외 2개' 200000원 으로 저장하고 
							// 주문정보에는 '자바클래스1', 100000원 , '자바클래스2', 100000원 
							// 이렇게 주문한 상품 리스트를 하나씩 저장하기 위해 테이블을 2개를 두고 저장하는 로직으로 구성함
							
							//결제정보 저장(PAY_INFO)
							savePayinfo(rsp);
							
							//장바구니 목록에서 주문한 상품 삭제(CART)
							deleteCart();
							
							//주문정보 저장(ORDER_INFO)
							//=> 주문 저장 후 쿠폰상태(MYCOUPON) 업데이트 및 나의클래스(MYCOURSE)에 인서트 처리
							saveOrderinfo(rsp);
							
							
						//-------------------------------------------	
						} else {
							alert("결제 금액 오류로 결제 실패");
							//결제 취소
							cancelPay(rsp);
							location.reload();
						}
					});
				} else {
					alert("결제를 실패하였습니다.");
					console.log("실패사유: "+ rsp.error_msg);
					location.reload();
				}
			} //function(rsp) 함수 끝
	    );//IMP.request_pay끝
	}//requestPay() 함수 끝
	
	//-------------------------------------------------------------------------------------
	// 1. 결제정보 저장(결제 테이블에 저장)
	function savePayinfo(rsp) {
		//rsp로 받은 데이터에 없는 회원ID 데이터 가져오기
		let mem_id = $("#memberInfo").data("id");
		console.log("회원 ID:", mem_id);
		
		let payInfo = {
			merchant_uid: rsp.merchant_uid,
			class_name : rsp.name,
			mem_id : mem_id,
			mem_name : rsp.buyer_name,
			price : rsp.paid_amount,
			discount_amount : discountAmount,		
			pay_method : rsp.pay_method,
			pay_status : rsp.status,		//주문상태: paid(결제완료), failed(결제실패), ready(미결제)
			imp_uid : rsp.imp_uid,
			card_name : rsp.card_name,
			card_num : rsp.card_number,
			bank_name : rsp.vbank_name,
			bank_num : rsp.vbank_num,
			apply_num : rsp.apply_num,
			receipt_url	: rsp.receipt_url,
			vbank_due: rsp.vbank_due, //가상계좌 입금기한 : YYYY-MM-DD, YYYYMMDD, YYYY-MM-DD HH:mm:ss, YYYYMMDDHHmmss
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
		
		
		//가져온 데이터 합치기
		let orderInfo = {
			merchant_uid : rsp.merchant_uid,	
			mem_id : memId,						
			items : items,						//상품별 정보 배열			
			coupon_id : couponData.couponId,	//사용한쿠폰아이디
			price : rsp.paid_amount				//총 결제 금액
		}
		console.log("저장할 주문 정보 : " + JSON.stringify(orderInfo));
		/* 저장할 주문 정보(JSON 타입)
			{
			    "merchant_uid": "2024112524071",
			    "mem_id": "bborara",
			    "items": [
			        { "class_id": 2, "class_price": 1004 },
			        { "class_id": 1, "class_price": 1004 }
			    ],
			    "coupon_id": 6,
			    "price" : "2008"
			}
		*/
		
		// 주문 정보를 AJAX 요청
		$.ajax({
			type: "Post",
			url: "orderinfoSave",
			contentType: "application/json",
			data: JSON.stringify(orderInfo),
			success: function(response) {
				console.log("주문정보 저장 완료", response); //주문고유번호 리턴받음
				
				//저장 완료되면 결제 완료 페이지로 이동
				//(alert창 SweetAlert2 라이브러리 사용함)
				Swal.fire({
					icon: 'success',
					title: '결제 완료!',
					text: '결제 완료 페이지로 이동합니다.'
				}).then(() => {
					window.location.href = "PayResult?merchant_uid="+response;
				});
				
			},
			error: function(error) {
				console.log("주문정보 저장 실패", error);
			}
			
		});
	}
	
	//-------------------------------------------------------------------------------------
	// 결제 완료 후 장바구니 내역 삭제
	function deleteCart() {
		//GET방식 주소로 받은 선택한 장바구니 파라미터값 추출하여 배열로 변환
		let params = new URLSearchParams(window.location.search);
		let checkitems = params.getAll('checkitem');
		
		//삭제 AJAX 요청(장바구니 체크박스 선택삭제 코드 재사용)
		//앞에서는 선택된 항목들을 콤마로 구분된 문자열로 결합했었어서 이번에도 똑같이 맞춰줄꺼임
		let cartItemsParam = checkitems.join(",");
		console.log("삭제할 장바구니 번호 : " + cartItemsParam);
		
		$.ajax({
			type : "GET",
			url : "DeleteItems",
			data : { //넘겨줄 데이터들 작성
				cartitem_idx : cartItemsParam //요청 파라미터
			}, 
			success : function() {
				console.log("결제 후 해당상품 장바구니에도 삭제되었습니다.");
			},
			error : function(error) {
				console.log("삭제 요청중 오류 발생 : ", error);
			}
			
		});
	}
	
	//-------------------------------------------------------------------------------------
	// 결제 직전 취소 
	function cancelPay(rsp) {
		//결제 취소에 필요한 정보 가져오기
		
		$.ajax({
			type: "Post",
			url: "/payments/cancel",
			dataType: "json",
			contentType: "application/json; charset=utf-8",
			data: JSON.stringify({
				"imp_uid": rsp.imp_uid,
				"amount": rsp.paid_amount, 	// 미입력시 전액 환불
//				"checksum": rsp.paid_amount // 부분환불(환불가능금액)
				//checksum을 넣어주는 이유 : 서버와 포트원 서버간의 환불 가능 금액을 검증하기 위해서 필수 입력(우리는 전체 환불만 가능하도록 설계)			
				"reason": "테스트 결제 환불",	
			})
		}).done(function(response) {
			alert("환불 성공");
			
		}).fail(function(error) {
			console.log("환불 실패", error);
		});
	}
	
	
});// 페이지 로드 이벤트 끝
