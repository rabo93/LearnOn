<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>런 온 - 온라인 No.1 교육 플랫폼</title>
<link rel="SHORTCUT ICON" href="${pageContext.request.contextPath}/resources/images/favicon.ico">
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
			<section class="tb-con">
				<div class="tb-hd">
					<h3 class="ttl">${notice.notice_subject}</h3>
					작성자 : <span class="author">${notice.mem_id}</span>
					작성일자 : <span class="date">${notice.notice_date}</span>
					조회수 : <span class="count">${notice.notice_read_count}</span>
				</div>
				<div class="tb-details">
					${notice.notice_content}
				</div>
				<div class="tb-files">
					<c:forEach var="file" items="${fileList}" varStatus="status">
						<c:if test="${not empty file}">
						 	<div>
						 		<i class="fa-solid fa-paperclip"></i> ${file}
						 		<a href="${pageContext.request.contextPath}/resources/upload/${file}"
						 		   download="${originalFileList[status.index]}">
					 			<input type="button" value="다운로드">
						 		</a>
						 	</div>
						 </c:if>
					</c:forEach>
				</div>
			</section>
			<section class="tb-btns">
				<c:if test="${sessionScope.sGrade eq 'MEM03'}">
					<button class="btn-02" onclick="noticeDelete()">삭제</button>
					<button class="btn-03" onclick="noticeModify()">수정</button>
				</c:if>
				<button class="btn-03" onclick="location.href='NoticeList'">목록</button>
			</section>
			<!-- 목록, 수정, 삭제 버튼 추가하기! -->
		</div>
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
	</footer>
	<script type="text/javascript">
		
		function getParams() {
			let params = "";
			let searchParams = new URLSearchParams(location.search);	//	[notice_idx : XX]
																		//		키값	: 값
																		//	 param[0]	: param[1]
			for (let param of searchParams) {
				params += param[0] + "=" + param[1] + "&";
			}
			
			if (params.lastIndexOf("&" == params.length - 1)) {
				params = params.substring(0, params.length - 1);
			}
			
			return params;
		}
	
		function noticeDelete() {
			if (confirm("삭제하시겠습니까?")) {
				location.href = "NoticeDelete?" + getParams();
			}
		}
		
		function noticeModify() {
			location.href = "NoticeModify?" + getParams();
		}
		
	</script>
	
</body>
</html>