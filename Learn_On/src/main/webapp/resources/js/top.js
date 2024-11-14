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
			 $('#cartCount').html(data.cartCount); //장바구니 아이콘에 갯수 표시 
		}
	});
});
