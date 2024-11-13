<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>런온</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/reset.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/course.css">
    
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>

</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
	</header>
	<main>
		<div class="wrapper">
			<div class="cls-wrap">
				
				
				
				<div class="container">
					 <section class="breadcrumb">
			            <a href="#">카테고리</a> &gt; <a href="#">IT/프로그래밍</a> &gt; 백엔드
			        </section>
			        
			        <section class="class-details">
			        
			            <h1>${course[0].class_title}</h1>
						<p>${course[0].class_intro}</p>       
			            <div class="cls_det_rating">
			            	<span class="stars"></span>
			            	<h4>${course[0].review_score }</h4>
							<div class="cls-det-text">            	
				            	<i class="fa-sharp-duotone fa-solid fa-user"></i>
				            	<h4>${course[0].mem_id}</h4>
				            </div>
							<div class="cls-det-text">            	
				            	<i class="fa-regular fa-clock"></i>
				            	
				            	<h4>총  강 ( 분)</h4>
				            </div>
			            </div>
			        </section>
			        
			        <!-- 탭메뉴 영역안에 탭을 만드는 것이아니고 content 바로 위에 넣어야 함. -->
			<!-- 		<div class="tab"> -->
						<ul class="tabnav">
							<li><a href="#tab01">클래스 소개</a></li>
							<li><a href="#tab02">커리큘럼</a></li>
							<li><a href="#tab03">수강평</a></li>
							<li><a href="#tab04">문의(10)</a></li>
						</ul>
						<div class="tabcontent">
							<div class="tabmenu" id="tab01">
								<h2>클래스 소개</h2>
					            <div class="intro_title">
					            	<img data-drag-handle="true" class="resizable-media-img" src="https://cdn.inflearn.com/public/files/courses/335118/builder/01jbxgpm8ttbf91tdak2339ch6?w=960" title="image.png" alt="image" width="668" height="260">
				            	</div>
					            <div class="intro">
<%-- 					            	${course.CLASS_CONTENTS } --%>
								</div>
							</div>
							<div class="tabmenu" id="tab02">
								<h2>커리큘럼 소개</h2>
								<c:forEach var="cur" items="${course}">
					            	<div class="lesson">${cur.cur_id}강 ${cur.cur_title}<span>${cur.cur_video}</span></div>
								</c:forEach>
							</div>
							
							
							<div class="tabmenu" id="tab03">
								<div class="review_title">
									<h2>수강평</h2><h4>(전체 개)</h4>
									<select>
										<option>최신순</option>
										<option>오래된순</option>
										<option>평점순</option>
									</select>
								</div>	
									
					            <div class="review-rating">
					                <span class="rating-score" style="color:red;">수정요!! ${course[0].review_score}</span><br>
					                <span class="stars"></span>
					            </div>
<%-- 					            ${myReview} --%>
					            
					            
					            <c:forEach var="review" items="${myReview}" varStatus="status">
					            	<div class="review">
									    <div class="r_header">
									        <div class="profile-icon"></div>
									        <div class="user-info">
									            <div class="name">${review.mem_id}</div>
									            <div class="date">${review.review_date}</div>
									        </div>
									    </div>
							            <div class="stars">
							            	<span style="width: 80%;"></span>
							            	<h4>${review.review_score}</h4>
							            </div>
									    <div class="review-text">${review.review_content}</div>
									</div>
					            </c:forEach>
							</div>
							
							<div class="tabmenu" id="tab04">
								<div class="question_title">
									<h2>문의</h2><h4>(전체 3개)</h4>
						            <button onclick="window.location.href='CourseFaq';">
						            	문의작성하기
						            </button>
					            </div>
					            
					            <div class="question_qna">
						            <div class="question_q">
									    <div class="r_header">
									        <div class="profile-icon"></div>
									        <div class="user-info">
									            <div class="name">초보자</div>
									            <div class="date">2024.10.30</div>
									        </div>
									    </div>
									    <div class="review-text">
									        안녕하세요. 강의 난이도가 궁금합니다. 초보자도 들을 수 있나요??
									    </div>
									</div>
									
									<div class="question_a">
									    <div class="r_header">
									        <div class="profile-icon"></div>
									        <div class="user-info">
									            <div class="name">자바강사 홍길동</div>
									            <div class="date">2024.10.30</div>
									        </div>
									    </div>
									    <div class="review-text">
									        초보자도 열심히 따라오시면 충분히 가능합니다.
									    </div>
									</div>
								</div>
								<div class="question_qna">
						            <div class="question_q">
									    <div class="r_header">
									        <div class="profile-icon"></div>
									        <div class="user-info">
									            <div class="name">홍길동</div>
									            <div class="date">2024.11.07</div>
									        </div>
									    </div>
									    <div class="review-text">
									        안녕하세요. 자바 교재는 무엇으로 하나요??
									    </div>
									</div>
									
								</div>
							</div>
							
							
						</div><!-- tabcontent 끝 -->
						
							
				    </div>
				    
				    
				    
				    
				    
				    
				    
				    
				    
				    
				    
				    
				    
				    
				    
	    
	    
	    
	    
	    

        <section class="recommended-classes">
            <h2>강사의 다른 클래스 보기</h2>
			<div class="card-container">
			    <div class="card">
			        <img src="" alt="Class Image">
		            <div class="rating">
		                <span class="star">★</span> 4.8 (+50)
		            </div>
			        <div class="card-content">
			            <div class="category">IT/개발</div>
			            <div class="title">자바(Java) 알고리즘 문제풀이 입문: 코딩테스트 대비</div>
			            <div class="description">프로그래머 홍길동</div>
			        </div>
			    </div>
			    <div class="card">
			        <img src="" alt="Class Image">
		            <div class="rating">
		                <span class="star">★</span> 4.8 (+50)
		            </div>
			        <div class="card-content">
			            <div class="category">IT/개발</div>
			            <div class="title">자바(Java) 알고리즘 문제풀이 입문: 코딩테스트 대비</div>
			            <div class="description">프로그래머 홍길동</div>
			        </div>
			    </div>
			    <div class="card">
			        <img src="" alt="Class Image">
		            <div class="rating">
		                <span class="star">★</span> 4.8 (+50)
		            </div>
			        <div class="card-content">
			            <div class="category">IT/개발</div>
			            <div class="title">자바(Java) 알고리즘 문제풀이 입문: 코딩테스트 대비</div>
			            <div class="description">프로그래머 홍길동</div>
			        </div>
			    </div>
			    <div class="card">
			        <img src="" alt="Class Image">
		            <div class="rating">
		                <span class="star">★</span> 4.8 (+50)
		            </div>
			        <div class="card-content">
			            <div class="category">IT/개발</div>
			            <div class="title">자바(Java) 알고리즘 문제풀이 입문: 코딩테스트 대비</div>
			            <div class="description">프로그래머 홍길동</div>
			        </div>
			    </div>
            </div>
        </section>






































			</div>
		</div>
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
	</footer>
</body>
</html>