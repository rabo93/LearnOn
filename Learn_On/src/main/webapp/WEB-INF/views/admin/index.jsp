<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    
    <!-- 포트원 결제api sdk 추가 -->
	<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
	
<meta charset="UTF-8">
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
                                <p class="mb-2">총 회원수</p>
                                <h6 class="mb-0">${nomalMemberCount}명</h6>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6 col-xl-3">
                        <div class="bg-light rounded d-flex align-items-center justify-content-between p-4">
                            <i class="fa fa-chart-bar fa-3x text-primary"></i>
                            <div class="ms-3">
                                <p class="mb-2">총 강사수</p>
                                <h6 class="mb-0">${instrucMemberCount}명</h6>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6 col-xl-3">
                        <div class="bg-light rounded d-flex align-items-center justify-content-between p-4">
                            <i class="fa fa-chart-area fa-3x text-primary"></i>
                            <div class="ms-3">
                                <p class="mb-2">오늘 매출</p>
                                <h6 class="mb-0">
                                	￦ <fmt:formatNumber pattern="#,###">${todayPayTotal}</fmt:formatNumber>원
                                </h6>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6 col-xl-3">
                        <div class="bg-light rounded d-flex align-items-center justify-content-between p-4">
                            <i class="fa fa-chart-pie fa-3x text-primary"></i>
                            <div class="ms-3">
                                <p class="mb-2">주간 매출</p>
                                <h6 class="mb-0">
                                	￦ <fmt:formatNumber pattern="#,###">${weekPayTotal}</fmt:formatNumber>원
                                </h6>
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
                                <h6 class="mb-0">일간 매출 통계</h6>
                            </div>
                            <canvas id="TodaySales"></canvas>
                        </div>
                    </div>
                    <div class="col-sm-12 col-xl-6">
                        <div class="bg-light text-center rounded p-4">
                            <div class="d-flex align-items-center justify-content-between mb-4">
                                <h6 class="mb-0">주간 매출 통계</h6>
                            </div>
                            <canvas id="WeeklySales"></canvas>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Sales Chart End -->

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
            <div>
            	<canvas id="myChart"></canvas>
            </div>
	<%@include file="inc/footer.jsp"%>

	<!-- Back to Top -->
    <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>

    <!-- JavaScript Libraries -->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
<!--     <script src="resources/admin/lib/chart/chart.min.js"></script> -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="resources/admin/lib/easing/easing.min.js"></script>
    <script src="resources/admin/lib/waypoints/waypoints.min.js"></script>
    <script src="resources/admin/lib/owlcarousel/owl.carousel.min.js"></script>
    <script src="resources/admin/lib/tempusdominus/js/moment.min.js"></script>
    <script src="resources/admin/lib/tempusdominus/js/moment-timezone.min.js"></script>
    <script src="resources/admin/lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>

    <!-- Template Javascript -->
    <script src="resources/admin/js/main.js"></script>
    <script src="resources/admin/js/main_chart.js"></script>
    <script>
   		var link = document.location.href;
    	if (link.includes("Adm")) {
    		document.getElementById("adminIndex").classList.toggle("active");
    	};
    	
    	
    	//	===================================================
	    	
    	
    	const ctxToday = document.getElementById('TodaySales');
    	const ctxWeekly = document.getElementById('WeeklySales');
    	
    	const today = new Date();
    	const todayLabels = [];  // 매일 날짜 배열
    	const weekLabels = [];  // 주간 날짜 배열
    	const dataToday = ${payFiveDayTotals};    // 데이터 배열
    	const dataWeekly = ${payFourWeekTotals};    // 데이터 배열
		
    	// 5일치 데이터를 생성 (오늘 날짜부터 시작)
    	for (let i = 0; i < 5; i++) {
			const date = new Date(today);
			date.setDate(today.getDate() - (4 - i)); // 5일 전부터 오늘까지 날짜를 생성
   			todayLabels.push(date.toLocaleDateString());  // 날짜 포맷을 'MM/DD/YYYY'로 변환하여 배열에 추가
   		}
	    	
	   	new Chart(ctxToday, {
	   	    type: 'bar',
	   	    data: {
	   	      labels: todayLabels,
	   	      datasets: [{
	   	        label: 'TodaySales',
	   	        data: dataToday,
	   	        borderWidth: 1
	   	      }]
	   	    },
	   	    options: {
	   	      scales: {
	   	        y: {
	   	          beginAtZero: true
	   	        }
	   	      }
	   	    }
	   	  });
	    
	   	for (let i = 0; i < 4; i++) {
	   		const startOfWeek = new Date(today);
	   	    startOfWeek.setDate(today.getDate() - (today.getDay() + 6) % 7 - ((3 - i) * 7));
	   	 	weekLabels.push(startOfWeek.toLocaleDateString());
	   	}
	   	
	   	new Chart(ctxWeekly, {
	   	    type: 'bar',
	   	    data: {
	   	        labels: weekLabels,  // 주간 시작일을 X축에 표시
	   	        datasets: [{
	   	            label: 'WeeklySales',  // 데이터셋 레이블
	   	            data: dataWeekly,  // 4주간의 매출 데이터를 Y축에 표시
	   	            borderWidth: 1,
	   	        }]
	   	    },
	   	    options: {
	   	        responsive: true,
	   	        scales: {
	   	            y: {
	   	                beginAtZero: true  // Y축은 0부터 시작
	   	            }
	   	        }
	   	    }
	   	});
	   	
    </script>
</body>
</html>