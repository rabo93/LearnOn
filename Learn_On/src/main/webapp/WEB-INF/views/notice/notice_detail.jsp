<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/reset.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/notice.css">
    
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/slick.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/index.js"></script>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
	</header>
	<main>
		<div id="nt_dt_form">
			<h2>공지사항</h2>
			<section class="tb-wrap">
				<table class="tb-02">
					<colgroup>
						<col width="70%">
						<col width="15%">
						<col width="15%">
					</colgroup>
					<tr>
						<th class="dt-title">${notice.NOTICE_SUBJECT}</th>	<%-- 제목 --%>
						<th class="dt-author">${notice.MEM_ID}</th>			<%-- 작성자 --%>
						<th class="dt-date">${notice.NOTICE_DATE}</th>		<%-- 작성날짜 --%>
					</tr>
					<tr>
						<td colspan="3">
							<div class="dt-content">${notice.NOTICE_CONTENT}</div>
						</td>
					</tr>
					<tfoot>
						<tr>
							<td colspan="3">
								<c:forEach var="file" items="${fileList}" varStatus="status">
									<c:if test="${not empty file}">
									 	<div>
									 		<i class="fa-solid fa-paperclip"></i> ${file}
									 		<a href="${pageContext.request.contextPath}/resources/upload/${file}" download="${originalFileList[status.index]}">
									 			<input type="button" value="download">
									 		</a>
									 	</div>
									 </c:if>
								</c:forEach>
							</td>
						</tr>
					</tfoot>
				</table>
			</section>
			<!-- 목록, 수정, 삭제 버튼 추가하기! -->
		</div>
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
	</footer>
</body>
</html>