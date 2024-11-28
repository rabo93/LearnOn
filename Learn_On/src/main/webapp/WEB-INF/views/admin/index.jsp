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
	
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@include file="inc/sidebar.jsp"%>
	<%@include file="inc/navbar.jsp"%>
	
	<!-- Sale & Revenue Start -->
            <div class="container-fluid pt-4 px-4">
                <div class="row g-4">
                    <div class="col-sm-6 col-xl-3">
                        <div class="bg-light rounded d-flex align-items-center justify-content-between p-4">
                            <i class="fa fa-chart-line fa-3x text-primary"></i>
                            <div class="ms-3">
                                <p class="mb-2">오늘의 매출</p>
                                <h6 class="mb-0">￦ 1,234,567</h6>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6 col-xl-3">
                        <div class="bg-light rounded d-flex align-items-center justify-content-between p-4">
                            <i class="fa fa-chart-bar fa-3x text-primary"></i>
                            <div class="ms-3">
                                <p class="mb-2">주간 매출</p>
                                <h6 class="mb-0">￦ 12,345,678</h6>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6 col-xl-3">
                        <div class="bg-light rounded d-flex align-items-center justify-content-between p-4">
                            <i class="fa fa-chart-area fa-3x text-primary"></i>
                            <div class="ms-3">
                                <p class="mb-2">오늘의 수익</p>
                                <h6 class="mb-0">￦ 345,678</h6>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6 col-xl-3">
                        <div class="bg-light rounded d-flex align-items-center justify-content-between p-4">
                            <i class="fa fa-chart-pie fa-3x text-primary"></i>
                            <div class="ms-3">
                                <p class="mb-2">주간 수익</p>
                                <h6 class="mb-0">￦ 789,123</h6>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Sale & Revenue End -->


            <!-- Sales Chart Start -->
            <div class="container-fluid pt-4 px-4">
                <div class="row g-4">
                    <div class="col-sm-12 col-xl-6">
                        <div class="bg-light text-center rounded p-4">
                            <div class="d-flex align-items-center justify-content-between mb-4">
                                <h6 class="mb-0">카테고리별 월간 매출 통계</h6>
                                <a href="">자세히 보기</a>
                            </div>
                            <canvas id="worldwide-sales"></canvas>
                        </div>
                    </div>
                    <div class="col-sm-12 col-xl-6">
                        <div class="bg-light text-center rounded p-4">
                            <div class="d-flex align-items-center justify-content-between mb-4">
                                <h6 class="mb-0">월간 매출 통계</h6>
                                <a href="">자세히 보기</a>
                            </div>
                            <canvas id="salse-revenue"></canvas>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Sales Chart End -->


            <!-- Recent Sales Start -->
            <div class="container-fluid pt-4 px-4">
                <div class="bg-light text-center rounded p-4">
                    <div class="d-flex align-items-center justify-content-between mb-4">
                        <h6 class="mb-0">사용자 구매 내역</h6>
                        <a href="AdmPayList">자세히 보기</a>
                    </div>
                    <div class="table-responsive">
<!--                         <table class="table text-start align-middle table-bordered table-hover mb-0"> -->
<!--                             <thead> -->
<!--                                 <tr class="text-dark"> -->
<!--                                     <th scope="col"><input class="form-check-input" type="checkbox"></th> -->
<!--                                     <th scope="col">구매 일시</th> -->
<!--                                     <th scope="col">구매 코드</th> -->
<!--                                     <th scope="col">구매자</th> -->
<!--                                     <th scope="col">금액</th> -->
<!--                                     <th scope="col">상태</th> -->
<!--                                     <th scope="col">비고</th> -->
<!--                                 </tr> -->
<!--                             </thead> -->
<!--                             <tbody> -->
<!--                                 <tr> -->
<!--                                     <td><input class="form-check-input" type="checkbox"></td> -->
<!--                                     <td>2024-11-01</td> -->
<!--                                     <td>INV-0123</td> -->
<!--                                     <td>얋다ㅓㅁ쟈</td> -->
<!--                                     <td>￦ 80,000</td> -->
<!--                                     <td>결제 완료</td> -->
<!--                                     <td><a class="btn btn-sm btn-primary" href="">상세 정보</a></td> -->
<!--                                 </tr> -->
<!--                                 <tr> -->
<!--                                     <td><input class="form-check-input" type="checkbox"></td> -->
<!--                                     <td>2024-11-01</td> -->
<!--                                     <td>INV-0123</td> -->
<!--                                     <td>엻댬턐ㄷ</td> -->
<!--                                     <td>￦ 80,000</td> -->
<!--                                     <td>결제 대기중</td> -->
<!--                                     <td><a class="btn btn-sm btn-primary" href="">상세 정보</a></td> -->
<!--                                 </tr> -->
<!--                                 <tr> -->
<!--                                     <td><input class="form-check-input" type="checkbox"></td> -->
<!--                                     <td>2024-11-01</td> -->
<!--                                     <td>INV-0123</td> -->
<!--                                     <td>볔ㄹ리ㅑㅋ</td> -->
<!--                                     <td>￦ 80,000</td> -->
<!--                                     <td>결제 완료</td> -->
<!--                                     <td><a class="btn btn-sm btn-primary" href="">상세 정보</a></td> -->
<!--                                 </tr> -->
<!--                                 <tr> -->
<!--                                     <td><input class="form-check-input" type="checkbox"></td> -->
<!--                                     <td>2024-11-01</td> -->
<!--                                     <td>INV-0123</td> -->
<!--                                     <td>엸카햧ㅍ</td> -->
<!--                                     <td>￦ 80,000</td> -->
<!--                                     <td>결제 대기중</td> -->
<!--                                     <td><a class="btn btn-sm btn-primary" href="">상세 정보</a></td> -->
<!--                                 </tr> -->
<!--                                 <tr> -->
<!--                                     <td><input class="form-check-input" type="checkbox"></td> -->
<!--                                     <td>2024-11-01</td> -->
<!--                                     <td>INV-0123</td> -->
<!--                                     <td>몡ㅀ캬릍</td> -->
<!--                                     <td>￦ 80,000</td> -->
<!--                                     <td>결제 대기중</td> -->
<!--                                     <td><a class="btn btn-sm btn-primary" href="">상세 정보</a></td> -->
<!--                                 </tr> -->
<!--                             </tbody> -->
<!--                         </table> -->
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
												</tr>
												<tr class="paymentDetailBox" id="paymentDetail${status.index}">
													<td colspan="8">
				                           				<c:forEach var="item" items="${payment.value}">	
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
														</c:forEach>
														<div class="total-item">
															<span class="ttl">총 결제금액</span>
															<span class="price"> <fmt:formatNumber pattern="#,###">${payment.value[0].total_price}</fmt:formatNumber> 원</span>
		                             					</div>
													</td>
				                             	</tr>
											</c:forEach>
										</c:otherwise>
									</c:choose>
								</tbody>
							</table>
                    </div>
                </div>
            </div>
            <!-- Recent Sales End -->


            <!-- Widgets Start -->
            <div class="container-fluid pt-4 px-4">
                <div class="row g-4">
                    <div class="col-sm-12 col-md-6 col-xl-6 col-auto">
                        <div class="h-100 bg-light rounded p-4">
                            <div class="d-flex align-items-center justify-content-between mb-4">
                                <h6 class="mb-0">달력</h6>
                                <a href="">자세히 보기</a>
                            </div>
                            <div id="calender"></div>
                        </div>
                    </div>
                    <div class="col-sm-12 col-md-6 col-auto">
                        <div class="h-100 bg-light rounded p-4">
                            <div class="d-flex align-items-center justify-content-between mb-4">
                                <h6 class="mb-0">해야할 일 메모</h6>
                                <a href="">자세히 보기</a>
                            </div>
                            <div class="d-flex mb-2">
                                <input class="form-control bg-transparent" type="text" placeholder="메모를 입력해주세요">
                                <button type="button" class="btn btn-primary ms-2">추가하기</button>
                            </div>
                            <div class="d-flex align-items-center border-bottom py-2">
                                <input class="form-check-input m-0" type="checkbox">
                                <div class="w-100 ms-3">
                                    <div class="d-flex w-100 align-items-center justify-content-between">
                                        <span>메모 내용 표시</span>
                                        <button class="btn btn-sm"><i class="fa fa-times"></i></button>
                                    </div>
                                </div>
                            </div>
                            <div class="d-flex align-items-center border-bottom py-2">
                                <input class="form-check-input m-0" type="checkbox" checked>
                                <div class="w-100 ms-3">
                                    <div class="d-flex w-100 align-items-center justify-content-between">
                                        <span><del>메모 내용 표시</del></span>
                                        <button class="btn btn-sm text-primary"><i class="fa fa-times"></i></button>
                                    </div>
                                </div>
                            </div>
                            <div class="d-flex align-items-center border-bottom py-2">
                                <input class="form-check-input m-0" type="checkbox" checked>
                                <div class="w-100 ms-3">
                                    <div class="d-flex w-100 align-items-center justify-content-between">
                                        <span><del>메모 내용 표시</del></span>
                                        <button class="btn btn-sm text-primary"><i class="fa fa-times"></i></button>
                                    </div>
                                </div>
                            </div>
                            <div class="d-flex align-items-center border-bottom py-2">
                                <input class="form-check-input m-0" type="checkbox">
                                <div class="w-100 ms-3">
                                    <div class="d-flex w-100 align-items-center justify-content-between">
                                        <span>메모 내용 표시</span>
                                        <button class="btn btn-sm"><i class="fa fa-times"></i></button>
                                    </div>
                                </div>
                            </div>
                            <div class="d-flex align-items-center pt-2">
                                <input class="form-check-input m-0" type="checkbox">
                                <div class="w-100 ms-3">
                                    <div class="d-flex w-100 align-items-center justify-content-between">
                                        <span>메모 내용 표시</span>
                                        <button class="btn btn-sm"><i class="fa fa-times"></i></button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
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
<!--     <script src="resources/admin/js/main_chart.js"></script> -->
    <script type="text/javascript">
    		var link = document.location.href;
	    	if (link.includes("Adm")) {
	    		document.getElementById("adminIndex").classList.toggle("active");
	    	};
    </script>
</body>
</html>