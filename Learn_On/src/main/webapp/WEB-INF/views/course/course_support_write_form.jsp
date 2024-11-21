<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>런온</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/reset.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/course.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/notice.css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
</head>

<body>
	<header>
		<%-- inc/top.jsp 페이지 삽입(jsp:include 액션태그 사용 시 / 경로는 webapp 가리킴) --%>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
	</header>
	<!-- 게시판 등록 -->
	<div id="nt_dt_form">
		<h2>문의하기</h2>
		
		<form action="CourseSupportWrite" method="post" enctype="multipart/form-data">
 			<input type="hidden" name="class_id" value="${param.class_id}">
 			<select name="c_support_category">
 				<option value=''>카테고리 선택</option>
 				<option value="01" <c:if test="${param.c_support_cate eq '01'}">selected</c:if>>수강/영상</option>
 				<option value="02" <c:if test="${param.c_support_cate eq '02'}">selected</c:if>>결제/환불</option>
 				<option value="03" <c:if test="${param.c_support_cate eq '03'}">selected</c:if>>기타</option>
 			</select>
 			
			<table>
				<tr>
					<td>제목</td>
					<td><input type="text" name="c_support_subject"/></td>
				</tr>
				<tr>
					<td>내용</td>
					<td>
						<textarea name="c_support_content" rows="15" cols="40" required="required" placeholder="문의할 내용"></textarea>
					</td>
				</tr>
				<tr>
					<td class=""><label for="board_file">첨부파일</label></td>
					<td class="">
						<input type="file" name="file">
					</td>
				</tr>
				
			</table>
			<input type="submit" value="작성하기">&nbsp;&nbsp;
			<input type="button" value="취소" onclick="history.back()">
		</form>
	</article>
</body>
</html>








