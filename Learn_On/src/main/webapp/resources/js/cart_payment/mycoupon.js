/*
	쿠폰 기능 구현
	- (V) 쿠폰선택 클릭시 목록 불러오기(mypage_coupon 참고하기) => 쿠폰선택 새창으로 열기
	- () 선택한 쿠폰 금액 표출 : 
	- (V) 쿠폰 코드 입력시 MYCOUPON 테이블에 인서트
	- () 선택하기 누르면 payment페이지에서 선택한 할인금액 표출
*/
	
$(document).ready(function() {
	//=============================================================================
    // "사용하기" 버튼 클릭 시 해당 금액 기존창에 표출 및 창 닫기
    $(".select-btn").click(function() {
		var couponId = $(this).data("coupon-id");  // 쿠폰 ID 가져오기
		var couponName = $(this).closest("li").find(".c-name").text();
		var couponDiscountAmount = $(this).closest("li").find(".c-dis").text();  // 쿠폰 할인 금액
		
		// 기존 페이지에 쿠폰 정보 전달
       	var coupon = {
			id: couponId,
			name : couponName,
			discountAmount: couponDiscountAmount, // 할인 금액
			discountPercent: couponDiscountPercent // 할인 비율
		};
       	// 기존 페이지의 setCoupon 함수 호출
       	window.opener.setCoupon(coupon);
       
       	// 창닫기
       	window.close();
       
    });





});