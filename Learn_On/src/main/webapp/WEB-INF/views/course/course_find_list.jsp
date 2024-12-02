<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>런 온 - 온라인 No.1 교육 플랫폼</title>
<link rel="SHORTCUT ICON" href="${pageContext.request.contextPath}/resources/images/favicon.ico">
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
					<c:set var="find_cnt" value="${courseList}" />
					<h1 class="cls-ttl">'${param.find_title}'의 검색결과 ${fn:length(find_cnt)}건 </h1>
					<div class="cate-li">
						<script>
							function handleChange(event) {
								let form = document.searchType;
						        form.method = "get";
						        form.submit();
							}
						</script>
					</div><!-- cate-li -->
				</div><!-- clas-cate -->
				<div class="course-wrap">
					
					<c:set var="pageNum" value="1"/>
					
					<c:if test="${not empty param.pageNum}">
						<c:set var="pageNum" value="${param.pageNum}"/>
					</c:if>
					<c:choose>
						<c:when test="${empty requestScope.courseList}">
							<div class="empty">해당 클래스가 등록되어 있지 않습니다.</div>
						</c:when>
						<c:otherwise>
							<ul class="course-card">
								<c:forEach var="course" items="${requestScope.courseList}" varStatus="status">
									<li id="${course.class_id}">
										<button class="fav-off" style="display:block;" onclick="addToWishList('${course.class_id}')">
											<i class="fa-regular fa-heart"></i>
										</button>
										<button class="fav-on" style="display:none;" onclick="deleteToWishList('${course.class_id}')">
											<i class="fa-solid fa-heart"></i>
										</button>
										<a href="CourseDetail?class_id=${course.class_id}&codetype=${codeType[0].codetype}">
											<img src="${pageContext.request.contextPath}/resources/upload/${course.class_pic1}" class="card-thumb" alt="thumbnail" />
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
								
								<script>
									window.onload = function() {
										const wishList = ${wishList};
										wishList.forEach(wish => {
											const listItem = document.getElementById(wish.CLASS_ID);
											if (listItem) {
								                const favOnBtn = listItem.querySelector(".fav-on");
								                if (favOnBtn) {
								                	favOnBtn.style.display = "block";
								                }
			
								                const favOffBtn = listItem.querySelector(".fav-off");
								                if (favOffBtn) {
								                	favOffBtn.style.display = "none";
								                }
								            }
										});
									}
									function addToWishList(id){
										if(confirm("관심목록에 추가하시겠습니까?")) {
											location.href="MyFavAdd?class_id=" + id;
										}
									}
									function deleteToWishList(id){
										if(confirm("관심목록에서 삭제하시겠습니까?")){
											location.href="MyFavDel?class_id=" + id;
										}
									}
								</script>									
							</ul>
						</c:otherwise>
					</c:choose>
					
					<!-- 페이징 처리 시작 -->
					<c:choose>
						<c:when test="${not empty requestScope.courseList}">		
							<section id="pageList">
								<input type="button" value="&lt;&lt;" 
								onclick="location.href='CourseFind?find_title=${param.find_title}&pageNum=${pageInfo.startPage - pageInfo.pageListLimit}'"				
								<c:if test="${pageInfo.startPage == 1}">disabled</c:if> 	
								>
								<input type="button" value="이전" 
									onclick="location.href='CourseFind?find_title=${param.find_title}&pageNum=${pageNum - 1}'"
									<c:if test="${pageNum == 1}">disabled</c:if> 	
								>
								
								<c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
									<c:choose>
										<c:when test="${i eq pageNum}">
											<strong>${i}</strong>
										</c:when>
										<c:otherwise>
											<a href="CourseFind?find_title=${param.find_title}&pageNum=${i}">${i}</a>
										</c:otherwise>
									</c:choose>
								</c:forEach>
								
								<!-- [다음] 버튼 클릭시 이전 페이지 글 목록 요청(파라미터로 현재 페이지번호 +1 전달) -->
								<%-- 현재 페이지가 전체 페이지 수와 동일할 경우 비활성화(disabled) --%>
								<input type="button" value="다음" 
									onclick="location.href='CourseFind?find_title=${param.find_title}&pageNum=${pageNum + 1}'"
									<c:if test="${pageNum == pageInfo.maxPage}">disabled</c:if> 		
								>
								<!-- 현재 목록의 시작페이지 번호에서 페이지 번호 갯수를 더한 페이지 요청ㄹ -->
								<%-- 끝 페이지가 전체 페이지 수와 동일할 경우 비활성화(disabled) --%>
								<input type="button" value="&gt;&gt;" 
									onclick="location.href='CourseFind?find_title=${param.find_title}&pageNum=${pageInfo.startPage + pageInfo.pageListLimit}'"
									<c:if test="${pageInfo.endPage == pageInfo.maxPage}">disabled</c:if>	
								>	
							</section>
						</c:when>				
					</c:choose>	
					<!-- 페이징 처리 끝 -->
				</div><!-- course-wrap -->
			</div><!-- cls-wrap -->
		</div><!-- wrapper -->
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
	</footer>
</body>
</html>