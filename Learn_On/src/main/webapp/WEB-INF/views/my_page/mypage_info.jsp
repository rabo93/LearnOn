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
				<a href="MyInfo" class="active">계정정보</a>
				<a href="MyFav">관심목록</a>
				<a href="MyDashboard">나의 강의실</a>
				<a href="MyReview">작성한 수강평</a>
				<a href="MyPayment">결제내역</a>
				<a href="MyCoupon">보유한 쿠폰</a>
				<a href="MyInquiry">문의내역</a>
				<a href="MyAttendance">출석체크</a>
			</aside>
			<div class="my-container">
				<div class="contents-ttl">계정설정</div>
				<div class="contents">
					<!-- contents -->
					<section class="info-set-wrap">
						<form action="" class="my-frm" method="post">
							<div class="set">
								<label>프로필</label>
								<div>
									<img src="${pageContext.request.contextPath}/resources/images/profile_thumb.svg" class="profile-thumb" alt="profile">
									<input type="button" value="프로필 변경" class="btn-frm">
								</div>
							</div>
							<div class="set">
								<label>
									아이디
								</label>
								<div>
									<input type="text" name="id" id="id" value="" value="#{sessionScope.sId}" disabled>
								</div>
							</div>
							<div class="set">
								<label>닉네임</label>
								<div>
									<input type="text" name="nickname" value="#{SessionScope.sId}">
								</div>
							</div>
							<div class="set">
								<label>비밀번호 <span>*</span></label>
								<div>
									<input type="password" name="oldPasswd" required>
								</div>
							</div>
							<div class="set">
								<label>변경할 비밀번호</label>
								<div>
									<input type="password" id="passwd" name="passwd" placeholder="8 ~ 16글자 사이 입력">
								</div>
								<div class="ip-tips" id="checkPasswd1Result">비밀번호는 최소 8글자 이상입니다</div>
							</div>
							<div class="set">	
								<label>변경할 비밀번호 재입력</label>
								<div>
									<input type="password" id="passwd2">
								</div>
								<div id="checkPasswd2Result" class="ip-tips">비밀번호가 일치합니다</div>
							</div>
							<div class="set">
								<label>주소</label>
								<div>
									<input type="text" id="postcode" name="post_code" value="" size="6" readonly placeholder="우편번호">
									<input type="button" value="주소검색" onclick="" class="btn-frm"><br>
								</div>
								<div>
									<input type="text" id="address1" name="address1" value="" size="25" readonly placeholder="기본주소"><br>
									<input type="text" id="address2" name="address2" value="" size="25" placeholder="상세주소">
								</div>
							</div>
							<div class="set">
								<label>이메일 </label>
								<div>
									<input type="text" size="10" id="email1" value="" name="email1">@<input type="text" size="10"  value="" id="email2" name="email2">
									<select id="emailDomain" class="sel-frm">
										<option value="">직접입력</option>
										<option value="naver.com">naver.com</option>
										<option value="nate.com">nate.com</option>
										<option value="gmail.com">gmail.com</option>
									</select>
								</div>
							</div>
							<div class="set">
								<label>전화번호</label>
								<div>
									<input type="text" size="10" id="phone" value="" name="phone">
								</div>
								<div id="checkPhoneResult" class="ip-tips">전화번호를 올바르게 입력해주세요</div>
							</div>
							<div class="btns">
								<input type="submit" class="btn-submit" value="수정">
							</div>
						</form>
						<a href="#" class="withdraw-link">회원탈퇴</a>
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