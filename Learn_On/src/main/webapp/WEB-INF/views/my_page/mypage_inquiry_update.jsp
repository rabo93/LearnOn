<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>런온</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/reset.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css">
    
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>

</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
	</header>
	<main>
		<!-- 계정설정 -->
		<h2 class="page-ttl">마이페이지</h2>
		<section class="my-wrap">
			<aside class="my-menu">
				<a href="MyInfo">계정정보</a>
				<a href="MyFav">관심목록</a>
				<a href="MyDashboard">나의 강의실</a>
				<a href="MyReview">작성한 수강평</a>
				<a href="MyPayment">결제내역</a>
				<a href="MyCoupon">보유한 쿠폰</a>
				<a href="MySupport" class="active">문의내역</a>
				<a href="MyAttendance">출석체크</a>
			</aside>
			<div class="my-container">
				<div class="contents-ttl">1:1 문의 수정</div>
				<div class="contents">
					<!-- contents -->
					<section class="inq-wrap">
						<form action="MySupportModify" method="post" class="inq-frm" enctype="multipart/form-data">
							<input type="hidden" name="support_idx" value="${param.support_idx}">
							<input type="hidden" name="pageNum" value="${param.pageNum}">
							<div class="row">
								<select name="support_category">
			                    	<option value="1" <c:if test="${support.support_category == 1}">selected</c:if>>이용문의</option>
			                    	<option value="2" <c:if test="${support.support_category == 2}">selected</c:if>>결제문의</option>
			                    	<option value="3" <c:if test="${support.support_category == 3}">selected</c:if>>기타</option>
			                    </select>
							</div>
		                    <div class="row">
			                    <input type="text" placeholder="제목을 입력하세요" name="support_subject" required="required" value="${support.support_subject}">
		                    </div>
		                    <div class="row">
		                    	<textarea name="support_content" rows="15" cols="40" required="required" placeholder="문의할 내용을 입력하세요">${support.support_content}</textarea>
		                    </div>
		                    <!-- 파일 첨부 -->
		                    <div class="row attach">
								<c:choose>
									<c:when test="${not empty support.support_file1}">
										<i class="fa-solid fa-paperclip"></i>
										${originalFileName}
		 								<a href="${pageContext.request.contextPath}/resources/upload/${fileName}" download="${originalFileName}" class="dw">
		 									<i class="fa-solid fa-download"></i>
		 								</a>
		 								<a href="javascript:deleteFile(${support.support_idx}, '${fileName}')" class="del">
		 									<i class="fa-solid fa-trash-can"></i>
		 								</a>
										<input type="file" name="file1" hidden>
									</c:when>
									<c:otherwise>
										<input type="file" name="file1">
									</c:otherwise>
								</c:choose>
		                    </div>
		                     <div class="btns">
		                    	<button type="button" onclick="history.back()">취소</button>
		                    	<button type="submit">등록하기</button>
		                    </div>
		                </form>
					</section>
					<!-- // contents -->
				</div>
			</div>
		</section>
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
	</footer>
	<script>
		// 수정 화면에서 첨부파일 삭제
		function deleteFile(support_idx, file) {
			console.log(support_idx + ", " + file);
			if(confirm("삭제하시겠습니까?")) {
				$.ajax({
					type : "post",
					url : "MySupportDeleteFile",
					data : {
						support_idx : support_idx,
						file : file
					}
				}).done(function(result){
					console.log(result);
					if(result.trim() == "true"){
						let fileElem = $("input[name=file1]");
						$(fileElem).parent().html(fileElem);
						$(fileElem).prop("hidden", false);
					} else {
						alert("파일 삭제 실패!\n다시 시도해주시기 바랍니다.");
					}
					
					
				}).fail(function(){
					alert("오류 발생");
				});
				
			}
			
			
		}
	</script>
</body>
</html>