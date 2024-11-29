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
//			console.log(data);
			let resultArea = document.querySelector("#resultArea");
			
			const newData = data.reduce((acc, item) => {
				const {MAIN_MENU, SUB_MENU, CODEID, CODETYPE_ID} = item;
				
				if(!acc[CODEID]) {
					acc[CODEID] = {MAIN_MENU, CODEID, sub_menu: []}; // 배열 생성
				}
				acc[CODEID].sub_menu.push({CODETYPE_ID, SUB_MENU});
				return acc;
				
			}, {});
			
			const dataArr = Object.values(newData);
			
			dataArr.forEach((item, i) => {
				resultArea.innerHTML += `<li><a href="Category?codetype=${item.CODEID}">${item.MAIN_MENU}</a><ul class="sub-dropdown sub-dropdown${i}"></ul></li>`;
				item.sub_menu.forEach((sub) => {
					let subMenu = document.createElement("li");
					subMenu.innerHTML += `<a href="Category?codetype=${item.CODEID}&codetype_id=${sub.CODETYPE_ID}">${sub.SUB_MENU}</a>`;
					document.querySelector(`.sub-dropdown${i}`).append(subMenu);
				});
			}); 
		}, error: function(){
			alert("메뉴 불러오기 실패");
		}
	});	
	
});
//	닉네임 클릭 시 나의강의실/마이페이지/관리자홈/로그아웃 표시
function toggleLoginMenu(){
	let loginMenu = document.querySelector(".login-menu");
	loginMenu.classList.toggle("on");
}