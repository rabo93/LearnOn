$(document).ready(function(){
	// header
	// hamburger menu (mobile menu)
	const hamburger = document.querySelector('.hamburger');
	const mobileMenu = document.querySelector('.m-menu-wrap');
	hamburger.addEventListener("click", function () {
	  hamburger.classList.toggle("is-active");
	  mobileMenu.classList.toggle("is-active");
	});
	//================================================================================
	// 페이지 로드시 장바구니 개수 불러오기
	$.ajax({
		type : "get",
		url : "CartCount",
        dataType: "json",
        
		success : function(data) {
			if(!data.isLogin) {
				$('.cart-btn').hide(); // 로그인하지 않은 경우 장바구니 버튼 숨김
				
			} else { //로그인 되어 있는 경우 
				if(data.cartCount > 0) { //장바구니에 담겨 있는 경우 
					$('#cartCount').html(data.cartCount);
				} else { //장바구니 갯수 0일 경우 
					$('#cartCount').html("0");
				}
			}
		},
		error: function(jqXHR) {
			console.log("장바구니 개수 불러오기 오류 : "+ jqXHR);
		}
	});
	$.ajax({
		type: "get",
		url: "TopMenu",
		dataType: "json",
		success : function(data) {
			console.log(data);
		},
		error: function(){
			alert("메뉴 불러오기 실패");
		}
	});	
	
});
