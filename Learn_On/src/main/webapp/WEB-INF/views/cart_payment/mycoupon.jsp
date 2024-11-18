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

<!-- page 개별 CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/coupon.css">
<!-- page 개별 JS -->
<script src="${pageContext.request.contextPath}/resources/js/payment.js"></script>

</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
	</header>
	
	<!----------------------------- page 영역 --------------------------- -->
	<!-- -----------------쿠폰선택 버튼시 모달창 영역------------------ -->
	<section class="modal">
		<div class="my-container">
				<div class="contents-ttl">보유한 쿠폰</div>
				<div class="contents">
					<!-- contents -->
					<section class="coupon-wrap">
						<div class="coupon-total">
					        <div class="coupon-title">사용가능한 쿠폰</div>
					        <div class="coupon-count">${couponCount}</div>
					        <div class="coupon-unit">개</div>
						</div>
						<div class="coupon-list">
					    	<ul class="myCoupon">
					    		<c:choose>
					    			<c:when test="${empty coupon}">
					    				<li class="empty">발급받은 쿠폰이 없습니다.</li>
					    			</c:when>
					    			<c:otherwise>
						    			<c:forEach var="coupon" items="${coupon}">
							    			<li class="<c:if test='${coupon.COUPON_STATUS >= 2}'>end</c:if>">
								    			<p class="c-name">${coupon.COUPON_NAME}</p>
								    			<p class="c-exp-date">
								    				사용기한 : ~ 
								    				<fmt:parseDate value="${coupon.C_EXPIRY_DATE}" var="couponDate" pattern="yyyyMMdd" />
								    				<fmt:formatDate value="${couponDate}" pattern="yyyy년 MM월 dd일" /> 까지
								    			</p>
								    						
								    			<p class="c-dis">
								    				<c:choose>
								    					<c:when test="${not empty coupon.DISCOUNT_PERCENT}">
								    						${coupon.DISCOUNT_PERCENT} %
								    					</c:when>
								    					<c:when test="${not empty coupon.DISCOUNT_AMOUNT}">
								    						${coupon.DISCOUNT_AMOUNT} 원
								    					</c:when>
								    				</c:choose>
								    			</p>
								    		</li>
							    		</c:forEach>
					    			</c:otherwise>
					    		</c:choose>
					    		
					    	</ul>
						</div>
					</section>
					<!-- // contents -->
				</div>
								
								
				<!-- 쿠폰 총 할인 금액 표출 -->				
				<div class="price">
					<div class="price-view">판매가
						<span id="">원</span>
					</div>
					<div class="price-view-discount">할인 금액
						<span id="">원</span>
					</div>
					<div class="price-view-total">쿠폰할인가
						<span id="">원</span>
					</div>
				</div>
				
				<!-- 쿠폰 적용 버튼 -->
				<div class="coupon-apply">
				<button type="button" class="btn-close" onclick="history.back()">취소</button>
				<button type="button" class="btn-apply">
					<c:out value="${total}원 할인 적용"></c:out>
				</button>
				</div>
		
		</div>
	</section>
	
	
	
	
	<!----------------------------- page 영역 --------------------------- -->
	
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
	</footer>


</body>
</html>