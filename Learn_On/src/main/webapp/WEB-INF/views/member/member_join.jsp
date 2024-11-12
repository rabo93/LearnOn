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
<%-- <script src="${pageContext.request.contextPath}/resources/js/index.js"></script> --%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/join.css">
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/join.js"></script>

</head>
<body>
	<header id="hd">
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
	</header>
	<main>
	<div class="join-wrap">
		<!-- page 영역 -->   
		<h3>회원가입</h3>
		<div id="form-container">
			<div id="form-inner-container">
				<!-- Sign up form -->
				<div id="sign-up-container">
					<form action="MemberJoin" name="joinForm" method="post"
						enctype="multipart/form-data">
						<label for="MEM_NAME">이름</label>
						<div id="checkName"></div>
						<input type="text" name="MEM_NAME" id="MEM_NAME" placeholder="이름"
							onblur="checkNameLength()"> <label for="MEM_ID">아이디</label>
						<div id="checkId"></div>
						<input type="text" name="MEM_ID" id="MEM_ID" placeholder="아이디"
							onblur="checkIdLength()"> <label for="MEM_PASSWD1">비밀번호</label>
						<div id="checkPasswd1"></div>
						<input type="password" name="MEM_PASSWD" id="MEM_PASSWD1"
							placeholder="&#9679;&#9679;&#9679;&#9679;&#9679;&#9679;"
							onblur="checkPasswdLength1()"> <label for="MEM_PASSWD2">비밀번호
							확인</label>
						<div id="checkPasswd2"></div>
						<input type="password" name="MEM_PASSWD2" id="MEM_PASSWD2"
							placeholder="비밀번호 확인" onkeyup="checkPasswdResult()"> <label
							for="MEM_NICK">닉네임</label>
						<div id="checkNic"></div>
						<input type="text" name="MEM_NICK" id="MEM_NICK" placeholder="닉네임">
	
						<label>성별</label>
						<div id="gender-container">
							<div class="gender-option">
								<input type="radio" name="MEM_GENDER" id="male" value="M">
								<label for="male">남</label>
							</div>
							<div class="gender-option">
								<input type="radio" name="MEM_GENDER" id="female" value="F">
								<label for="female">여</label>
							</div>
						</div>
	
						<label for="mem_birthday">생년월일</label><br>
						<!-- 					<select id="year"> -->
						<!-- 						<option value="YEAR">출생년도</option> -->
						<!-- 					</select>  -->
						<!-- 					<select id="month"> -->
						<!-- 						<option value="MONTH">월</option> -->
						<!-- 					</select>  -->
						<!-- 					<select id="day"> -->
						<!-- 						<option value="DAY">일</option> -->
						<!-- 					</select>  -->
						<input type="date" min="1990-01-01" max="2000-12-31"
							name="MEM_BIRTHDAY"> 
							<br> <label for="MEM_PHONE">연락처</label>
						<div id="checkNumber"></div>
						<input type="text" name="MEM_PHONE" id="MEM_PHONE"
							placeholder="'-'없이 입력해주세요" onblur="numberCk()"> 
						
						<label for="mem_ddress1">주소</label>
						<div id="checkAddr"></div>
						<div class=mem_addr_form>
							<input type="text" name="MEM_ADDRESS1" placeholder="주소찾기"
									onclick="search_address()" id="mem_ddress1" size="25" readonly>
							<input type="text" placeholder="우편번호" id="mem_post_code"
								name="MEM_POST_CODE" size="6" readonly>
						</div>
	
						<input type="text" name="MEM_ADDRESS2" placeholder="상세주소" id="mem_address2" size="25">
						<label for="MEM_EMAIL1">이메일</label>
						<div id="checkMail"></div>
						<div class="email_form">
							<input type="text" name="MEM_EMAIL1" id="MEM_EMAIL1" placeholder="Email">
							@
							<input type="text" size="10" id="MEM_EMAIL2" name="MEM_EMAIL2">
							<select id="EMAILDMAIN">
								<option value="">직접입력</option>
								<option value="naver.com">naver.com</option>
								<option value="gmail.com">gmail.com</option>
								<option value="daum.net">daum.net</option>
							</select> 
						</div>
						<div class="email-auth-bx">
							<input type="button" value="인증코드 발송" name="mail_auth">
<!-- 							<input type="text" placeholder="인증코드를 입력해주세요" name="mail_auth"><br> -->
<!-- 							<input type="button" value="인증코드 확인" name="mail_auth_status" -->
<!-- 								id="mail_auth_status"><br> -->
<!-- 							<div id="checkCode"></div> -->
						</div>
						<div class="mem-grade">
							<label for="MEM_GRADE">
								<input type="checkbox" id="MEM_GRADE">
								강사 회원 신청
							</label>
						
						</div>
	
						<div id="file">
							<input type="file" name="MEM_PP_FILE" id="MEM_PP_FILE"><br>
						</div>
	

	
						<section>
							<label for="terms_all" class="terms-all"><input type="checkbox" name="terms" id="terms_all" class="terms"> 이용약관 전체동의 </label> 
							<div class="accordion">
								<ul>
									<li class="on">
										<div class="title">
											<label for="terms1"><input type="checkbox"name="terms" id="terms1" class="terms" required>(필수) 런온(LearnOn)이용약관 동의</label>
										</div> 
											<textarea rows="4" cols="40">
	이용약관 (Terms of Service)
제1조 (목적)
이 약관은 런온(LearnOn) 서비스(이하 ‘서비스’)의 이용과 관련하여 회사와 사용자 간의 권리와 의무 및 책임사항, 서비스 이용조건 및 절차 등 기본적인 사항을 규정함을 목적으로 합니다.

제2조 (정의)
‘서비스’란 회사가 제공하는 학습 및 교육 관련 모든 서비스를 의미합니다.
‘회원’이란 이 약관을 승인하고 회사와 서비스 이용 계약을 체결한 자를 의미합니다.
제3조 (약관의 효력 및 변경)
이 약관은 회원이 가입 시 동의하는 순간부터 효력이 발생합니다.
회사는 약관의 변경이 필요하다고 인정될 경우, 사전 공지 후 약관을 변경할 수 있으며, 변경된 약관은 공지된 날로부터 7일 후에 효력이 발생합니다.
제4조 (회원의 의무)
회원은 서비스 이용 시 관련 법규를 준수하며, 회사가 서비스 제공과 관련하여 공지한 사항을 준수해야 합니다.
회원은 타인의 개인정보를 부정하게 사용해서는 안 됩니다.
제5조 (서비스의 중단 및 변경)
회사는 시스템 점검, 유지보수, 교체, 장애, 운영상 필요 등 불가피한 경우 서비스의 전부 또는 일부를 일시 중단할 수 있습니다.
제6조 (면책 조항)
회사는 천재지변, 불가항력 등에 의해 서비스를 제공할 수 없는 경우 책임이 면제됩니다.
회원의 고의 또는 과실로 인해 발생한 손해에 대해서는 책임을 지지 않습니다.</textarea>
									</li>
	
									<li class="on">
										<div class="title">
											<label for="terms2"><input type="checkbox"
												name="terms" id="terms2" class="terms" required>(필수) 개인정보 수집 및이용 동의</label>
										</div> 
											<textarea rows="4" cols="40">
	개인정보 수집 및 이용 동의서 (Privacy Policy Agreement)
런온(LearnOn)은 다음과 같은 목적을 위해 개인정보를 수집 및 이용합니다.
		
1. 수집하는 개인정보 항목
필수 항목: 이름, 이메일 주소, 연락처, 생년월일
선택 항목: 직업, 학력 정보
2. 개인정보의 수집 및 이용 목적
회원 관리: 회원 가입 의사 확인, 본인 식별 및 인증, 서비스 제공을 위한 기본 정보 확인
서비스 제공: 학습 기록 관리, 학습 진도 분석 및 맞춤형 콘텐츠 추천
고객 지원: 민원 처리, 공지사항 전달
3. 개인정보 보유 및 이용 기간
회사는 회원이 서비스를 이용하는 동안 개인정보를 보유하며, 회원 탈퇴 시 해당 정보를 지체 없이 파기합니다. 단, 관련 법령에 의거해 보존이 필요한 경우 일정 기간 동안 보관할 수 있습니다.
4. 동의 거부 권리 및 불이익
회원은 개인정보 수집 및 이용에 동의하지 않을 권리가 있으며, 이 경우 서비스 이용이 제한될 수 있습니다.</textarea>
									</li>
	
									<li class="on">
										<div class="title">
											<label for="terms3"><input type="checkbox" name="terms" id="terms3" class="terms">광고성 정보 수신 동의서</label>
										</div> 
											<textarea rows="4" cols="40">
	광고성 정보 수신 동의서 (Marketing Consent)
런온(LearnOn)은 다양한 유익한 정보를 제공하기 위해 광고성 정보를 발송하고자 합니다. 이에 대해 동의하시는 경우, 귀하에게 이메일, SMS 등을 통해 마케팅 정보를 제공합니다.
	
1. 수신하는 광고성 정보의 내용
서비스 업데이트, 이벤트 및 프로모션 정보
신규 교육 콘텐츠 및 맞춤형 학습 제안
기타 학습에 유용한 교육 정보 및 추천 사항
2. 광고성 정보 수신 방법
이메일, SMS, 푸시 알림 등을 통해 발송됩니다.
3. 동의 철회
회원은 언제든지 광고성 정보 수신을 거부할 수 있습니다. 수신 거부를 원할 경우, 고객센터 또는 설정 메뉴에서 수신 거부를 요청하시면 됩니다.</textarea>
									</li>
								</ul>
							</div>
						</section>
						<div id="form-controls">
							<button type="submit" id="btnSubmit">회원가입</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	</main>
	<footer id="ft">
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
	</footer>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script type="text/javascript">
		function search_address() {
			new daum.Postcode({
				oncomplete : function(data) {
					console.log(data);
					document.joinForm.MEM_POST_CODE.value = data.zonecode;

					let address = data.address;
					if (data.buildingName != "") {
						address += " (" + data.buildingName + ")";
					}

					document.joinForm.MEM_ADDRESS1.value = address;

					document.joinForm.MEM_ADDRESS2.focus();

				}
			}).open();
		}
	</script>
</body>
</html>