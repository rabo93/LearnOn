/*
	장바구니 기능 구현
	-(V) 장바구니 목록 불러오기 : 클래스ID, 클래스명, 강사명, 클래스가격, 썸네일사진
	-(V) 전체선택 체크 기능 : checkAll, chk(각각의 클래스id)
	-(V) 삭제버튼 기능 => 장바구니(CART) 테이블에서 딜리트
	-(V) 체크한 상품에 대한 총계 표출 
	-(V) 선택 삭제 => 체크된 상품 삭제
	-(V) 헤더부분 장바구니 갯수 표시 => top.js에서 작성함
	-(V) 선택 구매 => 선택한 상품 결제페이지로 데이터 넘기기
	-(V) 썸네일사진 표출 : 클래스 등록 완료되면 구현
	-(V) 상품 클릭시 상품 상세 페이지 이동 : CourseDetail?CLASS_ID=240108
 */
$(document).ready(function() {
	//-------------------------------------------------------------------------
	// "전체선택(checkAll)" 버튼 클릭시 전체 항목 선택/해제 이벤트
	const checkAll = document.querySelector('#checkAll'); //id 속성 가져와서 변수에 저장
	const checkboxes = document.querySelectorAll('.chk'); //name 속성 전체 가져와서 변수에 저장
	//-------------
	const itemCnt = document.querySelector('#itemCount'); //선택상품 갯수 
	const itemTotal = document.querySelector('#totalAmount') //선택상품 금액
	
	
	// 1. 초기 동기화 : 페이지가 처음 로드될 때 'checkAll'의 상태에 따라 다른 체크박스들의 상태를 설정
	const isChecked = checkAll.checked; // checkAll이 체크되어 있는지 확인
	// 각 체크박스의 상태를 전체선택 상태와 동일하게 설정하는 for문
//	for(const checkbox of checkboxes) { 
//		checkbox.checked = isChecked; 
//	}
	//=> 람다식으로!! 
	checkboxes.forEach(checkbox => checkbox.checked = isChecked);
		
	// 2. 전체선택 클릭시 이벤트
	checkAll.addEventListener('click', function() {
		let isChecked = checkAll.checked;
//		console.log("전체선택 버튼 클릭함? ", isChecked); 
		checkboxes.forEach(checkbox => checkbox.checked = isChecked);
		
		updateSelect(); //전체선택 후 총합 계산 호출
	});
	
	// 3. 개별 체크박스 클릭 시, 전체선택 상태 업데이트
	// 개별 체크박스 하나라도 체크 해제 시 전체선택 체크 해제 이벤트
	checkboxes.forEach(checkbox => {
		checkbox.addEventListener('click', function() {
			let totalCnt = checkboxes.length; //총 체크박스 갯수
			let checkedCnt = document.querySelectorAll('.chk:checked').length; //체크한 갯수
			
			// 모든 체크박스가 선택되었는지 확인 후 전체선택 상태 업데이트
			checkAll.checked = (totalCnt === checkedCnt);
			
			updateSelect(); //개별선택 후 항목에 대한 총합 호출
		});
		
	});	
	
	//-------------------------------------------------------------------------
	// 체크한 체크박스의 갯수/금액 계산 업데이트 함수
	function updateSelect() {
		let selectCnt = 0; 
		let selectTotal = 0;
		
		checkboxes.forEach(checkbox => { //체크박스요소들 체크될때마다
	        if (checkbox.checked) {
	            selectCnt++; // 체크된 항목 갯수 증가
	            selectTotal += parseInt(checkbox.dataset.price); // 체크된 항목 금액 누적
	        }
   		});
		
		itemCnt.textContent = selectCnt;
		itemTotal.textContent = selectTotal.toLocaleString(); // 금액에 세자리 콤마 추가
	}
    
		
	//-----------------------------------------------------------------------------------
	// "주문하기" 버튼 클릭 시 체크 여부 확인 함수
	window.orderCart = function (event) {
	    event.preventDefault(); // 기본 폼 제출 방지

		// 선택한 체크박스 가져오기
		const selectedChk = []; 
		document.querySelectorAll('.chk:checked').forEach(checkbox => {
			selectedChk.push(checkbox.value); // 체크된 항목의 cartitem_idx 값을 배열에 넣기
		});
		
		if(selectedChk.length == 0) {
			// 체크된 항목이 없으면 알림창 띄우기
	        alert("주문할 상품을 선택해주세요.");
	        return;
		}
		
	    //체크한 항목들을 콤마로 구분된 문자열로 결합
	    const cartItemsParam = selectedChk.join(","); 
	//    console.log("cartItemsParam : " + cartItemsParam); //cartItemsParam : 8,7,6,3
	   	
		//AJAX 요청을 통해 주문 처리    
	    $.ajax({
			type : "Post",
			url : "SubcribeClassCheck",
			data : { //넘겨줄 데이터들 작성
				cartitem_idx : cartItemsParam //요청 파라미터
			}, 
			success : function(response) {
				console.log("조회된 결과:"+response); //갯수 출력
				if(response == 0) { //이미 수강중인게 없을 경우
					//체크된 항목 폼 제출
		        	document.getElementById('cartForm').submit();
				} else { // 수강 중인 강의가 있는 경우
					alert("이미 수강중인 클래스가 있습니다. \n해당 클래스 삭제 후 주문해 주세요.");
				}
			},
			error : function(jqXHR) {
				console.log(jqXHR);
			}
			
		});
	    
	    
    };
	
	//-----------------------------------------------------------------------------------
	// 페이지 로드시 초기화
    updateSelect();
	
});


//================================================================================
// 'X' 버튼(btn-del 클래스) 클릭시 해당상품 장바구니 테이블에서 삭제 (foreach로 각 상품)
//"삭제하시겠습니까?" 확인 창 출력 후 사용자로부터 "예/아니오" 입력받아 판별
$(document).on("click", ".btn-del", function(e) {
    // 삭제 여부 확인
    if (!confirm("삭제하시겠습니까?")) {
        return;  // "취소"를 클릭하면 아무 작업도 하지 않음
    }
    // "확인"을 클릭하면 삭제 요청을 GET 방식으로 보냄
    const cartItemIdx = $(this).data("cartitem"); //data-cartitem 속성에서 값 가져오기

    // 삭제 요청을 GET 방식으로 보내는 URL로 이동
    window.location.href = "DeleteItem?cartitem_idx=" + cartItemIdx;
    
});

//================================================================================
// '선택삭제' 버튼 클릭시 체크한 상품을 장바구니 테이블에서 삭제 chkDelete()
function chkDelete() {
	// 삭제 확인 메세지
    if (!confirm("선택된 상품을 삭제하시겠습니까?")) {
        return;
    }
	
	// 선택한 체크박스 가져오기 (상수로 선언=const 변하지 않는 값)
	const selectedChk = []; 
	document.querySelectorAll('.chk:checked').forEach(checkbox => {
		selectedChk.push(checkbox.value); // 체크된 항목의 cartitem_idx 값을 배열에 넣기
	});
	
	if(selectedChk.length == 0) {
		alert("선택된 상품이 없습니다.");
		return;
	}
   
    //선택된 항목들을 콤마로 구분된 문자열로 결합
    const cartItemsParam = selectedChk.join(","); 
//    console.log("cartItemsParam : " + cartItemsParam); //cartItemsParam : 8,7,6,3
   	
	//AJAX 요청을 통해 삭제 처리    
    $.ajax({
		type : "GET",
		url : "DeleteItems",
		data : { //넘겨줄 데이터들 작성
			cartitem_idx : cartItemsParam //요청 파라미터
		}, 
		success : function(response) {
			alert("선택한 상품이 삭제되었습니다.");
			location.reload();// 삭제 후 페이지 새로 고침
		},
		error : function(jqXHR) {
			console.log("삭제 요청중 오류 발생 : "+ jqXHR);
			alert("삭제에 실패하였습니다. 다시 시도해주세요.");
		}
		
	});
    
}
