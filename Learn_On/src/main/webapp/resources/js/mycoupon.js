/*
	쿠폰 기능 구현
	- (V) 쿠폰선택 클릭시 목록 불러오기(mypage_coupon 참고하기) => 쿠폰선택 새창으로 열기
	- (V) 쿠폰 코드 입력시 MYCOUPON 테이블에 인서트
	- (V) 선택하기 누르면 payment페이지에서 선택한 할인금액 표출
*/
$(document).ready(function() {
	//=============================================================================
    // "사용하기" 버튼 클릭 시 해당 금액 기존창에 표출 및 창 닫기
    $(".select-btn").click(function() {
		//클릭한 사용하기 버튼의 쿠폰 아이디 및 필요한 할인 정보 가져와서 coupon에 담기
		let coupon = { 
			COUPON_ID: $(this).data("coupon-id"),
	        DISCOUNT_TYPE: $(this).data("discount-type"),
	        DISCOUNT_PERCENT: $(this).data("discount-percent"),
	        DISCOUNT_AMOUNT: $(this).data("discount-amount")
		};
		// 기존 페이지로 데이터 전달
		window.opener.setCoupon(coupon);
       	// 창닫기
       	window.close();
    });



});