<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 수정</title>
	<!-- Favicon -->
    <link href="resources/admin/img/favicon.ico" rel="icon">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- Icon Font Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="resources/admin/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="resources/admin/lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />

    <!-- Customized Bootstrap Stylesheet -->
    <link href="resources/admin/css/bootstrap.min.css" rel="stylesheet">
    
	<!-- 한글폰트 -->
    <link rel="stylesheet" href="resources/admin/css/reset.css">
    
    <!-- Template Stylesheet -->
    <link href="resources/admin/css/style.css" rel="stylesheet">
    <!-- JQuery -->
    <script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
</head>
<body>
	<%@include file="inc/sidebar.jsp"%>
	<%@include file="inc/navbar.jsp"%>
	
	<div class="container-fluid pt-4 px-4">
		<div class="bg-light rounded p-4">
			<div class="d-flex mb-5">
				<h5 class="me-auto tableSubject">글 수정하기</h5>
			</div>
			<section class="tb-wrap">
				<form action="AdminNoticeModify" class="d-flex input-group mb-3" method="post" enctype="multipart/form-data">
					<input type="hidden" name="notice_idx" value="${param.notice_idx}">
					<table class="table table-striped">
						<colgroup>
								<col width="20%">
								<col width="80%">
						</colgroup>
						<tr>
							<th>제목</th>
							<td>
								<input type="text" class="form-control" name="notice_subject" value="${notice.notice_subject}" required />
							</td>
						</tr>
						<tr>
							<th>내용</th>
							<td>
								<textarea name="notice_content" class="form-control" rows="15" cols="40" required>${notice.notice_content}</textarea>
							</td>
						</tr>
						<tr>
							<th>첨부파일</th>
							<td>
							
								<c:forEach var="file" items="${fileList}" varStatus="status">
									<div class="board_file" id="file_${status.count}">
										<c:choose>
											<c:when test="${not empty file}">
												<input class="form-control" type="text" name="notice_file_get" value="${originalFileList[status.index]}" readonly>
												<a href="${pageContext.request.contextPath}/resources/upload/${file}" download="${originalFileList[status.index]}"><i class="fa-solid fa-download"></i></a>
												<a href="javascript:deleteFile(${notice.notice_idx}, '${file}', ${status.count})"><i class="fa-solid fa-trash"></i></a>
											</c:when>
										</c:choose>
									</div>
								</c:forEach>
								<div>
									<input class="form-control" type="file" name="notice_file_get" multiple>
								</div>
							</td>
						</tr>
					</table>
					<section class="nt-btns">
						<button class="btn btn-lg btn-primary ms-3" type="submit">수정</button>
						<button class="btn btn-lg btn-primary ms-3" type="button" onclick="location.href='AdmNotice'">취소</button>
					</section>
				</form>
			</section>
		</div>
	</div>
	<%@include file="inc/footer.jsp"%>
	<!-- Back to Top -->
    <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>

    <!-- JavaScript Libraries -->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="resources/admin/lib/chart/chart.min.js"></script>
    <script src="resources/admin/lib/easing/easing.min.js"></script>
    <script src="resources/admin/lib/waypoints/waypoints.min.js"></script>
    <script src="resources/admin/lib/owlcarousel/owl.carousel.min.js"></script>
    <script src="resources/admin/lib/tempusdominus/js/moment.min.js"></script>
    <script src="resources/admin/lib/tempusdominus/js/moment-timezone.min.js"></script>
    <script src="resources/admin/lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>

    <!-- Template Javascript -->
    <script src="resources/admin/js/main.js"></script>
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
		
		var link = document.location.href;
	   	if (link.includes("board")) {
	   		document.getElementById("board").classList.toggle("active");
	   		document.getElementById("boardManage").classList.toggle("active");
	   	};
	</script>
</body>
</html>








