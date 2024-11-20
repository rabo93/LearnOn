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
		<form action="CourseSupportModify" method="post" enctype="multipart/form-data">
		
			<section class="tb-con">
				<div class="tb-hd">
					<h3 class="ttl">${courseSupport.c_support_subject}</h3>
					작성자 : <input type="hidden" name="mem_id" value="${param.class_id}">
					작성일자 : <span class="date">${courseSupport.c_support_date}</span>
	 				카테고리 :
	 				<c:if test="${courseSupport.c_support_category eq '01'}">수강/영상</c:if>
	 				<c:if test="${courseSupport.c_support_category eq '02'}">결제/환불</c:if>
	 				<c:if test="${courseSupport.c_support_category eq '03'}">기타</c:if>
				</div>
			</section>
			
			
		</form>	
	</div>
</body>
</html>








