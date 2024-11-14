<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>공지사항</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/reset.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/notice.css">

<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/index.js"></script>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
	</header>
	<main>
		<div id="nt_write_container">
			<h2>공지사항 작성</h2>
			<form action="NoticeWrite" name="writeForm" method="post" enctype="multipart/form-data">
				<table>
					<tr>
						<td>글쓴이</td>
						<td>
							<input type="text" name="mem_id" value="${sessionScope.sId}" readonly>
						</td>
					</tr>
					<tr>
						<td>제목</td>
						<td>
							<input type="text" name="notice_subject">
						</td>
					</tr>
					<tr>
						<td>내용</td>
						<td>
							<textarea rows="15" cols="40" name="notice_content"></textarea>
						</td>
					</tr>
					<tr>
						<td>
							<input type="file" name="notice_file_get" multiple>
						</td>
					</tr>
				</table>
				<section>
					<input type="submit" value="등록">
					<input type="button" value="취소" onclick="history.back()">
				</section>
			</form>
		</div>
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
	</footer>
</body>
</html>