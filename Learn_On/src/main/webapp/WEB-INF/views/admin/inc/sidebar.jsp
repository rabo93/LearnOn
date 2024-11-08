<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="container-fluid position-relative bg-white d-flex p-0">
        <!-- Spinner Start -->
        <div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
            <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                <span class="sr-only">Loading...</span>
            </div>
        </div>
        <!-- Spinner End -->


        <!-- Sidebar Start -->
        <div class="sidebar pe-4 pb-3">
            <nav class="navbar bg-light navbar-light">
                <a href="admin" class="navbar-brand" style="display: flex;align-items: center;width: 100%;margin: 0;">
                	<img class="projectLogo" src="resources/admin/img/learn_on_logo2.png" alt="learnLogo" style="width: 150px; margin: 10px auto; border-radius: 20px;">
<!--                     <h3 class="text-primary">LearnOn</h3> -->
                </a>
                <div class="navbar-nav w-100">
                    <a href="admin" onclick="sidebarSelect();" id="dropdownbtn" class="nav-item nav-link ddb"><i class="fas fa-columns" style="margin-right: 10px;"></i>메인</a>
                    <div class="nav-item dropdown">
                        <a href="#" onclick="sidebarSelect();" id="dropdownbtn" class="nav-link dropdown-toggle active" data-bs-toggle="dropdown"><i class="fas fa-chalkboard" style="margin-right: 10px;"></i>클래스 관리</a>
                        <div class="dropdown-menu bg-transparent border-0">
                            <a href="admin_class_add" onclick="sidebarSelect();" class="dropdown-item" >클래스 등록</a>
                            <a href="admin_class_list" onclick="sidebarSelect();" class="dropdown-item">클래스 목록</a>
                            <a href="admin_class_delete" onclick="sidebarSelect();" class="dropdown-item">삭제된 클래스 목록</a>
                        </div>
                    </div>
                    <div class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle" onclick="sidebarSelect();" id="dropdownbtn" data-bs-toggle="dropdown"><i class="fas fa-users" style="margin-right: 10px;"></i>회원 관리</a>
                        <div class="dropdown-menu bg-transparent border-0">
                            <a href="admin_member_list" class="dropdown-item">회원 목록</a>
                            <a href="admin_member_list_instructor" class="dropdown-item">강사 회원 목록</a>
                            <a href="admin_member_list_delete" class="dropdown-item">탈퇴한 회원 목록</a>
                        </div>
                    </div>
                    <div class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"><i class="fas fa-credit-card" style="margin-right: 10px;"></i>결제 관리</a>
                        <div class="dropdown-menu bg-transparent border-0">
                            <a href="admin_payment_list" class="dropdown-item">결제 내역 관리</a>
                            <a href="admin_payment_list_coupon" class="dropdown-item">쿠폰 관리</a>
                        </div>
                    </div>
                    <div class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"><i class="fa fa-laptop me-2" style="margin-right: 10px;"></i>고객 지원 관리</a>
                        <div class="dropdown-menu bg-transparent border-0">
                            <a href="admin_board_management" class="dropdown-item">게시판 관리</a>
                            <a href="admin_board_faq" class="dropdown-item">FAQ 관리</a>
                            <a href="admin_board_review" class="dropdown-item">수강 후기 관리</a>
                        </div>
                    </div>
                    <div class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"><i class="fas fa-chart-line" style="margin-right: 10px;"></i>통계</a>
                        <div class="dropdown-menu bg-transparent border-0">
                            <a href="admin_chart_member" class="dropdown-item">회원별 통계</a>
                            <a href="admin_chart_class" class="dropdown-item">클래스별 통계</a>
                            <a href="admin_chart_payment" class="dropdown-item">결제 통계</a>
                            <a href="admin_chart_review" class="dropdown-item">수강 후기 통계</a>
                        </div>
                    </div>
                </div>
                <form class="d-none d-md-flex ms-4 searchbar">
                    <input class="form-control border-0" type="search" placeholder="메뉴 검색">
                </form>
            </nav>
        </div>
        <!-- Sidebar End -->
</body>
</html>