<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
    <title>LearnOn - 관리자 페이지</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">

    <!-- Favicon -->
    <link href="resources/admin/img/favicon.ico" rel="icon">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
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
    
    <!-- 클래스 관리 script -->
     <script src="resources/admin/js/admClass.js"></script>
</head>
<body>
	<%@include file="inc/sidebar.jsp"%>
	<%@include file="inc/navbar.jsp"%>
	
	<%-- 내용 시작 --%>
	<!-- Blank Start -->
			<div class="container-fluid pt-4 px-4">
				<div class="bg-light rounded p-4">
					<div class="d-flex mb-5">
						<h5 class="me-auto tableSubject">클래스 목록</h5>
						<button type="button" class="btn btn-lg btn-primary ms-3" onclick="location.href='AdmClassAdd'">클래스 등록</button>
					</div>
<!-- 					<div class="d-flex input-group mb-3"> -->
<!-- 						<input type="text" class="form-control" placeholder="클래스 제목 검색" aria-label="Recipient's username" aria-describedby="button-addon2"> -->
<!-- 						<button class="btn btn-primary" type="button" id="button-addon2">검색</button> -->
<!-- 					</div> -->
						<form name="${getClassList}">
							<table class="table table-striped">
								<thead>
									<tr>
										<th scope="col">제목</th>
										<th scope="col">대분류</th>
										<th scope="col">소분류</th>
										<th scope="col">공개상태</th>
										<th scope="col"></th>
										<th scope="col"></th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${getClassList}" var="li" varStatus="status">
										<tr id="${li.class_id}">
											<td><input class="form-control" type="text" placeholder="" value="${li.class_title}" disabled="disabled"></td>
											<td>
												<input type="text" class="form-control" id="mainCategory${li.class_id}" name="class_maincate" disabled="disabled">
<%-- 													<c:forEach items="${getMainCate}" var="cate"> --%>
<%-- 														<option value="${cate.CODEID}"  --%>
<%-- 															<c:if test="${fn:contains(cate.DESCRIPTION, li.class_category)}">selected="selected"</c:if>> --%>
<%-- 																${cate.CODENAME} --%>
<!-- 														</option> -->
<%-- 													</c:forEach> --%>
											</td>
											<td>
												<input type="text" class="form-control" id="subCategory${li.class_id}" disabled="disabled">
<!-- 												<select class="form-control" id="floatingSelect2" name="class_category" disabled="disabled"> -->
<!-- 												</select> -->
											</td>
											<td>
												<select class="form-control" id="classStat" disabled="disabled">
													<option value="1" <c:if test="${li.class_status == 1}">selected</c:if>>공개</option>
													<option value="2" <c:if test="${li.class_status == 2}">selected</c:if>>비공개</option>
													<option value="3" <c:if test="${li.class_status == 3}">selected</c:if>>폐강</option>
												</select>
		                                 	</td>
		                                 	<td>
		                                 		<button type="button" class="btn-primary" onclick="modifyClass(${li.class_id})">수정</button>
		                                 	</td>
		                                 	<td>
		                                 		<button type="button" class="btn-primary" onclick="deleteClass(${li.class_id})">삭제</button>
		                                 	</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</form>
					</div>
				</div>
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
	    	if (link.includes("AdmClass")) {
	    		document.querySelector("#classList").parentElement.previousElementSibling.classList.add("show");
	    		document.querySelector("#classList").parentElement.previousElementSibling.classList.add("active");
	    		document.querySelector("#classList").parentElement.classList.add("show");
	    		document.querySelector("#classList").classList.toggle("active");
	    	};
    </script>
</body>
</html>