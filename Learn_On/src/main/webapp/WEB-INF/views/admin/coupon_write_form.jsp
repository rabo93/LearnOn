<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>런 온 - 관리자 페이지</title>
	<link rel="SHORTCUT ICON" href="${pageContext.request.contextPath}/resources/images/favicon.ico">
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
				<h5 class="me-auto tableSubject">COUPON 등록</h5>
			</div>
			<section class="tb-wrap">
				<form action="AdmCouponWrite" class="d-flex input-group mb-3" method="post" enctype="multipart/form-data">
					<table class="table table-striped">
						<tr>
							<th>쿠폰이름</th>
							<td>
								<input type="text" class="form-control" name="coupon_name">
							</td>
						</tr>
						<tr>
							<th>쿠폰코드</th>
							<td>
								<input type="text" class="form-control" name="coupon_code">
							</td>
						</tr>
						<tr>
							<th>쿠폰할인률</th>
							<td>
								<select class="form-select" name="discount_type" id="discount_type">
									<option value="1">%</option>
									<option value="2">금액</option>
								</select>
								<input type="text" class="form-control" id="discount_input" name="discount_value">
							</td>
						</tr>
						<tr>
							<th>쿠폰 유효기간</th>
							<td>
								<input type="date" class="form-control" id="expiry_date" name="c_expiry_date" min="">
							</td>
						</tr>
					</table>
					<section class="nt-btns">
						<button class="btn btn-lg btn-primary ms-3" type="submit">등록</button>
						<button class="btn btn-lg btn-primary ms-3" type="button" onclick="location.href='AdmPayListCoupon'">취소</button>
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
		$(document).ready(function() {
	        let discountStatus = $('#discount_type').val(); // 초기 선택값 확인
	        let discountInput = $('#discount_input');
	
	        if (discountStatus === '1') {
	            discountInput.attr('name', 'discount_percent'); // 초기 상태가 퍼센트일 때
	        } else if (discountStatus === '2') {
	            discountInput.attr('name', 'discount_amount'); // 초기 상태가 금액일 때
	        }
	        
	     	// 오늘 날짜를 'yyyy-mm-dd' 형식으로 가져오기
	        let today = new Date();
	        let day = String(today.getDate()).padStart(2, '0'); // 날짜 2자리로 포맷
	        let month = String(today.getMonth() + 1).padStart(2, '0'); // 월 2자리로 포맷 (0부터 시작)
	        let year = today.getFullYear(); // 년도

	        // 'yyyy-mm-dd' 형식으로 결합
	        let todayDate = year + '-' + month + '-' + day;

	        // min 속성에 오늘 날짜 설정
	        $('#expiry_date').attr('min', todayDate);
	        
	        
	    });
		
		$('#discount_type').on('change', function() {
	        let discountInput = $('#discount_input');
	        let discountStatus = $(this).val();
			
	        // discount_value의 name 속성 변경
	        if (discountStatus === '1') {
	            discountInput.attr('name', 'discount_percent'); // 퍼센트일 경우
	        } else if (discountStatus === '2') {
	            discountInput.attr('name', 'discount_amount'); // 금액일 경우
	        }
	    });
		
		// 메뉴 활성화
		let link = document.location.href;
    	if (link.includes("AdmCouponWrite")) {
    		document.querySelector("#paymentCoupon").parentElement.previousElementSibling.classList.add("show");
    		document.querySelector("#paymentCoupon").parentElement.previousElementSibling.classList.add("active");
    		document.querySelector("#paymentCoupon").parentElement.classList.add("show");
    		document.querySelector("#paymentCoupon").classList.toggle("active");
    	};
	</script>
</body>
</html>








