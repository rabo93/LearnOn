<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

<!-- page 개별 CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/cart.css">
<!-- page 개별 JS 
	 (defer 속성 : 페이지가 모두 로드된 후에 해당 외부 스크립트가 실행됨) --> 
<script src="${pageContext.request.contextPath}/resources/js/cart_payment/cart.js"></script>

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
							<!-- 전체선택 체크박스-->
							<input type="checkbox" id="checkAll" checked="checked">
							<label for="checkAll">전체선택</label>
							<!-- 선택삭제 버튼-->
							<input type="button" value="선택삭제" class="select-del" onclick="chkDelete()">
						</div>
						
						<c:choose>
							<%--장바구니에 아무것도 담겨져 있지 않은 경우 --%>
							<c:when test="${empty cartList}">
								<p>장바구니에 담은 상품이 없습니다.</p>
							</c:when>
							
							<c:otherwise>
							<%-- 상품이 존재할 경우 - 여러개일 경우 단락 반복--%>
								<c:set var="total" value="0"/> 
									<c:forEach var="cart" items="${cartList}" varStatus="status"> 
										<div class="cart-item">
												<!-- 상품별 체크박스 -->
												<div class="item-btns">
													<input type="checkbox" class="chk" name="checkitem" value="${cart.cartitem_idx}" data-price="${cart.class_price}" >
													<%-- 체크 후 서버 넘길때 checkitem=${cart.cartitem_idx}로 넘어감 --%>
														
												     <!-- X버튼 클릭시 해당상품 삭제(1개) -->
												     <a href="javascript:void(0)" class="btn-del" data-cartitem="${cart.cartitem_idx}">
												    	<i class="fa-solid fa-xmark"></i>
												    </a>
												</div>
												<!-- 상품 정보 내역 클릭시 강의 상세 페이지로 이동(class_id 값 전달)-->
												<a href='CourseDetail?CLASS_ID=${cart.class_id}' class="item-link">
													<div class="class-pic">
														<!-- 썸네일 사진 나중에 바꿀것!! -->
														<img src="${pageContext.request.contextPath}/resources/images/thumb_01.webp">
			<%-- 											<img src="${cart.class_pic1}"> --%>
													</div>
													<div class="item-info">
														<p>${cart.class_title}</p>
														<p>${cart.mem_name}</p>
													</div>
												</a>
												<!-- 상품 금액 -->
												<div class="item-result">
													<fmt:formatNumber var="price" value="${cart.class_price}" type="number"/>
													<span class="price">${price}</span>원
													<!-- 반복하면서 각 상품의 가격을 total에 누적 -->
													<c:set var="total" value="${total + cart.class_price}" />
												</div>
										</div>
									</c:forEach> <!-- foreach문 끝 -->
							</c:otherwise>
						</c:choose>
						
					</section>
					
					<!-- ----------------- 장바구니 주문 금액 ---------------->
					<section class="cart-right">
						<form action="Payment" method="get" class="price-box">
							<dl>
								<dt>총 상품 금액</dt>
								<fmt:formatNumber var="total" value="${total}" type="number"/>
								<dd><c:out value="${total}원"/></dd>
							</dl>
							
							<dl>
								<dt>선택 상품 수</dt>
								<dd>총 <span id="itemCount"></span>건</dd>
							</dl>
							<!-- 아래 주문금액은 서버단으로 넘겨야함 -->
							<dl class="total">
								<dt>주문 금액</dt>
								<dd><span id="totalAmount"></span>원</dd>
							</dl>
						</form>
						<!-- ----------------- 주문 버튼 ---------------->
						<div class="btns-box">
							<!-- !!!!!!!!!!!!!지금 구현해야하는거!!!!!!!!!!!!!!!!! -->
							<input type="submit" value="주문하기" class="btnSubmit" onclick="orderCart()">
							<input type="button" value="돌아가기" class="btnHome" onclick="location.href='./'">
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