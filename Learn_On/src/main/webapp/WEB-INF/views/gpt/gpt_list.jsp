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
    
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>

</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
	</header>
	<main>
		<div class="wrapper">
			<section class="rec-wrap">
				<div class="rec-inner">
					<div class="rec-ttl">
						안녕하세요. ${sessionScope.sId}님 ✨<br>
						런온의 추천로봇이 강의를 추천해드릴게요! 🤖
						<br>
						XXX님의 관심사<br>
						<span class="hashtag">#개발</span>
						<span class="hashtag">#그림</span>
						<span class="hashtag">#개발</span>
						<span class="hashtag">#개발</span>
						<span class="hashtag">#개발</span>
					</div>
					<ul class="course-card">
						<li>
<%-- 						<img src="${pageContext.request.contextPath}/resources/upload/${best.CLASS_PIC}" onclick="location.href='CourseDetail?class_id=${best.CLASS_ID}'" class="card-thumb" alt="thumbnail" /> --%>
							<img src="${pageContext.request.contextPath}/resources/images/thumb_01.webp" class="card-thumb" alt="thumbnail" />
							<div class="card-info" onclick="">
								<div class="category">
									<span>프로그래밍</span>
								</div>
								<div class="ttl">강의제목</div>
								<div class="price">₩50,000</div>
<%-- 								<div class="price">₩<fmt:formatNumber pattern="#,###">${best.CLASS_PRICE}</fmt:formatNumber></div> --%>
								<div class="rating">
									<i class="fa-solid fa-star"></i>
									<span>4.5</span>
								</div>
								<div class="name">김선생</div>
							</div>
						</li>
						<li>
							<img src="${pageContext.request.contextPath}/resources/images/thumb_02.webp" class="card-thumb" alt="thumbnail" />
							<div class="card-info" onclick="">
								<div class="category">
									<span>프로그래밍</span>
								</div>
								<div class="ttl">강의제목</div>
								<div class="price">₩50,000</div>
								<div class="rating">
									<i class="fa-solid fa-star"></i>
									<span>4.5</span>
								</div>
								<div class="name">김선생</div>
							</div>
						</li>
						<li>
							<img src="${pageContext.request.contextPath}/resources/images/thumb_03.webp" class="card-thumb" alt="thumbnail" />
							<div class="card-info" onclick="">
								<div class="category">
									<span>프로그래밍</span>
								</div>
								<div class="ttl">강의제목</div>
								<div class="price">₩50,000</div>
								<div class="rating">
									<i class="fa-solid fa-star"></i>
									<span>4.5</span>
								</div>
								<div class="name">김선생</div>
							</div>
						</li>
						<li>
							<img src="${pageContext.request.contextPath}/resources/images/thumb_04.webp" class="card-thumb" alt="thumbnail" />
							<div class="card-info" onclick="">
								<div class="category">
									<span>프로그래밍</span>
								</div>
								<div class="ttl">강의제목</div>
								<div class="price">₩50,000</div>
								<div class="rating">
									<i class="fa-solid fa-star"></i>
									<span>4.5</span>
								</div>
								<div class="name">김선생</div>
							</div>
						</li>
					</ul>
				</div>
			</section>
		</div>
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
	</footer>
</body>
</html>