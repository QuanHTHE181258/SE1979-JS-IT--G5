<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<header class="header">
  <nav class="navbar navbar-expand-lg fixed-top">
    <div class="container-fluid px-lg-4 px-xl-5">
      <a class="navbar-brand" href="${pageContext.request.contextPath}/home">
        <i class="bi bi-book me-2"></i>Online Learning
      </a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
              aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>

      <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav mx-auto">
          <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/home">
              <i class="bi bi-house-door"></i> Trang chủ
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/course">
              <i class="bi bi-collection"></i> Khóa học
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/blogs">
              <i class="bi bi-journal-text"></i> Blog
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/introduce.jsp">
              <i class="bi bi-info-circle"></i> Giới thiệu
            </a>
          </li>

          <c:if test="${sessionScope.loggedInUser != null}">
            <c:if test="${sessionScope.userRole == '5'}">
              <li class="nav-item">
                <a class="nav-link special-link" href="${pageContext.request.contextPath}/admin/dashboard">
                  <i class="bi bi-speedometer2"></i> Dashboard
                </a>
              </li>
            </c:if>

            <c:if test="${sessionScope.userRole == '2'}">
              <li class="nav-item">
                <a class="nav-link special-link" href="${pageContext.request.contextPath}/teaching-courses">
                  <i class="bi bi-mortarboard"></i> Khóa học đang dạy
                </a>
              </li>
            </c:if>

            <c:if test="${sessionScope.userRole == '1'}">
              <li class="nav-item">
                <a class="nav-link special-link" href="${pageContext.request.contextPath}/enrollments">
                  <i class="bi bi-book"></i> Khóa học của bạn
                </a>
              </li>
            </c:if>

            <c:if test="${sessionScope.userRole == '3'}">
              <li class="nav-item">
                <a class="nav-link special-link" href="${pageContext.request.contextPath}/course-manager">
                  <i class="bi bi-gear"></i> Quản lý khóa học
                </a>
              </li>
            </c:if>
          </c:if>
        </ul>

        <ul class="navbar-nav ms-auto">
          <c:if test="${sessionScope.userRole == '1'}">
            <li class="nav-item me-3">
              <a class="nav-link cart-link" href="${pageContext.request.contextPath}/CartServlet">
                <i class="bi bi-cart"></i> Giỏ hàng
              </a>
            </li>
          </c:if>

          <c:choose>
            <c:when test="${not empty sessionScope.loggedInUser}">
              <li class="nav-item me-3">
                <a class="nav-link user-link" href="${pageContext.request.contextPath}/profile">
                  <i class="bi bi-person-circle"></i> ${sessionScope.username}
                </a>
              </li>
              <li class="nav-item">
                <a class="nav-link logout-link" href="${pageContext.request.contextPath}/logout">
                  <i class="bi bi-box-arrow-right"></i> Đăng xuất
                </a>
              </li>
            </c:when>
            <c:otherwise>
              <li class="nav-item">
                <a class="nav-link login-link" href="${pageContext.request.contextPath}/login">
                  <i class="bi bi-box-arrow-in-right"></i> Đăng nhập
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
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<style>
  :root {
    --primary-color: #4e73df;
    --secondary-color: #6f42c1;
    --success-color: #1cc88a;
    --header-height: 70px;
  }

  body {
    padding-top: var(--header-height);
  }

  .navbar {
    height: var(--header-height);
    background: rgba(255, 255, 255, 0.95) !important;
    backdrop-filter: blur(10px);
    box-shadow: 0 2px 15px rgba(0,0,0,0.1);
  }

  .navbar-brand {
    font-size: 1.5rem;
    font-weight: 700;
    color: var(--primary-color) !important;
    transition: all 0.3s ease;
  }

  .navbar-brand:hover {
    transform: translateY(-2px);
  }

  .nav-link {
    font-size: 0.95rem;
    font-weight: 500;
    color: #444 !important;
    padding: 0.5rem 1rem !important;
    border-radius: 8px;
    transition: all 0.3s ease;
  }

  .nav-link:hover {
    color: var(--primary-color) !important;
    background: rgba(78, 115, 223, 0.1);
    transform: translateY(-2px);
  }

  .nav-link i {
    margin-right: 5px;
    font-size: 1.1rem;
  }

  .special-link {
    background: linear-gradient(45deg, var(--primary-color), var(--secondary-color));
    color: white !important;
    padding: 0.5rem 1rem;
    border-radius: 8px;
    margin: 0 5px;
  }

  .special-link:hover {
    color: white !important;
    transform: translateY(-2px);
    box-shadow: 0 4px 15px rgba(78, 115, 223, 0.3);
  }

  .cart-link {
    color: #444 !important;
    position: relative;
  }

  .cart-link:hover {
    color: var(--success-color) !important;
  }

  .user-link {
    background: rgba(78, 115, 223, 0.1);
    border-radius: 8px;
    color: var(--primary-color) !important;
  }

  .user-link:hover {
    background: rgba(78, 115, 223, 0.2);
  }

  .logout-link {
    color: #dc3545 !important;
  }

  .logout-link:hover {
    background: rgba(220, 53, 69, 0.1);
    color: #dc3545 !important;
  }

  .login-link {
    background: var(--primary-color);
    color: white !important;
    border-radius: 8px;
    padding: 0.5rem 1.2rem !important;
  }

  .login-link:hover {
    background: var(--secondary-color);
    color: white !important;
    transform: translateY(-2px);
    box-shadow: 0 4px 15px rgba(78, 115, 223, 0.3);
  }

  @media (max-width: 991.98px) {
    .navbar-nav {
      padding: 1rem 0;
    }

    .nav-link {
      padding: 0.75rem 1rem !important;
    }

    .special-link {
      margin: 5px 0;
    }
  }
</style>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
