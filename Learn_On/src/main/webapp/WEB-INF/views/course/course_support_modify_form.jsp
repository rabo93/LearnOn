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
			<input type="hidden" name="c_support_idx" value="${courseSupport.c_support_idx}">
			<input type="hidden" name="pageNum" value="${param.pageNum}">
			<section class="tb-con">
				<div class="tb-hd">
				제목 : <input type="text" name="c_support_subject" value="${courseSupport.c_support_subject}"/><br>
					작성자 : <span>${courseSupport.mem_id}</span>
					작성일자 : <span class="date">${courseSupport.c_support_date}</span>
	 				카테고리 : 
	 				<select name="c_support_category">
		 				<option>카테고리 선택</option>
		 				<option value="01" <c:if test="${courseSupport.c_support_category eq '01'}">selected</c:if>>수강/영상</option>
		 				<option value="02" <c:if test="${courseSupport.c_support_category eq '02'}">selected</c:if>>결제/환불</option>
		 				<option value="03" <c:if test="${courseSupport.c_support_category eq '03'}">selected</c:if>>기타</option>
		 			</select>
				</div>
				<div class="tb-details">
					<textarea name="c_support_content" rows="15" cols="40" required="required" placeholder="문의할 내용">${courseSupport.c_support_content}</textarea>
				</div>
				<section class="tb-btns">
						<div class="tb-files">
							<c:choose>
								<c:when test="${not empty originalFileList}">
									<div class="board_file" id="file">
										${originalFileList}
										<a href="${pageContext.request.contextPath}/resources/upload/${originalFileList}" download="${originalFileList}"><i class="fa-solid fa-download"></i></a>
										<a href="#" onclick="deleteFile(${courseSupport.c_support_idx}, '${originalFileList}')"><i class="fa-solid fa-trash"></i></a>
										<input type="file" name="file" size="50" hidden>
										
									</div>
								</c:when>
								<c:otherwise>
								 	<input type="file" name="file">
								</c:otherwise>
							</c:choose>
						</div>
<%-- 					</c:forEach> --%>
				</section>
			</section>
			
			<section id="commandCell">
				<input type="submit" value="수정">
				<input type="button" value="취소" onclick="history.back()">
			</section>
		</form>	
	</div>
	<script>
		// --------- AJAX 활용하여 파일 삭제 ----------
		function deleteFile(c_support_idx, c_support_file) {
			if(confirm("삭제하시겠습니까?")) {
				console.log(c_support_idx + ", " + c_support_file);
				
				$.ajax({
					type : "post",
					url : "CourseSupportDeleteFile",
					data : {
						c_support_idx : c_support_idx,
						c_support_file : c_support_file
					}
				}).done(function(result) {
					if(result.trim() == "true") {
						let fileElem = $("input[name=file]");
						$(fileElem).parent().html(fileElem);
						$(fileElem).prop("hidden", false); 
					} else {
						alert("파일 삭제 실패\n 다시 시도하시오.")
					}
				}).fail(function(jqXHR) {
					alert("오류 발생!");
					console.log("오류: " + jqXHR.responseText);
				});
			}
		}
	</script>
</body>
</html>








