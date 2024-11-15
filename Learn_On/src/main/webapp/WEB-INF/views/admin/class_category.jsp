<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
    <title>LearnOn - 관리자 페이지</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js">
    </script>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">

    <!-- Favicon -->
    <link href="resources/admin/img/favicon.ico" rel="icon">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- Icon Font Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
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
</head>
<body>
	<%@include file="inc/sidebar.jsp"%>
	<%@include file="inc/navbar.jsp"%>
	
	<%-- 내용 시작 --%>
	<!-- Blank Start -->
	<form action="admin_class_category" name="addForm" method="post">
		<div class="container-fluid pt-4 px-4">
			<div class="bg-light rounded p-4">
				<div class="d-flex mb-5">
					<h5 class="me-auto tableSubject">카테고리 편집</h5>
				</div>
				<div>
					<div class="d-flex mb-3">
						<h5 class="me-auto tableSubject">대분류</h5>
						<button type="button" class="btn btn-lg btn-primary ms-3" onClick="deleteMainCateRow();">삭제</button>
						<button type="button" class="btn btn-lg btn-primary ms-3" onClick="addMainCateRow();">추가</button>
						<button type="submit" class="btn btn-lg btn-primary ms-3">저장</button>
					</div>
					<table class="table table-striped" id="mainCateTable">
						<thead>
							<tr>
								<th scope="col">#</th>
								<th scope="col">카테고리 아이디(CODEID)</th>
								<th scope="col">카테고리 타입(CODETYPE)</th>
								<th scope="col">카테고리 이름(CODENAME)</th>
								<th scope="col">카테고리 설명(DESCRIPTION)</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${getMainCate}" var="mainCate">
								<tr>
									<td><input class="form-check-input" type="checkbox" id="gridCheck1" name="mainCateRowCheck"></td>
									<td><input id="CODEID" class="form-control " type="text" placeholder="아이디" value="${mainCate.CODEID}"></td>
									<td><input id="CODETYPE" class="form-control " type="text" placeholder="타입" value="${mainCate.CODETYPE}"></td>
									<td><input id="CODENAME" class="form-control " type="text" placeholder="이름" value="${mainCate.CODENAME}"></td>
									<td><input id="DESCRIPTION" class="form-control " type="text" placeholder="설명" value="${mainCate.DESCRIPTION}"></td>
	                           	</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<hr>
				<div>
					<div class="d-flex mb-3">
						<h5 class="me-auto tableSubject">소분류</h5>
						<button type="button" class="btn btn-lg btn-primary ms-3" onClick="deleteSubCateRow();">삭제</button>
						<button type="button" class="btn btn-lg btn-primary ms-3" onClick="addSubCateRow();">추가</button>
					</div>
					<table class="table table-striped" id="subCateTable">
						<thead>
							<tr>
								<th scope="col">#</th>
								<th scope="col">카테고리 타입(CODETYPE)</th>
								<th scope="col">카테고리 아이디(CODETYPE_ID)</th>
								<th scope="col">카테고리 이름(NAME)</th>
								<th scope="col">카테고리 설명(DESCRIPTION)</th>
								<th scope="col">오더(ORDER)</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${getSubCate}" var="subCate">
								<tr>
									<td><input class="form-check-input" type="checkbox" id="gridCheck1" name="subCateRowCheck"></td>
									<td><input name="old_codetype_subcate" class="form-control" type="text" placeholder="타입" value="${subCate.CODETYPE}"></td>
									<td><input name="old_codetype_id_subcate" class="form-control" type="text" placeholder="아이디" value="${subCate.CODETYPE_ID}"></td>
									<td><input name="old_name_subcate" class="form-control" type="text" placeholder="이름" value="${subCate.NAME}"></td>
									<td><input name="old_description_subcate" class="form-control" type="text" placeholder="설명" value="${subCate.DESCRIPTION}"></td>
									<td><input name="old_order_subcate" class="form-control" type="text" placeholder="오더" value="${subCate.ORDER}"></td>
	                           	</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</form>
	<!-- Blank End -->
	<%-- 내용 끝 --%>
            
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
    <script src="resources/admin/js/admClass.js"></script>
    <script type="text/javascript">
   		var link = document.location.href;
    	if (link.includes("class")) {
    		document.getElementById("classCategory").classList.toggle("active");
    		document.getElementById("classManage").classList.toggle("active");
    	};
    </script>
</body>
</html>