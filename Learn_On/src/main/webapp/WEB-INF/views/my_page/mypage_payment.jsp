<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>런온</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/reset.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css">
    
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/modal.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/rating.js"></script>

</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
	</header>
	<main>
		<!-- 계정설정 -->
		<h2 class="page-ttl">마이페이지</h2>
		<section class="my-wrap">
			<aside class="my-menu">
				<a href="MyInfo">계정정보</a>
				<a href="MyFav">관심목록</a>
				<a href="MyDashboard">나의 강의실</a>
				<a href="MyReview">작성한 수강평</a>
				<a href="MyPayment" class="active">결제내역</a>
				<a href="MyCoupon">보유한 쿠폰</a>
				<a href="MySupport">문의내역</a>
				<a href="MyAttendance">출석체크</a>
			</aside>
			<div class="my-container">
				<div class="contents-ttl">결제내역</div>
				<div class="contents">
					<!-- contents -->
					<section class="payment-wrap">
						<div class="my-ord-li">
							<c:choose>
								<c:when test="${empty paymentList}">
									<article class="ord-box">
										결제내역이 존재하지 않습니다.
									</article>
								</c:when>
								<c:otherwise>
									<c:forEach var="payment" items="${paymentList}">
										<article class="ord-box">
											<div class="infos">
												<div class="info">
													<span class="status">
														<c:if test="${payment.value[0].pay_status == 1}">
															결제완료
														</c:if>
														<c:if test="${payment.value[0].pay_status == 2}">
															결제취소
														</c:if>
														<c:if test="${payment.value[0].pay_status == 3}">
															입금대기
														</c:if>
													</span>
													<span>결제번호</span>
													<span class="num">${payment.key}</span>
												</div>
												<div class="products">
													<c:forEach var="item" items="${payment.value}">
														<span class="ttl">${item.class_title}</span>
													</c:forEach>
												</div>
											</div>
											<div class="price">
												<dl class="pri">
													<dt>금액</dt>
													<c:forEach var="item" items="${payment.value}">
													<dd>￦ ${item.class_price}</dd>
													</c:forEach>
												</dl>
												<dl class="dis">
													<dt>할인</dt>
													<dd>- 
<%-- 														<c:if test="${payment.value.discount_type == 1}"> --%>
<%-- 															${payment.value.discount_percent} % --%>
<%-- 														</c:if> --%>
<%-- 														<c:if test="${payment.value.discount_type == 2}"> --%>
<%-- 															￦ <fmt:formatNumber pattern="#,###">${payment.value[0].discount_amount}</fmt:formatNumber> --%>
<%-- 														</c:if> --%>
													</dd>
												</dl>
												<dl class="total">
													<dt>합계</dt>
<%-- 													<dd>￦ <fmt:formatNumber pattern="#,###">${payment.value[0].result_price}</fmt:formatNumber></dd> --%>
												</dl>
											</div>
											<div class="btns">
<%-- 												<a href="${payment.value.receipt_url}" target="_blank">영수증 보기</a> --%>
											</div>
										</article>
									</c:forEach>
								</c:otherwise>
							</c:choose>	
									
							<%-- article class="ord-box">
								<div class="infos">
									<div class="info">
										<span class="status">결제완료</span>
										<span>주문번호</span>
										<span class="num">1230459</span>
									</div>
									<div class="products">
										<span class="ttl">홍길동의 실전자바 - 고급1편, 멀티스레드와 동시성</span>
										<span class="ttl">어쩌주저쩌구 2편</span>
									</div>
								</div>
								<div class="price">
									<dl class="pri">
										<dt>금액</dt>
										<dd>￦155,000</dd>
									</dl>
									<dl class="dis">
										<dt>할인</dt>
										<dd>- ￦ 55,000</dd>
									</dl>
									<dl class="total">
										<dt>합계</dt>
										<dd>￦ 100,000</dd>
									</dl>
								</div>
								<div class="btns">
									<button>영수증 보기</button>
									<button>거래명세서 보기</button>
								</div>
							</article --%>
						</div>
					</section>
					<!-- // contents -->
				</div>
			</div>
		</section>
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
	</footer>
</body>
</html>