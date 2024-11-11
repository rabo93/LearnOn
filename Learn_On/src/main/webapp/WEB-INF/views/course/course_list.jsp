<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>런온</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/reset.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/course.css">
    
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>

</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
	</header>
	<main>
		<div class="wrapper">
			<div class="cls-wrap">
				<div class="cls-cate">
					<h1 class="cls-ttl">${courseList[0].CATENAME}</h1>
					<div class="cate-li">
						<button <c:if test="${param.CODETYPE eq codeType[0].CODETYPE && param.CODETYPE_ID eq null}">class="on"</c:if>>
							<a href="Category?CODETYPE=CATE01" >전체</a>
						</button>
						<c:forEach var="category" items="${requestScope.codeType}" varStatus="status">
 							<button <c:if test="${param.CODETYPE_ID eq category.CODETYPE_ID}">class="on"</c:if>> 
								 <a href="Category?CODETYPE=${category.CODETYPE}&CODETYPE_ID=${category.CODETYPE_ID}">${category.NAME}</a>
							</button>
						</c:forEach>
						
						<select name="searchType">
							<option value="new" <c:if test="${param.searchType eq 'new'}">selected</c:if>>최신순</option>
							<option value="popularity" <c:if test="${param.searchType eq 'popularity'}">selected</c:if>>인기순</option>
							<option value="average" <c:if test="${param.searchType eq 'average'}">selected</c:if>>평점순</option>
							<option value="like" <c:if test="${param.searchType eq 'like'}">selected</c:if>>좋아요 순</option>
						</select>
					</div>
				</div>
				<div class="course-wrap">
					<ul class="course-card">
							<c:forEach var="course" items="${requestScope.courseList}" varStatus="status">
								<li>
									<a href="CourseDetail?CLASS_ID=${course.CLASS_ID}">
										<img src="${pageContext.request.contextPath}/resources/images/thumb_0${status.count}.webp" class="card-thumb" alt="thumbnail" />
										<div class="card-info">
											<div class="category">
												<span>${course.CATENAME}</span>
											</div>
											<div class="ttl">${course.CLASS_TITLE}</div>
											<div class="rating">
												<i class="fa-solid fa-star"></i>
												<span>${course.REVIEW_SCORE}</span>
											</div>
											<div class="name">${course.MEM_ID}</div>
										</div>
									</a>
								</li>
							</c:forEach>
						
						
						
					</ul>
				</div>
			</div>
		</div>
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
	</footer>
</body>
</html>