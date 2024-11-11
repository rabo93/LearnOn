/*
	장바구니 기능 구현
	-(V) 장바구니 목록 불러오기 : 클래스ID, 클래스명, 강사명, 클래스가격, 썸네일사진(이거는 나중에 구현) 
	-(V) 전체선택 체크 기능 : checkAll, chk(각각의 클래스id)
	-() 선택 구매 => 구매(PURCHASE) 테이블에 인서트
	-() 선택 삭제 => 장바구니(CART) 테이블에서 딜리트
	
 */

document.addEventListener("DOMContentLoaded", function() {
// 페이지가 완전히 로드되면 다음 코드를 실행(이거 안하니까 초기 페이지 로딩시 전체선택 이벤트가 안되어있음)
	
	//------------------------------------------------------------------------------------------
	// "전체선택(checkAll)" 버튼 클릭시 전체 항목 선택/해제 이벤트
	const checkAll = document.querySelector('#checkAll'); //id 속성 가져와서 변수에 저장
//	console.log(checkAll); //<input type="checkbox" id="checkAll" checked="checked">
	const checkboxes = document.querySelectorAll('.chk'); //name 속성 전체 가져와서 변수에 저장
//	console.log(checkboxes); //NodeList(5) [input.chk, input.chk, input.chk, input.chk, input.chk]
	
	// 1. 초기 동기화 : 페이지가 처음 로드될 때 'checkAll'의 상태에 따라 다른 체크박스들의 상태를 설정
	const isChecked = checkAll.checked; // checkAll이 체크되어 있는지 확인
	// 각 체크박스의 상태를 전체선택 상태와 동일하게 설정하는 for문
//	for(const checkbox of checkboxes) { 
//		checkbox.checked = isChecked; 
//	}
	//=> 람다식으로!! 
	checkboxes.forEach(checkbox => checkbox.checked = isChecked);
	
		
	// 2. 그러고나서 클릭 이벤트 설정
	checkAll.addEventListener('click', function() {
		const isChecked = checkAll.checked;
//		console.log("전체선택 버튼 클릭함? ", isChecked); 
		
		checkboxes.forEach(checkbox => checkbox.checked = isChecked);
	}); //클릭이벤트 끝
		
	
	// 3. 개별 체크박스 하나라도 체크 해제 시 전체선택 체크 해제 업데이트
	checkboxes.forEach(checkbox => {
		checkbox.addEventListener('click', function() {
			const totalCnt = checkboxes.length; //총 체크박스 갯수
			console.log("totalCnt: " + totalCnt); 
			const checkedCnt = document.querySelectorAll('.chk:checked').length; //체크한 갯수
			console.log("checkedCnt: "+ checkedCnt);
			
			// 모든 체크박스가 선택되었는지 확인 후 전체선택 상태 업데이트
			checkAll.checked = totalCnt === checkedCnt;
		});
	});	
});




//================================================================
// 'X' 버튼 클릭시 해당상품 장바구니 테이블에서 삭제 deleteItem() 
// 확인해야할 데이터 : CARTITEM_IDX
//"삭제하시겠습니까?" 확인 창 출력 후 사용자로부터 "예/아니오" 입력받아 판별
//function deleteItem(){
//	 // data-cartitem-id 속성에서 CARTITEM_IDX 가져오기
////	 const cartItemIdx = button.getAttribute('data-cartitem-id'); 
//    
//    if (confirm("삭제하시겠습니까?")) {
//        location.href = 'DeleteItem?CARTITEM_IDX=' + cartItemIdx;
//    }
//
//}


//================================================================
// '선택삭제' 버튼 클릭시 체크한 상품을 장바구니 테이블에서 삭제 chkDelete()
	



	

//================================================================



//================================================================
// "주문하기(btnSubmit)" 클릭시 선택한 상품을 가지고 결제페이지(payment.jsp)로 이동
function orderCart() {
	//주문할 상품 있는지 판별 여부 팝업창
	const checkedCnt = document.querySelectorAll('.chk:Checked').length;
	if(checkedCnt == 0) {
		alert('주문할 상품이 없습니다.\n상품을 선택해 주세요.');
//		return;
	}
	
	//--------------------------------------------------------
	// 선택한 상품을 결제 페이지로 넘겨야하는 데이터
	// : 체크한 CLASS_ID, 갯수 ....(좀따 적으셈)
	
	
	

	
	
	
	
	//Payment 매핑주소 포워딩 해야함 (controller)
	location.href = "Payment"; 
}



