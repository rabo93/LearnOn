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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/modal.css">
    
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/dashboard.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/rating.js"></script>

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
				<a href="MyFav">관심목록</a>
				<a href="MyDashboard" class="active">나의 강의실</a>
				<a href="MyReview">작성한 수강평</a>
				<a href="MyPayment">결제내역</a>
				<a href="MyCoupon">보유한 쿠폰</a>
				<a href="MySupport">문의내역</a>
				<a href="MyAttendance">출석체크</a>
			</aside>
			<div class="my-container">
				<div class="contents-ttl">나의 강의실</div>
				<div class="contents">
					<!-- contents -->
					<section class="dashboard-wrap">
						
						<div class="course-sel">
							<form action="MyDashboard" method="get" class="course-sel-form">
								<div class="my-tabs">
									<button class="reset-btn" onclick="this.form.reset()"><i class="fa-solid fa-rotate"></i> 초기화</button>
									<button class="status-studying <c:if test="${param.statusType eq 'studying'}">checked</c:if>" name="statusType" value="studying" onclick="toggleStatus('studying')">학습중</button>
									<button class="status-completed <c:if test="${param.statusType eq 'completed'}">checked</c:if>" name="statusType" value="completed" onclick="toggleStatus('completed')">완강</button>
								</div>
								<select id="course_sel" name="filterType" onchange="this.form.submit()">
									<option value="newest" <c:if test="${param.filterType eq 'newest'}">selected</c:if>>최신순</option>
									<option value="title" <c:if test="${param.filterType eq 'title'}">selected</c:if>>제목순</option>
								</select>
							</form>
						</div>
						<div class="course-wrap">
							<c:choose>
								<c:when test="${empty myCourse}">
									<ul class="course-card row-1">
										<li class="empty">수강 목록이 존재하지 않습니다.</li>
									</ul>
								</c:when>
								<c:otherwise>
									<ul class="course-card row-3">
										<c:forEach var="course" items="${myCourse}">
											<li>
												<div class="thumb-area" onclick="location.href='MyCourseBoard?class_id=${course.class_id}'">
													<img src="${pageContext.request.contextPath}/resources/upload/${course.class_pic}" class="card-thumb" alt="thumbnail" />
<%-- 													<img src="${pageContext.request.contextPath}/resources/images/thumb_01.webp" class="card-thumb" alt="thumbnail" /> --%>
												</div>
												<div class="card-info" onclick="location.href='MyCourseBoard?class_id=${course.class_id}'">
													<div class="category">
														<span>${course.class_category}</span>
													</div>
													<div class="ttl">${course.class_title}</div>
													<div class="name">${course.teacher_name}</div>
												</div>
												<div class="card-info2">
													<div class="course-status">
														<progress class="progress" id="progress" value="<fmt:formatNumber value="${course.completion_rate}" pattern="#" />" min="0" max="100"></progress>
														<p>총 <span>${course.curriculum_count}</span>강 (<fmt:formatNumber value="${course.completion_rate}" pattern="#" />%)</p>
													</div>
													<c:choose>
														<c:when test="${course.completion_rate >= 80 and !course.is_reviewed}">
															<button class="btn-write" onclick="showWriteModal(${course.class_id})">
																수강평 작성 <i class="fa-regular fa-pen-to-square"></i>
															</button>
														</c:when>
														<c:when test="${course.is_reviewed eq true}">
															<button class="btn-review" onclick="showUpdateModal(${course.class_id})">
																<i class="fa-solid fa-star"></i> 작성한 수강평
															</button>
														</c:when>
													</c:choose>
												</div>
											</li>
										</c:forEach>
									</ul>
								</c:otherwise>
							</c:choose>
						</div>
					</section>
					<!-- // contents -->
				</div>
			</div>
		</section>
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
	</footer>
	
	<!-- 수강평 수정하기 모달 -->
    <div class="modal" id="updateReview">
      <div class="modal-dim" onclick="hideModal('updateReview')"></div>
      <div class="modal-layer">
        <div class="modal-hd">
			수강평 수정하기
        </div>
        <button class="modal-close" onclick="hideModal('updateReview')"><i class="fa-solid fa-xmark"></i></button>
        <div class="modal-con">
        	<form id="review_update_frm" action="MyReviewUpdate" method="post">
        		<input type="hidden" name="mem_id" value="${sessionScope.sId}">
        		<input type="hidden" id="course_id" name="class_id">
	        	<!-- 별점 -->
	        	<section class="course-rating">
				    <label class="rating-lab rating-lab-full" for="star1">
				        <input type="radio" id="star1" class="rating-input" name="review_score" value="1">
				        <span class="star-icon"></span>
				    </label>
				    <label class="rating-lab rating-lab-full" for="star2">
				        <input type="radio" id="star2" class="rating-input" name="review_score" value="2">
				        <span class="star-icon"></span>
				    </label>
				    <label class="rating-lab rating-lab-full" for="star3">
				        <input type="radio" id="star3" class="rating-input" name="review_score" value="3">
				        <span class="star-icon"></span>
				    </label>
				    <label class="rating-lab rating-lab-full" for="star4">
				        <input type="radio" id="star4" class="rating-input" name="review_score" value="4">
				        <span class="star-icon"></span>
				    </label>
				    <label class="rating-lab rating-lab-full" for="star5">
				        <input type="radio" id="star5" class="rating-input" name="review_score" value="5">
				        <span class="star-icon"></span>
				    </label>
	        	</section>
	        	<!-- // 별점 -->
	        	<!-- 수강평 -->
        		<section class="review-write">
        			<ul class="noti">
        				<li>공개 게시판이므로 소중한 개인정보를 남기지 않도록 해주세요.</li>
        				<li>사적인 상담 및 광고성, 욕설, 비방, 도배 등 부적절한 글은 무통보 삭제처리될 수 있습니다.</li>
        			</ul>
        			<textarea class="rev-con" name="review_content" rows="6" placeholder="수강후기를 남겨주세요"></textarea>
        		</section>
        	</form>
        </div>
        <div class="modal-ft">
          <button class="reset" onclick="hideModal('updateReview')">취소</button>
          <button type="submit" form="review_update_frm" class="active" onclick="hideModal('updateReview')">수정하기</button>
        </div>
      </div>
    </div>
	<!-- // 수강평 수정하기 모달 -->
	<!-- 수강평 등록하기 모달 -->
    <div class="modal" id="writeReview">
      <div class="modal-dim" onclick="hideModal('writeReview')"></div>
      <div class="modal-layer">
        <div class="modal-hd">
			수강평 등록하기
        </div>
        <button class="modal-close" onclick="hideModal('writeReview')"><i class="fa-solid fa-xmark"></i></button>
        <div class="modal-con">
        	<form id="review_write_frm" action="MyReviewWrite" method="post">
        		<input type="hidden" name="mem_id" value="${sessionScope.sId}">
        		<input type="hidden" id="course_id" name="class_id">
	        	<!-- 별점 -->
	        	<section class="course-rating">
				    <label class="rating-lab rating-lab-full" for="star01">
				        <input type="radio" id="star01" class="rating-input" name="review_score" value="1">
				        <span class="star-icon"></span>
				    </label>
				    <label class="rating-lab rating-lab-full" for="star02">
				        <input type="radio" id="star02" class="rating-input" name="review_score" value="2">
				        <span class="star-icon"></span>
				    </label>
				    <label class="rating-lab rating-lab-full" for="star03">
				        <input type="radio" id="star03" class="rating-input" name="review_score" value="3">
				        <span class="star-icon"></span>
				    </label>
				    <label class="rating-lab rating-lab-full" for="star04">
				        <input type="radio" id="star04" class="rating-input" name="review_score" value="4">
				        <span class="star-icon"></span>
				    </label>
				    <label class="rating-lab rating-lab-full" for="star05">
				        <input type="radio" id="star05" class="rating-input" name="review_score" value="5">
				        <span class="star-icon"></span>
				    </label>
	        	</section>
	        	<!-- // 별점 -->
	        	<!-- 수강평 -->
        		<section class="review-write">
        			<ul class="noti">
        				<li>공개 게시판이므로 소중한 개인정보를 남기지 않도록 해주세요.</li>
        				<li>사적인 상담 및 광고성, 욕설, 비방, 도배 등 부적절한 글은 무통보 삭제처리될 수 있습니다.</li>
        			</ul>
        			<textarea class="rev-con" name="review_content" rows="6" placeholder="수강후기를 남겨주세요"></textarea>
        		</section>
        	</form>
        </div>
        <div class="modal-ft">
          <button class="reset" onclick="hideModal('writeReview')">취소</button>
          <button type="submit" form="review_write_frm" class="active" onclick="hideModal('writeReview')">등록하기</button>
        </div>
      </div>
    </div>
	<!-- // 수강평 등록하기 모달 -->
</body>
</html>