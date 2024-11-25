<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
    <title>LearnOn - 관리자 페이지</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">

    <!-- Favicon -->
    <link href="resources/admin/img/favicon.ico" rel="icon">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- Icon Font Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="resources/admin/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="resources/admin/lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />

    <!-- Customized Bootstrap Stylesheet -->
    <link href="resources/admin/css/bootstrap.min.css" rel="stylesheet">
    
	<!-- 한글폰트 -->
    <link rel="stylesheet" href="resources/admin/css/reset.css">
    
    <!-- Template Stylesheet -->
    <link href="resources/admin/css/style.css" rel="stylesheet">
</head>
<body>
	<%@include file="inc/sidebar.jsp"%>
	<%@include file="inc/navbar.jsp"%>
	
	<%-- 내용 시작 --%>
	<!-- Blank Start -->
			<div class="container-fluid pt-4 px-4">
				<div class="bg-light rounded p-4">
					<div class="d-flex mb-2">
						<h5 class="me-auto tableSubject">강의별 수강문의 관리</h5>
					</div>
					<div class="d-flex input-group mb-3">
						<input type="text" class="form-control" placeholder="게시글 검색" aria-label="Recipient's username" aria-describedby="button-addon2">
						<button class="btn btn-primary" type="button" id="button-addon2">검색</button>
					</div>
						<table class="table table-striped">
							<colgroup>
								<col width="5%">
								<col width="50%">
								<col width="20%">
								<col width="15%">
								<col width="15%">
							</colgroup>
							<thead>
								<tr>
									<th scope="col">글번호</th>
									<th scope="col">제목</th>
									<th scope="col">작성자</th>
									<th scope="col">작성일</th>
									<th scope="col">답변여부</th>
								</tr>
							</thead>
							<tbody>
								<c:set var="pageNum" value="1" />
								<c:if test="${not empty param.pageNum}">
									<c:set var="pageNum" value="${param.pageNum}" />
								</c:if>
								<c:choose>
									<c:when test="${empty courseSupportList}">
										<tr>
											<td class="empty" colspan="4">작성된 문의내역이 없습니다.</td>
										</tr>
									</c:when>
									<c:otherwise>
										<c:forEach var="support" items="${courseSupportList}" varStatus="status">
											<tr onclick="showDetail(${status.index})">
<!-- 												<th><input class="form-check-input" type="checkbox" id="gridCheck1"></th> -->
												<td>${support.c_support_idx}</td>
												<td><input class="form-control" type="text" value="${support.c_support_subject}" readonly></td>
												<td><input class="form-control" type="text" value="${support.mem_id}" readonly></td>
												<td><input class="form-control" type="text" value="<fmt:formatDate value='${support.c_support_date}' pattern='yy-MM-dd HH:mm' />" readonly></td>
												<td>
												<c:choose>
													<c:when test="${support.c_support_answer_date != null}">
														<span class="answer-st status01">답변완료</span>
													</c:when>
													<c:otherwise>
														<span class="answer-st status02">미답변</span>
													</c:otherwise>												
												</c:choose>
												</td>
			                             	</tr>
			                             	<tr class="supportDetailBox" id="supportDetail${status.index}">
			                             		<td colspan="4">
			                             			<textarea class="form-control" rows="5" readonly>${support.c_support_content}</textarea>
			                             			<c:if test="${not empty support.c_support_file}">
				                             			<div class="support-attach">
					                             			${support.c_support_file}
							 								<a href="${pageContext.request.contextPath}/resources/upload/${support.c_support_file}" download="${originalFileNames[status.index]}">
							 									<input type="button" value="다운로드">
							 								</a>
						 								</div>
					 								</c:if>
			                             		</td>
			                             		<td colspan="1">
			                             			<button class="btn btn-lg btn-primary ms-3" type="button" onclick="showAnswer(${status.index})">
			                             				<c:choose>
			                             					<c:when test="${empty support.c_support_answer_subject}">답변작성</c:when>
			                             					<c:otherwise>답변보기</c:otherwise>
			                             				</c:choose>
			                             			</button>
			                             		</td>
			                             	</tr>
			                             	<tr class="answerDetailBox" id="answerDetail${status.index}">
			                             		<c:choose>
			                             			<c:when test="${empty support.c_support_answer_subject}">
				                             			<%-- 문의 답글 작성 --%>
				                             			<form action="AdmCourseSupportUpdate" method="post">
				                             				<input type="hidden" name="c_support_idx" value="${support.c_support_idx}">
				                             				<input type="hidden" name="pageNum" value="${pageNum}">
						                             		<td colspan="4">
						                             			<input class="form-control mb-2" type="text" placeholder="답글 제목" name="c_support_answer_subject">
						                             			<textarea class="form-control" rows="5" placeholder="답글 내용" name="c_support_answer_content"></textarea>
						                             		</td>
						                             		<td colspan="1">
						                             			<button class="btn btn-lg btn-primary ms-3">작성하기</button>
				                             				</td>
			                             				</form>
			                             			</c:when>
			                             			<c:otherwise>
			                             				<%-- 문의 답글 작성 후 --%>
			                             				<form action="AdmCourseSupportUpdate" method="post">
			                             					<input type="hidden" name="c_support_idx" value="${support.c_support_idx}">
			                             					<input type="hidden" name="pageNum" value="${pageNum}">
				                             				<td colspan="4">
						                             			<input class="form-control mb-2" type="text" placeholder="답글 제목" name="c_support_answer_subject" value="${support.c_support_answer_subject}">
						                             			<textarea class="form-control" rows="5" placeholder="답글 내용" name="c_support_answer_content">${support.c_support_answer_content}</textarea>
						                             		</td>
						                             		<td colspan="1">
						                             			<button class="btn btn-lg btn-primary ms-3">수정하기</button>
				                             				</td>
			                             				</form>
			                             			</c:otherwise>
			                             		</c:choose>
			                             	</tr>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
						
						<section id="pagingArea">
							<button
							onclick="location.href='AdmCourseSupport?pageNum=${pageInfo.startPage - pageInfo.pageListLimit}'"
							<c:if test="${pageInfo.startPage eq 1}">disabled</c:if>>
								<i class="fas fa-angle-double-left"></i>
							</button>
							<button
							onclick="location.href='AdmCourseSupport?pageNum=${pageNum - 1}'"
							<c:if test="${pageNum eq 1}">disabled</c:if>>
								<i class="fas fa-chevron-left"></i>
							</button>
							<c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
								<c:choose>
									<c:when test="${i eq pageNum}">
										<strong>${i}</strong>
									</c:when>
									<c:otherwise>
										<a href="AdmCourseSupport?pageNum=${i}">${i}</a>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							<button
							onclick="location.href='AdmSupport?pageNum=${pageNum + 1}'"
							<c:if test="${pageNum eq pageInfo.maxPage}">disabled</c:if>>
								<i class="fas fa-angle-right"></i>
							</button>
						   	<button
						   	onclick="location.href='AdmSupport?pageNum=${pageInfo.startPage + pageInfo.pageListLimit}'"
							<c:if test="${pageInfo.endPage eq pageInfo.maxPage}">disabled</c:if>>
						   		<i class="fas fa-angle-double-right"></i>
						   	</button>
					   	</section>
					   	
					</div>
				</div>
            <!-- Blank End -->
	<%-- 내용 끝 --%>
            
	<%@include file="inc/footer.jsp"%>

	<!-- Back to Top -->
    <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>

    <!-- JavaScript Libraries -->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="resources/admin/lib/chart/chart.min.js"></script>
    <script src="resources/admin/lib/easing/easing.min.js"></script>
    <script src="resources/admin/lib/waypoints/waypoints.min.js"></script>
    <script src="resources/admin/lib/owlcarousel/owl.carousel.min.js"></script>
    <script src="resources/admin/lib/tempusdominus/js/moment.min.js"></script>
    <script src="resources/admin/lib/tempusdominus/js/moment-timezone.min.js"></script>
    <script src="resources/admin/lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>

    <!-- Template Javascript -->
    <script src="resources/admin/js/main.js"></script>
    <script type="text/javascript">
    		function showDetail(idx){
				let supportDetailBox = document.querySelectorAll(".supportDetailBox");
				let answerDetailBox = document.querySelectorAll(".answerDetailBox");
				
				supportDetailBox.forEach((elem) => {
					elem.style.display = "none";
    			});
				answerDetailBox.forEach((elem) => {
					elem.style.display = "none";
    			});
				
				supportDetailBox[idx].style.display = "table-row";
    		}
    		
    		function showAnswer(idx){
    			let answerDetailBox = document.querySelectorAll(".answerDetailBox");
    			answerDetailBox.forEach((elem) => {
					elem.style.display = "none";
    			});
    			answerDetailBox[idx].style.display = "table-row";
    		}
    		
    		
    		// 메뉴 활성화
    		let link = document.location.href;
	    	if (link.includes("AdmCourseSupport")) {
	    		document.querySelector("#AdmCourseSupport").parentElement.previousElementSibling.classList.add("show");
	    		document.querySelector("#AdmCourseSupport").parentElement.previousElementSibling.classList.add("active");
	    		document.querySelector("#AdmCourseSupport").parentElement.classList.add("show");
	    		document.querySelector("#AdmCourseSupport").classList.toggle("active");
	    	};
    </script>
</body>
</html>