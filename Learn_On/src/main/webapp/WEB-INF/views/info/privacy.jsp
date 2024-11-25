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
			<h1 class="terms-ttl">개인정보처리방침</h1>
			<div class="terms-con">
			    <div>본 사이트는 회원의 개인정보를 중요하게 생각하며, 이를 안전하게 보호하기 위해 최선을 다하고 있습니다.</div>
    
			    <p>1. 수집하는 개인정보</p>
			    <div>본 사이트는 다음과 같은 개인정보를 수집합니다:</div>
			    <ul>
			      <li>회원가입 정보: 이름, 이메일, 비밀번호</li>
			      <li>결제 정보: 신용카드 정보, 송금 내역</li>
			      <li>서비스 이용 기록: 접속 로그, 사용 통계</li>
			    </ul>
			
			    <p>2. 개인정보 이용 목적</p>
			    <div>수집된 개인정보는 다음과 같은 목적으로 사용됩니다:</div>
			    <ul>
			      <li>회원 식별 및 서비스 제공</li>
			      <li>결제 처리 및 서비스 이용 통계 분석</li>
			      <li>마케팅 및 프로모션 제공</li>
			    </ul>
			
			    <p>3. 개인정보 보관 기간</p>
			    <div>회원의 개인정보는 법적 요구 사항에 따라 필요한 기간 동안 보관되며, 이후 안전하게 삭제됩니다.</div>
			</div>
					
		</div>
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
	</footer>
</body>
</html>