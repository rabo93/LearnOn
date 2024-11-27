<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>런 온 - 온라인 No.1 교육 플랫폼</title>
<link rel="SHORTCUT ICON" href="${pageContext.request.contextPath}/resources/images/favicon.ico">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/reset.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<!-- page 개별 CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/pay_result.css">
<!-- page 개별 JS -->
<%-- <script src="${pageContext.request.contextPath}/resources/js/pay_result.js"></script> --%>

</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
	</header>
	
	<!----------------------------- page 영역 --------------------------- -->
	<main id="pay_result">
		<div class="wrapper">
			<!-- pay-wrap start  -->
			<div class="pay-wrap">
				<article class="ord-box">
					<div class="infos">
						<span class="result"><i class="fa-solid fa-check"></i>결제완료</span>
						<div class="info">
							<span>주문번호</span>
							<span class="num">${payinfo.merchant_uid}</span>
						</div>
						<div class="products">
							<span class="ttl">${payinfo.class_name}</span>
						</div>
					</div>
					<div class="price">
						<dl class="price-ttl">
							<dt class="price-ttl">결제 정보</dt>
						</dl>
						<dl class="pri">
							<dt>총 상품 금액</dt>
							<dd id="totalAmount">${payinfo.totalAmount}원</dd>
						</dl>
						<dl class="dis">
							<dt>할인 금액</dt>
							<dd id="discountAmount">${payinfo.discount_amount}원</dd>
						</dl>
						<dl class="total">
							<dt>총 결제 금액</dt>
							<dd id="totalPrice">${payinfo.price}원</dd>
						</dl>
						<dl class="Method">
							<!-- 결제수단이 카드일경우 카드정보, 가상계좌일경우 가상계좌정보 표출 -->
							<c:choose>
								<c:when test="${payinfo.pay_method == 'card'}">
									<dt>결제 카드</dt>
									<dd class="payMethod">${payinfo.card_name} / ${payinfo.card_num}</dd>
								</c:when>
								<c:otherwise>
									<dt>입금 계좌</dt>
									<dd class="payMethod">${payinfo.bank_name} / ${payinfo.bank_num}</dd>
								</c:otherwise>
							</c:choose>
						</dl>
						<!-- 결제수단이 가상계좌일경우 표출 -->
<!-- 						<dl class="vBank-exp"> -->
<!-- 							<dt>입금기한</dt> -->
<%-- 							<dd id="expDate">${payinfo.vbank_due}</dd> --%>
<!-- 						</dl> -->
					</div>
					<!-- 버튼 -->
					<div class="btns-box">
						<input type="button" value="메인 페이지" onclick="location.href='./'" class="btnHome">
						<input type="button" value="영수증 조회" onclick="location.href='${payinfo.receipt_url}'" class="btnReceipt">
						<input type="button" value="나의 강의실" onclick="location.href='MyDashboard'" class="btnMypage">
					</div>
				</article>
			</div>
			<!-- // pay-wrap end  -->
		</div>
	</main>
	<!----------------------------- page 영역 --------------------------- -->
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
	</footer>
</body>
</html>