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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
    
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/slick.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/index.js"></script>

</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
	</header>
	<main>
		<div class="wrapper">
			<!-- section01. 메인 비주얼 배너 -->
			<section id="sec01" class="sec-full">
				<div class="sec-inner">
					<div class="visual-area">
						<div class="main-visual">
							<div><img src="${pageContext.request.contextPath}/resources/images/main_banner01.jpg" alt="배너1"></div>
							<div><img src="${pageContext.request.contextPath}/resources/images/main_banner02.jpg" alt="배너1"></div>
							<div><img src="${pageContext.request.contextPath}/resources/images/main_banner03.jpg" alt="배너1"></div>
						</div>
						<a href="#" class="visu-prev"><i class="fa-solid fa-chevron-left"></i></a>
						<a href="#" class="visu-next"><i class="fa-solid fa-chevron-right"></i></a>
					</div>
				</div>
			</section>
			<!-- section02. 실시간 인기 클래스 -->
			<section id="sec02" class="sec">
				<div class="sec-inner">
					<h1 class="sec-ttl">
						실시간 인기 클래스 ✨
						<button class="more" onclick="location.href='/Category?codetype=CATE01'"><i class="fa-solid fa-chevron-right"></i></button>
					</h1>
					<div class="course-wrap">
						<!-- 8개 -->
						<c:choose>
							<c:when test="${empty bestClassList}">
								<div class="empty">강의를 준비중이에요 😊</div>
							</c:when>
								<c:otherwise>
									<ul class="course-card">
										<c:forEach var="best" items="${bestClassList}">
											<li>
												<img src="${pageContext.request.contextPath}/resources/upload/${best.CLASS_PIC}" onclick="location.href='CourseDetail?class_id=${best.CLASS_ID}'" class="card-thumb" alt="thumbnail" />
	<%-- 											<img src="${pageContext.request.contextPath}/resources/images/thumb_01.webp" class="card-thumb" alt="thumbnail" /> --%>
												<div class="card-info" onclick="location.href='CourseDetail?class_id=${best.CLASS_ID}'">
													<div class="category">
														<span>${best.CLASS_CATEGORY}</span>
													</div>
													<div class="ttl">${best.CLASS_TITLE}</div>
													<div class="price">₩<fmt:formatNumber pattern="#,###">${best.CLASS_PRICE}</fmt:formatNumber></div>
													<div class="rating">
														<i class="fa-solid fa-star"></i>
														<span>${best.REVIEW_SCORE}</span>
													</div>
													<div class="name">${best.TEACHER_NAME}</div>
												</div>
											</li>
										</c:forEach>
									</ul>
								</c:otherwise>
						</c:choose>
					</div>
				</div>
			</section>
			<!-- section03. 방금 오픈한 강의 -->
			<section id="sec03" class="sec">
				<div class="sec-inner">
					<h1 class="sec-ttl">
						방금 오픈한 강의 👀
						<button class="more" onclick="location.href='/Category?codetype=CATE01'"><i class="fa-solid fa-chevron-right"></i></button>
					</h1>
					<div class="course-wrap">
						<c:choose>
							<c:when test="${empty newClassList}">
								<div class="empty">강의를 준비중이에요 😊</div>
							</c:when>
							<c:otherwise>
								<ul class="course-card">
									<c:forEach var="newClass" items="${newClassList}">
										<li onclick="location.href='CourseDetail?class_id=${newClass.CLASS_ID}'">
											<img src="${pageContext.request.contextPath}/resources/upload/${newClass.CLASS_PIC}" class="card-thumb" alt="thumbnail" />
<%-- 											<img src="${pageContext.request.contextPath}/resources/images/thumb_01.webp" class="card-thumb" alt="thumbnail" /> --%>
											<div class="card-info">
												<div class="category">
													<span>${newClass.CLASS_CATEGORY}</span>
												</div>
												<div class="ttl">${newClass.CLASS_TITLE}</div>
												<div class="price">₩<fmt:formatNumber pattern="#,###">${newClass.CLASS_PRICE}</fmt:formatNumber></div>
												<div class="rating">
													<i class="fa-solid fa-star"></i>
													<span>${newClass.REVIEW_SCORE}</span>
												</div>
												<div class="name">${newClass.TEACHER_NAME}</div>
											</div>
										</li>
									</c:forEach>
								</ul>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</section>
			<!-- section05. 출석체크 -->
			<section id="sec05" class="sec-full">
				<div class="sec-inner">
					<div class="sec-ttl center">출석체크 이벤트</div>
					<div class="sec-desc">매일 출석체크하고 출석 기록을 세워보세요!</div>
					<div class="imsi">
						<span class="icon"><i class="fa-solid fa-calendar-check"></i></span>
						<h3 class="tt">지금 바로 출석체크하러 가기</h3>
						<a href="MyAttendance">바로가기 <i class="fa-solid fa-location-arrow"></i></a>
					</div>
				</div>
			</section>
			<!-- section06. 관심있는 클래스 -->
			<section id="sec06" class="sec">
				<div class="sec-inner">
					<div class="sec-ttl center">관심있는 클래스를 찾지 못하셨나요?</div>
					<div class="sec-desc">다양한 카테고리를 탐색해 보세요</div>
					<div class="cate-list">
						<ul>
							<li><a href="Category?codetype=CATE01&codetype_id=03">🖥️&nbsp;&nbsp;&nbsp;백엔드</a></li>
							<li><a href="Category?codetype=CATE01&codetype_id=01">📱&nbsp;&nbsp;&nbsp;프로그래밍</a></li>
							<li><a href="Category?codetype=CATE02&codetype_id=06">🔤&nbsp;&nbsp;&nbsp;영어</a></li>
							<li><a href="Category?codetype=CATE02&codetype_id=08">🇨🇳&nbsp;&nbsp;&nbsp;중국어</a></li>
							<li><a href="Category?codetype=CATE03&codetype_id=12">🧘🏻‍♀️&nbsp;&nbsp;&nbsp;요가</a></li>
							<li><a href="Category?codetype=CATE03&codetype_id=15">💪&nbsp;&nbsp;&nbsp;피트니스</a></li>
							<li><a href="Category?codetype=CATE04&codetype_id=20">🎨&nbsp;&nbsp;&nbsp;드로잉</a></li>
							<li><a href="Category?codetype=CATE04&codetype_id=22">📸&nbsp;&nbsp;&nbsp;포토그래퍼</a></li>
							<li><a href="Category?codetype=CATE05&codetype_id=26">🍲&nbsp;&nbsp;&nbsp;한식</a></li>
						</ul>
					</div>
				</div>
			</section>
		</div>
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
	</footer>
</body>
</html>