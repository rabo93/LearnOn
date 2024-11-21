<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>할인쿠폰 선택 - LearOn</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/reset.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<!-- page 개별 CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mycoupon.css">
<!-- page 개별 JS -->
<script src="${pageContext.request.contextPath}/resources/js/cart_payment/mycoupon.js"></script>
<!-- 포트원 결제api sdk 추가 -->
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>

</head>
<body>
	<!----------------------------- page 영역 --------------------------- -->
	<section class="coupon">
	    <div class="my-container">
	        <div class="headline">
	            <h2 class="contents-ttl">보유한 쿠폰</h2>
	            <a href="javascript:window.close()" id="modal-del">
	                <i class="fa-solid fa-xmark"></i>
	            </a>
	        </div>
	        <div class="contents">
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
	                                    <li>
	                                        <p class="c-name">${coupon.COUPON_NAME}</p>
	                                        <p class="c-dis">
	                                            <c:choose>
	                                                <c:when test="${coupon.DISCOUNT_STATUS == 1}">
	                                                    ${coupon.DISCOUNT_PERCENT} %
	                                                </c:when>
	                                                <c:when test="${coupon.DISCOUNT_STATUS == 2}">
	                                                    ${coupon.DISCOUNT_AMOUNT} 원
	                                                </c:when>
	                                            </c:choose>
	                                        </p>
	                                        <p class="c-exp-date">
	                                            사용기한 : ~ 
	                                            <fmt:parseDate value="${coupon.C_EXPIRY_DATE}" var="couponDate" pattern="yyyy-MM-dd" />
	                                            <fmt:formatDate value="${couponDate}" pattern="yyyy년 MM월 dd일" /> 까지
	                                        </p>
<%-- 	                                        <input type="hidden" name="couponId" value="${coupon.COUPON_ID}"> --%>
<%-- 	                                        <button class="select-btn" data-coupon="${coupon}">사용하기</button> --%>
	                                        <button class="select-btn" 
	                                        data-coupon-id="${coupon.COUPON_ID}" 
										    data-discount-status="${coupon.DISCOUNT_STATUS}" 
										    data-discount-amount="${coupon.DISCOUNT_AMOUNT}" 
										    data-discount-percent="${coupon.DISCOUNT_PERCENT}" >
	                                        사용하기</button>
	                                    </li>
	                                </c:forEach>
	                            </c:otherwise>
	                        </c:choose>
	                    </ul>
	                </div>
	            </section>
	        </div>
	    </div>
	</section>
	
</body>
</html>