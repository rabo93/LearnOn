<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>런 온 - 온라인 No.1 교육 플랫폼</title>
<link rel="SHORTCUT ICON" href="${pageContext.request.contextPath}/resources/images/favicon.ico">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/reset.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css">


<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
</head>

<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
	</header>
	<main>
		<h2 class="page-ttl">문의하기</h2>
		<section class="my-wrap">
			<div class="my-container">
				<div class="contents-ttl">수강 문의 쓰기</div>
				<div class="contents">
					<!-- contents -->
					<section class="inq-wrap">
						<form action="CourseSupportWrite" method="post" enctype="multipart/form-data" class="inq-frm">
			 				<input type="hidden" name="class_id" value="${param.class_id}">
								<div class="row">
									<select name="c_support_category">
						 				<option value=''>문의사항 카테고리 선택</option>
						 				<option value="01" <c:if test="${param.c_support_cate eq '01'}">selected</c:if>>수강/영상</option>
						 				<option value="02" <c:if test="${param.c_support_cate eq '02'}">selected</c:if>>결제/환불</option>
						 				<option value="03" <c:if test="${param.c_support_cate eq '03'}">selected</c:if>>기타</option>
						 			</select>
						 		</div>
						 		<div class="row">
									<input type="text" placeholder="제목을 입력하세요." name="c_support_subject" required="required"/>
								</div>
								<div class="row">
									<textarea name="c_support_content" rows="15" cols="40" required="required" placeholder="문의할 내용"></textarea>
								</div>
								<div class="row">
									<input type="file" name="file">
								</div>
								<div class="btns">
								 	<button type="button" onclick="history.back()">취소</button>
			                    	<button type="submit">등록하기</button>
								</div>
							</form>
						</section>
					</div><!-- // contents -->
			</div><!-- my-container -->
		</section>	
	</main>
</body>
</html>