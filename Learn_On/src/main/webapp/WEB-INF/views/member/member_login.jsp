<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/reset.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<%-- <script src="${pageContext.request.contextPath}/resources/js/index.js"></script> --%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login.css">

</head>
<body>
	<header id="hd">
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
	</header>
	<!-- page 영역 -->
	<main>
	<div class="member-wrap">
	
	</div>
   <div class="login-wrap">
	    <h1 class="login-ttl">로그인</h1>
	    <div class="login-box">
           <div class="mem-select">
               <label>
                   <input type="radio" name="mem_status" id="mem_user" value="일반회원"> 일반회원
               </label>
               <label>
                   <input type="radio" name="mem_status" id="mem_teacher" value="강사회원"> 강사회원
               </label>
           </div>
           <form action="MemberLogin" method="post">
               <label for="mem_id" >아이디</label>
               <input type="text" name="mem_id" id="mem_id" placeholder="아이디" value="${cookie.userId.value }">
               <label for="mem_passwd">비밀번호</label>
               <input type="password" name="mem_passwd" id="mem_passwd" placeholder="&#9679;&#9679;&#9679;&#9679;&#9679;&#9679;">
               <div class="checkbox-container">
              	 <label for="rememberId"><input type="checkbox" name="rememberId" id="rememberId"<c:if test="${not empty cookie.userId}">checked</c:if>>아이디 기억하기</label>
               </div>
               <div class="passwd_find">
					<label for="passwd_find"><a href="PasswdFinder">비밀번호 찾기</a></label>
               </div>
               <div id="form-controls">
					<button type="submit">로그인</button>
               </div>
               <div class="signup-link">
                   <span>런온(LearmOn)이 처음이신가요? <a href="MemberJoin">회원가입</a></span>
               </div>
           </form>
       </div>
   </div>
	</main>
	<!-- // page 영역 -->
	<footer id="ft">
	<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
	</footer>
</body>
</html>