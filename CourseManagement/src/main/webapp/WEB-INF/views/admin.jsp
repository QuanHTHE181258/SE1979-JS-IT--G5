<%--
  Created by IntelliJ IDEA.
  User: ducmi
  Date: 28/05/2025
  Time: 5:58 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/layout/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Course Management System</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        /* Reset và base styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f8f9fa;
            min-height: 100vh;
        }

        /* Layout chính */
        .wrapper {
            display: flex;
            min-height: 100vh;
        }

        /* Main content */
        .main-content {
            flex: 1;
            margin-left: var(--sidebar-width, 280px); /* Sử dụng biến CSS từ _admin_sidebar.jsp */
            padding: 2rem;
            background: #f8f9fa;
            transition: all 0.3s ease;
        }

        /* Responsive cho main content */
        @media (max-width: 768px) {
            .main-content {
                margin-left: 0;
                padding: 1rem;
                width: 100%;
            }
        }

        /* Card styles */
        .card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
            margin-bottom: 2rem;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            border: 1px solid rgba(0, 0, 0, 0.05);
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
        }

        .card-header {
            padding: 1.5rem;
            border-bottom: 1px solid rgba(0, 0, 0, 0.05);
            background: white;
            border-radius: 12px 12px 0 0;
        }

        .card-body {
            padding: 1.5rem;
        }

        /* Table styles */
        .table {
            width: 100%;
            margin-bottom: 1rem;
            color: #2c3e50;
            border-collapse: collapse;
        }

        .table th,
        .table td {
            padding: 1rem;
            vertical-align: middle;
            border: 1px solid #e9ecef;
        }

        .table th {
            background: #f8f9fa;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.85rem;
            letter-spacing: 0.5px;
        }

        .table tbody tr:hover {
            background: #f8f9fa;
        }

        /* Button styles */
        .btn {
            padding: 0.5rem 1rem;
            border-radius: 6px;
            font-weight: 500;
            transition: all 0.3s ease;
            cursor: pointer;
            border: 1px solid transparent;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }

        /* Form controls */
        .form-control {
            padding: 0.5rem 1rem;
            border: 1px solid #e9ecef;
            border-radius: 6px;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            outline: none;
        }

        /* Stats cards */
        .stats-card {
            background: white;
            border-radius: 12px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
            position: relative;
            overflow: hidden;
            animation: slideIn 0.5s ease-out forwards;
        }

        .stats-card-header {
            font-size: 0.9rem;
            color: #6c757d;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 1rem;
        }

        .stats-card-value {
            font-size: 2rem;
            font-weight: 700;
            color: #2c3e50;
            margin-bottom: 0.5rem;
        }

        .stats-card-icon {
            float: right;
            font-size: 2.5rem;
            color: rgba(102, 126, 234, 0.2);
        }

        /* Animation keyframes */
        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.02); }
            100% { transform: scale(1); }
        }

        /* Apply animations */
        .stats-card {
            animation: slideIn 0.5s ease-out forwards;
        }

        .stats-card:nth-child(1) { animation-delay: 0.1s; }
        .stats-card:nth-child(2) { animation-delay: 0.2s; }
        .stats-card:nth-child(3) { animation-delay: 0.3s; }
        .stats-card:nth-child(4) { animation-delay: 0.4s; }

        .stats-card:hover {
            animation: pulse 1s infinite;
        }

        /* Enhanced card styles */
        .stats-card {
            position: relative;
            overflow: hidden;
            border: none;
            background: linear-gradient(135deg, #fff 0%, #f8f9fa 100%);
        }

        .stats-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: linear-gradient(90deg, #667eea, #764ba2);
        }

        .stats-card:nth-child(1)::before { background: linear-gradient(90deg, #667eea, #764ba2); }
        .stats-card:nth-child(2)::before { background: linear-gradient(90deg, #f093fb, #f5576c); }
        .stats-card:nth-child(3)::before { background: linear-gradient(90deg, #4facfe, #00f2fe); }
        .stats-card:nth-child(4)::before { background: linear-gradient(90deg, #fa709a, #fee140); }

        /* Enhanced table styles */
        .table thead th {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            border-top: none;
            text-transform: uppercase;
            font-size: 0.75rem;
            letter-spacing: 1px;
            padding: 1.2rem 1rem;
        }

        .table tbody tr {
            transition: all 0.3s ease;
        }

        .table tbody tr:hover {
            background: rgba(102, 126, 234, 0.05);
            transform: scale(1.01);
        }

        /* Button enhancements */
        .btn {
            position: relative;
            overflow: hidden;
        }

        .btn::after {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 50%;
            transform: translate(-50%, -50%);
            transition: width 0.6s, height 0.6s;
        }

        .btn:active::after {
            width: 200px;
            height: 200px;
            opacity: 0;
        }

        /* Search form enhancement */
        .form-control {
            border-radius: 20px;
            padding: 0.5rem 1.2rem;
            border: 2px solid transparent;
            background: #f8f9fa;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            background: #fff;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        /* Badge enhancements */
        .badge {
            padding: 0.5em 1em;
            border-radius: 20px;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .badge-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .main-content {
                margin-left: 0;
                padding: 1rem;
            }

            .stats-card {
                margin-bottom: 1rem;
            }
        }

        /* Utility classes */
        .d-flex { display: flex; }
        .justify-content-between { justify-content: space-between; }
        .align-items-center { align-items: center; }
        .mb-4 { margin-bottom: 1.5rem; }
        .text-primary { color: #667eea; }
        .font-weight-bold { font-weight: 700; }
    </style>
</head>
<body>
<!-- Include sidebar -->
<jsp:include page="_admin_sidebar.jsp" />

<div class="wrapper">
    <div class="main-content">
        <!-- Stats Cards -->
        <div class="row g-4">
            <div class="col-md-4">
                <div class="stats-card">
                    <i class="fas fa-users stats-card-icon"></i>
                    <div class="stats-card-header">Tổng Người Dùng</div>
                    <div class="stats-card-value">
                        <fmt:formatNumber value="${dashboardStats.totalUsers}" type="number"/>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="stats-card">
                    <i class="fas fa-book stats-card-icon"></i>
                    <div class="stats-card-header">Tổng Khóa Học</div>
                    <div class="stats-card-value">
                        <fmt:formatNumber value="${dashboardStats.totalCourses}" type="number"/>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="stats-card">
                    <i class="fas fa-dollar-sign stats-card-icon"></i>
                    <div class="stats-card-header">Doanh Thu</div>
                    <div class="stats-card-value">
                        <fmt:formatNumber value="${dashboardStats.totalRevenue}" type="currency" currencySymbol="$"/>
                    </div>
                </div>
            </div>
        </div>

        <!-- Recent Activities -->
        <div class="row">
            <div class="col-12">
                <div class="card shadow mb-4">
                    <div class="card-header py-3 d-flex justify-content-between align-items-center">
                        <h6 class="m-0 font-weight-bold text-primary">Recent Activities</h6>
                        <div class="d-flex gap-2">
                            <!-- Search Form -->
                            <form action="${pageContext.request.contextPath}/admin" method="GET" class="d-flex gap-2">
                                <input type="hidden" name="courseSearch" value="${param.courseSearch}">
                                <input type="hidden" name="courseLimit" value="${param.courseLimit}">
                                <input type="hidden" name="activityLimit" value="${param.activityLimit}">
                                <input type="hidden" name="activityRole" value="${param.activityRole}">

                                <input type="text" name="activitySearch" class="form-control form-control-sm"
                                       placeholder="Search users..." value="${param.activitySearch}" style="width: 200px;">
                                <button type="submit" class="btn btn-sm btn-primary">
                                    <i class="fas fa-search"></i>
                                </button>
                                <c:if test="${not empty param.activitySearch}">
                                    <a href="${pageContext.request.contextPath}/admin?courseSearch=${param.courseSearch}&courseLimit=${param.courseLimit}&activityLimit=${param.activityLimit}&activityRole=${param.activityRole}"
                                       class="btn btn-sm btn-outline-secondary">
                                        <i class="fas fa-times"></i>
                                    </a>
                                </c:if>
                            </form>

                            <!-- Role Filter -->
                            <div class="btn-group btn-group-sm" role="group">
                                <a href="${pageContext.request.contextPath}/admin?activitySearch=${param.activitySearch}&courseSearch=${param.courseSearch}&courseLimit=${param.courseLimit}&activityLimit=5&activityRole=student"
                                   class="btn btn-outline-primary ${param.activityRole == 'student' || empty param.activityRole ? 'active' : ''}">Student</a>
                                <a href="${pageContext.request.contextPath}/admin?activitySearch=${param.activitySearch}&courseSearch=${param.courseSearch}&courseLimit=${param.courseLimit}&activityLimit=5&activityRole=teacher"
                                   class="btn btn-outline-primary ${param.activityRole == 'teacher' ? 'active' : ''}">Teacher</a>
                            </div>

                            <!-- Limit Toggle -->
                            <div class="btn-group btn-group-sm" role="group">
                                <a href="${pageContext.request.contextPath}/admin?activitySearch=${param.activitySearch}&courseSearch=${param.courseSearch}&courseLimit=${param.courseLimit}&activityLimit=5&activityRole=${param.activityRole}"
                                   class="btn btn-outline-info ${param.activityLimit == 5 || empty param.activityLimit ? 'active' : ''}">5</a>
                                <a href="${pageContext.request.contextPath}/admin?activitySearch=${param.activitySearch}&courseSearch=${param.courseSearch}&courseLimit=${param.courseLimit}&activityLimit=10&activityRole=${param.activityRole}"
                                   class="btn btn-outline-info ${param.activityLimit == 10 ? 'active' : ''}">10</a>
                            </div>
                        </div>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${not empty recentActivities}">
                                <div class="table-responsive">
                                    <table class="table table-bordered">
                                        <thead>
                                        <tr>
                                            <th>User</th>
                                            <th>Last Login Time</th>
                                            <th>Registration Time</th>
                                            <th>Role</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach var="user" items="${recentActivities}">
                                            <tr>
                                                <td>${user.firstName} ${user.lastName}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${not empty user.lastLoginDate}">
                                                            <fmt:formatDate value="${user.lastLoginDate}" pattern="MMM dd, yyyy HH:mm" />
                                                        </c:when>
                                                        <c:otherwise>
                                                            N/A
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <fmt:formatDate value="${user.createdAtDate}" pattern="MMM dd, yyyy HH:mm" />
                                                </td>
                                                <td>${userRoles[user.id].roleName}</td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="text-center py-4">
                                    <i class="fas fa-inbox fa-3x text-gray-300 mb-3"></i>
                                    <p class="text-muted">
                                        <c:choose>
                                            <c:when test="${not empty param.activitySearch}">
                                                No recent activities found for "${param.activitySearch}"
                                            </c:when>
                                            <c:otherwise>
                                                No recent activities found
                                            </c:otherwise>
                                        </c:choose>
                                    </p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>

        <!-- Recent Created Courses -->
        <div class="row">
            <div class="col-12">
                <div class="card shadow mb-4">
                    <div class="card-header py-3 d-flex justify-content-between align-items-center">
                        <h6 class="m-0 font-weight-bold text-primary">Recent Created Courses</h6>
                        <div class="d-flex gap-2">
                            <!-- Search Form -->
                            <form action="${pageContext.request.contextPath}/admin" method="GET" class="d-flex gap-2">
                                <input type="hidden" name="activitySearch" value="${param.activitySearch}">
                                <input type="hidden" name="activityLimit" value="${param.activityLimit}">
                                <input type="hidden" name="activityRole" value="${param.activityRole}">
                                <input type="hidden" name="courseLimit" value="${param.courseLimit}">

                                <input type="text" name="courseSearch" class="form-control form-control-sm"
                                       placeholder="Search courses..." value="${param.courseSearch}" style="width: 200px;">
                                <button type="submit" class="btn btn-sm btn-primary">
                                    <i class="fas fa-search"></i>
                                </button>
                                <c:if test="${not empty param.courseSearch}">
                                    <a href="${pageContext.request.contextPath}/admin?activitySearch=${param.activitySearch}&activityLimit=${param.activityLimit}&activityRole=${param.activityRole}&courseLimit=${param.courseLimit}"
                                       class="btn btn-sm btn-outline-secondary">
                                        <i class="fas fa-times"></i>
                                    </a>
                                </c:if>
                            </form>

                            <!-- Limit Toggle -->
                            <div class="btn-group btn-group-sm" role="group">
                                <a href="${pageContext.request.contextPath}/admin?activitySearch=${param.activitySearch}&courseSearch=${param.courseSearch}&activityLimit=${param.activityLimit}&activityRole=${param.activityRole}&courseLimit=5"
                                   class="btn btn-outline-info ${param.courseLimit == 5 || empty param.courseLimit ? 'active' : ''}">5</a>
                                <a href="${pageContext.request.contextPath}/admin?activitySearch=${param.activitySearch}&courseSearch=${param.courseSearch}&activityLimit=${param.activityLimit}&activityRole=${param.activityRole}&courseLimit=10"
                                   class="btn btn-outline-info ${param.courseLimit == 10 ? 'active' : ''}">10</a>
                            </div>
                        </div>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${not empty recentCourses}">
                                <div class="table-responsive">
                                    <table class="table table-bordered">
                                        <thead>
                                        <tr>
                                            <th>Course Code</th>
                                            <th>Title</th>
                                            <th>Teacher</th>
                                            <th>Created At</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach var="course" items="${recentCourses}">
                                            <tr>
                                                <td>${course.courseCode}</td>
                                                <td>${course.title}</td>
                                                <td>${course.teacherUsername}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${not empty course.createdAtDate}">
                                                            <fmt:formatDate value="${course.createdAtDate}" pattern="MMM dd, yyyy HH:mm" />
                                                        </c:when>
                                                        <c:otherwise>
                                                            N/A
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="text-center py-4">
                                    <i class="fas fa-book fa-3x text-gray-300 mb-3"></i>
                                    <p class="text-muted">
                                        <c:choose>
                                            <c:when test="${not empty param.courseSearch}">
                                                No recent courses found for "${param.courseSearch}"
                                            </c:when>
                                            <c:otherwise>
                                                No recent courses created
                                            </c:otherwise>
                                        </c:choose>
                                    </p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>

        <!-- Additional Statistics -->
        <div class="row">
            <div class="col-lg-6">
                <div class="card shadow mb-4">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-primary">Top Courses</h6>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${not empty topCourses}">
                                <c:forEach var="course" items="${topCourses}">
                                    <div class="d-flex justify-content-between align-items-center mb-3">
                                        <div>
                                            <h6 class="mb-1">${course.title}</h6>
                                            <small class="text-muted">${course.enrollmentCount} students</small>
                                        </div>
                                        <span class="badge badge-primary">Category ${course.categoryId}</span>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="text-center py-3">
                                    <p class="text-muted">No courses available</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>


        </div>
    </div>
</div>

<!-- Mobile toggle button -->
<button id="sidebar-toggle" class="d-md-none position-fixed" style="top: 1rem; left: 1rem; z-index: 1040;">
    <i class="fas fa-bars"></i>
</button>
</body>
</html>
