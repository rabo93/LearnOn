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
		<div id="nt_commandArea">
			<div class="nt-head">
				<h2>공지사항</h2>
				<div class="nt-form">
					<form class="nt-sort-form" method="get">
						<select class="title_search" name="sort" onchange="this.form.submit()">
							<option value="latest"
							<c:if test="${sort eq 'latest'}">selected</c:if>
							>
							최신순
							</option>
							<option value="oldest"
							<c:if test="${sort eq 'oldest'}">selected</c:if>
							>
							오래된순
							</option>
						</select>
					</form>
					<form class="nt-search-form" method="get">
						<input type="text" name="searchKeyword" placeholder="검색어를 입력하세요">
						<input type="submit" value="검색">
					</form>
				</div>
			</div>
			<section>
				<div class="tb-wrap">
					<table class="nt-table tb-01">
						<colgroup>
							<col width="10%">
							<col width="70%">
							<col width="10%">
							<col width="10%">
						</colgroup>
							<tr>
								<th>번호</th>
								<th class="title">제목</th>
								<th>작성자</th>
								<th>날짜</th>
							</tr>
							<c:forEach items="${noticeList}" var="noticeBoard">
								<tr>
									<td class="nt_idx">${noticeBoard.NOTICE_IDX}</td>
									<td class="nt_subject">${noticeBoard.NOTICE_SUBJECT}</td>
									<td>${noticeBoard.MEM_ID}</td>
									<td>${noticeBoard.NOTICE_DATE}</td>
								</tr>
							</c:forEach>
					</table>
				</div>
			</section>
	<!--  ==============================    페이지처리영역		================================ -->
			<section id="nt_pagingArea">
				<input type="button" value="&lt;&lt;"
					onclick="location.href='NoticeList?pageNum=${pageInfo.startPage - pageInfo.pageListLimit}&sort=${sort}'"
					<c:if test="${pageInfo.startPage eq 1}">disabled</c:if>
				>
				<input type="button" value="&lt;"
					   onclick="location.href='NoticeList?pageNum=${pageNum - 1}&sort=${sort}'"
					   <c:if test="${pageNum eq 1}">disabled</c:if>
			    >
				<c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
					<c:choose>
						<c:when test="${i eq pageNum}">
							<strong>${i}</strong>
						</c:when>
						<c:otherwise>
							<a href="NoticeList?pageNum=${i}&sort=${sort}">${i}</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				
				<input type="button" value="&gt;"
					   onclick="location.href='NoticeList?pageNum=${pageNum + 1}&sort=${sort}'"
					   <c:if test="${pageNum eq pageInfo.maxPage}">disabled</c:if>
			   	>
				<input type="button" value="&gt;&gt;"
					   onclick="location.href='NoticeList?pageNum=${pageInfo.startPage + pageInfo.pageListLimit}&sort=${sort}'"
					   <c:if test="${pageInfo.endPage eq pageInfo.maxPage}">disabled</c:if>
			   	>
			</section>
				<div class="nt-writebtn">
					<input type="button" value="공지사항 쓰기" onclick="location.href='NoticeWrite'">
				</div>
		</div>
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
	</footer>
	<script type="text/javascript">
		$(".nt_subject").on("click", function(event){
			let parent = $(event.target).parent();
			
			let notice_idx = $(parent).find(".nt_idx").text();
			
			location.href = "NoticeDetail?notice_idx=" + notice_idx;
			//	파라미터로 페이지 넘버 추가?
			
		});
		
	</script>
	
</body>
</html>