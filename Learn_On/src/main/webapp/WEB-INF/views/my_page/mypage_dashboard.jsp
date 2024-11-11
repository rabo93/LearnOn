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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/reset.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/modal.css">
    
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/modal.js"></script>
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
				<a href="MyInquiry">문의내역</a>
				<a href="MyAttendance">출석체크</a>
			</aside>
			<div class="my-container">
				<div class="contents-ttl">나의 강의실</div>
				<div class="contents">
					<!-- contents -->
					<section class="dashboard-wrap">
						<div class="my-tabs">
							<button class="checked">학습중</button>
							<button>완강</button>
							<button class="checked">수강평 작성</button>
						</div>
						<div class="course-sel">
							<form action="MyDashboard" method="get">
								<select id="course_sel" name="filterType" onchange="this.form.submit(filterType.value)">
									<option value="newest" <c:if test="${param.filterType eq 'newest'}">selected</c:if>>최신순</option>
									<option value="title" <c:if test="${param.filterType eq 'title'}">selected</c:if>>제목순</option>
								</select>
							</form>
						</div>
						<div class="course-wrap">
							<ul class="course-card row-3">
								<c:choose>
									<c:when test="${empty mycourse}">
										<li class="empty">수강 목록이 존재하지 않습니다.</li>
									</c:when>
									<c:otherwise>
										<c:forEach var="course" items="${mycourse}">
											<li>
												<div class="thumb-area">
													<img src="${pageContext.request.contextPath}/resources/images/thumb_01.webp" class="card-thumb" alt="thumbnail" />
												</div>
												<div class="card-info">
													<div class="category">
														<span>${course.class_category}</span>
													</div>
													<div class="ttl">${course.class_title}</div>
													<div class="name">${course.teacher_name}</div>
												</div>
												
												<div class="card-info2">
													<div class="course-status">
														<progress class="progress" id="progress" value="80" min="0" max="100"></progress>
														<p><span>8</span>강/<span>10</span>강 (80%)</p>
													</div>
													<c:choose>
														<c:when test="${course.review_write_status == 1}">
															<button class="btn-review" onclick="showModal('viewWriteReview')"><i class="fa-solid fa-star"></i> 5.0</button>
														</c:when>
														
													</c:choose>
												</div>
											</li>
										</c:forEach>
									</c:otherwise>
								</c:choose>
								<!-- 6개 -->
<!-- 								<li> -->
<!-- 									<div class="thumb-area"> -->
<%-- 										<img src="${pageContext.request.contextPath}/resources/images/thumb_01.webp" class="card-thumb" alt="thumbnail" /> --%>
<!-- 									</div> -->
<!-- 									<div class="card-info"> -->
<!-- 										<div class="category"> -->
<!-- 											<span>IT/개발</span> -->
<!-- 										</div> -->
<!-- 										<div class="ttl">초심자를 위한 알고리즘 강의</div> -->
<!-- 										<div class="name">프로그래머 홍길동</div> -->
<!-- 									</div> -->
<!-- 									<div class="card-info2"> -->
<!-- 										<div class="course-status"> -->
<!-- 											<progress class="progress" id="progress" value="80" min="0" max="100"></progress> -->
<!-- 											<p><span>8</span>강/<span>10</span>강 (80%)</p> -->
<!-- 										</div> -->
<!-- 										<button class="btn-review" onclick="showModal('viewWriteReview')"><i class="fa-solid fa-star"></i> 5.0</button> -->
<!-- 									</div> -->
<!-- 								</li> -->
<!-- 								<li> -->
<!-- 									<div class="thumb-area"> -->
<%-- 										<img src="${pageContext.request.contextPath}/resources/images/thumb_01.webp" class="card-thumb" alt="thumbnail" /> --%>
<!-- 									</div> -->
<!-- 									<div class="card-info"> -->
<!-- 										<div class="category"> -->
<!-- 											<span>IT/개발</span> -->
<!-- 										</div> -->
<!-- 										<div class="ttl">초심자를 위한 알고리즘 강의</div> -->
<!-- 										<div class="name">프로그래머 홍길동</div> -->
<!-- 									</div> -->
<!-- 									<div class="card-info2"> -->
<!-- 										<div class="course-status"> -->
<!-- 											<progress class="progress" id="progress" value="80" min="0" max="100"></progress> -->
<!-- 											<p><span>8</span>강/<span>10</span>강 (80%)</p> -->
<!-- 										</div> -->
<!-- 										<button class="btn-write" onclick="showModal('writeReview')">수강평 작성 <i class="fa-regular fa-pen-to-square"></i></button> -->
<!-- 									</div> -->
<!-- 								</li> -->
							</ul>
						</div>
						<!-- 수강평 작성하기 모달 -->
					    <div class="modal" id="writeReview">
					      <div class="modal-dim" onclick="hideModal('writeReview')"></div>
					      <div class="modal-layer">
					        <div class="modal-hd">수강평 작성하기</div>
					        <button class="modal-close" onclick="hideModal('writeReview')"><i class="fa-solid fa-xmark"></i></button>
					        <div class="modal-con">
					        	<form id="review_update_frm" action="" method="post">
						        	<!-- 별점 -->
						        	<section class="course-rating">
						        		<label class="rating-lab rating-lab-half" for="starhalf">
									        <input type="radio" id="starhalf" class="rating-input" name="rating" value="">
									        <span class="star-icon"></span>
									    </label>
									    <label class="rating-lab rating-lab-full" for="star1">
									        <input type="radio" id="star1" class="rating-input" name="rating" value="">
									        <span class="star-icon"></span>
									    </label>
									    <label class="rating-lab rating-lab-half" for="star1half">
									        <input type="radio" id="star1half" class="rating-input" name="rating" value="">
									        <span class="star-icon"></span>
									    </label>
									    <label class="rating-lab rating-lab-full" for="star2">
									        <input type="radio" id="star2" class="rating-input" name="rating" value="">
									        <span class="star-icon"></span>
									    </label>
									    <label class="rating-lab rating-lab-half" for="star2half">
									        <input type="radio" id="star2half" class="rating-input" name="rating" value="">
									        <span class="star-icon"></span>
									    </label>
									    <label class="rating-lab rating-lab-full" for="star3">
									        <input type="radio" id="star3" class="rating-input" name="rating" value="">
									        <span class="star-icon"></span>
									    </label>
									    <label class="rating-lab rating-lab-half" for="star3half">
									        <input type="radio" id="star3half" class="rating-input" name="rating" value="">
									        <span class="star-icon"></span>
									    </label>
									    <label class="rating-lab rating-lab-full" for="star4">
									        <input type="radio" id="star4" class="rating-input" name="rating" value="">
									        <span class="star-icon"></span>
									    </label>
									    <label class="rating-lab rating-lab-half" for="star4half">
									        <input type="radio" id="star4half" class="rating-input" name="rating" value="">
									        <span class="star-icon"></span>
									    </label>
									    <label class="rating-lab rating-lab-full" for="star5">
									        <input type="radio" id="star5" class="rating-input" name="rating" value="">
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
					        			<textarea name="review_content" rows="6" placeholder="수강후기를 남겨주세요"></textarea>
					        		</section>
					        	</form>
					        </div>
					        <div class="modal-ft">
					          <button class="normal" onclick="hideModal('writeReview')">취소</button>
					          <button type="submit" form="review_update_frm" class="active" onclick="hideModal('writeReview')">작성하기</button>
					        </div>
					      </div>
					    </div>
						<!-- // 수강평 수정하기 모달 -->
						<!-- 수강평 수정하기 모달 -->
					    <div class="modal" id="viewWriteReview">
					      <div class="modal-dim" onclick="hideModal('viewWriteReview')"></div>
					      <div class="modal-layer">
					        <div class="modal-hd">수강평 수정하기</div>
					        <button class="modal-close" onclick="hideModal('viewWriteReview')"><i class="fa-solid fa-xmark"></i></button>
					        <div class="modal-con">
					        	<form id="review_update_frm" action="" method="post">
						        	<!-- 별점 -->
						        	<section class="course-rating">
						        		<label class="rating-lab rating-lab-half" for="starhalf">
									        <input type="radio" id="starhalf" class="rating-input" name="rating" value="">
									        <span class="star-icon"></span>
									    </label>
									    <label class="rating-lab rating-lab-full" for="star1">
									        <input type="radio" id="star1" class="rating-input" name="rating" value="">
									        <span class="star-icon"></span>
									    </label>
									    <label class="rating-lab rating-lab-half" for="star1half">
									        <input type="radio" id="star1half" class="rating-input" name="rating" value="">
									        <span class="star-icon"></span>
									    </label>
									    <label class="rating-lab rating-lab-full" for="star2">
									        <input type="radio" id="star2" class="rating-input" name="rating" value="">
									        <span class="star-icon"></span>
									    </label>
									    <label class="rating-lab rating-lab-half" for="star2half">
									        <input type="radio" id="star2half" class="rating-input" name="rating" value="">
									        <span class="star-icon"></span>
									    </label>
									    <label class="rating-lab rating-lab-full" for="star3">
									        <input type="radio" id="star3" class="rating-input" name="rating" value="">
									        <span class="star-icon"></span>
									    </label>
									    <label class="rating-lab rating-lab-half" for="star3half">
									        <input type="radio" id="star3half" class="rating-input" name="rating" value="">
									        <span class="star-icon"></span>
									    </label>
									    <label class="rating-lab rating-lab-full" for="star4">
									        <input type="radio" id="star4" class="rating-input" name="rating" value="">
									        <span class="star-icon"></span>
									    </label>
									    <label class="rating-lab rating-lab-half" for="star4half">
									        <input type="radio" id="star4half" class="rating-input" name="rating" value="">
									        <span class="star-icon"></span>
									    </label>
									    <label class="rating-lab rating-lab-full" for="star5">
									        <input type="radio" id="star5" class="rating-input" name="rating" value="">
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
					        			<textarea name="review_content" rows="6">작성한 수강평 내용 다시 뿌리기</textarea>
					        		</section>
					        	</form>
					        </div>
					        <div class="modal-ft">
					          <button class="normal" onclick="hideModal('viewWriteReview')">취소</button>
					          <button type="submit" form="review_update_frm" class="active" onclick="hideModal('viewWriteReview')">수정하기</button>
					        </div>
					      </div>
					    </div>
						<!-- // 수강평 수정하기 모달 -->
					</section>
					<!-- // contents -->
				</div>
			</div>
		</section>
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
	</footer>
</body>
</html>