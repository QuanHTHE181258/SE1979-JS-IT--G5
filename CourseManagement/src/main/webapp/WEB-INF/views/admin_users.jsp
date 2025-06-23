<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Management - Admin</title>
    <link href="${pageContext.request.contextPath}/css/admincss.css" rel="stylesheet">


</head>
<body>
<div class="wrapper">
    <nav id="sidebar" class="bg-dark text-white">
        <div class="sidebar-header">
            <h3>Admin Panel</h3>
        </div>
        <ul class="list-unstyled components">
            <li <c:if test="${request.servletPath == '/admin'}">class="active"</c:if>>
                <a href="${pageContext.request.contextPath}/admin">
                    <i class="fas fa-tachometer-alt"></i> Dashboard
                </a>
            </li>
            <li <c:if test="${request.servletPath == '/admin/users' || request.servletPath == '/admin/user-management'}">class="active"</c:if>>
                <a href="${pageContext.request.contextPath}/admin/users">
                    <i class="fas fa-users"></i> User Management
                </a>
            </li>
            <li <c:if test="${request.servletPath == '/admin/courses' || request.servletPath == '/admin/course-management'}">class="active"</c:if>>
                <a href="${pageContext.request.contextPath}/admin/courses">
                    <i class="fas fa-book"></i> Courses Management
                </a>
            </li>
            <li <c:if test="${request.servletPath == '/admin/orders'}">class="active"</c:if>>
                <a href="${pageContext.request.contextPath}/admin/orders">
                    <i class="fas fa-shopping-cart"></i> Order Management
                </a>
            </li>
            <li <c:if test="${request.servletPath == '/admin/categories'}">class="active"</c:if>>
                <a href="${pageContext.request.contextPath}/admin/categories">
                    <i class="fas fa-tags"></i> Categories
                </a>
            </li>
             <li <c:if test="${request.servletPath == '/admin/enrollments'}">class="active"</c:if>>
                <a href="${pageContext.request.contextPath}/admin/enrollments">
                  <i class="fas fa-user-graduate"></i> Enrollments
                </a>
            </li>
            <li <c:if test="${request.servletPath == '/admin/feedback'}">class="active"</c:if>>
                 <a href="${pageContext.request.contextPath}/admin/feedback">
                   <i class="fas fa-comments"></i> Feedback
                 </a>
            </li>
            <li <c:if test="${request.servletPath == '/admin/reports'}">class="active"</c:if>>
                <a href="${pageContext.request.contextPath}/admin/reports">
                    <i class="fas fa-chart-bar"></i> Reports
                </a>
            </li>
            <li <c:if test="${request.servletPath == '/admin/settings'}">class="active"</c:if>>
                <a href="${pageContext.request.contextPath}/admin/settings">
                    <i class="fas fa-cog"></i> Settings
                </a>
            </li>
        </ul>
    </nav>

    <div id="content">
        <!-- Top Navbar -->
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <div class="container-fluid">
                <a class="navbar-brand" href="#">User Management</a>
            </div>
        </nav>

        <div class="container-fluid py-4">
            <div class="row justify-content-center">
                <div class="col-md-8">
                    <div class="card shadow">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">Create User Manager Account</h6>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="card h-100">
                                        <div class="card-body text-center">
                                            <i class="fas fa-user-shield fa-3x text-primary mb-3"></i>
                                            <h5 class="card-title">User Manager</h5>
                                            <p class="card-text text-muted">Create an account for managing users in the system</p>
                                            <a href="${pageContext.request.contextPath}/admin/users/new?role=USER_MANAGER" class="btn btn-primary">
                                                <i class="fas fa-user-shield"></i> Create User Manager
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="card shadow mt-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">User Management</h6>
                        </div>
                        <div class="card-body text-center">
                            <i class="fas fa-users-cog fa-3x text-info mb-3"></i>
                            <h5 class="card-title">Manage Users</h5>
                            <p class="card-text text-muted">Go to the user management interface to manage all users in the system</p>
                            <a href="${pageContext.request.contextPath}/admin/user-management" class="btn btn-info">
                                <i class="fas fa-users-cog"></i> Go to User Management
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>