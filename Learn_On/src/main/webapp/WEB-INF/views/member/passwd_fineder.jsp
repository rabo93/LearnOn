<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"
	integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/reset.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/common.css">
<script
	src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<%-- <script src="${pageContext.request.contextPath}/resources/js/index.js"></script> --%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/login.css">

</head>
<main>
	<body>
		<header id="hd">
			<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
		</header>
			<form action="PasswdFinder" method="post">
				<h3>비밀번호 찾기</h3>
				<input type="text" placeholder="이름을 입력해주세요" id="name" name="mem_name" required><br> 
				<input type="text" placeholder="이메일 입력" id="email" name="mem_email" required>
				<input type="submit" value="본인확인"><br> 
			</form>
		</body>
</main>
<footer id="ft">
	<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
</footer>
</body>
</html>