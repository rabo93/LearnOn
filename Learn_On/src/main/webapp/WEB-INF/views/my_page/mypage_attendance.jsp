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
				<a href="MyFav">관심목록</a>
				<a href="MyDashboard">나의 강의실</a>
				<a href="MyReview">작성한 수강평</a>
				<a href="MyPayment">결제내역</a>
				<a href="MyCoupon">보유한 쿠폰</a>
				<a href="MySupport">문의내역</a>
				<a href="MyAttendance" class="active">출석체크</a>
			</aside>
			<div class="my-container">
				<div class="contents-ttl">출석체크</div>
				<div class="contents">
					<!-- contents -->
					<div class="attendance-wrap">
						<c:set var="today"><fmt:formatDate value="<%=new java.util.Date()%>" pattern="yyyy-MM-dd" /></c:set> 
						<c:choose>
							<c:when test="${empty attendance.check_in_date || attendance.check_in_date != today}">
								<button class="btn-att checked"><i class="fa-solid fa-check"></i> 출석하기</button>
							</c:when>
							<c:otherwise>
								<button class="btn-att"><i class="fa-solid fa-check"></i> 출석완료</button>
							</c:otherwise>
						</c:choose>
						
						<div class="att-box">
							<i class="fa-solid fa-calendar-check"></i>
							<p><span>
								<c:choose>
									<c:when test="${empty attendance.streak_days}">0</c:when>
									<c:otherwise>${attendance.streak_days}</c:otherwise>
								</c:choose>
							</span>일 연속 출석하셨습니다.</p>
						</div>
					</div>
					<!-- // contents -->
				</div>
			</div>
		</section>
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
	</footer>
	
	<script type="text/javascript">
    document.addEventListener('DOMContentLoaded', function () {
        const checkButton = document.querySelector('.btn-att.checked');
        const streakDisplay = document.querySelector('.att-box span'); // 연속 출석 일 수를 표시하는 요소

        if (checkButton) {
            checkButton.addEventListener('click', function () {
                // 연속 출석일 계산
                let streakDays = parseInt(streakDisplay.textContent) || 0;
                streakDays += 1; // 버튼 클릭 시 1 증가
                
                // UI 업데이트
                streakDisplay.textContent = streakDays;

                // 알림 표시
                alert("출석완료!");
                
                // 버튼 상태 변경
                checkButton.textContent = '출석완료';
                checkButton.classList.remove('checked'); // 버튼을 '출석완료' 상태로 변경
            });
        }
    });
</script>
</body>
</html>