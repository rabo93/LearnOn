<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <title>런 온 - 관리자 페이지</title>
	<link rel="SHORTCUT ICON" href="${pageContext.request.contextPath}/resources/images/favicon.ico">
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
	
            <!-- Widgets Start -->
            <div class="container-fluid pt-4 px-4">
                <div class="row g-4">
<!--                     <div class="col-sm-12 col-md-6 col-xl-6 col-auto"> -->
<!--                         <div class="h-100 bg-light rounded p-4"> -->
<!--                             <div class="d-flex align-items-center justify-content-between mb-4"> -->
<!--                                 <h6 class="mb-0">달력</h6> -->
<!-- <!--                                 <a href="">자세히 보기</a> -->
<!--                             </div> -->
<!--                             <div id="calender"></div> -->
<!--                         </div> -->
<!--                     </div> -->
                    <div class="col-sm-12">
                        <div class="bg-light rounded h-100 p-4">
                            <h6 class="mb-4">등록한 클래스</h6>
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th scope="col">클래스ID</th>
                                        <th scope="col">클래스명</th>
                                        <th scope="col">카테고리</th>
                                        <th scope="col">상태</th>
                                    </tr>
                                </thead>
                                <tbody>
                                	<c:forEach items="${getClass}" var="cla">
	                                    <tr>
	                                        <td>
	                                        	<input type="text" value="${cla.CLASS_ID}" class="form-control" name="class_id" disabled="disabled">
	                                        </td>
	                                        <td>
	                                        	<input type="text" value="${cla.CLASS_TITLE}" class="form-control" name="class_title" disabled="disabled">
	                                        </td>
	                                        <td>
	                                        	<input type="text" value="${cla.CLASS_CATEGORY}" class="form-control" name="class_category" disabled="disabled">
	                                        </td>
	                                        <td>
	                                        	<input type="text" value="${cla.CLASS_STATUS}" class="form-control" name="class_status" disabled="disabled">
	                                        </td>
	                                    </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
<!--                     <div class="col-sm-12 col-md-6 col-auto"> -->
<!--                         <div class="h-100 bg-light rounded p-4"> -->
<!--                             <div class="d-flex align-items-center justify-content-between mb-4"> -->
<!--                                 <h6 class="mb-0">해야할 일 메모</h6> -->
<!--                                 <a href="">자세히 보기</a> -->
<!--                             </div> -->
<!--                             <div class="d-flex mb-2"> -->
<!--                                 <input class="form-control bg-transparent" type="text" placeholder="메모를 입력해주세요"> -->
<!--                                 <button type="button" class="btn btn-primary ms-2">추가하기</button> -->
<!--                             </div> -->
<!--                             <div class="d-flex align-items-center border-bottom py-2"> -->
<!--                                 <input class="form-check-input m-0" type="checkbox"> -->
<!--                                 <div class="w-100 ms-3"> -->
<!--                                     <div class="d-flex w-100 align-items-center justify-content-between"> -->
<!--                                         <span>메모 내용 표시</span> -->
<!--                                         <button class="btn btn-sm"><i class="fa fa-times"></i></button> -->
<!--                                     </div> -->
<!--                                 </div> -->
<!--                             </div> -->
<!--                             <div class="d-flex align-items-center border-bottom py-2"> -->
<!--                                 <input class="form-check-input m-0" type="checkbox" checked> -->
<!--                                 <div class="w-100 ms-3"> -->
<!--                                     <div class="d-flex w-100 align-items-center justify-content-between"> -->
<!--                                         <span><del>메모 내용 표시</del></span> -->
<!--                                         <button class="btn btn-sm text-primary"><i class="fa fa-times"></i></button> -->
<!--                                     </div> -->
<!--                                 </div> -->
<!--                             </div> -->
<!--                             <div class="d-flex align-items-center border-bottom py-2"> -->
<!--                                 <input class="form-check-input m-0" type="checkbox" checked> -->
<!--                                 <div class="w-100 ms-3"> -->
<!--                                     <div class="d-flex w-100 align-items-center justify-content-between"> -->
<!--                                         <span><del>메모 내용 표시</del></span> -->
<!--                                         <button class="btn btn-sm text-primary"><i class="fa fa-times"></i></button> -->
<!--                                     </div> -->
<!--                                 </div> -->
<!--                             </div> -->
<!--                             <div class="d-flex align-items-center border-bottom py-2"> -->
<!--                                 <input class="form-check-input m-0" type="checkbox"> -->
<!--                                 <div class="w-100 ms-3"> -->
<!--                                     <div class="d-flex w-100 align-items-center justify-content-between"> -->
<!--                                         <span>메모 내용 표시</span> -->
<!--                                         <button class="btn btn-sm"><i class="fa fa-times"></i></button> -->
<!--                                     </div> -->
<!--                                 </div> -->
<!--                             </div> -->
<!--                             <div class="d-flex align-items-center pt-2"> -->
<!--                                 <input class="form-check-input m-0" type="checkbox"> -->
<!--                                 <div class="w-100 ms-3"> -->
<!--                                     <div class="d-flex w-100 align-items-center justify-content-between"> -->
<!--                                         <span>메모 내용 표시</span> -->
<!--                                         <button class="btn btn-sm"><i class="fa fa-times"></i></button> -->
<!--                                     </div> -->
<!--                                 </div> -->
<!--                             </div> -->
<!--                         </div> -->
<!--                     </div> -->
                </div>
            </div>
            <!-- Widgets End -->
            
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
    <script src="resources/admin/js/main_chart.js"></script>
    <script type="text/javascript">
    		var link = document.location.href;
	    	if (link.includes("Adm")) {
	    		document.getElementById("adminIndex").classList.toggle("active");
	    	};
    </script>
</body>
</html>