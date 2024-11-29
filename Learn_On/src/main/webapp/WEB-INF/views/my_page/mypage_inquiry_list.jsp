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
				<a href="MySupport" class="active">문의내역</a>
				<a href="MyAttendance">출석체크</a>
			</aside>
			<div class="my-container">
				<div class="contents-ttl">1:1 문의</div>
				<div class="contents">
					<!-- contents -->
					<section class="inq-wrap">
						<div class="inq-tops">
							<button class="btn-inq" onclick="location.href='/MySupportWrite'">문의 남기기</button>
						</div>
						<div class="tb-wrap">
							<table class="tb-01 tb-inq">
								<colgroup>
<%-- 									<col width="10%"> --%>
									<col width="15%">
									<col width="50%">
									<col width="15%">
									<col width="20%">
								</colgroup>
								<thead>
									<tr>
<!-- 										<th>번호</th> -->
										<th>분류</th>
										<th>제목</th>
										<th>작성자</th>
										<th>날짜</th>
									</tr>
								</thead>
								<tbody>
									<c:set var="pageNum" value="1" />
									<c:if test="${not empty param.pageNum}">
										<c:set var="pageNum" value="${param.pageNum}" />
									</c:if>
									<c:choose>
										<c:when test="${empty supportList}">
											<tr>
												<td class="empty" colspan="4">작성한 문의내역이 없습니다.</td>
											</tr>
										</c:when>
										<c:otherwise>
											<c:forEach var="support" items="${supportList}">
												<tr>
													<td class="board_num" style="display:none;">${support.support_idx}</td>
													<td>
														<c:if test="${support.support_category == 1}">
															이용문의
														</c:if>
														<c:if test="${support.support_category == 2}">
															결제문의
														</c:if>
														<c:if test="${support.support_category == 3}">
															기타
														</c:if>
													</td>
													<td class="subject">
														${support.support_subject}
														<c:if test="${support.support_answer_date != null}">
															<span class="inq-reply">답변완료 <i class="fa-solid fa-reply"></i></span>
														</c:if>
													</td>
													<td>${support.mem_name}</td>
													<td><fmt:formatDate value="${support.support_date}" pattern="yy-MM-dd HH:mm" /></td>
												</tr>
												
											</c:forEach>
										</c:otherwise>
									</c:choose>
<!-- 									<tr class="reply"> -->
<!-- 										<td>└</td> -->
<!-- 										<td>답변</td> -->
<!-- 										<td class="subject">안녕하세요. 런온 입니다.</td> -->
<!-- 										<td>관리자</td> -->
<!-- 										<td>2024-11-06</td> -->
<!-- 									</tr> -->
								</tbody>
							</table>
							<div class="no-data" style="display:none;">데이터가 존재하지 않습니다.</div>
						</div>
						<section id="pageList">
							<button 
								onclick="location.href='MySupport?pageNum=${pageInfo.startPage - pageInfo.pageListLimit}'"
								<c:if test="${pageInfo.startPage == 1}">disabled</c:if>
							><i class="fa-solid fa-angles-left"></i></button>
							<button 
								onclick="location.href='MySupport?pageNum=${pageNum - 1}'"
								<c:if test="${pageNum == 1}">disabled</c:if>
							><i class="fa-solid fa-angle-left"></i></button>
							<c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
								<c:choose>
									<c:when test="${i eq pageNum}">
										<strong>${i}</strong>
									</c:when>
									<c:otherwise>
										<a href="MySupport?pageNum=${i}">${i}</a>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							<button 
								onclick="location.href='MySupport?pageNum=${pageNum + 1}'"
								<c:if test="${pageNum == pageInfo.maxPage}">disabled</c:if>
							><i class="fa-solid fa-angle-right"></i></button>
							<button
								onclick="location.href='MySupport?pageNum=${pageInfo.startPage + pageInfo.pageListLimit}'"
								<c:if test="${pageInfo.endPage == pageInfo.maxPage}">disabled</c:if>
							><i class="fa-solid fa-angles-right"></i></button>
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
	<script type="text/javascript">
		$(".subject").on("click", function(event) {
			let parent = $(event.target).parent();
			let board_num = $(parent).find(".board_num");
			console.log(board_num.text());
			location.href = "MySupportDetail?support_idx=" + board_num.text() +  "&pageNum=" + ${pageNum};
		});
	</script>
</body>
</html>