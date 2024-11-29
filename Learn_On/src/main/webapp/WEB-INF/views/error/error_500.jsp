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
    
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<style>
	.error { color:#13AE85;width:100%;min-height: 100vh;text-align: center;display: flex;align-items: center;justify-content: center;flex-direction: column;overflow-y: auto;overflow-x: hidden;}
	.error .error-box {padding:0 30px;}
	.error .error-box img {margin: 0 auto;width: min(515px, 100%);}
	.error .error-box .desc {padding:20px 0;font-size:20px;line-height: 1.6;}
	.error .error-box .desc p {display: block;font-size: 30px;margin-bottom:20px;font-weight:800}
	.error .error-box .desc span {display: block;}
	.error .error-box .desc button {margin:40px auto;background:#222943;padding:10px 40px; border-radius:50px; font-weight:700;color:#C4FEA1;}
	
	@media screen and (max-width:1023px){
	  .error .error-box .desc {font-size:18px;}
	  .error .error-box .desc p {font-size:26px;margin-bottom: 10px;}
	  .error .error-box .desc button {margin:20px auto;}
	}
	
	@media screen and (max-width:640px){
	  .error .error-box .desc {font-size:14px;}
	  .error .error-box .desc p {font-size:18px;margin-bottom: 10px;}
	}
</style>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
	</header>
	<main>
		<div class="error">
			<div class="error-box">
				<i class="fa-solid fa-triangle-exclamation"></i>
				<div class="desc">
					<p>웹 페이지를 표시할 수 없습니다.</p>
					<span>
						500 Internal Server Error
					</span>
				</div>
			</div>
		</div>
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
	</footer>
</body>
</html>