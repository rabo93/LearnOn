<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
	</header>
	<main>
		<!-- 계정설정 -->
		<h2 class="page-ttl">마이페이지</h2>
		<section class="my-wrap">
			<aside class="my-menu">
				<a href="MyInfo">계정정보</a>
				<a href="MyFav" class="active">관심목록</a>
				<a href="MyDashboard">나의 강의실</a>
				<a href="MyReview">작성한 수강평</a>
				<a href="MyPayment">결제내역</a>
				<a href="MyCoupon">보유한 쿠폰</a>
				<a href="MySupport">문의내역</a>
				<a href="MyAttendance">출석체크</a>
			</aside>
			<div class="my-container">
				<div class="contents-ttl">관심목록</div>
				<div class="contents">
					<!-- contents -->
					<div class="course-sel">
						<form action="MyFav" method="get" >
							<select id="fav_sel" name="filterType" onchange="this.form.submit(filterType.value)">
								<option value="newest" <c:if test="${param.filterType eq 'newest'}">selected</c:if>>최신순</option>
								<option value="popularity" <c:if test="${param.filterType eq 'popularity'}">selected</c:if>>높은 평점 순</option>
							</select>
						</form>
					</div>
					<div class="course-wrap">
						<c:choose>
							<c:when test="${empty wishlist}">
								<ul class="course-card row-1">
									<li class="empty">관심목록이 존재하지 않습니다.</li>
								</ul>
							</c:when>
							<c:otherwise>
								<ul class="course-card row-3">
									<c:forEach var="wish" items="${wishlist}">
										<li>
											<div class="thumb-area">
												<img src="${pageContext.request.contextPath}/resources/images/thumb_01.webp" class="card-thumb" alt="thumbnail" onclick="location.href='CourseDetail?class_id=${wish.class_id}'" />
												<form action="MyFavDel" method="post" class="MyFavDelFrm">
													<input type="hidden" name="class_id" value="${wish.class_id}">
													<button type="button" class="fav-on" onclick="confirmDeleteWishItem()"><i class="fa-solid fa-heart"></i></button>
												</form>
											</div>
											<div class="card-info" onclick="location.href='CourseDetail?class_id=${wish.class_id}'">
												<div class="category">
													<span>${wish.class_category}</span>
												</div>
												<div class="ttl">${wish.class_title}</div>
												<div class="rating">
													<i class="fa-solid fa-star"></i>
													<span>${wish.review_score}</span>
												</div>
												<div class="name">${wish.teacher_name}</div>
											</div>
										</li>
									</c:forEach>
								</ul>
							</c:otherwise>
						</c:choose>
					</div>
					<!-- // contents -->
				</div>
			</div>
		</section>
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
	</footer>
	<script>
		function confirmDeleteWishItem() {
			if(confirm("관심목록에서 삭제하시겠습니까?")) {
				document.querySelector(".MyFavDelFrm").submit();
			} else {
				return;
			}
		}
	</script>
</body>
</html>