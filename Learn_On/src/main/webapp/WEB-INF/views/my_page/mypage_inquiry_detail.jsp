<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
				<a href="MySupport" class="active">문의내역</a>
				<a href="MyAttendance">출석체크</a>
			</aside>
			<div class="my-container">
				<div class="contents-ttl">1:1 문의 내용</div>
				<div class="contents">
					<!-- contents -->
					<section class="inq-wrap">
						<div class="com">
							<label>분류</label>
							<span>
								<c:if test="${support.support_category == 1}">이용문의</c:if>
								<c:if test="${support.support_category == 2}">결제문의</c:if>
								<c:if test="${support.support_category == 3}">기타</c:if>
							</span>
						</div>
	                    <div class="com">
		                    <label>제목</label>
							<span>${support.support_subject}</span>
	                    </div>
	                    <div class="com">
	                    	<label>작성일자</label>
							<span>
								<fmt:formatDate value="${support.support_date}" pattern="yyyy-MM-dd" />
							</span>
	                    </div>
	                    <div class="com">
	                    	<label>내용</label>
							<span class="contents">
								${support.support_content}
							</span>
	                    </div>
	                    <!-- 파일 첨부 -->
						<c:if test="${not empty support.support_file1}">
		                    <div class="com attach">
		                    	<label>첨부파일</label>
		                    	<span>
									<div>${support.support_file1}
		 								<a href="${pageContext.request.contextPath}/resources/upload/${fileName}" download="${originalFileName}">
		 									<input type="button" value="다운로드">
		 								</a>
	 								</div>
		                    	</span>
		                    </div>
						</c:if>
	                    <div class="btns">
		                    <c:if test="${not empty sessionScope.sId}">
		                    	<c:if test="${sessionScole.sId eq 'admin'}">
									<button type="button">답글</button>
		                    	</c:if>
								<c:if test="${sessionScope.sId eq support.mem_id or sessionScope.sId eq 'admin'}">
									<button onclick="requestModify()">수정</button>
									<button onclick="confirmDelete()">삭제</button>
								</c:if>
							</c:if>
							<button onclick="location.href='MySupport?pageNum=${param.pageNum}'">목록으로</button>
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
	<script>
		function getQueryParams() {
			let params = "";
			
			// URL에서 파라미터 탐색하여 파라미터가 존재하면 URL 뒤에 파라미터 결합
			let searchParams = new URLSearchParams(location.search);
			if(searchParams)
			for(let param of searchParams) {
				params += param[0] + "=" + param[1] + "&";
			}
			
			// 마지막 파라미터 뒤에 붙은 "&" 기호 제거
			if(params.lastIndexOf("&") == params.length - 1) { // & 기호가 배열의 끝에 있을 경우
				// & 기호 앞까지 추출하여 url 변수에 저장(덮어쓰기)
				params = params.substring(0, params.length - 1);
			}
			
			// 파라미터 결합된 문자열 리턴
			return params;
		}
	
		function confirmDelete(){
			if(confirm("삭제하시겠습니까?")){
				location.href = "MySupportDelete?" + getQueryParams(); // 페이지 요청
			}			
		}
	
		function requestModify() {
			location.href = "MySupportModify?" + getQueryParams(); // 페이지 요청
		}	
	</script>
</body>
</html>