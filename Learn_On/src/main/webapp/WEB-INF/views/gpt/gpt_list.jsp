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

</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
	</header>
	<main>
		<div class="wrapper">
			<section class="rec-wrap">
				<div class="rec-inner">
					<c:if test="${not empty userInfo.HASHTAG}">
						<div class="rec-ttl">
							안녕하세요. ${userInfo.MEM_NAME}님 ✨<br>
							런온의 추천로봇이 ${userInfo.MEM_NAME}님을 위한 강의를 추천해드릴게요! 🤖
						</div>
						<div class="rec-hashtags"></div>
					</c:if>
					<c:choose>
						<c:when test="${empty myClassList}">
							<div class="empty">강의를 준비중이에요 😊</div>
						</c:when>
							<c:otherwise>
								<ul class="course-card">
									<c:forEach var="my" items="${myClassList}">
										<li>
											<img src="${pageContext.request.contextPath}/resources/upload/${my.CLASS_PIC}" onclick="location.href='CourseDetail?class_id=${my.CLASS_ID}'" class="card-thumb" alt="thumbnail" />
											<div class="card-info" onclick="location.href='CourseDetail?class_id=${my.CLASS_ID}'">
												<div class="category">
													<span>${my.CLASS_CATEGORY}</span>
												</div>
												<div class="ttl">${my.CLASS_TITLE}</div>
												<div class="price">₩<fmt:formatNumber pattern="#,###">${my.CLASS_PRICE}</fmt:formatNumber></div>
												<div class="rating">
													<i class="fa-solid fa-star"></i>
													<span>${my.REVIEW_SCORE}</span>
												</div>
												<div class="name">${my.TEACHER_NAME}</div>
											</div>
										</li>
									</c:forEach>
								</ul>
							</c:otherwise>
					</c:choose>
					<div class="rec-ttl2">
						요즘 트렌드 강의는? <br>
						런온 회원이 가장 선호하는 해시태그를 기반으로 추천해드려요! 🤖
					</div>
					<div class="rec-hashtags2"></div>
					<c:choose>
						<c:when test="${empty classList}">
							<div class="empty">강의를 준비중이에요 😊</div>
						</c:when>
							<c:otherwise>
								<ul class="course-card">
									<c:forEach var="rec" items="${classList}">
										<li>
											<img src="${pageContext.request.contextPath}/resources/upload/${rec.CLASS_PIC}" onclick="location.href='CourseDetail?class_id=${rec.CLASS_ID}'" class="card-thumb" alt="thumbnail" />
											<div class="card-info" onclick="location.href='CourseDetail?class_id=${rec.CLASS_ID}'">
												<div class="category">
													<span>${rec.CLASS_CATEGORY}</span>
												</div>
												<div class="ttl">${rec.CLASS_TITLE}</div>
												<div class="price">₩<fmt:formatNumber pattern="#,###">${rec.CLASS_PRICE}</fmt:formatNumber></div>
												<div class="rating">
													<i class="fa-solid fa-star"></i>
													<span>${rec.REVIEW_SCORE}</span>
												</div>
												<div class="name">${rec.TEACHER_NAME}</div>
											</div>
										</li>
									</c:forEach>
								</ul>
							</c:otherwise>
					</c:choose>
				</div>
			</section>
		</div>
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
	</footer>
	<script>
	$(document).ready(function(){
		let hashtags = "${userInfo.HASHTAG}";
		let hashtagArr = hashtags.split(',');
		console.log(hashtagArr);
		
		for(let hash of hashtagArr) {
			$(".rec-hashtags").append(
					"<span>" + hash + "</span>"
			);
		}
		
	});
	</script>
</body>
</html>