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
				<a href="MyCoupon">보유한 쿠폰</a>
				<a href="MySupport" class="active">문의내역</a>
				<a href="MyAttendance">출석체크</a>
			</aside>
			<div class="my-container">
				<div class="contents-ttl">1:1 문의 쓰기</div>
				<div class="contents">
					<!-- contents -->
					<section class="inq-wrap">
						<form action="MySupportWrite" method="post" enctype="multipart/form-data" class="inq-frm">
							<input type="hidden" name="mem_id" value="${sessionScope.sId}">
							<div class="row">
								<select name="support_category">
			                    	<option value="1">이용문의</option>
			                    	<option value="2">결제문의</option>
			                    	<option value="3">기타</option>
			                    </select>
							</div>
		                    <div class="row">
			                    <input type="text" placeholder="제목을 입력하세요" name="support_subject" required="required" >
		                    </div>
		                    <div class="row">
		                    	<textarea name="support_content" rows="15" cols="40" required="required" placeholder="문의할 내용을 입력하세요"></textarea>
		                    </div>
		                    <!-- 파일 첨부 -->
		                    <div class="row">
		                    	<input type="file" name="file1">
		                    </div>
		                     <div class="btns">
		                    	<button type="button" onclick="history.back()">취소</button>
		                    	<button type="submit">등록하기</button>
		                    </div>
		                </form>
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