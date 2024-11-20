<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
        		</div>
				<ul class="mgnb">
					<li class="mgnb-menu">
						<a href="#">카테고리</a>
						<ul class="mgnb-dep-01">
							<li><a href="Category?codetype=CATE01">IT/개발</a></li>
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
<!-- 					<li> -->
<!-- 						<a href="Category?codetype=CATE01">IT/개발</a> -->
<!-- 						<ul class="sub-dropdown"> -->
<!-- 							<li><a href="Category?codetype=CATE01">전체</a></li> -->
<!-- 							<li><a href="Category?codetype=CATE01&codetype_id=01">프로그래밍</a></li> -->
<!-- 							<li><a href="Category?codetype=CATE01&codetype_id=02">WEB 개발</a></li> -->
<!-- 							<li><a href="Category?codetype=CATE01&codetype_id=03">프론트엔드</a></li> -->
<!-- 							<li><a href="Category?codetype=CATE01&codetype_id=04">백엔드</a></li> -->
<!-- 							<li><a href="Category?codetype=CATE01&codetype_id=05">App</a></li> -->
<!-- 						</ul> -->
<!-- 					</li> -->


				
					<c:set var="cnt" value="0" />  <!-- cnt를 처음에 0으로 초기화 -->
					<c:forEach var="code" items="${requestScope.commonCode}" varStatus="count">
						<c:set var="num" value="${fn:substring(code.codetype, 4, 6)}"/>
						<!-- 처음 'num'이 cnt와 다를 때만 출력되게 설정 -->
<%-- 						CHOOSE UP NUM : ${num } --%>
						<c:choose>
							<c:when test="${num != cnt}">
									<!-- 여기서 반복 자체가 안됨.!! -->
									<li>								
										<a href="Category?codetype=${code.codetype}">${code.codename}</a>
										<ul class="sub-dropdown">
											<li><a href="Category?codetype=${code.codetype}">전체</a></li>
<%-- 											<li><a href="Category?codetype=${code.codetype}&codetype_id=${code.codetype_id}">${code.name}</a></li> --%>
											<%-- ================================================= --%>
											<%-- 객체를 다시 반복 --%>
											<c:forEach var="subcode" items="${requestScope.codeTypeAll}" varStatus="count">
												<%-- code 객체의 codeType 과 새로 반복하는 codeType 이 같으면--%>
												<%-- 서브카테고리명 출력 --%>
												<c:if test="${subcode.codetype eq code.codetype}">
													<li><a href="Category?codetype=${subcode.codetype}&codetype_id=${subcode.codetype_id}">${subcode.name}</a></li>
												</c:if>
											</c:forEach>										
											<%-- ================================================= --%>
										</ul>
									</li>
								<!-- codetype이 바뀔 때만 출력 -->
<%-- 							CHOOSE DOWN NUM : ${num } --%>
								<c:set var="cnt" value="${num}" /> <!-- 출력 후 cnt 값을 num으로 갱신 -->
							</c:when>
						</c:choose>
					</c:forEach>
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