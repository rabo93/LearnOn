<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="${pageContext.request.contextPath}/resources/js/top.js"></script>
    
<%-- header --%>
<script>
function logout() {
	if(confirm("로그아웃하시겠습니까?")){
		location.href = "MemberLogout"
	}
}
</script>
<header id="hd">
	<section id="hd_top">
		<div id="hd_logo">
			<a href="./"><h1><img src="${pageContext.request.contextPath}/resources/images/hd_logo2.png" alt="런온"></h1></a>
		</div>
		<div id="hd_sch">
			<form action="" method="post">
				<input type="text" name="" class="sch-input" placeholder="어떤 클래스를 찾으시나요?">
				<button type="submit" class="sch-submit">
					<i class="fa-solid fa-magnifying-glass"></i>
				</button>
			</form>
		</div>
		<div id="hd_right"<c:if test="${not empty sessionScope.sId}">
			class="on"
			</c:if>
		>  <!-- 로그인하면 class에 on 추가 -->
			<div class="normal-area">
				<a href="Cart" class="cart-btn"> 
					<span class="cart-count" id="cartCount"></span>
					<i class="fa-solid fa-cart-shopping"></i>
				</a>
<!-- 				<a href="#" class="login-btn">로그인</a> -->
				<a href="MemberLogin" class="login-btn">로그인</a>
			</div>
			<div class="login-area">
				<a href="MyDashboard">나의 강의실</a>
				<a href="MemberModify"><span>${sessionScope.sId}</span> 님</a>
				<a href="javascript:void(0)" onclick="logout()">로그아웃</a>
<!-- 				<a href="#">나의 강의실</a> -->
<!-- 				<a href="#"><span>홍길동</span> 님</a> -->
				<div class="login-menu">
					<a href="MyInfo">마이페이지</a>
					<a href="#">관리자 홈</a>
					<a href="#">로그아웃</a>
				</div>
			</div>
		</div>
		<div class="m-menu">
          <button class="hamburger hamburger--spin" type="button">
            <span class="hamburger-box">
              <span class="hamburger-inner"></span>
            </span>
          </button>
        </div>
        <div class="m-menu-wrap">
        	<div class="m-menu-bg">
        	
        	</div>
        	<nav id="m_nav">
        		<div class="m-info"> <!-- 로그인 하면 class에 on 추가 -->
        			<c:choose>
						<c:when test="${empty sessionScope.sId}">
	        				<a href="MemberLogin" class="login-link">로그인을 해주세요. <i class="fa-solid fa-arrow-right-to-bracket"></i></a>
						</c:when>
						<c:otherwise>
		        			<a href="MyInfo" class="my-info"><i class="fa-solid fa-gear"></i> <span>${sessionScope.sId} </span> 님</a>
		        			<a href="MyDashboard" class="my-course"> <i class="fa-solid fa-circle-play"></i> 나의 강의실</a>
						</c:otherwise>				
					</c:choose>
<!--         			<a href="#" class="login-link">로그인을 해주세요. <i class="fa-solid fa-arrow-right-to-bracket"></i></a> -->
<!--         			<a href="#" class="my-info"><i class="fa-solid fa-gear"></i> <span>홍길동</span> 님</a> -->
<!--         			<a href="#" class="my-course"> <i class="fa-solid fa-circle-play"></i> 나의 강의실</a> -->
        		</div>
				<ul class="mgnb">
					<li class="mgnb-menu">
						<a href="#">카테고리</a>
						<ul class="mgnb-dep-01">
							<li><a href="Category?codetype=CATE01">IT/개발</a></li>
							<li><a href="Category?codetype=CATE02">외국어</a></li>
							<li><a href="Category?codetype=CATE03">운동/건강</a></li>
							<li><a href="Category?codetype=CATE04">라이프스타일</a></li>
							<li><a href="Category?codetype=CATE05">음료/술</a></li>
						</ul>
					</li>
					<li class="gnb-menu"><a href="#">BEST</a></li>
					<li class="gnb-menu"><a href="#">얼리버드 특가</a></li>
					<li class="gnb-menu"><a href="#">이벤트</a></li>
					<li class="gnb-menu"><a href="#">AI 추천</a></li>
				</ul>
			</nav>
        </div>
	</section>
	<nav id="nav">	
		<ul class="navbar">
			<li><a href="#">카테고리</a>
				<div class="dropdown-bg"></div>
				<ul class="dropdown">
					<li>
						<a href="Category?codetype=CATE01">IT/개발</a>
						<ul class="sub-dropdown">
							<li><a href="Category?codetype=CATE01">전체</a></li>
							<li><a href="Category?codetype=CATE01&codetype_id=01">프로그래밍</a></li>
							<li><a href="Category?codetype=CATE01&codetype_id=02">WEB 개발</a></li>
							<li><a href="Category?codetype=CATE01&codetype_id=03">프론트엔드</a></li>
							<li><a href="Category?codetype=CATE01&codetype_id=04">백엔드</a></li>
							<li><a href="Category?codetype=CATE01&codetype_id=05">App</a></li>
						</ul>
					</li>
					<li>
						<a href="Category?codetype=CATE02">외국어</a>
						<ul class="sub-dropdown">
							<li><a href="Category?codetype=CATE02&codetype_id=01">영어</a></li>
							<li><a href="Category?codetype=CATE02&codetype_id=02">중국어</a></li>
							<li><a href="Category?codetype=CATE02&codetype_id=03">일본어</a></li>
							<li><a href="Category?codetype=CATE02&codetype_id=04">스페인어</a></li>
							<li><a href="Category?codetype=CATE02&codetype_id=05">프랑스어</a></li>
							<li><a href="Category?codetype=CATE02&codetype_id=06">기타언어</a></li>
						</ul>
					</li>
					<li>
						<a href="#">운동/건강</a>
						<ul class="sub-dropdown">
							<li><a href="Category?codetype=CATE03">전체</a></li>
							<li><a href="Category?codetype=CATE03&codetype_id=01">요가</a></li>
							<li><a href="Category?codetype=CATE03&codetype_id=02">필라테스</a></li>
							<li><a href="Category?codetype=CATE03&codetype_id=03">발레</a></li>
							<li><a href="Category?codetype=CATE03&codetype_id=04">피트니스</a></li>
							<li><a href="Category?codetype=CATE03&codetype_id=05">수영</a></li>
							<li><a href="Category?codetype=CATE03&codetype_id=06">러닝</a></li>
							<li><a href="Category?codetype=CATE03&codetype_id=07">사이클</a></li>
							<li><a href="Category?codetype=CATE03&codetype_id=08">스트레칭</a></li>
						</ul>
					</li>
					<li>
						<a href="#">라이프스타일</a>
						<ul class="sub-dropdown">
							<li><a href="Category?codetype=CATE04">전체</a></li>
							<li><a href="Category?codetype=CATE04&codetype_id=01">드로잉</a></li>
							<li><a href="Category?codetype=CATE04&codetype_id=02">공예</a></li>
							<li><a href="Category?codetype=CATE04&codetype_id=03">사진,영상</a></li>
							<li><a href="Category?codetype=CATE04&codetype_id=04">영상</a></li>
							<li><a href="Category?codetype=CATE04&codetype_id=05">DIY</a></li>
							<li><a href="Category?codetype=CATE04&codetype_id=06">기타</a></li>
						</ul>
					</li>
					<li>
						<a href="#">요리/음료</a>
						<ul class="sub-dropdown">
							<li><a href="#Category?codetype=CATE05">전체</a></li>
							<li><a href="Category?codetype=CATE05&codetype_id=01">한식</a></li>
							<li><a href="Category?codetype=CATE05&codetype_id=02">일식</a></li>
							<li><a href="Category?codetype=CATE05&codetype_id=03">중식</a></li>
							<li><a href="Category?codetype=CATE05&codetype_id=04">양식</a></li>
							<li><a href="Category?codetype=CATE05&codetype_id=05">비건</a></li>
							<li><a href="Category?codetype=CATE05&codetype_id=06">음료</a></li>
							<li><a href="Category?codetype=CATE05&codetype_id=07">술</a></li>
						</ul>
					</li>
				</ul>
			</li>
			<li><a href="#">BEST</a></li>
			<li><a href="#">얼리버드 특가</a></li>
			<li><a href="#">이벤트</a></li>
			<li><a href="#">AI 추천</a></li>
		</ul>
	</nav>
</header>

<%-- // header --%>