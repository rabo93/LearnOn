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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css">
    
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/dashboard.js"></script>

</head>
<body>
	<main id="myCourseDashboard">
		<div class="contents">
			<div class="hd">
				<a href="MyDashboard" class="back-btn"><i class="fa-solid fa-arrow-up-right-from-square"></i> 뒤로가기</a>
				<h2 class="ttl">${myDashboard.class_title}</h2>
			</div>
			<div class="video">
				<c:choose>
					<c:when test="${empty myCurList}">
						<span class="empty"><i class="fa-solid fa-video-slash"></i><br>커리큘럼이 등록되지 않았습니다.</span>
					</c:when>
					<c:otherwise>
						<c:forEach var="item" items="${myCurList}">
						    <c:if test="${item.cur_id == param.cur_id}">
						        <c:set var="cur_video" value="${item.cur_video}" />
						    </c:if>
						</c:forEach>
						<video controls muted>
							<source src="${pageContext.request.contextPath}/resources/upload/${cur_video}">
						</video>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		<aside class="cur-wrap">
			<ul class="cur-li">
				<c:if test="${empty myCurList}">
					<li class="empty">커리큘럼이 등록되지 않았습니다.</li>
				</c:if>
				<c:forEach var="myCurriculum" items="${myCurList}">
					<li class="<c:if test="${myCurriculum.completed_status == 1}">selected</c:if>" onclick="viewCurVideo(${myCurriculum.class_id}, ${myCurriculum.cur_id})">
						<div>
							<p class="runtime"><span>${myCurriculum.cur_runtime}</span>분</p>
							<p class="ttl">${myCurriculum.cur_title}</p>
						</div>
						<c:if test="${myCurriculum.completed_status == 1}"><p class="completed"><i class="fa-solid fa-circle-check"></i></p></c:if>
					</li>
				</c:forEach>
			</ul>
		</aside>
	</main>
	<script>
		function viewCurVideo(class_id, cur_id){
			location.href="CompletedVideo?class_id=" + class_id + "&cur_id=" + cur_id;
		}
	</script>
</body>
</html>