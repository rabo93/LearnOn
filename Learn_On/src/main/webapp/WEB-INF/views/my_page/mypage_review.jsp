<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
				<a href="MyDashboard">나의 강의실</a>
				<a href="MyReview" class="active">작성한 수강평</a>
				<a href="MyPayment">결제내역</a>
				<a href="MyCoupon">보유한 쿠폰</a>
				<a href="MyInquiry">문의내역</a>
				<a href="MyAttendance">출석체크</a>
			</aside>
			<div class="my-container">
				<div class="contents-ttl">작성한 수강평 <small>(총 <span>3</span>건)</small></div>
				<div class="contents">
					<!-- contents -->
					<section class="my-rev-wrap">
						<div class="my-rev-li">
							<article class="rev-box">
								<div class="info">
									<img src="/resources/images/thumb_06.webp" alt="썸네일">
									<div class="right">
										<p class="ttl">한국에서 제일 쉬운 리눅스 강의</p>
										<span class="name">리눅스마스터</span>
									</div>
								</div>
								<div class="detail">
									<p class="date">작성일시 : <span>2024.10.30</span></p>
									<div class="rating">
										<i class="fa-solid fa-star"></i>
										<span>4.0</span>
									</div>
									<div class="content">
										코딩에 다시 흥미를 느끼게 해주셔서 감사합니다. 이거 다 듣고 다른 강의들도 수강할 예정입니다. 코딩에 다시 흥미를 느끼게 해주셔서 감사합니다. 
										이거 다 듣고 다른 강의들도 수강할 예정입니다.
									</div>
									<div class="btns">
										<button class="btn-rev" onclick="showModal('viewWriteReview')">수정</button>
										<button class="btn-rev" onclick="">삭제</button>
									</div>
								</div>
							</article>
						</div>
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