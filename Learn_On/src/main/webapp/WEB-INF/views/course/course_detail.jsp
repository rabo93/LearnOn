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
					            	<div class="lesson">${cur.cur_id}강 ${cur.cur_title}
						            	<span>
						            		<c:set var="totalSeconds" value="${cur.cur_runtime}" />
						            		<c:set var="hours" value="${totalSeconds div 3600}" />
											<c:set var="minutes" value="${(totalSeconds mod 3600) div 60}" />
											<c:set var="seconds" value="${totalSeconds mod 60}" />
											
											<p>${hours} : ${minutes} : ${seconds}</p>
						            	</span>
					            	</div>
								</c:forEach>
							</div>
							
							
							<div class="tabmenu" id="tab03">
								<div class="review_title">
									<h2>수강평</h2><h4>(전체 ???개)</h4>
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
									<h2>문의</h2><h4>(전체 ???? 개)</h4>
						            <button onclick="window.location.href='CourseSupport?class_id=${course[0].class_id}'">
						            	문의작성하기
						            </button>
					            </div>
					            
					            
					            
					            <c:set var="pageNum" value="1"/>
					            <%-- pageNum 파라미터가 존재할 경우 pageNum 변수에 ㅎ ㅐ당 파라미터값 저장 --%>
					            <c:if test="${not empty param.pageNum}">
									<c:set var="pageNum" value="${param.pageNum}"/>
								</c:if>
					            <c:choose>
									<c:when test="${empty courseSupportList}">
										<%-- 게시물 목록이 하나도 존재하지 않을 경우 --%>
										<tr>
											<td colspan="5">게시물이 존재하지 않습니다.</td>
										</tr>
									</c:when>
									<c:otherwise>
							            <c:forEach var="support" items="${courseSupportList}">
								            <div class="question_qna">
									            <div class="question_q">
									            	<a href="CourseSupportDetail?class_id=${course[0].class_id}&c_support_idx=${support.c_support_idx}&pageNum=${pageNum}">
													    <div class="r_header">
													        <div class="profile-icon"></div>
													        <div class="user-info">
													            <div class="name">${support.mem_id}</div>
													            <div class="date">${support.c_support_date}</div>
													        </div>
													    </div>
													    <div class="review-title">
													    	${support.c_support_subject}
													    </div>
													    <div class="review-text">
													        ${support.c_support_content}
													    </div>
	<%-- 												    ${support.c_support_file} --%>
													    <c:if test="${not empty support.c_support_file}">
														    <div class="review-file">
														    	<a href="${pageContext.request.contextPath}/resources/upload/${support.c_support_file}" download="${originalFileList}">
																	${support.c_support_file}<input type="button" value="다운로드">
									 							</a>
														    </div>
														</c:if>
													</a>
												</div>
												
												
												<div class="question_a">
												    <div class="r_header">
												        <div class="profile-icon"></div>
												        <div class="user-info">
												            <div class="name"></div>
												            <div class="date"></div>
												        </div>
												    </div>
												    <div class="review-text">
												    </div>
												</div>
											</div> <!-- question_qna 문의사항 질문-답변 -->
										</c:forEach>
									</c:otherwise>
								</c:choose>
								
							<section id="pageList">	
							
								<!-- 현재 목록의 시작페이지 번호에서 페이지 번호 갯수를 뺀 페이지 요청ㄹ -->
								<!-- 시작 페이지가 1페이지 일 경우 페이지 비활성화! -->
								<input type="button" value="&lt;&lt;" 
									onclick="location.href='CourseDetail?class_id=${course[0].class_id}&pageNum=${pageInfo.startPage - pageInfo.pageListLimit}&#tab04'"				
									<c:if test="${pageInfo.startPage == 1}">disabled</c:if> 	
								>
								<!-- [이전] 버튼 클릭시 이전 페이지 글 목록 요청(파라미터로 현재 페이지번호 -1 전달) -->
								<!-- 현재 페이지가 1페이지 일 경우 페이지 비활성화! --> <!-- 0은 어차피 콘트롤러에서 제어함. -->
								<input type="button" value="이전" 
									onclick="location.href='CourseDetail?class_id=${course[0].class_id}&pageNum=${pageNum - 1}&#tab04'"
									<c:if test="${pageNum == 1}">disabled</c:if> 	
								>
								
								
								<!-- 계산된 페이지 번호가 저장된 PageInfo 객체(pageInfo)를 통해 페이지 번호 출력 -->
								<!-- startPage 부터 endPage 까지 1씩 증가하면서 페이지 번호 표시 -->
<%-- 								startPage : ${pageInfo.startPage} , endPage : ${pageInfo.endPage} , pageNum : ${pageNum} --%>
<%-- 								pageInfo :  ${pageInfo }	 --%>
								<c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
									<!-- 각페이지마다 하이퍼링크 설정(BoardList) => 페이지번호를 파라미터로 전달 -->
									<!-- 단, 현재 페이지 (i값과 pageNum 파라미터값이 동일)는 하이퍼링크 없이 굵게 표시			 -->
									<c:choose>
										<c:when test="${i eq pageNum}">
											<strong>${i}</strong>
										</c:when>
										<c:otherwise>
											<!-- 페이지 번호 클릭시 해당 페이지 번호를 파라미터로 전달					 -->
											<a href="CourseDetail?class_id=${course[0].class_id}&pageNum=${i}&#tab04">${i}</a>
										</c:otherwise>
									</c:choose>
								</c:forEach>
								
								<!-- [다음] 버튼 클릭시 이전 페이지 글 목록 요청(파라미터로 현재 페이지번호 +1 전달) -->
								<%-- 현재 페이지가 전체 페이지 수와 동일할 경우 비활성화(disabled) --%>
								<input type="button" value="다음" 
									onclick="location.href='CourseDetail?class_id=${course[0].class_id}&pageNum=${pageNum + 1}&#tab04'"
									<c:if test="${pageNum == pageInfo.maxPage}">disabled</c:if> 		
								>
								<!-- 현재 목록의 시작페이지 번호에서 페이지 번호 갯수를 더한 페이지 요청ㄹ -->
								<%-- 끝 페이지가 전체 페이지 수와 동일할 경우 비활성화(disabled) --%>
								<input type="button" value="&gt;&gt;" 
									onclick="location.href='CourseDetail?class_id=${course[0].class_id}&pageNum=${pageInfo.startPage + pageInfo.pageListLimit}&#tab04'"
									<c:if test="${pageInfo.endPage == pageInfo.maxPage}">disabled</c:if>	
								>			
							</section>
							<!-- 페이징 처리 끝 -->
							</div>
							
						</div><!-- tabcontent(클래스소개) 끝 -->
						
							
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