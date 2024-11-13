<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MVC 게시판</title>
<!-- 외부 CSS 파일(css/default.css) 연결하기 -->
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
		<%-- inc/top.jsp 페이지 삽입(jsp:include 액션태그 사용 시 / 경로는 webapp 가리킴) --%>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
	</header>
	<!-- 게시판 등록 -->
	<article id="modifyForm">
		<h1>글 상세내용 보기</h1>
		<form action="NoticeModify" method="post" enctype="multipart/form-data">
			<input type="hidden" name="notice_num" value="${param.mem_id}">
			<input type="hidden" name="pageNum" value="${param.pageNum}">
			<table>
				<tr>
					<td class="write_td_left"><label for="board_name">작성자</label></td>
					<td class="write_td_right">
						<input type="text" id="mem_id" name="mem_id" value="${sessionScope.sId}" readonly required />
					</td>
				</tr>
				<tr>
					<td class="write_td_left"><label for="notice_subject">제목</label></td>
					<td class="write_td_right">
						<input type="text" id="notice_subject" name="notice_subject" value="${board.notice_subject}" required />
					</td>
				</tr>
				<tr>
					<td class="write_td_left"><label for="notice_content">내용</label></td>
					<td class="write_td_right">
						<textarea id="notice_content" name="notice_content" rows="15" cols="40" required>${board.notice_content}</textarea>
					</td>
				</tr>
				<tr>
					<td class="write_td_left"><label for="notice_file">첨부파일</label></td>
					<td class="write_td_right">
					
						<c:forEach var="file" items="${fileList}" varStatus="status">
							<div class="board_file">
								<c:choose>
									<c:when test="${not empty file}">
										<input type="text" name="notice_file_get" value="${originalFileList[status.index]}">
<%-- 										${originalFileList[status.index]} --%>
										<a href="${pageContext.request.contextPath}/resources/upload/${file}" download="${originalFileList[status.index]}"><i class="fa-solid fa-download"></i></a>
										<a href="javascript:deleteFile(${notice.notice_idx}, '${file}', ${status.count})"><i class="fa-solid fa-trash"></i></a>
									</c:when>
								</c:choose>
							</div>
						</c:forEach>
						<div>
							<input type="file" name="notice_file_get" multiple>
						</div>
					</td>
				</tr>
			</table>
			<section id="commandCell">
				<input type="submit" value="수정">
				<input type="button" value="취소" onclick="history.back()">
			</section>
		</form>
	</article>
	<footer>
		<!-- 회사 소개 영역(inc/bottom.jsp) 페이지 삽입 -->
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
	</footer>
	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
	<script type="text/javascript">
		
		function deleteFile(notice_idx, file, index) {
			console.log(notice_idx + "," + file + "," + index);
// 			$.ajax({
// 				url : '/deleteFile',
// 				type : 'POST',
// 				data : {
// 					notice_idx : notice_Idx,
// 					file : file
// 				}
// 			});
		}
		
	</script>
</body>
</html>








