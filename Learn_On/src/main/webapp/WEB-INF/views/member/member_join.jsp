<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/reset.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/index.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/join.css">
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/join.js"></script>

</head>
<body>
	<header id="hd">
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
	</header>
	<!-- page 영역 -->   
	<h3>회원가입</h3>
	<div id="form-container">
		<div id="form-inner-container">
			<!-- Sign up form -->
			<div id="sign-up-container">
				<form action="MemberJoin" name="joinForm" method="post" enctype="multipart/form-data">
					<label for="mem_name">이름</label> 
					<div id="checkName"></div>
					<input type="text" name="MEM_NAME"id="MEM_NAME" placeholder="이름" onblur="checkNameLength()">

					<label for="mem_id">아이디</label> 
					<div id="checkId"></div>
					<input type="text" name="MEM_ID" id="MEM_ID" placeholder="아이디" onblur="checkIdLength()">

					<label for="mem_passwd1">비밀번호</label> 
					<div id="checkPasswd1"></div>
					<input type="password" name="MEM_PASSWD" id="MEM_PASSWD1"
						placeholder="&#9679;&#9679;&#9679;&#9679;&#9679;&#9679;"
						onblur="checkPasswdLength1()">

					<label for="mem_passwd2">비밀번호 확인</label> 
					<div id="checkPasswd2"></div>
					<input type="password" name="MEM_PASSWD2" id="MEM_PASSWD2" placeholder="비밀번호 확인"
					onblur="checkPasswdResult()">

					<label for="mem_nic">닉네임</label> 
					<div id="checkNic"></div>
					<input type="text" name="name" id="mem_nic" placeholder="닉네임"> 
					
					<label>성별</label>
					<div id="gender-container">
						<div class="gender-option">
							<input type="radio" name="mem_gender" id="male" value="남"> 
							<label for="male">남</label>
						</div>
						<div class="gender-option">
							<input type="radio" name="mem_gender" id="female" value="여">
							<label for="female">여</label>
						</div>
					</div>

					<label for="mem_birthday">생년월일</label><br> 
					<select id="year">
						<option value="">출생년도</option>
					</select> 
					<select id="month">
						<option value="">월</option>
					</select> 
					<select id="day">
						<option value="">일</option>
					</select> 
					
					<br> <label for="mem_number">연락처</label> 
					<input type="text" name="mem_number" id="mem_number" placeholder="'-'없이 입력해주세요">

					<label for="address">주소</label>
					<div id="checkAddr"></div>
					<div class=mem_addr_form>
						<input type="text" name="mem_address1" placeholder="주소찾기"
							onclick="search_address()" id="mem_ddress1"
							size="25" readonly> 
						<input type="text" placeholder="우편번호" id="mem_post_code" name="mem_post_code" size="6" readonly>
					</div>

					<input type="text" name="mem_address2" placeholder="상세주소" id="mem_address2"
						name="address2" size="25"> <label for="email">이메일</label>
					<div class="email_form">
						<input type="text" name="MEM_EMAIL1" id="email1" placeholder="Email">
						@<input type="text" size="10" id="email2" name="MEM_EMAIL2">
					</div>
					<select id="emailDmain" onchange="emailDomain">
						<option value="">직접입력</option>
						<option value="@naver.com">@naver.com</option>
						<option value="@gmail.com">@gmail.com</option>
						<option value="@daum.net">@daum.net</option>
					</select> 
					<div id="checkMail"></div>
					
					<input type="text" placeholder="인증코드를 입력해주세요" name="mail_auth"><br> 
					<input type="button" value="인증코드 확인" name="mail_auth_status" id="mail_auth_status"><br> 
					<div id="checkCode"></div>
					
					<label for="mem_for_teacher">
						<input type="checkbox" id="mem_for_teacher">강사 회원 신청
					</label>

					<div id="file">
						<input type="file" name="mem_pp_file" id="mem_pp_file"><br>
					</div>

					<div id="form-controls">
						<button type="submit" id="btnSubmit">회원가입</button>
					</div>

					<section>
						<input type="checkbox" name="terms" id="terms" class="terms"> <label for="termsAll">이용약관 전체동의 </label>
						<div class="accordion">
							<ul>
								<li class="on">
									<div class="title">
										<span><input type="checkbox" name="terms" id="terms1" class="terms">(필수) 런온(Learn On)이용약관 동의</span><i>▼</i>
									</div>
									<div class="desc">이용약관 내용~~</div>
								</li>
								
								<li class="on">
									<div class="title">
										<span><input type="checkbox" name="terms" id="terms2" class="terms">(필수) 개인정보 수집 및 이용 동의</span><i>▼</i>
									</div>
									<div class="desc">개인정보 수집 내용~~</div>
								</li>
								
								<li class="on">
									<div class="title">
										<span><input type="checkbox" name="terms" id="terms3" class="terms">프로모션 정보 수신 동의</span><i>▼</i>
									</div>
									<div class="desc">광고동의 내용~~</div>
								</li>
							</ul>
						</div>
					</section>

<!-- 					<label for="terms">(필수) 런온(Learn On)이용약관 동의 ▼</label>  -->
<!-- 					<input type="checkbox" name="terms" id="terms"><label for="terms">(필수) 개인정보 수집 및 이용 동의 ▼</label>  -->
<!-- 					<input type="checkbox" name="terms" id="terms"> <label for="terms">프로모션 정보 수신 동의</label> -->


				</form>
			</div>
		</div>
		<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
		<script type="text/javascript">
			function search_address() {
				new daum.Postcode({
					oncomplete : function(data) {
						console.log(data);
						document.joinForm.mem_post_code.value = data.zonecode;

						let address = data.address;
						if (data.buildingName != "") {
							address += " (" + data.buildingName + ")";
						}

						document.joinForm.mem_address1.value = address;

						document.joinForm.mem_address2.focus();

					}
				}).open();
			}
		</script>
	</div>
	<footer id="ft">
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
	</footer>
</body>
</html>