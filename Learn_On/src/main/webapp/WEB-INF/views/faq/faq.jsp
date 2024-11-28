<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>런 온 - 온라인 No.1 교육 플랫폼</title>
<link rel="SHORTCUT ICON" href="${pageContext.request.contextPath}/resources/images/favicon.ico">
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
		<div id="faq_commandArea">
			<section>
				<div class="faq-container">
					<div class="faq-head">
						<h2>FAQ</h2>
					</div>
					<div class="faq-buttons">
						<button class="faq-button" onclick="showFAQ('course')">강의수강</button>
						<button class="faq-button" onclick="showFAQ('account')">계정관리</button>
						<button class="faq-button" onclick="showFAQ('payment')">결제/환불</button>
						<button class="faq-button" onclick="showFAQ('evidence')">증빙서류</button>
					</div>
					<div class="faq-list" id="course">
						<ul>
							<c:forEach items="${faqList}" var="faqBoard">
								<c:if test="${faqBoard.faq_cate eq 1}">
									<li>
										<button class="faq-item" onclick="toggleAnswer(this)">${faqBoard.faq_subject}</button>
										<div class="answer">${fn:replace(faqBoard.faq_content, '\\n', '<br>')}</div>
									</li>
								</c:if>
							</c:forEach>
						</ul>
					</div>
					<div class="faq-list" id="account">
						<ul>
							<c:forEach items="${faqList}" var="faqBoard">
								<c:if test="${faqBoard.faq_cate eq 2}">
									<li>
										<button class="faq-item" onclick="toggleAnswer(this)">${faqBoard.faq_subject}</button>
										<div class="answer">
											${faqBoard.faq_content}
										</div>
									</li>
								</c:if>
							</c:forEach>
						</ul>
					</div>
					<div class="faq-list" id="payment">
						<ul>
							<c:forEach items="${faqList}" var="faqBoard">
								<c:if test="${faqBoard.faq_cate eq 3}">
									<li>
										<button class="faq-item" onclick="toggleAnswer(this)">${faqBoard.faq_subject}</button>
										<div class="answer">
											${faqBoard.faq_content}
										</div>
									</li>
								</c:if>
							</c:forEach>
						</ul>
					</div>
					<div class="faq-list" id="evidence">
						<ul>
							<c:forEach items="${faqList}" var="faqBoard">
								<c:if test="${faqBoard.faq_cate eq 4}">
										<li>
											<button class="faq-item" onclick="toggleAnswer(this)">${faqBoard.faq_subject}</button>
											<div class="answer">
												${faqBoard.faq_content}
											</div>
										</li>
								</c:if>
							</c:forEach>
						</ul>
					</div>
				</div>
			</section>
				<c:if test="${sessionScope.sGrade eq 'MEM03'}">
				<div class="faq-writebtn">
					<input type="button" value="글쓰기" onclick="location.href='FaqWrite'">
				</div>
				</c:if>
		</div>
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
	</footer>
</body>
</html>