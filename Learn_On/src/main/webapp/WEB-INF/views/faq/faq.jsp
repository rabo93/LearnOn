<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>런온</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/reset.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/faq.css">
    
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/slick.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/index.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/faq.js"></script>

</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
	</header>
	<main>
		<section>
			<div class="faq-container">
				<h2 class="faq-title">FAQ</h2>
				<div class="faq-buttons">
					<button class="faq-button" onclick="showFAQ('course')">강의수강</button>
					<button class="faq-button" onclick="showFAQ('account')">계정관리</button>
					<button class="faq-button" onclick="showFAQ('payment')">결제/환불</button>
					<button class="faq-button" onclick="showFAQ('evidence')">증빙서류</button>
				</div>
				<div class="faq-list" id="course">
					<ul>
						<li>
							<button class="faq-item" onclick="toggleAnswer(this)">수강은 어디서 하나요?</button>
							<div class="answer">
								로그인 이후 우측 상단 [나의 강의장] 클릭 시 결제하신 강의 목록을 보실 수 있습니다.<br>
								시청 원하시는 강의의 [수강하기] 버튼을 누르시면 강의 시청이 가능합니다.
							</div>
						</li>
						<li>
							<button class="faq-item" onclick="toggleAnswer(this)">영상이 재생되지 않습니다</button>
							<div class="answer">
								영상 재생시, 오류가 발생하는 경우 1:1문의로 문의 주세요.<br>
								자세한 오류 내용 확인 후 안내드리겠습니다.
							</div>
						</li>
					</ul>
				</div>
				<div class="faq-list" id="account">
					<ul>
						<li>
							<button class="faq-item" onclick="toggleAnswer(this)">로그인은 어디서 하나요?</button>
							<div class="answer">
								우측 상단[로그인] 클릭 시 나오는 로그인 창에서 가능합니다.
							</div>
						</li>
						<li>
							<button class="faq-item" onclick="toggleAnswer(this)">이메일주소/휴대폰번호를 변경하고싶어요</button>
							<div class="answer">
								로그인 하신 상태에서 우측 상단[마이페이지] 클릭 후 [계정정보]에서 변경 가능합니다.
							</div>
						</li>
					</ul>
				</div>
				<div class="faq-list" id="payment">
					<ul>
						<li>
							<button class="faq-item" onclick="toggleAnswer(this)">결제 방법은 어떤 것이 있나요?</button>
							<div class="answer">
								1. 카드결제<br>
								2. 무통장입금(가상계좌)
							</div>
						</li>
						<li>
							<button class="faq-item" onclick="toggleAnswer(this)">결제내역은 어디서 보나요?</button>
							<div class="answer">
								로그인 하신 상태에서 우측 상단[마이페이지] 클릭 후 [결제내역]에서 확인 가능합니다.
							</div>
						</li>
					</ul>
				</div>
				<div class="faq-list" id="evidence">
					<ul>
						<li>
							<button class="faq-item" onclick="toggleAnswer(this)">현금 영수증은 어떻게 신청하나요?</button>
							<div class="answer">
								현금 영수증은 가상 계좌로 결제시, 결제창에서 직접 발급 신청 가능하며,<br>
								소득공제용(개인), 지출증빙용(사업자) 중 선택 하실 수 있습니다.
							</div>
						</li>
					</ul>
				</div>
				
			</div>
		</section>
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
	</footer>
</body>
</html>