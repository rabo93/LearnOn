<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
    <title>LearnOn - 관리자 페이지</title>
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
</head>
<body>
	<%@include file="inc/sidebar.jsp"%>
	<%@include file="inc/navbar.jsp"%>
	
	<%-- 내용 시작 --%>
	<!-- Blank Start -->
			<div class="container-fluid pt-4 px-4">
				<div class="bg-light rounded p-4">
					<div class="d-flex mb-5">
						<h5 class="me-auto tableSubject">쿠폰 관리</h5>
						<button type="button" class="btn btn-lg btn-primary ms-3" onclick="location.href='AdmCouponWrite'">쿠폰 등록</button>
						<button type="button" class="btn btn-lg btn-primary ms-3" onclick="deleteCoupon()">쿠폰 삭제</button>
					</div>
					<form class="d-flex input-group mb-3" method="get">
						<select class="form-select" name= "searchType" aria-label="Default select example">
							<option value="subject" <c:if test="${param.searchType eq 'subject'}">selected</c:if>>쿠폰이름</option>
							<option value="code" <c:if test="${param.searchType eq 'code'}">selected</c:if>>쿠폰코드</option>
						</select>
						<input type="text" class="form-control" name="searchKeyword" placeholder="쿠폰 제목 검색" aria-label="Recipient's username" aria-describedby="button-addon2">
						<button class="btn btn-primary" type="submit" id="button-addon2">검색</button>
					</form>
						<table class="table table-striped">
							<colgroup>
								<col width="5%">
								<col width="5%">
								<col width="30%">
								<col width="20%">
								<col width="10%">
								<col width="10%">
								<col width="10%">
								<col width="10%">
							</colgroup>
							<thead>
								<tr>
									<th scope="col">#</th>
									<th scope="col">쿠폰 번호</th>
									<th scope="col">쿠폰 이름</th>
									<th scope="col">쿠폰 코드</th>
									<th scope="col">쿠폰 할인률</th>
									<th scope="col">쿠폰 유효기간</th>
									<th scope="col">쿠폰 상태</th>
									<th scope="col">수정</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${couponList}" var="couponBoard" varStatus="status">
									<tr>
										<th><input class="form-check-input" type="checkbox" id="gridCheck1" name="coupon_id" value="${couponBoard.coupon_id}"></th>
										<td><input class="form-control" type="text" aria-label="default input example" value="${couponBoard.coupon_id}"></td>
										<td><input class="form-control" type="text" aria-label="default input example" value="${couponBoard.coupon_name}"></td>
										<td><input class="form-control" type="text" aria-label="default input example" value="${couponBoard.coupon_code}"></td>
										<td><input class="form-control" type="text" aria-label="default input example"
											<c:choose>
												<c:when test="${couponBoard.discount_status eq 1}">value="-${couponBoard.discount_percent}%"</c:when>
												<c:when test="${couponBoard.discount_status eq 2}">value="-${couponBoard.discount_amount}원"</c:when>
											</c:choose>></td>
										<td><input class="form-control" type="text" aria-label="default input example" value="${couponBoard.c_expiry_date}"></td>
										<td><input class="form-control" type="text" aria-label="default input example"
											<c:choose>
												<c:when test="${couponBoard.coupon_status eq 1}">value="사용가능"</c:when>
												<c:when test="${couponBoard.coupon_status eq 2}">value="사용불가"</c:when>
											</c:choose>></td>
										<td><button type="button" class="btn btn-lg btn-primary ms-3" onclick="couponModify(${couponBoard.coupon_id},)">수정하기</button></td>
                             		</tr>
                               	</c:forEach>
							</tbody>
						</table>
						<section id="pagingArea">
							<button
							onclick="location.href='AdmPayListCoupon?pageNum=${pageInfo.startPage - pageInfo.pageListLimit}&searchType=${searchType}&searchKeyword=${searchKeyword}'"
							<c:if test="${pageInfo.startPage eq 1}">disabled</c:if>>
								<i class="fa-solid fa-angles-left"></i>
							</button>
							<button
							onclick="location.href='AdmPayListCoupon?pageNum=${pageNum - 1}&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}'"
							<c:if test="${pageNum eq 1}">disabled</c:if>>
								<i class="fa-solid fa-angle-left"></i>
							</button>
							<c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
								<c:choose>
									<c:when test="${i eq pageNum}">
										<strong>${i}</strong>
									</c:when>
									<c:otherwise>
										<a href="AdmPayListCoupon?pageNum=${i}&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}">${i}</a>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							<button
							onclick="location.href='AdmPayListCoupon?pageNum=${pageNum + 1}&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}'"
							<c:if test="${pageNum eq pageInfo.maxPage}">disabled</c:if>>
								<i class="fa-solid fa-angle-right"></i>
							</button>
						   	<button
						   	onclick="location.href='AdmPayListCoupon?pageNum=${pageInfo.startPage + pageInfo.pageListLimit}&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}'"
							<c:if test="${pageInfo.endPage eq pageInfo.maxPage}">disabled</c:if>>
						   		<i class="fa-solid fa-angles-right"></i>
						   	</button>
					   	</section>
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
    <script type="text/javascript">
    	if (performance.navigation.type === 1) {
			location.href= "AdmPayListCoupon";
		}
    	
    	function deleteCoupon() {
	    	const checkedValues = $('input[name="coupon_id"]:checked').map(function() {
	    		return $(this).val();
	    	}).get();
	    	
	    	if (checkedValues.length <= 0) {
	    		alert("삭제할 게시물을 선택하세요");
	    		return;
    		}
    		console.log("checkedValues : " + checkedValues);
    		location.href = "AdmCouponDelete?coupon_ids=" + checkedValues;
    	}
    	
    	function couponModify(coupon_id) {
    		location.href = "AdmCouponModify?coupon_id=" + coupon_id;
    	}
    	
    	// 메뉴 활성화
		let link = document.location.href;
    	if (link.includes("AdmPayListCoupon")) {
    		document.querySelector("#paymentCoupon").parentElement.previousElementSibling.classList.add("show");
    		document.querySelector("#paymentCoupon").parentElement.previousElementSibling.classList.add("active");
    		document.querySelector("#paymentCoupon").parentElement.classList.add("show");
    		document.querySelector("#paymentCoupon").classList.toggle("active");
    	};
    </script>
</body>
</html>