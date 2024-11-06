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
    
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/slick.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/index.js"></script>

</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
	</header>
	<main>
		<div class="wrapper">
			<!-- section01. 메인 비주얼 배너 -->
			<section id="sec01" class="sec-full">
				<div class="sec-inner">
					<div class="visual-area">
						<div class="main-visual">
							<div><img src="${pageContext.request.contextPath}/resources/images/main_visual_01.jpg" alt="배너1"></div>
							<div><img src="${pageContext.request.contextPath}/resources/images/main_visual_02.jpg" alt="배너1"></div>
							<div><img src="${pageContext.request.contextPath}/resources/images/main_visual_03.jpg" alt="배너1"></div>
						</div>
						<a href="#" class="visu-prev"><i class="fa-solid fa-chevron-left"></i></a>
						<a href="#" class="visu-next"><i class="fa-solid fa-chevron-right"></i></a>
					</div>
				</div>
			</section>
			<!-- section02. 실시간 인기 클래스 -->
			<section id="sec02" class="sec">
				<div class="sec-inner">
					<h1 class="sec-ttl">
						실시간 인기 클래스 ✨
						<button class="more"><i class="fa-solid fa-chevron-right"></i></button>
					</h1>
					<div class="course-wrap">
						<ul class="course-card">
							<!-- 8개 -->
							<li>
								<img src="${pageContext.request.contextPath}/resources/images/thumb_01.webp" class="card-thumb" alt="thumbnail" />
								<div class="card-info">
									<div class="category">
										<span>IT/개발</span>
									</div>
									<div class="ttl">초심자를 위한 알고리즘 강의</div>
									<div class="price">₩55,000</div>
									<div class="rating">
										<i class="fa-solid fa-star"></i>
										<span>4.5</span>
									</div>
									<div class="name">프로그래머 홍길동</div>
								</div>
							</li>
							<li>
								<img src="${pageContext.request.contextPath}/resources/images/thumb_04.webp" class="card-thumb" alt="thumbnail" />
								<div class="card-info">
									<div class="category">
										<span>IT/개발</span>
									</div>
									<div class="ttl">초심자를 위한 알고리즘 강의</div>
									<div class="name">프로그래머 홍길동</div>
								</div>
							</li>
							<li>
								<img src="${pageContext.request.contextPath}/resources/images/thumb_03.webp" class="card-thumb" alt="thumbnail" />
								<div class="card-info">
									<div class="category">
										<span>IT/개발</span>
									</div>
									<div class="ttl">초심자를 위한 알고리즘 강의</div>
									<div class="name">프로그래머 홍길동</div>
								</div>
							</li>
							<li>
								<img src="${pageContext.request.contextPath}/resources/images/thumb_02.webp" class="card-thumb" alt="thumbnail" />
								<div class="card-info">
									<div class="category">
										<span>IT/개발</span>
									</div>
									<div class="ttl">초심자를 위한 알고리즘 강의</div>
									<div class="name">프로그래머 홍길동</div>
								</div>
							</li>
							<li>
								<img src="${pageContext.request.contextPath}/resources/images/thumb_05.webp" class="card-thumb" alt="thumbnail" />
								<div class="card-info">
									<div class="category">
										<span>디자인/드로잉</span>
									</div>
									<div class="ttl">초심자를 위한 알고리즘 어쩌구저쩌구 어쩌구저쩌꾸 강의</div>
									<div class="name">프로그래머 홍길동</div>
								</div>
							</li>
							<li>
								<img src="${pageContext.request.contextPath}/resources/images/thumb_06.webp" class="card-thumb" alt="thumbnail" />
								<div class="card-info">
									<div class="category">
										<span>IT/개발</span>
									</div>
									<div class="ttl">초심자를 위한 알고리즘 강의</div>
									<div class="name">프로그래머 홍길동</div>
								</div>
							</li>
							<li>
								<img src="${pageContext.request.contextPath}/resources/images/thumb_07.webp" class="card-thumb" alt="thumbnail" />
								<div class="card-info">
									<div class="category">
										<span>IT/개발</span>
									</div>
									<div class="ttl">초심자를 위한 알고리즘 강의</div>
									<div class="name">프로그래머 홍길동</div>
								</div>
							</li>
							<li>
								<img src="${pageContext.request.contextPath}/resources/images/thumb_08.webp" class="card-thumb" alt="thumbnail" />
								<div class="card-info">
									<div class="category">
										<span>IT/개발</span>
									</div>
									<div class="ttl">초심자를 위한 알고리즘 강의</div>
									<div class="name">프로그래머 홍길동</div>
								</div>
							</li>
						</ul>
					</div>
				</div>
			</section>
			<!-- section03. 방금 오픈한 강의 -->
			<section id="sec03" class="sec">
				<div class="sec-inner">
					<h1 class="sec-ttl">
						방금 오픈한 강의 👀
						<button class="more"><i class="fa-solid fa-chevron-right"></i></button>
					</h1>
					<div class="course-wrap">
						<ul class="course-card">
							<!-- 4개 -->
							<li>
								<img src="${pageContext.request.contextPath}/resources/images/thumb_09.webp" class="card-thumb" alt="thumbnail" />
								<div class="card-info">
									<div class="category">
										<span>IT/개발</span>
									</div>
									<div class="ttl">초심자를 위한 알고리즘 강의</div>
									<div class="name">프로그래머 홍길동</div>
								</div>
							</li>
							<li>
								<img src="${pageContext.request.contextPath}/resources/images/thumb_10.webp" class="card-thumb" alt="thumbnail" />
								<div class="card-info">
									<div class="category">
										<span>IT/개발</span>
									</div>
									<div class="ttl">초심자를 위한 알고리즘 강의</div>
									<div class="name">프로그래머 홍길동</div>
								</div>
							</li>
							<li>
								<img src="${pageContext.request.contextPath}/resources/images/thumb_11.webp" class="card-thumb" alt="thumbnail" />
								<div class="card-info">
									<div class="category">
										<span>IT/개발</span>
									</div>
									<div class="ttl">초심자를 위한 알고리즘 강의</div>
									<div class="name">프로그래머 홍길동</div>
								</div>
							</li>
							<li>
								<img src="${pageContext.request.contextPath}/resources/images/thumb_12.webp" class="card-thumb" alt="thumbnail" />
								<div class="card-info">
									<div class="category">
										<span>IT/개발</span>
									</div>
									<div class="ttl">초심자를 위한 알고리즘 강의</div>
									<div class="name">프로그래머 홍길동</div>
								</div>
							</li>
						</ul>
					</div>
				</div>
			</section>
			<!-- section04. 얼리버드 특가 -->
			<section id="sec04" class="sec">
				<div class="sec-inner">
					<h1 class="sec-ttl">
						얼리버드 특가 🎉
						<button class="more"><i class="fa-solid fa-chevron-right"></i></button>
					</h1>
					<div class="course-wrap">
						<ul class="course-card">
							<!-- 4개 -->
							<li>
								<img src="${pageContext.request.contextPath}/resources/images/thumb_13.webp" class="card-thumb" alt="thumbnail" />
								<div class="card-info">
									<div class="category">
										<span>IT/개발</span>
									</div>
									<div class="ttl">초심자를 위한 알고리즘 강의</div>
									<div class="name">프로그래머 홍길동</div>
								</div>
							</li>
							<li>
								<img src="${pageContext.request.contextPath}/resources/images/thumb_14.webp" class="card-thumb" alt="thumbnail" />
								<div class="card-info">
									<div class="category">
										<span>IT/개발</span>
									</div>
									<div class="ttl">초심자를 위한 알고리즘 강의</div>
									<div class="name">프로그래머 홍길동</div>
								</div>
							</li>
							<li>
								<img src="${pageContext.request.contextPath}/resources/images/thumb_11.webp" class="card-thumb" alt="thumbnail" />
								<div class="card-info">
									<div class="category">
										<span>IT/개발</span>
									</div>
									<div class="ttl">초심자를 위한 알고리즘 강의</div>
									<div class="name">프로그래머 홍길동</div>
								</div>
							</li>
							<li>
								<img src="${pageContext.request.contextPath}/resources/images/thumb_05.webp" class="card-thumb" alt="thumbnail" />
								<div class="card-info">
									<div class="category">
										<span>IT/개발</span>
									</div>
									<div class="ttl">초심자를 위한 알고리즘 강의</div>
									<div class="name">프로그래머 홍길동</div>
								</div>
							</li>
						</ul>
					</div>
				</div>
			</section>
			<!-- section05. 출석체크 -->
			<section id="sec05" class="sec-full">
				<div class="sec-inner">
					<div class="sec-ttl center">출석체크 이벤트</div>
					<div class="sec-desc">매일 출석체크하고 출석 기록을 세워보세요!</div>
					<div class="imsi"></div>
				</div>
			</section>
			<!-- section06. 관심있는 클래스 -->
			<section id="sec06" class="sec">
				<div class="sec-inner">
					<div class="sec-ttl center">관심있는 클래스를 찾지 못하셨나요?</div>
					<div class="sec-desc">다양한 카테고리를 탐색해 보세요</div>
					<div class="cate-list">
						<ul>
							<li><a href="#">🖥️&nbsp;&nbsp;&nbsp;백엔드</a></li>
							<li><a href="#">📱&nbsp;&nbsp;&nbsp;APP</a></li>
							<li><a href="#">🔤&nbsp;&nbsp;&nbsp;영어</a></li>
							<li><a href="#">🇨🇳&nbsp;&nbsp;&nbsp;중국어</a></li>
							<li><a href="#">🧘🏻‍♀️&nbsp;&nbsp;&nbsp;요가</a></li>
							<li><a href="#">💪&nbsp;&nbsp;&nbsp;피트니스</a></li>
							<li><a href="#">🎨&nbsp;&nbsp;&nbsp;드로잉</a></li>
							<li><a href="#">📸&nbsp;&nbsp;&nbsp;사진,영상</a></li>
							<li><a href="#">🍲&nbsp;&nbsp;&nbsp;한식</a></li>
							<li><a href="#">🥂&nbsp;&nbsp;&nbsp;음료,술</a></li>
						</ul>
					</div>
				</div>
			</section>
		</div>
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
	</footer>
</body>
</html>