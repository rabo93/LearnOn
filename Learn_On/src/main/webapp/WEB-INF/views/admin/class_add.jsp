<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
    <title>LearnOn - 관리자 페이지</title>
    <script
		src="https://code.jquery.com/jquery-3.7.1.js"
		integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
		crossorigin="anonymous">
    </script>
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
</head>
<body>
	<%@include file="inc/sidebar.jsp"%>
	<%@include file="inc/navbar.jsp"%>
	
	<%-- 내용 시작 --%>
	<!-- Blank Start -->
		<form action="admin_class_add" name="addForm" method="post" enctype="multipart/form-data">
            <div class="container-fluid pt-4 px-4">
                <div class="row vh-100 bg-light rounded align-items-center justify-content-center mx-0">
                	<div class="bg-light rounded p-4">
                		<div class="d-flex justify-content-between mb-3">
							<div class="p-2 bd-highlight">
	                			<h5>클래스 등록</h5>
							</div>
							<div class="p-2 bd-highlight">
		                		<button type="submit" class="btn btn-lg btn-primary">클래스 등록</button>
		                		<button type="button" class="btn btn-lg btn-primary ms-3" onclick="moveBack()">클래스 삭제</button>
							</div>
						</div>
						<div class="d-flex justify-content-between">
							<div class="col-8">
		                		<div class="form-floating mb-3">
		                			<input type="text" class="form-control" id="floatingInput" name="CLASS_TITLE">
		                			<label for="floatingInput">강의 제목</label>
		                		</div>
								<div class="form-floating mb-3">
									<input type="text" class="form-control" id="floatingInput" name="CLASS_INTRO">
									<label for="floatingInput">강의 소개</label>
								</div>
								<div class="form-floating mb-3">
									<input type="text" class="form-control" id="floatingTextarea" style="height: 150px;" name="CLASS_CONTENTS"/>
									<label for="floatingTextarea">강의 상세내용</label>
								</div>
								<div class="d-flex">
									<div class="form-floating flex-fill me-3">
										<select class="form-select" id="floatingSelect" name="class_maincate" onchange="selectMainCate()">
											<c:forEach items="${getMainCate}" var="cate">
												<option value="${cate.CODEID}">${cate.CODEID}</option>
											</c:forEach>
										</select>
										<label for="floatingSelect">대분류</label>
									</div>
									<div class="form-floating flex-fill me-3">
										<select class="form-select" id="floatingSelect2" name="class_subcate">
											
										</select>
										<label for="floatingSelect2">소분류</label>
									</div>
									<div class="form-floating flex-fill">
										<input type="text" class="form-control" id="floatingInput" name="MEM_ID">
										<label for="floatingInput">강사</label>
									</div>
								</div>
							</div>
							<figure class="figure">
								<img src="resources/admin/img/learn_on_logo2.png" id="preview" class="figure-img img-fluid rounded" alt="thumpnail" style="height: 280px;">
								<figcaption class="figure-caption text-center mb-3">썸네일 이미지 미리보기</figcaption>
<!-- 									<input type="file" class="file form-control" id="inputGroupFile02" name="CLASS_PIC1"  -->
									<input type="file" class="file form-control" id="inputGroupFile02"
									accept="image/*" onchange="readURL(this);">
							</figure>
						</div>
						<div class="p-2 bd-highlight d-flex">
                            <h6 class="me-auto p-2">커리큘럼</h6>
	                		<button type="button" class="btn btn-lg btn-primary col-auto" onClick="addRow();">커리큘럼 추가</button>
	                		<button type="button" class="btn btn-lg btn-primary col-auto ms-3" onClick="deleteRow();">커리큘럼 제거</button>
						</div>
						<div class="col-12">
	                        <div class="bg-light rounded h-100 p-4">
	                            <div class="table-responsive" style="overflow: scroll; height: 200px;">
<!-- 	                                <table class="table" id="dynamic_table" cellpadding="0" cellspacing="0" name="CLASS_CURRICULUM"> -->
	                                <table class="table" id="dynamic_table" cellpadding="0" cellspacing="0">
	                                </table>
	                            </div>
	                        </div>
                   		 </div>
                   		 <div class="d-flex">
                   		 	<div class="col-3 me-3">
								<h6>가격</h6>
								<div class="input-group">
									<input type="number" class="form-control" name="CLASS_PRICE">
									<span class="input-group-text">원</span>
								</div>
							</div>
							<div class="col-3 me-3">
								<h6>할인</h6>
								<div class="input-group">
									<input type="number" class="form-control" ">
									<span class="input-group-text">원</span>
								</div>
							</div>
							<div class="col-2 me-3">
								<h6>공개상태</h6>
								<div class="form-floating">
									<select class="form-select mb-3" aria-label="Default select example" name="CLASS_STATUS">
										<option value="1">공개</option>
										<option value="2">비공개</option>
										<option value="3">폐강</option>
									</select>
								</div>
							</div>
						</div>
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
	<script src="https://code.jquery.com/jquery-3.7.1.js"></script>

    <!-- Template Javascript -->
    <script src="resources/admin/js/main.js"></script>
    <script src="resources/admin/js/admClass.js"></script>
    <script type="text/javascript">
   		var link = document.location.href;
    	if (link.includes("class")) {
    		document.getElementById("classAdd").classList.toggle("active");
    		document.getElementById("classManage").classList.toggle("active");
    	};
    </script>
</body>
</html>