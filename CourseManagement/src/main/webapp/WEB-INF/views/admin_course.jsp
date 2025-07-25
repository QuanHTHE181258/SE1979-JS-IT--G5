<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Course Management - Admin</title>
    <link href="${pageContext.request.contextPath}/css/admincss.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
</head>
<body>
<div class="wrapper">
    <nav id="sidebar" class="sidebar">
      <div class="sidebar-header">
        <h3>Admin Panel</h3>
      </div>
      <ul class="nav flex-column">
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/admin"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/admin/user-management"><i class="fas fa-users"></i> User Management</a>
        </li>
        <li class="nav-item">
          <a class="nav-link active" href="${pageContext.request.contextPath}/admin/courses"><i class="fas fa-book"></i> Courses Management</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/admin/orders"><i class="fas fa-shopping-cart"></i> Order Management</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/admin/revenue-analytics"><i class="fas fa-chart-bar"></i> Revenue Analytics</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/teacher-performance"><i class="fas fa-chart-line"></i> Teacher Performance</a>
        </li>
      </ul>
    </nav>
    <div id="content">
        <nav class="navbar navbar-expand-lg">
            <div class="container-fluid">
                <a class="navbar-brand" href="#">Course Management</a>
            </div>
        </nav>
        <div class="container-fluid py-4">
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
                            <h6 class="m-0 font-weight-bold text-primary">Course List</h6>
                        </div>
                        <div class="card-body">
                            <table style="width:100%; border-collapse:collapse; font-size:1rem;">
                                <thead>
                                    <tr style="background:#f5f5fa; color:#2c2c54;">
                                        <th style="padding:14px 8px; text-align:left; font-weight:700;">COURSE NAME</th>
                                        <th style="padding:14px 8px; text-align:left; font-weight:700;">INSTRUCTOR</th>
                                        <th style="padding:14px 8px; text-align:left; font-weight:700;">CATEGORY</th>
                                        <th style="padding:14px 8px; text-align:left; font-weight:700;">STATUS</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${courses}" var="course">
                                        <tr style="border-bottom:1px solid #e5e7eb;">
                                            <td style="padding:12px 8px;">${course.name}</td>
                                            <td style="padding:12px 8px;">${course.instructor}</td>
                                            <td style="padding:12px 8px;">${course.category}</td>
                                            <td style="padding:12px 8px;">${course.status}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                            <div style="text-align:center; margin-top:20px;">
                                <a href="${pageContext.request.contextPath}/admin/course-management" class="btn btn-info" style="background:#17a2b8; color:#fff; padding:10px 20px; border:none; border-radius:4px; font-weight:600; text-decoration:none;">
                                    <i class="fas fa-book"></i> Go to Course Management
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html> 