<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
    <title>LearnOn - FAQ</title>
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
						<h5 class="me-auto tableSubject">FAQ 관리</h5>
						<button type="button" class="btn btn-lg btn-primary ms-3" onclick="location.href='AdminFaqWrite'">게시판 등록</button>
						<button type="button" class="btn btn-lg btn-primary ms-3" onclick="deleteBoard()">게시판 삭제</button>
					</div>
					<div>
						<form class="d-flex input-group mb-3" method="get">
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
								<col width="75%">
								<col width="20%">
							</colgroup>
							<thead>
								<tr>
									<th scope="col">#</th> 
 									<th scope="col">FAQ 번호</th>
 									<th scope="col">FAQ 제목</th>
 									<th scope="col">FAQ 카테고리</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${faqList}" var="faqBoard" varStatus="status">
									<tr onclick="showFaq(${status.index})">
										<th><input class="form-check-input" type="checkbox" id="gridCheck1" name="faq_idx" value="${faqBoard.faq_idx}" readonly></th>
										<td><input class="form-control faq" type="text" aria-label="default input example" value="${faqBoard.faq_idx}" readonly></td>
										<td>
											<input class="form-control faq" type="text" aria-label="default input example" value="${faqBoard.faq_subject}" readonly>
										</td>
										<td><input class="form-control faq" type="text" aria-label="default input example"
											<c:choose>
												<c:when test="${faqBoard.faq_cate eq 1}">value="강의수강"</c:when>
												<c:when test="${faqBoard.faq_cate eq 2}">value="계정관리"</c:when>
												<c:when test="${faqBoard.faq_cate eq 3}">value="결제/환불"</c:when>
												<c:when test="${faqBoard.faq_cate eq 4}">value="증빙서류"</c:when>
											</c:choose> readonly></td>
                             		</tr>
                             		<tr class="AdmfaqDetail">
	                                 	<td colspan="3">
		                             		<div>
												<textarea class="form-control faq" aria-label="default input example" rows="10" readonly>${faqBoard.faq_content}</textarea>
											</div>
	                                 	</td>
	                                 	<td><button class="btn btn-primary" onclick="faqModify(${faqBoard.faq_idx})">수정하기</button></td>
                             		</tr>
                               	</c:forEach>
							</tbody>
						</table>
						<section id="pagingArea">
							<button
							onclick="location.href='AdmFaq?pageNum=${pageInfo.startPage - pageInfo.pageListLimit}&searchType=${searchType}&searchKeyword=${searchKeyword}'"
							<c:if test="${pageInfo.startPage eq 1}">disabled</c:if>>
								<i class="fa-solid fa-angles-left"></i>
							</button>
							<button
							onclick="location.href='AdmFaq?pageNum=${pageNum - 1}&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}'"
							<c:if test="${pageNum eq 1}">disabled</c:if>>
								<i class="fa-solid fa-angle-left"></i>
							</button>
							<c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
								<c:choose>
									<c:when test="${i eq pageNum}">
										<strong>${i}</strong>
									</c:when>
									<c:otherwise>
										<a href="AdmFaq?pageNum=${i}&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}">${i}</a>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							<button
							onclick="location.href='AdmFaq?pageNum=${pageNum + 1}&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}'"
							<c:if test="${pageNum eq pageInfo.maxPage}">disabled</c:if>>
								<i class="fa-solid fa-angle-right"></i>
							</button>
						   	<button
						   	onclick="location.href='AdmFaq?pageNum=${pageInfo.startPage + pageInfo.pageListLimit}&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}'"
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
    <script src="resources/admin/js/faq_list.js"></script>

    <!-- Template Javascript -->
    <script src="resources/admin/js/main.js"></script>
    <script type="text/javascript">
// 	    if (performance.navigation.type === 1) {
// 			location.href= "AdmFaq";
// 		}
    
//     	function showFaq(index) {
// 	        const detailRows = document.querySelectorAll('.AdmfaqDetail');
// 	        detailRows.forEach(function(row) {
// 	            row.style.display = 'none';
// 	        });
	
// 	        const selectedSubject = document.querySelectorAll('.AdmfaqDetail')[index];
// 	        if (selectedSubject) {
// 	            selectedSubject.style.display = 'table-row';
// 	        }
// 	    }
    	
//     	function faqModify(faq_idx) {
//     		console.log("faq_idx : " + faq_idx);
//     		location.href = "AdminFaqModify?faq_idx=" + faq_idx;
//     	}
    	
//     	function deleteBoard() {
// 	    	const checkedValues = $('input[name="faq_idx"]:checked').map(function() {
// 	    		return $(this).val();
// 	    	}).get();
	    	
// 	    	if (checkedValues.length <= 0) {
// 	    		alert("삭제할 게시물을 선택하세요");
// 	    		return;
// 	    	}
	    	
// 	    	console.log("checkedValues : " + checkedValues);
// 	    	location.href = "AdminFaqDelete?faq_idxs=" + checkedValues;
	    	
// 	    }
    
    	// 메뉴 활성화
		let link = document.location.href;
    	if (link.includes("AdmFaq")) {
    		document.querySelector("#AdmFaq").parentElement.previousElementSibling.classList.add("show");
    		document.querySelector("#AdmFaq").parentElement.previousElementSibling.classList.add("active");
    		document.querySelector("#AdmFaq").parentElement.classList.add("show");
    		document.querySelector("#AdmFaq").classList.toggle("active");
    	};
    </script>
</body>
</html>