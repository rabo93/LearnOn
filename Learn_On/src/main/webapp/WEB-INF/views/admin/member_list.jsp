<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
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
						<h5 class="me-auto tableSubject">회원 목록</h5>
						<button type="button" class="btn btn-lg btn-primary ms-3" onclick="deleteMember()">회원 삭제</button>
					</div>
					<div class="member-sch">
						<form class="d-flex input-group mb-3 w-25" method="get">
							<select class="form-select" name= "sort" onchange="this.form.submit()" aria-label="Default select example">
								<option value="reg_latest" <c:if test="${param.sort eq 'reg_latest'}">selected</c:if>>최신가입순</option>
								<option value="reg_oldest" <c:if test="${param.sort eq 'reg_oldest'}">selected</c:if>>오래된가입순</option>
							</select>
						</form>
						<form class="d-flex input-group mb-3" method="get">
							<select class="form-select" name= "searchType" aria-label="Default select example">
								<option value="id" <c:if test="${param.searchType eq 'id'}">selected</c:if>>아이디</option>
								<option value="name" <c:if test="${param.searchType eq 'name'}">selected</c:if>>이름</option>
							</select>
							<input type="text" class="form-control w-50" name="searchKeyword" aria-label="Recipient's username" aria-describedby="button-addon2">
							<button class="btn btn-primary" type="submit" id="button-addon2">검색</button>
						</form>
					</div>
					<div>
						<table class="table table-striped">
							<thead>
								<tr>
									<th scope="col">#</th>
									<th scope="col">회원 번호</th>
									<th scope="col">아이디</th>
									<th scope="col">이름</th>
									<th scope="col">닉네임</th>
									<th scope="col">생년월일</th>
									<th scope="col">성별</th>
									<th scope="col">가입일</th>
									<th scope="col">이메일</th>
									<th scope="col">연락처</th>
									<th scope="col">권한</th>
									<th scope="col">상태</th>
									<th scope="col">수정</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${getMemberList}" var="ml" varStatus="mem">
									<tr>
										<th><input class="form-check-input" type="checkbox" id="gridCheck_${mem.index}" name="mem_id" value="${ml.mem_id}"></th>
										<td class="col-1"><input id="idx_${mem.index}" class="form-control member" type="text" placeholder="회원 번호" aria-label="default input example" value="${ml.idx}" readonly></td>
										<td class="col-1"><input id="memId_${mem.index}" class="form-control member" type="text" placeholder="아이디" aria-label="default input example" value="${ml.mem_id}" readonly></td>
										<td class="col-1"><input id="memName_${mem.index}" class="form-control member" type="text" placeholder="이름" aria-label="default input example" value="${ml.mem_name}" readonly></td>
										<td class="col-1"><input id="memNick_${mem.index}" class="form-control member" type="text" placeholder="닉네임" aria-label="default input example" value="${ml.mem_nick}" readonly></td>
										<td class="col-1"><input id="memBirth_${mem.index}" class="form-control member" type="text" placeholder="생년월일" aria-label="default input example" value="${ml.mem_birthday}" readonly></td>
										<td class="col-1">
											<select id="memGender_${mem.index}" class="form-select gender" aria-label="Default select example">
												<option value="1" <c:if test="${ml.mem_gender eq 'M'}">selected</c:if>>남자</option>
												<option value="2" <c:if test="${ml.mem_gender eq 'F'}">selected</c:if>>여자</option>
											</select>
										</td>
										<td><input id="memRegDate_${mem.index}" class="form-control member" type="text" placeholder="가입일" aria-label="default input example" value="${ml.mem_reg_date}" readonly></td>
										<td>
											<div class="input-group">
												<input id="memEmail_${mem.index}" type="text" class="form-control member" placeholder="Username" aria-label="Username" value="${ml.mem_email}" readonly>
	                 		  				</div>
	                          		 	</td>
										<td><input id="memPhone_${mem.index}" class="form-control member" type="text" placeholder="연락처" aria-label="default input example" value="${ml.mem_phone}" readonly></td>
										<td class="col-1">
											<select id="memGrade_${mem.index}" class="form-select gradeChange" aria-label="Default select example">
												<option value="MEM01" <c:if test="${ml.mem_grade eq 'MEM01'}">selected</c:if>>일반회원</option>
												<option value="MEM02" <c:if test="${ml.mem_grade eq 'MEM02'}">selected</c:if>>강사회원</option>
												<option value="MEM03" <c:if test="${ml.mem_grade eq 'MEM03'}">selected</c:if>>관리자</option>
											</select>
										</td>
										<td class="col-1">
											<select id="status_${mem.index}" class="form-select status" aria-label="Default select example">
												<option value="1" <c:if test="${ml.mem_status == 1}">selected</c:if>>승인</option>
												<option value="2" <c:if test="${ml.mem_status == 2}">selected</c:if> hidden>대기</option>
												<option value="3" <c:if test="${ml.mem_status == 3}">selected</c:if>>탈퇴</option>
											</select>
										</td>
										<td><button type="button" class="btn btn-lg btn-primary ms-3" onclick="memberModify('${ml.mem_id}')">수정하기</button></td>
	                             	</tr>
								</c:forEach>
							</tbody>
						</table>
						<section id="pagingArea">
							<button
							onclick="location.href='AdmMemList?pageNum=${pageInfo.startPage - pageInfo.pageListLimit}&sort=${sort}&searchType=${searchType}&searchKeyword=${searchKeyword}'"
							<c:if test="${pageInfo.startPage eq 1}">disabled</c:if>>
								<i class="fa-solid fa-angles-left"></i>
							</button>
							<button
							onclick="location.href='AdmMemList?pageNum=${pageNum - 1}&sort=${sort}&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}'"
							<c:if test="${pageNum eq 1}">disabled</c:if>>
								<i class="fa-solid fa-angle-left"></i>
							</button>
							<c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
								<c:choose>
									<c:when test="${i eq pageNum}">
										<strong>${i}</strong>
									</c:when>
									<c:otherwise>
										<a href="AdmMemList?pageNum=${i}&sort=${sort}&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}">${i}</a>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							<button
							onclick="location.href='AdmMemList?pageNum=${pageNum + 1}&sort=${sort}&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}'"
							<c:if test="${pageNum eq pageInfo.maxPage}">disabled</c:if>>
								<i class="fa-solid fa-angle-right"></i>
							</button>
						   	<button
						   	onclick="location.href='AdmMemList?pageNum=${pageInfo.startPage + pageInfo.pageListLimit}&sort=${sort}&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}'"
							<c:if test="${pageInfo.endPage eq pageInfo.maxPage}">disabled</c:if>>
						   		<i class="fa-solid fa-angles-right"></i>
						   	</button>
					   	</section>
					</div>
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
    <script src="resources/admin/js/member_list.js"></script>
    
    <!-- Template Javascript -->
    <script src="resources/admin/js/main.js"></script>
    <script type="text/javascript">
	    if (performance.navigation.type === 1) {
			location.href= "AdmMemList";
		}
   		
	 	// 메뉴 활성화
		let link = document.location.href;
    	if (link.includes("AdmMemList")) {
    		document.querySelector("#memberList").parentElement.previousElementSibling.classList.add("show");
    		document.querySelector("#memberList").parentElement.previousElementSibling.classList.add("active");
    		document.querySelector("#memberList").parentElement.classList.add("show");
    		document.querySelector("#memberList").classList.toggle("active");
    	};
    </script>
</body>
</html>