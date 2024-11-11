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
				<a href="MyInquiry" class="active">문의내역</a>
				<a href="MyAttendance">출석체크</a>
			</aside>
			<div class="my-container">
				<div class="contents-ttl">1:1 문의</div>
				<div class="contents">
					<!-- contents -->
					<section class="inq-wrap">
						<div class="inq-tops">
							<button class="btn-inq" onclick="">문의 남기기</button>
						</div>
						<div class="tb-wrap">
							<table class="tb-01 tb-inq">
								<colgroup>
									<col width="10%">
									<col width="15%">
									<col width="40%">
									<col width="15%">
									<col width="20%">
								</colgroup>
								<thead>
									<tr>
										<th>번호</th>
										<th>분류</th>
										<th>제목</th>
										<th>작성자</th>
										<th>날짜</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>1</td>
										<td>이용문의</td>
										<td class="subject">클래스 상세내용을 알고싶습니다.</td>
										<td>홍길동</td>
										<td>2024-11-05</td>
									</tr>
									<tr>
										<td>2</td>
										<td>결제문의</td>
										<td class="subject">결제가 되지않습니다. 확인해주세요</td>
										<td>홍길동</td>
										<td>2024-11-05</td>
									</tr>
									<tr class="reply">
										<td>└</td>
										<td>답변</td>
										<td class="subject">안녕하세요. 런온 입니다.</td>
										<td>관리자</td>
										<td>2024-11-06</td>
									</tr>
									<tr>
										<td>3</td>
										<td>기타</td>
										<td class="subject">이메일 변경이 되지 않아요</td>
										<td>홍길동</td>
										<td>2024-11-05</td>
									</tr>
								</tbody>
							</table>
							<div class="no-data" style="display:none;">데이터가 존재하지 않습니다.</div>
						</div>
						<section id="pageList">
							<button onclick=""><i class="fa-solid fa-angles-left"></i></button>
							<button onclick=""><i class="fa-solid fa-angle-left"></i></button>
							<strong>1</strong>
							<a href="">2</a>
							<a href="">3</a>
							<a href="">4</a>
							<a href="">5</a>
							<a href="">6</a>
							<a href="">7</a>
							<a href="">8</a>
							<a href="">9</a>
							<a href="">10</a>	
							<button onclick=""><i class="fa-solid fa-angle-right"></i></button>
							<button onclick=""><i class="fa-solid fa-angles-right"></i></button>
						</section>
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