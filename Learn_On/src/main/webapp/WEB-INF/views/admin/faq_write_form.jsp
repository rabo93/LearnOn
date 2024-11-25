<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FAQ</title>
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
				<h5 class="me-auto tableSubject">FAQ 글쓰기</h5>
			</div>
			<section class="tb-wrap">
				<form action="AdminFaqWrite" class="d-flex input-group mb-3" method="post" enctype="multipart/form-data">
					<table class="table table-striped">
						<colgroup>
								<col width="20%">
								<col width="80%">
						</colgroup>
						<tr>
							<th>제목</th>
							<td>
								<input type="text" class="form-control" name="faq_subject">
							</td>
							<td>
							</td>
						</tr>
						<tr>
							<th>카테고리</th>
							<td>
								<select class="form-select" name="faq_cate">
									<option value="1">강의수강</option>
									<option value="2">계정관리</option>
									<option value="3">결제환불</option>
									<option value="4">증빙서류</option>
								</select>
							</td>
						</tr>
						<tr>
							<th>내용</th>
							<td>
								<textarea class="form-control" rows="15" cols="40" name="faq_content"></textarea>
							</td>
						</tr>
					</table>
					<section class="nt-btns">
						<button class="btn btn-lg btn-primary ms-3" type="submit">등록</button>
						<button class="btn btn-lg btn-primary ms-3" type="button" onclick="location.href='AdmFaq'">취소</button>
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
		let link = document.location.href;
		if (link.includes("AdminFaqWrite")) {
			document.querySelector("#AdmFaq").parentElement.previousElementSibling.classList.add("show");
			document.querySelector("#AdmFaq").parentElement.previousElementSibling.classList.add("active");
			document.querySelector("#AdmFaq").parentElement.classList.add("show");
			document.querySelector("#AdmFaq").classList.toggle("active");
		};
	</script>
</body>
</html>







