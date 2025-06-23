<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Course Management - Admin</title>
    <link href="${pageContext.request.contextPath}/css/admincss.css" rel="stylesheet">
</head>
<body>
<div class="wrapper">
    <nav class="col-md-2 d-md-block sidebar min-vh-100" id="sidebar">
        <div class="position-sticky pt-3">
            <h3 class="text-white text-center mb-4">Admin Panel</h3>
            <ul class="nav flex-column">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard">
                        <i class="fas fa-home"></i> Dashboard
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/courses">
                        <i class="fas fa-book"></i> Courses
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/orders">
                        <i class="fas fa-shopping-cart"></i> Orders
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="${pageContext.request.contextPath}/admin/users">
                        <i class="fas fa-users"></i> Users
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/revenue-analytics">
                        <i class="fas fa-chart-bar"></i> Revenue Analytics
                    </a>
                </li>
            </ul>
        </div>
    </nav>

    <div id="content">
        <!-- Top Navbar -->
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <div class="container-fluid">
                <a class="navbar-brand" href="#">Course Management</a>
            </div>
        </nav>

        <div class="container-fluid py-4">
<%--            <c:if test="${sessionScope.admin.role.roleName == 'ADMIN'}">--%>
                <div class="row justify-content-center">
                    <div class="col-md-8">
                        <div class="card shadow">
                            <div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-primary">Create Course Manager Account</h6>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="card h-100">
                                            <div class="card-body text-center">
                                                <i class="fas fa-book-reader fa-3x text-success mb-3"></i>
                                                <h5 class="card-title">Course Manager</h5>
                                                <p class="card-text text-muted">Create an account for managing courses in the system</p>
                                                <a href="${pageContext.request.contextPath}/admin/courses/new?role=COURSE_MANAGER" class="btn btn-success">
                                                    <i class="fas fa-book-reader"></i> Create Course Manager
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="card shadow mt-4">
                            <div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-primary">Course Management</h6>
                            </div>
                            <div class="card-body text-center">
                                <i class="fas fa-book fa-3x text-info mb-3"></i>
                                <h5 class="card-title">Manage Courses</h5>
                                <p class="card-text text-muted">Go to the course management interface to manage all courses in the system</p>
                                <a href="${pageContext.request.contextPath}/admin/course-management" class="btn btn-info">
                                    <i class="fas fa-book"></i> Go to Course Management
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
<%--            </c:if>--%>
<%--            <c:if test="${sessionScope.admin.role.roleName != 'ADMIN'}">--%>
<%--                <div class="alert alert-danger text-center">--%>
<%--                    <h4 class="alert-heading">Access Denied!</h4>--%>
<%--                    <p>You do not have permission to access this page. Only administrators can manage course managers.</p>--%>
<%--                    <hr>--%>
<%--                    <p class="mb-0">Please contact your administrator if you need access.</p>--%>
<%--                </div>--%>
<%--            </c:if>--%>
        </div>
    </div>
</div>
</body>
</html> 