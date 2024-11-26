<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    
    <!-- 포트원 결제api sdk 추가 -->
	<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
	
</head>
<body>
	<%@include file="inc/sidebar.jsp"%>
	<%@include file="inc/navbar.jsp"%>
	
	<%-- 내용 시작 --%>
	<!-- Blank Start -->
			<div class="container-fluid pt-4 px-4">
				<div class="bg-light rounded p-4">
					<div class="d-flex mb-5">
						<h5 class="me-auto tableSubject">결제 내역 관리</h5>
					</div>
					<table class="table table-striped">
						<colgroup>
							<col width="15%">
							<col width="15%">
							<col width="13%">
							<col width="12%">
							<col width="10%">
							<col width="10%">
							<col width="12%">
							<col width="13%">
						</colgroup>
						<thead>
							<tr>
								<th scope="col">결제번호</th>
								<th scope="col">결제일시</th>
								<th scope="col">회원ID</th>
								<th scope="col">결제수단</th>
								<th scope="col">상태</th>
								<th scope="col">결제금액</th>
								<th scope="col">환불처리</th>
								<th scope="col">상세정보</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${empty paymentList}">
									<tr><td colspan="8" class="empty">결제내역이 존재하지 않습니다.</td></tr>
								</c:when>
								<c:otherwise>
									<c:forEach var="payment" items="${paymentList}" varStatus="status">
										<tr>
											<td>${payment.key}</td>
											<td><fmt:formatDate value="${payment.value[0].pay_date}" pattern="yy-MM-dd HH:mm:ss" /></td>
											<td>${payment.value[0].mem_id}</td>
											<td>
												<c:choose>
													<c:when test="${payment.value[0].pay_method.equals('vbank')}">
														${payment.value[0].bank_name} (무통장)
													</c:when>
													<c:when test="${payment.value[0].pay_method.equals('card')}">
														${payment.value[0].card_name}
													</c:when>
												</c:choose>
											</td>
											<td>
												<c:if test="${payment.value[0].pay_status == 1}">
													<span class="payment-status st01">결제완료</span>
												</c:if>
												<c:if test="${payment.value[0].pay_status == 2}">
													<span class="payment-status st02">결제취소</span>
												</c:if>
												<c:if test="${payment.value[0].pay_status == 3}">
													<span class="payment-status st03">입금대기</span>
												</c:if>
											</td>
											<td><fmt:formatNumber pattern="#,###">${payment.value[0].total_price}</fmt:formatNumber> 원</td>
											<td><button type="button" class="btn btn-lg btn-primary" onclick="cancelPay('${payment.value[0].imp_uid}', '${payment.value[0].total_price}')"  formmethod="post">결제취소</button></td>
											<td><button type="button" class="btn btn-lg btn-primary" onclick="showDetail(${status.index})">상세정보</button></td>
										</tr>
                           				<c:forEach var="item" items="${payment.value}">	
											<tr class="paymentDetailBox" id="paymentDetail${status.index}">
												<td colspan="8">
	                             					<div class="payment-item">
														<span class="ttl">${item.class_title}</span>
														<span class="price"><fmt:formatNumber pattern="#,###">${item.class_price}</fmt:formatNumber> 원</span>
	                             					</div>
	                             					<c:if test="${item.discount_type == 1}">
														<div class="discount-item">
															<span class="ttl">쿠폰 할인 사용</span>
															<span class="price">- ${item.discount_percent} % </span>
														 </div>
													</c:if>
													<c:if test="${item.discount_type == 2}">
														<div class="discount-item"> 
															<span class="ttl">쿠폰 할인 사용</span>
															<span class="price"> - <fmt:formatNumber pattern="#,###">${item.discount_amount}</fmt:formatNumber> 원  </span>
														</div>
													</c:if>
													<div class="total-item">
														<span class="ttl">총 결제금액</span>
														<span class="price"> <fmt:formatNumber pattern="#,###">${payment.value[0].total_price}</fmt:formatNumber> 원</span>
	                             					</div>
												</td>
			                             	</tr>
										</c:forEach>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
						
					<section id="pagingArea">
						<button
						onclick="location.href='AdmPayList?pageNum=${pageInfo.startPage - pageInfo.pageListLimit}'"
						<c:if test="${pageInfo.startPage eq 1}">disabled</c:if>>
							<i class="fas fa-angle-double-left"></i>
						</button>
						<button
						onclick="location.href='AdmPayList?pageNum=${pageNum - 1}'"
						<c:if test="${pageNum eq 1}">disabled</c:if>>
							<i class="fas fa-chevron-left"></i>
						</button>
						<c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
							<c:choose>
								<c:when test="${i eq pageNum}">
									<strong>${i}</strong>
								</c:when>
								<c:otherwise>
									<a href="AdmPayList?pageNum=${i}">${i}</a>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<button
						onclick="location.href='AdmPayList?pageNum=${pageNum + 1}'"
						<c:if test="${pageNum eq pageInfo.maxPage}">disabled</c:if>>
							<i class="fas fa-angle-right"></i>
						</button>
					   	<button
					   	onclick="location.href='AdmPayListpageNum=${pageInfo.startPage + pageInfo.pageListLimit}'"
						<c:if test="${pageInfo.endPage eq pageInfo.maxPage}">disabled</c:if>>
					   		<i class="fas fa-angle-double-right"></i>
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
	 	// 결제 취소 
		function cancelPay(imp_uid, paid_amount) {
			$.ajax({
				type: "Post",
				url: "/payments/cancel",
				dataType: "json",
				contentType: "application/json; charset=utf-8",
				data: JSON.stringify({
					"imp_uid": imp_uid,
					"reason": "결제 검증 실패",
					"checksum": paid_amount
				})
			}).done(function() {
				alert("결제를 취소하였습니다.");
			}).fail(function(error) {
				alert(JSON.stringify(error));
			});
		}
		
		function showDetail(idx){
			let paymentDetailBox = document.querySelectorAll(".paymentDetailBox");
			
			paymentDetailBox.forEach((elem) => {
				elem.style.display = "none";
			});
			
			paymentDetailBox[idx].style.display = "table-row";
		}
		
		// 메뉴 활성화
		let link = document.location.href;
		if (link.includes("AdmPayList")) {
			document.querySelector("#AdmPayList").parentElement.previousElementSibling.classList.add("show");
			document.querySelector("#AdmPayList").parentElement.previousElementSibling.classList.add("active");
			document.querySelector("#AdmPayList").parentElement.classList.add("show");
			document.querySelector("#AdmPayList").classList.toggle("active");
		};
    </script>
</body>
</html>