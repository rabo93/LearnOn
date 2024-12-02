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
	<%-- 잠시 보류 --%>
	<div class="container-fluid pt-4 px-4">
		<div class="bg-light rounded p-4">
			<div class="d-flex mb-5">
				<h5 class="me-auto tableSubject">회원 정보 수정</h5>
			</div>
			<section class="tb-wrap">
				<form action="AdmMemberModify" name="modifyForm" class="d-flex input-group mb-3" method="post" enctype="multipart/form-data">
<%-- 					<input type="hidden" name="faq_idx" value="${param.faq_idx}"> --%>
					<table class="table table-striped">
						<colgroup>
								<col width="20%">
								<col width="80%">
						</colgroup>
						<tr>
							<td>이름</td>
							<td><input class="form-control" type="text" name="mem_name" value="${member.mem_name}" required /></td>
						</tr>
						<tr>
							<td>아이디</td>
							<td><input class="form-control" type="text" name="mem_id" value="${member.mem_id}" readonly /></td>
						</tr>
						<tr>
							<td>닉네임</td>
							<td><input class="form-control" type="text" name="mem_nick" value="${member.mem_nick}" required /></td>
						</tr>
						<tr>
							<td>성별</td>
							<td>
							<select class="form-select" name="mem_gender">
									<option value="M" <c:if test="${member.mem_gender eq 'M'}">selected</c:if>>남</option>
									<option value="F" <c:if test="${member.mem_gender eq 'F'}">selected</c:if>>여</option>
							</select>
							</td>
						</tr>
						<tr>
							<td>이메일</td>
							<td><input class="form-control" type="text" name="mem_email" value="${member.mem_email}" readonly/></td>
						</tr>
						<tr>
							<td>주소</td>
							<td>
								<div class="memModifyAddress">
									<input class="form-control w-50" type="text" id="mem_post_code" name="mem_post_code" value="${member.mem_post_code}" required />
									<button type="button" class="btn btn-lg btn-primary ms-3" onclick="search_address()">주소찾기</button>
								</div>
								<div>
									<input class="form-control w-75" type="text" name="mem_address1" value="${member.mem_address1}" required />
									<input class="form-control w-75" type="text" name="mem_address2" value="${member.mem_address2}" required />
								</div>
							</td>
								
						</tr>
					</table>
					<section class="nt-btns">
						<button class="btn btn-lg btn-primary ms-3" type="submit">등록</button>
						<button class="btn btn-lg btn-primary ms-3" type="button" onclick="location.href='AdmMemList'">취소</button>
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
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script type="text/javascript">
		let link = document.location.href;
		if (link.includes("AdmMemberModify")) {
			document.querySelector("#memberList").parentElement.previousElementSibling.classList.add("show");
			document.querySelector("#memberList").parentElement.previousElementSibling.classList.add("active");
			document.querySelector("#memberList").parentElement.classList.add("show");
			document.querySelector("#memberList").classList.toggle("active");
		};
		
		function search_address() {
			new daum.Postcode({
				oncomplete : function(data) {
					console.log(data);
					document.modifyForm.mem_post_code.value = data.zonecode;

					let address = data.address;
					if (data.buildingName != "") {
						address += " (" + data.buildingName + ")";
					}

					document.modifyForm.mem_address1.value = address;

					document.modifyForm.mem_address2.focus();

				}
			}).open();
		}
	</script>
</body>
</html>








