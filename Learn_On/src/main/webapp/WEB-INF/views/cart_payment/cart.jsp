<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%--
JSTL - format(fmt) 라이브러리를 활용하여 날짜 및 시각 형식(포맷) 변경
1) <fmt:formatDate> : Date 등의 날짜 및 포맷 객체의 날짜 형식 변경
   => <fmt:formatDate value="${날짜 및 시각 객체}" pattern="표현패턴">
   => 자바의 SimpleDateFormat 등의 포맷팅 클래스와 동일한 역할 수행
2) <fmt:parseDate> : String 객체의 날짜 형식 변경
----------------------------------------------------------------------
[ 날짜 및 시각 형식을 지정하는 패턴 문자 ]
y : 연도(yy : 연도 2자리, yyyy : 연도 4자리)
M : 월(MM : 월 2자리)
d : 일(dd : 일 2자리)
H : 시(HH : 24시간제, hh : 12시간제)
m : 분(mm : 분 2자리)
s : 초(ss : 초 2자리) 
--%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>장바구니</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/reset.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">

<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/index.js"></script>

<!-- page 개별 CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/cart.css">
<!-- page 개별 JS 
	 (defer 속성 : 페이지가 모두 로드된 후에 해당 외부 스크립트가 실행됨) --> 
<script src="${pageContext.request.contextPath}/resources/js/cart.js"></script>

</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
	</header>
	
	<!----------------------------- page 영역 --------------------------- -->
	<main id="cart">
		<div class="wrapper">
		
			<!-- cart-wrap start  -->
			<div class="cart-wrap">
				<h2 class="cart-ttl">장바구니</h2>
				<!-- -----------------장바구니 상품 목록 ---------------->
				<div class="frame">
				
					<section class="cart-list">
						<div class="cart-select">
							<!-- 전체선택 -->
<!-- 							<input type="checkbox" id="checkAll"> -->
							<input type="checkbox" id="checkAll" checked="checked">
							<label for="checkAll">전체선택</label>
							<!-- 선택삭제 -->
							<button class="btn-del" onclick="chkDelete()">선택삭제</button>
						</div>
						<!-- 상품 내역 cartList객체를 cart에 담음 -->
						<c:forEach var="cart" items="${cartList}" varStatus="status"> 
						<div class="cart-item">
							<!-- 주문상품 상세내역(클릭시 상품상세페이지로 이동) -->
<!-- 						<a href="course-detail" class="item-link"> -->
							<c:choose>
								<%--장바구니에 아무것도 담겨져 있지 않은 경우 --%>
								<c:when test="${empty cartList}">
									<p>장바구니에 담은 상품이 없습니다.</p>
								</c:when>
								
								<c:otherwise>
								<%-- 상품이 존재할 경우 - 여러개일 경우 단락 반복--%>
									<!-- 상품별 선택버튼 -->
									<div class="item-btns">
										<input type="checkbox" class="chk" name="checkitem" value="${cart.CLASS_ID}">
											<!-- 아래 카운튼나중에 지울겁니당(확인용) -->
										    <span>${status.count}</span>
<%-- 									    <button class="btn-del" onclick="deleteItem(this)" data-cartitem-id="${cart.CARTITEM_IDX}"> --%>
									    <button class="btn-del" onclick="deleteItem()">
									    	<i class="fa-solid fa-xmark"></i>
									    </button>
									</div>
									<!-- 상품 정보 내역 클릭시 강의 상세 페이지로 이동(CLASS_ID 전달)-->
									<a href='CourseDetail?CLASS_ID=${cart.CLASS_ID}' class="item-link">
										<div class="class-pic">
											<!-- 썸네일 사진 나중에 바꿀것!! -->
											<img src="/resources/images/thumb_01.webp">
<%-- 											<img src="${cart.CLASS_PIC1}"> --%>
										</div>
										<div class="item-info">
											<p>${cart.CLASS_TITLE}</p>
											<p>${cart.MEM_NAME}</p>
										</div>
									</a>
									<!-- 상품 금액 -->
									<div class="item-result">
										<fmt:formatNumber var="price" value="${cart.CLASS_PRICE}" type="number"/>
										<span class="price">${price}</span>원
										<!-- 반복하면서 각 상품의 가격을 total에 누적 -->
										<c:set var="total" value="${total + cart.CLASS_PRICE}" />
									</div>
								</c:otherwise>
								
							</c:choose>
						</div>
						</c:forEach> <!-- foreach문 끝 -->
					</section>
					
					<!-- ----------------- 장바구니 주문 금액 ---------------->
					<section class="cart-right">
						<div class="price-box">
							<dl>
								<dt>총 상품 금액</dt>
								<fmt:formatNumber var="total" value="${total}" type="number"/>
								<dd><c:out value="${total}원"/></dd>
							</dl>
							<dl>
								<dt>선택 상품 수</dt>
								<dd>총 <span id="itemCount">0</span>건</dd>
							</dl>
							<dl class="total">
								<dt>주문 금액</dt>
								<dd><span id="totalAmount">0</span>원</dd>
							</dl>
						</div>
						<!-- ----------------- 주문 버튼 ---------------->
						<div class="btns-box">
							<input type="hidden" name="memId" value="hong1234"> <!-- 예제용으로 회원 ID 하드코딩 -->
							<input type="submit" value="주문하기" class="btnSubmit" onclick="orderCart()">
							<input type="button" value="돌아가기" class="btnBack" onclick="history.back()">
						</div>
						<!-- ----------------- 장바구니 약관 ---------------->
						<div class="notice-box">
			<!-- 					아래의 내용은 확인 후 적용 예정 -->
			<!-- 					* 장바구니 상품은 30일동안 보관되며, 최대 10개까지 담을 수 있습니다.<br> -->
							* 보유하신 쿠폰은 주문서에서 적용 가능합니다.
						</div>
					</section>
				</div>
			</div>
			<!-- // cart-wrap end  -->
			
		</div>
	</main>
	
	<!----------------------------- page 영역 --------------------------- -->
	
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
	</footer>


</body>
</html>