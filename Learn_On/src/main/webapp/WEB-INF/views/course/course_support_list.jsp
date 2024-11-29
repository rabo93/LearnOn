<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
			<div class="cls-wrap detail">
				<div class="container">
					<section class="breadcrumb">
						<a href="#">카테고리</a> <i class="fa-solid fa-angle-right"></i>
						<a href="Category?codetype=${course[0].codetype}">${course[0].catename}</a> <i class="fa-solid fa-angle-right"></i>
						<span>${course[0].class_category}</span>
			        </section>
			        <section class="class-details">
<<<<<<< HEAD
			            <div class="cls-pic">
			            	<c:choose>
			            		<c:when test="${not empty course[0].class_pic1}">
			            			<img src="resources/upload/${course[0].class_pic1}" id="preview" class="figure-img img-fluid rounded" alt="thumpnail" style="height: 280px;">
			            		</c:when>
			            		<c:otherwise>
			            			<img src="${pageContext.request.contextPath}/resources/images/empty.png">
			            		</c:otherwise>
			            	</c:choose>
			            </div>
			            <div class="cls-infos">
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
					            	<c:set var="total_cur" value="${course}" />
					            	<h4>총  ${fn:length(total_cur)}강 (  ${course[0].class_runtime}분)</h4>
					            </div>
=======
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
				            	<c:set var="total_cur" value="${course}" />
				            	<h4>총  ${fn:length(total_cur)}강 (  ${course[0].class_runtime}분)</h4>
				            </div>
				            <div class="cls-pic">
				           
				            	<c:choose>
				            		<c:when test="${not empty course[0].class_pic1}">
				            			<img src="resources/upload/${course[0].class_pic1}" id="preview" class="figure-img img-fluid rounded" alt="thumpnail" style="height: 280px;">
				            		</c:when>
				            		<c:otherwise>
				            			<img src="${pageContext.request.contextPath}/resources/images/empty.png">
				            		</c:otherwise>
				            	</c:choose>
>>>>>>> branch 'main' of https://github.com/jhk727/learn_on.git
				            </div>
			            </div>
			        </section><!-- class-details -->
					<ul class="tabnav">
						<li><a href="CourseDetail?class_id=${course[0].class_id}&codetype=${param.codetype}#tab01">클래스 소개</a></li>
						<li><a href="CourseDetail?class_id=${course[0].class_id}&codetype=${param.codetype}#tab02">커리큘럼</a></li>
						<li><a href="CourseDetail?class_id=${course[0].class_id}&codetype=${param.codetype}#tab03">수강평(${totalReview})</a></li>
						<li><a class="tab on" href="#" >문의(${pageInfo.listCount})</a></li>
					</ul>
					<div class="tabcontent">
						<div class="tabmenu" id="tab04">
							<div class="question_title">
								<h2>문의</h2><h4>(전체 ${pageInfo.listCount} 개)</h4>
					            <button onclick="window.location.href='CourseSupport?class_id=${course[0].class_id}'">
					            	문의작성하기
					            </button>
				            </div>
					            
				            <c:set var="pageNum" value="1"/>
				            <c:if test="${not empty param.pageNum}">
								<c:set var="pageNum" value="${param.pageNum}"/>
							</c:if>
				            <c:choose>
								<c:when test="${empty courseSupportList}">
									<div class="empty">수강문의가 없습니다.</div>
								</c:when>
								<c:otherwise>
						            <c:forEach var="support" items="${courseSupportList}">
							            <div class="question_qna">
								            <div class="question_q">
								            	<a href="CourseSupportDetail?class_id=${support.c_class_id}&c_support_idx=${support.c_support_idx}&pageNum=${pageNum}">
												    <div class="r_header">
												        <div class="profile-icon"></div>
												        <div class="user-info">
												            <div class="name">${support.mem_id}</div>
												            <div class="date">
												            	<span><fmt:formatDate value="${support.c_support_date}" pattern="yy-MM-dd HH:mm" /></span>
												            </div>
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
											
											
											<c:if test="${not empty support.c_support_answer_subject }">
												<div class="question_a">
												    <div class="r_header">
												        <div class="profile-icon"></div>
												        <div class="user-info">
												            <div class="name">
												            	<c:if test="${not empty support.c_support_answer_subject}">
												            		관리자
												            	</c:if>
												            </div>
												            <div class="date">
												            	<span><fmt:formatDate value="${support.c_support_answer_date}" pattern="yy-MM-dd HH:mm" /></span>
<%-- 												            	<span><fmt:formatDate value="${support.c_support_answer_date}" pattern="yy-MM-dd HH:mm" /></span> --%>
												            </div>
												        </div>
												    </div>
												    <div class="review-title">
												    	${support.c_support_answer_subject}
												    </div>
												    <div class="review-text">
												    	${support.c_support_answer_content}
												    </div>
												</div>
											</c:if>
										</div> <!-- question_qna 문의사항 질문-답변 -->
									</c:forEach>
								</c:otherwise>
							</c:choose>
								
							<c:choose>
								<c:when test="${not empty requestScope.courseSupportList}">									
									<section id="pageList">	
									
										<!-- 현재 목록의 시작페이지 번호에서 페이지 번호 갯수를 뺀 페이지 요청ㄹ -->
										<!-- 시작 페이지가 1페이지 일 경우 페이지 비활성화! -->
										<input type="button" value="&lt;&lt;" 
											onclick="location.href='CourseSupportList?class_id=${course[0].class_id}&pageNum=${pageInfo.startPage - pageInfo.pageListLimit}'"				
											<c:if test="${pageInfo.startPage == 1}">disabled</c:if> 	
										>
										<!-- [이전] 버튼 클릭시 이전 페이지 글 목록 요청(파라미터로 현재 페이지번호 -1 전달) -->
										<!-- 현재 페이지가 1페이지 일 경우 페이지 비활성화! --> <!-- 0은 어차피 콘트롤러에서 제어함. -->
										<input type="button" value="이전" 
											onclick="location.href='CourseSupportList?class_id=${course[0].class_id}&pageNum=${pageNum - 1}'"
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
													<a href="CourseSupportList?class_id=${course[0].class_id}&pageNum=${i}">${i}</a>
												</c:otherwise>
											</c:choose>
										</c:forEach>
										
										<!-- [다음] 버튼 클릭시 이전 페이지 글 목록 요청(파라미터로 현재 페이지번호 +1 전달) -->
										<%-- 현재 페이지가 전체 페이지 수와 동일할 경우 비활성화(disabled) --%>
										<input type="button" value="다음" 
											onclick="location.href='CourseSupportList?class_id=${course[0].class_id}&pageNum=${pageNum + 1}'"
											<c:if test="${pageNum == pageInfo.maxPage}">disabled</c:if> 		
										>
										<!-- 현재 목록의 시작페이지 번호에서 페이지 번호 갯수를 더한 페이지 요청ㄹ -->
										<%-- 끝 페이지가 전체 페이지 수와 동일할 경우 비활성화(disabled) --%>
										<input type="button" value="&gt;&gt;" 
											onclick="location.href='CourseSupportList?class_id=${course[0].class_id}&pageNum=${pageInfo.startPage + pageInfo.pageListLimit}'"
											<c:if test="${pageInfo.endPage == pageInfo.maxPage}">disabled</c:if>	
										>			
									</section>
								</c:when>
							</c:choose>
							<!-- 페이징 처리 끝 -->
						</div><!-- tabmenu -->
						
					</div><!-- tabcontent(클래스소개) 끝 -->
				</div><!-- container -->
				<div class="cls-event-card">
			        <div class="cls-event-card-header">
			            결제하기
			        </div>
			        <div class="cls-event-card-body">
			        	<div class="price">
			            	<fmt:formatNumber pattern="#,###">${course[0].class_price}</fmt:formatNumber>원
			            </div>
			        </div>
			        <div class="cls-event-card-footer">
	
			            <button class="apply-button" onclick="applyForCourse('${course[0].class_id}', '${param.codetype}')"><i class="fa-solid fa-cart-arrow-down"></i> 수강신청 하기</button>
						<div  id="${course[0].class_id}">
				            <button class="fav-off" style="display:block;" onclick="addToWishList('${course[0].class_id}')">
								<i class="fa-solid fa-heart-circle-plus"></i> 관심목록에 추가
							</button>
							<button class="fav-on" style="display:none;" onclick="deleteToWishList('${course[0].class_id}')">
								<i class="fa-solid fa-heart-circle-minus"></i> 관심목록에서 삭제
							</button>
						</div>
			        </div>
			    </div>
			</div><!-- cls-wrap detail -->
			<c:choose>
				<c:when test="${not empty requestScope.courseTeacher}">
					<div class="tabmenu" id="tab05">		
						<section class="recommended-classes">
				            <h2>강사의 다른 클래스 보기</h2>
							<div class="card-container">
								<c:forEach var="others" items="${requestScope.courseTeacher}">
								    <a href="CourseDetail?class_id=${others.class_id}">
									    <div class="card">
									        <img src="resources/upload/${others.class_pic1}" alt="Class Image">
									        <div class="card-content">
									            <div class="category">IT/개발</div>
									            <div class="title">${others.class_title}</div>
									            <div class="description">${others.mem_id}</div>
									        </div>
									    </div>
									</a>
								</c:forEach>
				            </div>
						</section>
					</div><!-- tabmenu 05끝 -->		           
			     	
			     	
		     	</c:when>
		    </c:choose>
		</div><!-- wrapper -->
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
	</footer>
	<script>
		function applyForCourse(id, codetype){
			location.href="ApplyForCourse?class_id=" + id + "&codetype=" + codetype;
		}
		
		function addToWishList(id){
			if(confirm("관심목록에 추가하시겠습니까?")) {
				location.href="MyFavAdd?class_id=" + id;
			}
		}
		
		function deleteToWishList(id){
			if(confirm("관심목록에서 삭제하시겠습니까?")){
				location.href="MyFavDel?class_id=" + id;
			}
		}
	</script>
</body>
</html>