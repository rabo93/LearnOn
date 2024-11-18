<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>쿠폰</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/reset.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">

<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/index.js"></script>

<!-- page 개별 CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/coupon.css">
<!-- page 개별 JS -->
<script src="${pageContext.request.contextPath}/resources/js/coupon.js"></script>

</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
	</header>
	
	<!----------------------------- page 영역 --------------------------- -->
	<!-- -----------------쿠폰선택 버튼시 모달창 영역------------------ -->
	<section class="modal">
		<div class="coupon-modal">
			<div class="coupon">
				<div class="coupon-header">
					<p>쿠폰 선택</p>
				</div>
				
				
				<c:forEach var="coupon" items="${coupon}">
					<div class="coupon-view">
						<p>${coupon.MEM_ID}쿠폰 사용 가능 상품</p>
						
						<ul class="coupon-list">
							
							<!-- li 쿠폰 목록 반복 -->
							<li class="coupon-list-item">
								<!-- 클래스정보 -->
<%-- 								<span class="item-info">프로그래머${coupon.CLASS_TITLE}</span> --%>
								<!-- 쿠폰선택상자 -->
								<div class="selectbox">
									<button type="button" class="select-btn">
<%-- 										<span>사용가능 쿠폰 <i>${coupon.CNT}</i>장</span> --%>
										<i class="fa-solid fa-chevron-down"></i>
									</button>
									
									<!-- 쿠폰내역 -->
									<div class="select-list">
										<div class="select-list-item">
											<input type="radio" id="coupon-default" class="coupon-group"  value="None" name="coupon-group">
											<label for="coupon-default" class="coupon-select__label">선택 안함</label>
										</div>
										
										<div class="select-list-item">
											<input type="radio" id="coupon" class="coupon-group" 
												 value="${coupon.COUPON_CODE}" name="coupon-group">
											<label for="coupon" class="coupon-seleect__label">
												<span class="coupon-select__title">${coupon.COUPON_NAME}</span>
												<span class="coupon-select__desc">
													<small>
													<c:choose>
														<c:when test="${coupon.DISCOUNT_AMOUNT} eq '0'">
														${coupon.DISCOUNT_PERCENT}원 할인
														</c:when>
														<c:when test="${coupon.DISCOUNT_PERCENT} eq '0'">
														${coupon.DISCOUNT_AMOUNT}원 할인
														</c:when>
													</c:choose>
													</small>
												</span>
											</label>
										</div>
										
									</div>
								</div>
								
								<div class="price">
<%-- 									<div class="price-view">판매가 <span>${coupon.CLASS_PRICE}원</span></div> --%>
<%-- 									<div class="price-view-discount">할인 금액<span>${coupon.TOTAL_DISCOUNT}원</span></div> --%>
<%-- 									<div class="price-view-total">쿠폰할인가<span>${coupon.CLASS_PRICE-coupon.TOTAL_DISCOUNT}원</span></div> --%>
								</div>
							</li>
						
						</ul>
						
					</div>
					
<%-- 					<c:set var="total" value="${total + coupon.TOTAL_DISCOUNT}" /> --%>
				</c:forEach>
				
				
				<!-- 쿠폰 적용 버튼 -->
				<div class="coupon-apply">
				<button type="button" class="btn-close" onclick="history.back()">취소</button>
				<button type="button" class="btn-apply">
					<c:out value="${total}원 할인 적용"></c:out>
				</button>
				</div>
		
			</div>
		</div>
	</section>
	
	
	
	
	<!----------------------------- page 영역 --------------------------- -->
	
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
	</footer>


</body>
</html>