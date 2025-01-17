<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>런온</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/reset.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/terms.css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>

</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
	</header>
	<main>
		<div class="terms-wrap">
			<h1 class="terms-ttl">서비스 이용약관</h1>
			<div class="terms-con">
				<div>본 서비스 이용약관(이하 "약관")은 LearnOn(이하 "회사")이 제공하는 온라인 클래스 결제
					서비스(이하 "서비스")의 이용과 관련하여 회사와 회원 간의 권리, 의무 및 책임사항 등을 규정함을 목적으로 합니다. 본
					약관에 동의하지 않을 경우, 서비스 이용이 제한될 수 있습니다.</div>
				<p>제1조 (목적)</p>
				<div>본 약관은 회사가 제공하는 온라인 클래스 결제 서비스와 관련하여 회사와 회원 간의 권리와 의무, 책임사항을
					규정하는 것을 목적으로 합니다.</div>
				<p>제2조 (정의)</p>
				<ul>
					<li>"서비스"란 회사가 운영하는 LearnOn 웹사이트 및 관련 어플리케이션을 통해 제공되는 온라인 클래스의
						결제, 예약, 신청 등을 위한 서비스를 의미합니다.</li>
					<li>"회원"이란 회사의 웹사이트에 가입하여 본 약관에 동의하고, 회사가 제공하는 서비스를 이용하는 개인 또는
						법인을 말합니다.</li>
					<li>"강사"란 회원에게 클래스를 제공하는 자로서, 회사와의 별도 계약에 따라 강의를 제공하는 자를 의미합니다.</li>
					<li>"콘텐츠"란 회사가 제공하는 온라인 강의, 교육 자료, 멀티미디어 파일 등을 의미합니다.</li>
				</ul>
				<p>제3조 (약관의 효력과 변경)</p>
				<ul>
					<li>본 약관은 회사의 웹사이트를 통해 게시함으로써 효력을 발생합니다.</li>
					<li>회사는 관련 법령을 위반하지 않는 범위 내에서 본 약관을 변경할 수 있으며, 변경된 약관은 회사의 웹사이트에
						게시함으로써 효력이 발생합니다. 단, 중요한 약관의 변경 시에는 최소 7일 전 공지하며, 회원에게 개별 통지할 수 있습니다.</li>
				</ul>
				<p>제4조 (서비스의 제공 및 변경)</p>
				<ul>
					<li>회사는 다음과 같은 서비스를 제공합니다:<br> 
						- 온라인 클래스 결제 및 수강 신청<br> 
						- 강의 일정 및 수강 관련 정보 제공<br> 
						- 기타 회사가 추가 개발하거나 다른 회사와의 제휴 계약 등을 통해 회원에게 제공하는 일체의 서비스</li>
					<li>회사는 필요한 경우 서비스의 내용을 변경할 수 있으며, 변경 사항은 회원에게 사전에 통지합니다.</li>
				</ul>
				<p>제5조 (이용계약의 성립)</p>
				<ul>
					<li>이용계약은 회원이 본 약관에 동의하고 회사가 이를 승낙함으로써 성립합니다.</li>
					<li>회사는 다음의 경우 회원의 신청을 거절할 수 있습니다: - 신청 내용에 허위, 기재 누락, 오기가 있는 경우
						- 사회질서 및 미풍양속을 저해할 우려가 있다고 판단되는 경우 - 기타 회사가 정한 이용 요건을 충족하지 못한 경우</li>
				</ul>
				<p>제6조 (결제 및 환불)</p>
				<ul>
					<li>회원은 회사가 정한 방법에 따라 클래스에 대한 결제를 진행해야 하며, 결제 완료 후에만 서비스 이용이
						가능합니다.</li>
					<li>결제는 신용카드, 계좌이체, 전자화폐 등 회사가 지정한 결제 수단을 통해 가능합니다.</li>
					<li>환불은 회사의 환불 정책에 따르며, 클래스 시작 전 및 클래스 이용 후에는 일부 또는 전체 환불이 제한될 수
						있습니다. 상세 환불 정책은 LearnOn 웹사이트에 공지됩니다.</li>
				</ul>
				<p>제7조 (회원의 의무)</p>
				<ul>
					<li>회원은 본 약관 및 관계 법령, 회사가 제공하는 공지사항을 준수하여야 합니다.</li>
					<li>회원은 서비스 이용 시 다음 행위를 해서는 안 됩니다:
						- 타인의 정보 도용
						- 서비스의 무단 복제 및 배포
						- 회사의 사전 승인 없이 상업적 목적으로 이용
						- 기타 불법적이거나 부당한 목적을 위해 사용하는 행위</li>
				</ul>
				<p>제8조 (회사의 의무)</p>
				<ul>
					<li>회사는 관련 법령 및 본 약관이 금지하거나 미풍양속에 반하는 행위를 하지 않으며, 안정적이고 지속적인 서비스 제공을 위해 최선을 다합니다.</li>
					<li>회사는 회원으로부터 제기되는 의견이나 불만사항에 대해 적절한 절차를 거쳐 해결하도록 노력합니다.</li>
				</ul>
				<p>제9조 (서비스의 중단)</p>
				<ul>
					<li>회사는 시스템 유지보수, 교체 및 고장, 통신 장애 등의 사유로 서비스 제공을 일시적으로 중단할 수 있으며, 사전에 공지합니다.</li>
					<li>불가항력으로 인해 사전 통지가 불가능한 경우에는 예외로 합니다.</li>
				</ul>
				<p>제10조 (면책 조항)</p>
				<ul>
					<li>회사는 회원의 귀책사유로 인한 서비스 이용 장애에 대해 책임을 지지 않습니다.</li>
					<li>회사는 회원이 서비스를 이용하여 기대하는 수익, 효용 등을 얻지 못한 데 대한 책임을 지지 않습니다.</li>
				</ul>
				<p>제11조 (재판관할)</p>
				<ul>
					<li>본 약관과 관련된 사항은 대한민국 법률에 따라 해석되며, 서비스 이용 중 발생한 분쟁에 대해서는 회사의 본사 소재지를 관할하는 법원을 전속 관할 법원으로 합니다.</li>
				</ul>
				<div>
					본 약관은 2024년 01월 01일부터 적용됩니다.
				</div>
			</div>
					
		</div>
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
	</footer>
</body>
</html>