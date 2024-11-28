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
					<h1 class="cls-ttl">${codeType[0].codename}</h1>
					<div class="cate-li">
						<button <c:if test="${param.codetype eq codeType[0].codetype && param.codetype_id eq null}">class="on"</c:if>>
							<a href="Category?codetype=${codeType[0].codetype}" >전체</a>
						</button>
						<c:forEach var="category" items="${requestScope.codeType}" varStatus="status">
 							<button <c:if test="${param.codetype_id eq category.codetype_id}">class="on"</c:if>> 
								 <a href="Category?codetype=${category.codetype}&codetype_id=${category.codetype_id}">${category.name}</a>
							</button>
						</c:forEach>
						<form action="Category">
							<select name="searchType">
								<option value="new" <c:if test="${param.searchType eq 'new'}">selected</c:if>>최신순</option>
								<option value="title" <c:if test="${param.searchType eq 'title'}">selected</c:if>>제목순</option>
								<option value="price" <c:if test="${param.searchType eq 'price'}">selected</c:if>>가격순</option>
								<option value="score" <c:if test="${param.searchType eq 'score'}">selected</c:if>>평점순</option>
							</select>
							<input type="hidden" name="codetype" value="${codeType[0].codetype }"/>
							<input type="submit" value="검색" />
						</form>
					</div><!-- cate-li -->
				</div><!-- clas-cate -->
				<div class="course-wrap">
					<ul class="course-card">
						<c:forEach var="course" items="${requestScope.courseList}" varStatus="status">
							<li id="${course.class_id}">
								
								<a href="CourseDetail?class_id=${course.class_id}&codetype=${codeType[0].codetype}">
									<img src="${pageContext.request.contextPath}/resources/images/thumb_0${status.count}.webp" class="card-thumb" alt="thumbnail" />
									<div class="card-info">
										<div class="category">
											<span>${course.catename}</span>
										</div>
										<div class="ttl">${course.class_title}</div>
										<div class="price">
											 <fmt:formatNumber pattern="#,###">${course.class_price}</fmt:formatNumber>원
										</div>
										<div class="rating">
											<i class="fa-solid fa-star"></i>
											<span>${course.review_score}</span>
										</div>
										<div class="name">${course.mem_id}</div>
									</div>
								</a>
							</li>
						</c:forEach>
						
					</ul>
					<section id="pageList">	<!-- 페이징 처리 시작 -->
						<input type="button" value="&lt;&lt;" 
							onclick="location.href='CourseSupportList?class_id=${course[0].class_id}&pageNum=${pageInfo.startPage - pageInfo.pageListLimit}'"				
							<c:if test="${pageInfo.startPage == 1}">disabled</c:if> 	
						>
						<input type="button" value="이전" 
							onclick="location.href='CourseSupportList?class_id=${course[0].class_id}&pageNum=${pageNum - 1}'"
							<c:if test="${pageNum == 1}">disabled</c:if> 	
						>
						
						<c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
							<c:choose>
								<c:when test="${i eq pageNum}">
									<strong>${i}</strong>
								</c:when>
								<c:otherwise>
									<a href="CourseSupportList?class_id=${course[0].class_id}&pageNum=${i}">${i}</a>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						
						<!-- [다음] 버튼 클릭시 이전 페이지 글 목록 요청(파라미터로 현재 페이지번호 +1 전달) -->
						<%-- 현재 페이지가 전체 페이지 수와 동일할 경우 비활성화(disabled) --%>
						<input type="button" value="다음" 
							onclick="location.href='CourseSupportList?class_id=${course[0].class_id}&pageNum=${pageNum + 1}'"
							<c:if test="${pageNum == pageInfo.maxPage}">disabled</c:if> 		
						>
						<!-- 현재 목록의 시작페이지 번호에서 페이지 번호 갯수를 더한 페이지 요청ㄹ -->
						<%-- 끝 페이지가 전체 페이지 수와 동일할 경우 비활성화(disabled) --%>
						<input type="button" value="&gt;&gt;" 
							onclick="location.href='CourseSupportList?class_id=${course[0].class_id}&pageNum=${pageInfo.startPage + pageInfo.pageListLimit}'"
							<c:if test="${pageInfo.endPage == pageInfo.maxPage}">disabled</c:if>	
						>			
					</section><!-- 페이징 처리 끝 -->
				</div><!-- course-wrap -->
			</div><!-- cls-wrap -->
		</div><!-- wrapper -->
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
	</footer>
</body>
</html>