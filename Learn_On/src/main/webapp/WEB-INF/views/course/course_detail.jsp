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
<title>런 온 - 온라인 No.1 교육 플랫폼</title>
<link rel="SHORTCUT ICON" href="${pageContext.request.contextPath}/resources/images/favicon.ico">
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
			            <a href="Category?codetype=${course[0].codetype}&codetype_id=${course[0].codetype_id}">
			            	<span>${course[0].class_category}</span>
			            </a>
			        </section>
			        <section class="class-details">
			        	<div class="cls-pic">
			            	<c:choose>
			            		<c:when test="${not empty course[0].class_pic1}">
			            			<img src="${pageContext.request.contextPath}/resources/upload/${course[0].class_pic1}" id="preview" class="figure-img img-fluid rounded" alt="thumpnail" style="height: 280px;">
			            		</c:when>
			            		<c:otherwise>
			            			<img src="${pageContext.request.contextPath}/resources/images/thumb_origin.jpg">
			            		</c:otherwise>
			            	</c:choose>
			            </div>
			            <div class="cls-infos">
				            <h1>${course[0].class_title}</h1>
							<p>${course[0].class_intro}</p>
							<p>${course[0].hashtag}</p>       
				            <div class="cls_det_rating">
				            	<span class="stars"><i class="fa-solid fa-star"></i> ${course[0].review_score }</span>
								<div class="cls-det-text">            	
					            	<i class="fa-solid fa-user"></i>
					            	<h4>${course[0].mem_id}</h4>
					            </div>
								<div class="cls-det-text">            	
					            	<i class="fa-regular fa-hourglass-half"></i>
					            	<c:set var="total_cur" value="${course}" />
					            	<c:set var="total_re" value="${myReview}" />
					            	<h4>총  ${fn:length(total_cur)}강 ( ${course[0].class_runtime}분)</h4>
					            </div>
				            </div>
			            </div>
			        </section>
<%-- 	        		<c:set var="count" value="${courseSupportList}" /> --%>
					<ul class="tabnav">
						<li><a href="#tab01">클래스 소개</a></li>
						<li><a href="#tab02">커리큘럼</a></li>
						<li><a href="#tab03">수강평(${fn:length(total_re)})</a></li>
						<li><a class="tab" href="CourseSupportList?class_id=${course[0].class_id}&codetype=${param.codetype}">
						문의(${listCountSupport})
						</a></li>
					</ul>
					<div class="tabcontent">
						<div class="tabmenu" id="tab01">
							<h2>클래스 소개</h2>
				            <div class="intro_title" style="white-space: pre-line;">
				            	${course[0].class_intro}
			            	</div>
				            <div class="intro" style="white-space: pre-line;">
				            	${course[0].class_contents}
							</div>
						</div>
						<div class="tabmenu" id="tab02">
							<h2>커리큘럼 소개</h2>
							<c:forEach var="cur" items="${course}" varStatus="status">
				            	<div class="lesson">${status.count}강. ${cur.cur_title}
					            	<span>
					            		<p>${cur.cur_runtime} 분</p>
					            	</span>
				            	</div>
							</c:forEach>
						</div>
							
							
						<div class="tabmenu" id="tab03">
							<div class="review_title">
								<h2>수강평</h2><h4>(전체 ${fn:length(total_re)}개)</h4>
								<form action="CourseDetail">
									<select name="searchType">
										<option value="new" <c:if test="${param.searchType eq 'new'}">selected</c:if>>최신순</option>
										<option value="old" <c:if test="${param.searchType eq 'old'}">selected</c:if>>오래된순</option>
										<option value="score" <c:if test="${param.searchType eq 'score'}">selected</c:if>>평점순</option>
									</select>
										<input type="hidden" name="codetype" value="${param.codetype}"/>
									<input type="hidden" name="class_id" value="${param.class_id}">
									<input type="submit" value="검색" />
								</form>
							</div>	
							<c:choose>
								<c:when test="${empty myReview}">
									<div class="empty">작성된 수강평이 없습니다.</div>
								</c:when>
								<c:otherwise>	
									<div class="review-rating">
						                <span class="rating-score">${course[0].review_score}</span><br>
						                <span class="stars"><i class="fa-solid fa-star"></i></span>
						            </div>
						            <c:forEach var="review" items="${myReview}" varStatus="status">
						            	<div class="review">
										    <div class="r_header">
										        <div class="profile-icon"></div>
										        <div class="user-info">
										            <div class="name">${review.mem_id}</div>
										            <div class="date">${review.review_date}</div>
										        </div>
										    </div>
								            <div class=rating>
												<i class="fa-solid fa-star" ></i>
												<span><b>${review.review_score}</b></span>
											</div>
										    <div class="review-text">${review.review_content}</div>
										</div>
						            </c:forEach>
								</c:otherwise>
							</c:choose>	
								
								
								
								
								
				            
						</div><!-- tabmenu 03 -->
					</div><!-- tabcontent(클래스소개) 끝 -->
			  	</div><!-- container -->
				<div class="cls-event-card">
					<div class="cls-event-card-header">결제하기</div>
					<div class="cls-event-card-body">
						<div class="price">
							<fmt:formatNumber pattern="#,###">${course[0].class_price}</fmt:formatNumber>원	
						</div>
					</div>
					<div class="cls-event-card-footer">
						<button class="apply-button" onclick="applyForCourse('${course[0].class_id}', '${param.codetype}')"><i class="fa-solid fa-cart-arrow-down"></i> 수강신청 하기</button>
						<div id="${course[0].class_id}">
							<button class="fav-off" style="display:block;" onclick="addToWishList('${course[0].class_id}')"><i class="fa-solid fa-heart-circle-plus"></i> 관심목록에 추가</button>
							<button class="fav-on" style="display:none;" onclick="deleteToWishList('${course[0].class_id}')"><i class="fa-solid fa-heart-circle-minus"></i> 관심목록에서 삭제</button>
						</div>
					</div>
				</div><!-- cls-event-card -->
				
			</div><!-- cls-wrap detail -->
			<c:set var="pageNum" value="1"/>
            <c:if test="${not empty param.pageNum}">
				<c:set var="pageNum" value="${param.pageNum}"/>
			</c:if>
		    <c:choose>
				<c:when test="${not empty requestScope.courseTeacher}">    
			        <div class="tabmenu" id="tab05">
				        <section class="recommended-classes">
				            <h2>강사의 다른 클래스 보기</h2>
							<div class="card-container">
								<c:forEach var="others" items="${requestScope.courseTeacher}">
									<a href="CourseDetail?class_id=${others.class_id}">
									    <div class="card">
									        <img src="${pageContext.request.contextPath}/resources/upload/${others.class_pic1}" alt="Class Image">
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
			        </div><!--tabmenu 05 끝 -->	
				</c:when>
			</c:choose>
		</div> <!-- // wrapper -->
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
	</footer>
	<script>
		window.onload = function() {
			const wishList = ${wishList};
			
			
			wishList.forEach(wish => {
				const listItem = document.getElementById(wish.CLASS_ID);
				if (listItem) {
		               const favOnBtn = listItem.querySelector(".fav-on");
		               if (favOnBtn) {
		               	favOnBtn.style.display = "block";
		               }
		
		               const favOffBtn = listItem.querySelector(".fav-off");
		               if (favOffBtn) {
		               	favOffBtn.style.display = "none";
		               }
		           }
			});
		}
		
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