<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    // Debug thông tin phiên
    HttpSession currentSession = request.getSession(false);
    if(currentSession != null) {
        System.out.println("DEBUG HEADER - ID Phiên: " + currentSession.getId());
        System.out.println("DEBUG HEADER - Người dùng trong phiên: " + currentSession.getAttribute("user"));
        System.out.println("DEBUG HEADER - Tên người dùng: " + currentSession.getAttribute("username"));
        java.util.Enumeration<String> attributeNames = currentSession.getAttributeNames();
        System.out.println("DEBUG HEADER - Tất cả thuộc tính phiên:");
        while(attributeNames.hasMoreElements()) {
            String name = attributeNames.nextElement();
            System.out.println(name + ": " + currentSession.getAttribute(name));
        }
    } else {
        System.out.println("DEBUG HEADER - Không có phiên tồn tại");
    }
%>
<header>
    <nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
        <div class="container-fluid px-lg-4 px-xl-5">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/home">Học Trực Tuyến</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                    aria-controls="navbarNav" aria-expanded="false" aria-label="Chuyển đổi điều hướng">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav mx-auto">
                    <li class="nav-item">
                        <a class="nav-link px-3" href="${pageContext.request.contextPath}/home">Trang chủ</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link px-3" href="${pageContext.request.contextPath}/course">Khóa học</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link px-3" href="${pageContext.request.contextPath}/blog/list">Tin tức</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link px-3" href="${pageContext.request.contextPath}/home">Giới thiệu</a>
                    </li>

                    <c:if test="${sessionScope.loggedInUser != null}">
                        <c:if test="${sessionScope.userRole == '5'}">
                            <li class="nav-item">
                                <a class="nav-link px-3" href="${pageContext.request.contextPath}/admin/dashboard">
                                    <i class="bi bi-speedometer2"></i> Bảng điều khiển
                                </a>
                            </li>
                        </c:if>

                        <c:if test="${sessionScope.userRole == '3'}">
                            <li class="nav-item">
                                <a class="nav-link px-3" href="${pageContext.request.contextPath}/teaching-courses">
                                    <i class="bi bi-mortarboard"></i> Khóa học đang dạy
                                </a>
                            </li>
                        </c:if>

                        <c:if test="${sessionScope.userRole == '1'}">
                            <li class="nav-item">
                                <a class="nav-link px-3" href="${pageContext.request.contextPath}/enrollments">
                                    <i class="bi bi-book"></i> Khóa học của tôi
                                </a>
                            </li>
                        </c:if>

                        <c:if test="${sessionScope.userRole == '2'}">
                            <li class="nav-item">
                                <a class="nav-link px-3" href="${pageContext.request.contextPath}/view-all">
                                    <i class="bi bi-gear"></i> Quản lý khóa học
                                </a>
                            </li>
                        </c:if>
                    </c:if>
                </ul>

                <ul class="navbar-nav ms-auto">
                    <c:if test="${sessionScope.userRole == '1'}">
                        <li class="nav-item me-3">
                            <a class="nav-link" href="${pageContext.request.contextPath}/CartServlet">
                                <i class="bi bi-cart"></i> Giỏ hàng
                            </a>
                        </li>
                    </c:if>

                    <c:choose>
                        <c:when test="${not empty sessionScope.loggedInUser}">
                            <li class="nav-item me-3">
                                <a class="nav-link" href="${pageContext.request.contextPath}/profile">
                                    <i class="bi bi-person"></i> ${sessionScope.username}
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/logout">
                                    <i class="bi bi-box-arrow-right"></i> Đăng xuất
                                </a>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/login">
                                    <i class="bi bi-box-arrow-in-right me-1"></i>Đăng nhập
                                </a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>
</header>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<style>
    :root {
        --header-height: 60px;
    }
    body {
        padding-top: var(--header-height); /* Thêm padding-top cho fixed header */
    }
    .navbar {
        height: var(--header-height);
        box-shadow: 0 2px 4px rgba(0,0,0,.1);
    }
    .navbar-nav .nav-link {
        font-size: 1rem;
        font-weight: 500;
        transition: color 0.3s ease;
    }
    .navbar-nav .nav-link:hover {
        color: #0056b3;
    }
    .welcome-text {
        color: #333;
        font-weight: 500;
        margin-right: 8px;
    }
    .nav-link, .dropdown-item {
        font-family: 'Segoe UI', Arial, 'Noto Sans', sans-serif;
        white-space: nowrap;
    }
    .dropdown-menu {
        border-radius: 8px;
        box-shadow: 0 4px 6px rgba(0,0,0,.1);
        margin-top: 0.5rem;
    }
    .dropdown-item {
        padding: 8px 20px;
    }
    .dropdown-item:hover {
        background-color: #f8f9fa;
    }

    /* Large screen optimizations */
    @media (min-width: 1200px) {
        .container-fluid {
            max-width: 1400px;
        }
        .navbar-nav .nav-link {
            padding-left: 1.5rem !important;
            padding-right: 1.5rem !important;
        }
    }

    /* Medium screen adjustments */
    @media (min-width: 992px) and (max-width: 1199px) {
        .navbar-nav .nav-link {
            padding-left: 1rem !important;
            padding-right: 1rem !important;
        }
    }
</style>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
