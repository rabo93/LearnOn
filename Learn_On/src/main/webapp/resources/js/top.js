$(document).ready(function(){
	// header
	// hamburger menu (mobile menu)
	const hamburger = document.querySelector('.hamburger');
	const mobileMenu = document.querySelector('.m-menu-wrap');
	hamburger.addEventListener("click", function () {
	  hamburger.classList.toggle("is-active");
	  mobileMenu.classList.toggle("is-active");
	});
});

//================================================================================
// 페이지 로드시 장바구니 개수 불러오기
$(document).ready(function() {
	$.ajax({
		type : "get",
		url : "CartCount",
        dataType: "json",
        
		success : function(data) {
			if (data.cartCount == "") {
				$('.cart-btn').hide(); // 로그인하지 않은 경우 장바구니 아이콘 숨김
			} else {
				// 로그인되어 있으면 장바구니 개수 표시
				$('#cartCount').html(data.cartCount);
			}
		},
		error: function(jqXHR) {
			console.log("장바구니 개수 불러오기 오류 : "+ jqXHR);
			$('.cart-btn').hide(); // 오류 발생 시 아이콘 숨김
		}
	});
});
