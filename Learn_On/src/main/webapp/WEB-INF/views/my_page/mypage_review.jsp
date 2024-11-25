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
<script src="${pageContext.request.contextPath}/resources/js/review.js"></script>
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
				<a href="MyDashboard">나의 강의실</a>
				<a href="MyReview" class="active">작성한 수강평</a>
				<a href="MyPayment">결제내역</a>
				<a href="MyCoupon">보유한 쿠폰</a>
				<a href="MySupport">문의내역</a>
				<a href="MyAttendance">출석체크</a>
			</aside>
			<div class="my-container">
				<div class="contents-ttl">작성한 수강평 <small>(총 <span>${reviewCount}</span>건)</small></div>
				<div class="contents">
					<!-- contents -->
					<section class="my-rev-wrap">
						<div class="my-rev-li">
							<c:choose>
								<c:when test="${empty myReviewList}">
									<article class="rev-box empty">
										작성한 수강평이 존재하지 않습니다.
									</article>
								</c:when>
								<c:otherwise>
									<c:forEach var="review" items="${myReviewList}">
										<article class="rev-box">
											<div class="info">
												<img src="/resources/images/thumb_06.webp" alt="썸네일">
												<div class="right">
													<p class="ttl">${review.class_title}</p>
													<span class="name">${review.teacher_name}</span>
												</div>
											</div>
											<div class="detail">
												<p class="date">작성일시 : <span><fmt:formatDate value="${review.review_date}" pattern="yy-MM-dd HH:mm" /></span></p>
												<div class="rating">
													<i class="fa-solid fa-star"></i>
													<span>${review.review_score}</span>
												</div>
												<div class="content">
													${review.review_content}
												</div>
												<div class="btns">
													<button class="btn-rev" onclick="showUpdateModal(${review.class_id})">수정</button>
													<button class="btn-rev" onclick="showDeleteModal(${review.class_id})">삭제</button>
												</div>
											</div>
										</article>
									</c:forEach>
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
        <div class="modal-hd">수강평 수정하기</div>
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
        			<textarea class="rev-con" name="review_content" rows="6"></textarea>
        		</section>
        	</form>
        </div>
        <div class="modal-ft">
          <button class="normal" onclick="hideModal('updateReview')">취소</button>
          <button type="submit" form="review_update_frm" class="active" onclick="hideModal('updateReview')">수정하기</button>
        </div>
      </div>
    </div>
	<!-- // 수강평 수정하기 모달 -->
	<!-- 수강평 삭제하기 모달 -->
    <div class="modal" id="deleteReview">
      <div class="modal-dim" onclick="hideModal('deleteReview')"></div>
      <div class="modal-layer">
        <div class="modal-hd">수강평 삭제하기</div>
        <button class="modal-close" onclick="hideModal('deleteReview')"><i class="fa-solid fa-xmark"></i></button>
        <div class="modal-con">
        	<form id="review_delete_frm" action="MyReviewDelete" method="post">
        		<input type="hidden" name="mem_id" value="${sessionScope.sId}">
        		<input type="hidden" id="course_id" name="class_id">
        		<p>해당 수강평을 삭제하시겠습니까?</p>
        	</form>
        </div>
        <div class="modal-ft">
          <button class="normal" onclick="hideModal('deleteReview')">취소</button>
          <button type="submit" form="review_delete_frm" class="active" onclick="hideModal('deleteReview')">삭제하기</button>
        </div>
      </div>
    </div>
	<!-- // 수강평 삭제하기 모달 -->
</body>
</html>