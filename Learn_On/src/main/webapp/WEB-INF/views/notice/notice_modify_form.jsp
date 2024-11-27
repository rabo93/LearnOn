<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>런 온 - 온라인 No.1 교육 플랫폼</title>
<link rel="SHORTCUT ICON" href="${pageContext.request.contextPath}/resources/images/favicon.ico">
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
	<div id="nt_write_container">
		<div class="nt-head">
			<h2>글 수정하기</h2>
		</div>
		<section class="tb-wrap">
			<form action="NoticeModify" method="post" enctype="multipart/form-data">
				<input type="hidden" name="notice_idx" value="${param.notice_idx}">
				<input type="hidden" name="pageNum" value="${param.pageNum}">
				<table class="nt-table tb-02">
					<colgroup>
						<col width="20%">
						<col width="80%">
					</colgroup>
					<tr>
						<td>작성자</td>
						<td>
							<input type="text" name="mem_id" value="${sessionScope.sId}" readonly required />
						</td>
					</tr>
					<tr>
						<td>제목</td>
						<td>
							<input name="notice_subject" value="${notice.notice_subject}" required />
						</td>
					</tr>
					<tr>
						<td>내용</td>
						<td>
							<textarea name="notice_content" rows="15" cols="40" required>${notice.notice_content}</textarea>
						</td>
					</tr>
					<tr>
						<td>첨부파일</td>
						<td>
							<c:forEach var="file" items="${fileList}" varStatus="status">
								<div class="board_file" id="file_${status.count}">
									<c:choose>
										<c:when test="${not empty file}">
											<input type="text" name="notice_file_get" value="${originalFileList[status.index]}" readonly>
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
				<section class="btns">
					<input type="submit" value="수정">
					<input type="button" value="취소" onclick="history.back()">
				</section>
			</form>
		</section>
	</div>
	<footer>
		<!-- 회사 소개 영역(inc/bottom.jsp) 페이지 삽입 -->
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
	</footer>
	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
	<script type="text/javascript">
		
		function deleteFile(notice_idx, file, index) {
			console.log(notice_idx + "," + file + "," + index);
			$.ajax ({
				type : "POST",
				url : "/notice/deleteFile",
				data : {
					notice_idx : notice_idx,
					file : file,
					index : index - 1
				},
			}).done(function(result) {
				console.log("파일 삭제 성공" , result);
				$("#file_" + index).remove();
			}).fail(function(jqXHR){
				console.log("파일 삭제 실패 : " + jqXHR.status);
				alert("파일삭제에 실패했습니다. 다시 시도해주세요");
			});
		};
		
	</script>
</body>
</html>








