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
			for(let i of data) {
				let code = i.CODEID;
				if(code != code_test){
					$("#resultArea").append(
							"<li><a href='Category?codetype=" + code + "'>"+ i.MAIN_MENU +"</a></li>"
					);
					for(let j of data) {
						if(code == 	j.CODEID) { 
							$("#subResultArea").append(
								"<li>code?"+code+", j.codeid?"+j.CODEID+"</li>"
							);
						}
					}
				}
				var code_test = code;
			}
//				for(let sub of data) {
//					if(arr = sub.MAIN_MENU) {
//						$("#subResultArea").append(
//							"<li><a href='Category?codetype=" + sub.CODEID + "'>"+ sub.SUB_MENU +"</a></li>"
//						);
//					} 
//				}
		},
		error: function(){
			alert("메뉴 불러오기 실패");
		}
	});	
	
});
