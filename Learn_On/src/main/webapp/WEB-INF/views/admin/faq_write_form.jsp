<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>FAQ</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/reset.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/faq.css">

<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/index.js"></script>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
	</header>
	<main>
		<div id="faq_write_container">
			<div class="faq-head">
				<h2>FAQ 글쓰기</h2>
			</div>
			<section class="tb-wrap">
				<form action="AdminFaqWrite" name="writeForm" method="post" enctype="multipart/form-data">
					<table class="nt-table tb-02">
						<colgroup>
							<col width="20%">
							<col width="80%">
						</colgroup>
						<tr>
							<th>제목</th>
							<td>
								<input type="text" name="faq_subject">
							</td>
							<td>
							</td>
						</tr>
						<tr>
							<th>카테고리</th>
							<td>
								<select name="faq_cate">
									<option value="1">강의수강</option>
									<option value="2">계정관리</option>
									<option value="3">결제환불</option>
									<option value="4">증빙서류</option>
								</select>
							</td>
						</tr>
						<tr>
							<th>내용</th>
							<td>
								<textarea rows="15" cols="40" name="faq_content"></textarea>
							</td>
						</tr>
					</table>
					<section class="btns">
						<input type="submit" value="등록">
						<input type="button" value="취소" onclick="history.back()">
					</section>
				</form>
			</section>
		</div>
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
	</footer>
</body>
</html>