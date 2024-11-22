<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
    <title>LearnOn - 공지사항</title>
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
    <!-- JQuery -->
    <script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
</head>
<body>
	<%@include file="inc/sidebar.jsp"%>
	<%@include file="inc/navbar.jsp"%>
	
	<%-- 내용 시작 --%>
	<!-- Blank Start -->
			<div class="container-fluid pt-4 px-4">
				<div class="bg-light rounded p-4">
					<div class="d-flex mb-5">
						<h5 class="me-auto tableSubject">공지사항 관리</h5>
						<button type="button" class="btn btn-lg btn-primary ms-3" onclick="location.href='AdminNoticeWrite'">게시판 등록</button>
						<button type="button" class="btn btn-lg btn-primary ms-3" onclick="deleteBoard()">게시판 삭제</button>
					</div>
					<div class="notice-sch">
						<form class="d-flex input-group mb-3 w-25"  method="get">
							<select class="form-select" name= "sort" onchange="this.form.submit()" aria-label="Default select example">
								<option value="latest"
									<c:if test="${sort eq 'latest'}">selected</c:if>
									>
									최신순
									</option>
									<option value="oldest"
									<c:if test="${sort eq 'oldest'}">selected</c:if>
									>
									오래된순
									</option>
							</select>
						</form>
						<form class="d-flex input-group mb-3 w-75" method="get">
							<select class="form-select" name= "searchType" aria-label="Default select example">
								<option value="subject" <c:if test="${param.searchType eq 'subject'}">selected</c:if>>제목</option>
								<option value="content" <c:if test="${param.searchType eq 'content'}">selected</c:if>>내용</option>
								<option value="subject_content" <c:if test="${param.searchType eq 'subject_content'}">selected</c:if>>제목&내용</option>
							</select>
							<input type="text" class="form-control" name="searchKeyword" placeholder="게시판 검색" aria-label="Recipient's username" aria-describedby="button-addon2">
							<button class="btn btn-primary" type="submit" id="button-addon2">검색</button>
						</form>
					</div>
						<table class="table table-striped">
							<colgroup>
								<col width="5%">
								<col width="10%">
								<col width="60%">
								<col width="15%">
								<col width="10%">
							</colgroup>
							<thead>
								<tr>
									<th scope="col">#</th>
									<th scope="col">게시판 번호</th>
									<th scope="col">제목</th>
									<th scope="col">게시판 유형</th>
									<th scope="col">공개상태</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${noticeList}" var="noticeBoard" varStatus="status">
									<tr onclick="showNotice(${status.index})">
										<th><input class="form-check-input" type="checkbox" id="gridCheck1" name="notice_idx" value="${noticeBoard.notice_idx}"></th>
										<td><input class="form-control" type="text" aria-label="default input example" value="${noticeBoard.notice_idx}"></td>
										<td>
											<input class="form-control" type="text" aria-label="default input example" value="${noticeBoard.notice_subject}">
										</td>
										<td><input class="form-control" type="text" aria-label="default input example" value="공지사항" readonly></td>
										<td>
											<select class="form-select" aria-label="Default select example">
												<option value="1">공개</option>
												<option value="2">비공개</option>
											</select>
	                                 	</td>
                             		</tr>
                             		<tr class="AdmNoticeDetail">
	                                 	<td colspan="4">
		                             		<div>
												<textarea class="form-control" aria-label="default input example" rows="10" readonly>${noticeBoard.notice_content}</textarea>
											</div>
	                                 	</td>
	                                 	<td><button class="btn btn-primary" onclick="noticeModify(${noticeBoard.notice_idx})">수정하기</button></td>
                             		</tr>
                               	</c:forEach>
							</tbody>
						</table>
						<section id="pagingArea">
							<button
							onclick="location.href='AdmNotice?pageNum=${pageInfo.startPage - pageInfo.pageListLimit}&sort=${sort}&searchType=${searchType}&searchKeyword=${searchKeyword}'"
							<c:if test="${pageInfo.startPage eq 1}">disabled</c:if>>
								<i class="fa-solid fa-angles-left"></i>
							</button>
							<button
							onclick="location.href='AdmNotice?pageNum=${pageNum - 1}&sort=${sort}&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}'"
							<c:if test="${pageNum eq 1}">disabled</c:if>>
								<i class="fa-solid fa-angle-left"></i>
							</button>
							<c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
								<c:choose>
									<c:when test="${i eq pageNum}">
										<strong>${i}</strong>
									</c:when>
									<c:otherwise>
										<a href="AdmNotice?pageNum=${i}&sort=${sort}&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}">${i}</a>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							<button
							onclick="location.href='AdmNotice?pageNum=${pageNum + 1}&sort=${sort}&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}'"
							<c:if test="${pageNum eq pageInfo.maxPage}">disabled</c:if>>
								<i class="fa-solid fa-angle-right"></i>
							</button>
						   	<button
						   	onclick="location.href='AdmNotice?pageNum=${pageInfo.startPage + pageInfo.pageListLimit}&sort=${sort}&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}'"
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
			location.href= "AdmNotice";
		}
	    
	    function showNotice(index) {
	        const detailRows = document.querySelectorAll('.AdmNoticeDetail');
	        detailRows.forEach(function(row) {
	            row.style.display = 'none';
	        });

	        const selectedSubject = document.querySelectorAll('.AdmNoticeDetail')[index];
	        if (selectedSubject) {
	            selectedSubject.style.display = 'table-row';
	        }
        }
	    
	    function noticeModify(notice_idx) {
	    	console.log("notice_idx : " + notice_idx);
			location.href = "AdminNoticeModify?notice_idx=" + notice_idx;
		}
	    
	    
	    function deleteBoard() {
	    	const checkedValues = $('input[name="notice_idx"]:checked').map(function() {
	    		return $(this).val();
	    	}).get();
	    	
	    	if (checkedValues.length <= 0) {
	    		alert("삭제할 게시물을 선택하세요");
	    		return;
	    	}
	    	
	    	console.log("checkedValues : " + checkedValues);
	    	location.href = "AdminNoticeDelete?notice_idxs=" + checkedValues;
	    	
	    }
	    
	    // 메뉴 active
	    let link = document.location.href;
    	if (link.includes("AdmNotice")) {
    		document.querySelector("#AdmNotice").parentElement.previousElementSibling.classList.add("show");
    		document.querySelector("#AdmNotice").parentElement.previousElementSibling.classList.add("active");
    		document.querySelector("#AdmNotice").parentElement.classList.add("show");
    		document.querySelector("#AdmNotice").classList.toggle("active");
    	};
	   	
    </script>
</body>
</html>