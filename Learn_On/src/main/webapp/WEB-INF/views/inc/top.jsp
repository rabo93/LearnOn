<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="${pageContext.request.contextPath}/resources/js/top.js"></script>
    
<%-- header --%>
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
		<div id="hd_right"> <!-- 로그인하면 class에 on 추가 -->
			<div class="normal-area">
				<a href="Cart" class="cart-btn"> 
					<span class="cart-count" id="cartCount"></span>
					<i class="fa-solid fa-cart-shopping"></i>
				</a>
				<a href="#" class="login-btn">로그인</a>
			</div>
			<div class="login-area">
				<a href="#">나의 강의실</a>
				<a href="#"><span>홍길동</span> 님</a>
				<div class="login-menu">
					<a href="#">마이페이지</a>
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
        			<a href="#" class="login-link">로그인을 해주세요. <i class="fa-solid fa-arrow-right-to-bracket"></i></a>
        			<a href="#" class="my-info"><i class="fa-solid fa-gear"></i> <span>홍길동</span> 님</a>
        			<a href="#" class="my-course"> <i class="fa-solid fa-circle-play"></i> 나의 강의실</a>
        		</div>
				<ul class="mgnb">
					<li class="mgnb-menu">
						<a href="#">카테고리</a>
						<ul class="mgnb-dep-01">
							<li><a href="#">IT/개발</a></li>
							<li><a href="#">외국어</a></li>
							<li><a href="#">운동/건강</a></li>
							<li><a href="#">라이프스타일</a></li>
							<li><a href="#">음료/술</a></li>
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
						<a href="#">IT/개발</a>
						<ul class="sub-dropdown">
							<li><a href="#">전체</a></li>
							<li><a href="#">프로그래밍</a></li>
							<li><a href="#">WEB 개발</a></li>
							<li><a href="#">프론트엔드</a></li>
							<li><a href="#">백엔드</a></li>
							<li><a href="#">App</a></li>
						</ul>
					</li>
					<li>
						<a href="#">외국어</a>
						<ul class="sub-dropdown">
							<li><a href="#">전체</a></li>
							<li><a href="#">영어</a></li>
							<li><a href="#">중국어</a></li>
							<li><a href="#">일본어</a></li>
							<li><a href="#">스페인어</a></li>
							<li><a href="#">기타언어</a></li>
						</ul>
					</li>
					<li>
						<a href="#">운동/건강</a>
						<ul class="sub-dropdown">
							<li><a href="#">전체
							<li><a href="#">요가</a></li>
							<li><a href="#">필라테스</a></li>
							<li><a href="#">피트니스</a></li>
							<li><a href="#">러닝, 사이클</a></li>
							<li><a href="#">스트레칭</a></li>
						</ul>
					</li>
					<li>
						<a href="#">라이프스타일</a>
						<ul class="sub-dropdown">
							<li><a href="#">전체
							<li><a href="#">드로잉</a></li>
							<li><a href="#">공예</a></li>
							<li><a href="#">사진,영상</a></li>
							<li><a href="#">DIY</a></li>
							<li><a href="#">기타</a></li>
						</ul>
					</li>
					<li>
						<a href="#">요리/음료</a>
						<ul class="sub-dropdown">
							<li><a href="#">전체
							<li><a href="#">한식</a></li>
							<li><a href="#">일식, 중식</a></li>
							<li><a href="#">양식, 세계요리</a></li>
							<li><a href="#">비건, 건강식</a></li>
							<li><a href="#">음료,술</a></li>
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