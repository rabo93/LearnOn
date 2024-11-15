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
<script src="${pageContext.request.contextPath}/resources/js/dashboard.js"></script>

</head>
<body>
	<main id="myCourseDashboard">
		<div class="contents">
			<div class="hd">
				<a href="MyDashboard" class="back-btn"><i class="fa-solid fa-arrow-up-right-from-square"></i> 뒤로가기</a>
				<h2 class="ttl">자바 고급 2편</h2>
			</div>
			<div class="video">
				<video controls muted>
					<source src="/resources/videos/cur-01.webm" type="video/webm">
				</video>
			</div>
		</div>
		<aside class="cur-wrap">
			<ul class="cur-li">
				<li class="selected">
					<p class="runtime">15분</p>
					<p class="ttl">커리큘럼 상세 제목1</p>
				</li>
				<li>
					<p class="runtime">15분</p>
					<p class="ttl">커리큘럼 상세 제목1</p>
				</li>
				<li>
					<p class="runtime">15분</p>
					<p class="ttl">커리큘럼 상세 제목1</p>
				</li>
			</ul>
		</aside>
	</main>
</body>
</html>