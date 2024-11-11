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
				<a href="MyReview">작성한 수강평</a>
				<a href="MyPayment">결제내역</a>
				<a href="MyCoupon" class="active">보유한 쿠폰</a>
				<a href="MyInquiry">문의내역</a>
				<a href="MyAttendance">출석체크</a>
			</aside>
			<div class="my-container">
				<div class="contents-ttl">보유한 쿠폰</div>
				<div class="contents">
					<!-- contents -->
					<section class="coupon-wrap">
						<div class="coupon-total">
					        <div class="coupon-title">사용가능한 쿠폰</div>
					        <div class="coupon-count">2</div>
					        <div class="coupon-unit">개</div>
						</div>
						<div class="coupon-list">
					    	<ul class="myCoupon">
					    		<li id="coupon1">
					    			<p class="c-name">🎉오픈기념🎉 반짝 쿠폰✨</p>
					    			<p class="c-exp-date">사용기한 : ~ 2025.01.20</p>
					    			<p class="c-dis">30%</p>
					    		</li>
					    		<li id="coupon2">
					    			<p class="c-name">🐤신규가입🐤 쿠폰</p>
					    			<p class="c-exp-date">사용기한 : ~ 2025.01.20</p>
					    			<p class="c-dis">10,000원</p>
					    		</li>
					    		<li id="coupon3">
					    			<p class="c-name">생일 기념 반값 쿠폰</p>
					    			<p class="c-exp-date">사용기한 : ~ 2025.01.20</p>
					    			<p class="c-dis">50%</p>
					    		</li>
					    		<li id="coupon3" class="end">
					    			<p class="c-name">생일 기념 반값 쿠폰</p>
					    			<p class="c-exp-date">사용기한 : ~ 2025.01.20</p>
					    			<p class="c-dis">50%</p>
					    		</li>
					    	</ul>
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
</body>
</html>