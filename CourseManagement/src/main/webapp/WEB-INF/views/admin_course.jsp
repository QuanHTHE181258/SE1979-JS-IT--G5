<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Course Management - Admin</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #3498db;
            --danger-color: #e74c3c;
            --success-color: #2ecc71;
            --warning-color: #f1c40f;
            --dark-color: #2c3e50;
            --light-color: #ecf0f1;
            --sidebar-width: 280px;
        }

        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background: #f4f6fb;
        }

        .wrapper {
            display: flex;
            min-height: 100vh;
        }

        .main-content {
            flex: 1;
            margin-left: var(--sidebar-width);
            padding: 2rem;
        }

        .content-header {
            margin-bottom: 2rem;
            padding: 1rem;
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
            border: none;
        }

        .card-header {
            background: var(--dark-color);
            color: white;
            padding: 1rem;
            border-radius: 10px 10px 0 0;
        }

        .card-body {
            padding: 2rem;
        }

        .stats-card {
            background: linear-gradient(45deg, var(--primary-color), #2980b9);
            color: white;
            padding: 1.5rem;
            border-radius: 10px;
            margin-bottom: 1rem;
            transition: transform 0.3s ease;
        }

        .stats-card:hover {
            transform: translateY(-5px);
        }

        .course-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            margin-top: 1rem;
        }

        .course-table th,
        .course-table td {
            padding: 1rem;
            border-bottom: 1px solid #eee;
        }

        .course-table th {
            background: #f8f9fa;
            font-weight: 600;
            color: var(--dark-color);
        }

        .course-table tr:hover {
            background: #f8f9fa;
        }

        .status-badge {
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 500;
        }

        .status-active {
            background: var(--success-color);
            color: white;
        }

        .status-draft {
            background: var(--warning-color);
            color: white;
        }

        .btn-manage {
            background: var(--primary-color);
            color: white;
            padding: 0.75rem 1.5rem;
            border-radius: 5px;
            text-decoration: none;
            transition: all 0.3s ease;
            border: none;
            font-weight: 500;
        }

        .btn-manage:hover {
            background: #2980b9;
            transform: translateY(-2px);
            color: white;
        }

        .create-manager-card {
            text-align: center;
            padding: 2rem;
        }

        .create-manager-card i {
            font-size: 3rem;
            color: var(--primary-color);
            margin-bottom: 1rem;
        }

        .create-manager-card h5 {
            color: var(--dark-color);
            margin-bottom: 1rem;
        }

        .create-manager-card p {
            color: #666;
            margin-bottom: 1.5rem;
        }

        @media (max-width: 768px) {
            .main-content {
                margin-left: 0;
                padding: 1rem;
            }
        }
    </style>
</head>
<body>
<c:set var="active" value="courses" scope="request"/>
<%@ include file="/WEB-INF/layout/header.jsp" %>
<%@ include file="_admin_sidebar.jsp" %>

<div class="wrapper">
    <div class="main-content">
        <div class="content-header">
            <h1 class="h3 mb-0">Course Management</h1>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin">Dashboard</a></li>
                    <li class="breadcrumb-item active">Course Management</li>
                </ol>
            </nav>
        </div>

        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-header">
                        <h5 class="mb-0">Course Manager</h5>
                    </div>
                    <div class="card-body create-manager-card">
                        <i class="fas fa-book-reader mb-3"></i>
                        <h5>Create Course Manager Account</h5>
                        <p class="text-muted">Set up a new account for managing courses in the system</p>
                        <a href="${pageContext.request.contextPath}/admin/courses/new?role=COURSE_MANAGER"
                           class="btn btn-manage">
                            <i class="fas fa-plus-circle me-2"></i>Create Course Manager
                        </a>
                    </div>
                </div>

                <div class="card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h5 class="mb-0">Course List</h5>
<%--                        <a href="${pageContext.request.contextPath}/admin/course-management"--%>
<%--                           class="btn btn-manage btn-sm">--%>
<%--                            <i class="fas fa-cog me-2"></i>Manage Courses--%>
<%--                        </a>--%>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="course-table">
                                <thead>
                                <tr>
                                    <th>Course Name</th>
                                    <th>Instructor</th>
                                    <th>Category</th>
                                    <th>Status</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${courses}" var="course">
                                    <tr>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <img src="${course.imageUrl}" alt="${course.title}"
                                                     class="rounded" width="40" height="40" style="object-fit: cover;">
                                                <div class="ms-3">
                                                    <h6 class="mb-0">${course.title}</h6>
                                                    <small class="text-muted">ID: ${course.courseCode}</small>
                                                </div>
                                            </div>
                                        </td>
                                        <td>${course.teacherName}</td>
                                        <td>${course.categories}</td>
                                        <td>
                                                <span class="status-badge ${course.status == 'active' ? 'status-active' : 'status-draft'}">
                                                        ${course.status}
                                                </span>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
