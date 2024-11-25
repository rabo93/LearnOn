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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/terms.css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>

</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
	</header>
	<main>
		<div class="terms-wrap">
			<h1 class="terms-ttl">환불규정</h1>
			<div class="terms-con">
			    <div>환불 규정은 회원의 권익 보호를 목적으로 운영됩니다.</div>
			    
			    <p>1. 환불 신청 조건</p>
			    <div>다음 조건을 충족하는 경우 환불이 가능합니다:</div>
			    <ul>
			      <li>결제 후 7일 이내에 강의 시청 기록이 없는 경우</li>
			      <li>구매 후 제공된 콘텐츠에 중대한 결함이 있는 경우</li>
			    </ul>
			
			    <p>2. 환불 절차</p>
			    <div>환불 요청은 이메일 또는 고객센터를 통해 접수하며, 검토 후 7영업일 이내에 환불 처리됩니다.</div>
			    
			    <p>3. 환불 불가 사항</p>
			    <div>다음의 경우 환불이 제한될 수 있습니다:</div>
			    <ul>
			      <li>강의 시청 기록이 존재하는 경우</li>
			      <li>패키지 강의 또는 할인 상품</li>
			    </ul>
			</div>
					
		</div>
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
	</footer>
</body>
</html>