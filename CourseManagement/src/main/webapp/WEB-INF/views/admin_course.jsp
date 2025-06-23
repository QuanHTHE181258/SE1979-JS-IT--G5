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
    <nav id="sidebar" class="bg-dark text-white">
        <div class="sidebar-header">
            <h3>Admin Panel</h3>
        </div>
        <ul class="list-unstyled components">
            <li><a href="${pageContext.request.contextPath}/admin">
                <i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/users">
                <i class="fas fa-users"></i>User Management</a></li>
            <li class="active"><a href="${pageContext.request.contextPath}/admin/courses">
                <i class="fas fa-book"></i> Courses Management</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/orders">
                <i class="fas fa-shopping-cart"></i> Order Management</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/categories">
                <i class="fas fa-tags"></i> Categories</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/reports">
                <i class="fas fa-chart-bar"></i> Reports</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/settings">
                <i class="fas fa-cog"></i> Settings</a></li>
        </ul>
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