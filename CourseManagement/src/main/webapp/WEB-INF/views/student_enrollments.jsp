<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="project.demo.coursemanagement.entities.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>My Enrolled Courses</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .card {
            border: none;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
            border-radius: 10px;
        }
        .card-header {
            border-radius: 10px 10px 0 0 !important;
            background: linear-gradient(45deg, #4e73df, #36b9cc);
        }
        .progress {
            height: 20px;
            border-radius: 10px;
            background-color: #e9ecef;
        }
        .progress-bar {
            background: linear-gradient(45deg, #4e73df, #36b9cc);
        }
        .badge {
            font-size: 14px;
            padding: 8px 12px;
            border-radius: 6px;
        }
        .btn-action {
            margin: 2px;
            border-radius: 6px;
            transition: all 0.3s;
        }
        .btn-action:hover {
            transform: translateY(-2px);
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
        }
        .table > tbody > tr > td {
            vertical-align: middle;
            padding: 15px;
        }
        .table > thead > tr > th {
            background-color: #f8f9fc;
            color: #4e73df;
            font-weight: 600;
            border-bottom: 2px solid #e3e6f0;
        }
        .table > tbody > tr:hover {
            background-color: #f8f9fc;
            transition: all 0.3s;
        }
        .alert {
            border-radius: 10px;
            padding: 20px;
        }
        .container {
            padding: 30px 15px;
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/home">Online Learning</a>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav mx-auto">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/home">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/CourseController">Courses</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/blogs.jsp">Blogs</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/introduce.jsp">Introduce</a>
                </li>
            </ul>

            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/wishlist.jsp">
                        <i class="bi bi-heart"></i> Wishlist
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/cart.jsp">
                        <i class="bi bi-cart"></i> Cart
                    </a>
                </li>

                <c:choose>


                    <c:when test="${not empty sessionScope.user}">
                        <!-- Avatar + Welcome + Dropdown -->
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" id="userDropdown"
                               role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                <img src="<c:out value='${sessionScope.user.avatarUrl != null ? sessionScope.user.avatarUrl : "https://th.bing.com/th/id/OIP.-Zanaodp4hv0ry2WpuuPfgHaEf?rs=1&pid=ImgDetMain"}'/>"
                                     alt="Avatar" style="width:40px; height:40px; border-radius:50%; object-fit:cover; margin-right:8px;">

                            </a>
                            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                                <li>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/${sessionScope.user.roleId == 2 ? 'teacher/profile' : 'profile'}">
                                        My Profile
                                    </a>
                                </li>
                                <c:if test="${sessionScope.user.roleId == 3}">
                                    <li>
                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/student/refund">
                                            Refund Request
                                        </a>
                                    </li>
                                </c:if>
                                <c:if test="${sessionScope.user.roleId == 3}">
                                    <li>
                                        <a class="dropdown-item" href="myorder">
                                            My Order
                                        </a>
                                    </li>
                                </c:if>
                                <c:if test="${sessionScope.user.roleId == 1}">
                                    <li>
                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/dashBoard">
                                            Admin DashBoard
                                        </a>
                                    </li>
                                </c:if>
                                <li><hr class="dropdown-divider"></li>
                                <li>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/login?action=logout">
                                        Logout
                                    </a>
                                </li>
                            </ul>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/login.jsp">Login</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/register.jsp">Register</a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>
<div class="container mt-5">
    <div class="card">
        <div class="card-header">
            <h2 class="mb-0 text-white"><i class="fas fa-graduation-cap me-2"></i>My Enrolled Courses</h2>
            <p class="text-white-50 mb-0">Track your learning progress and achievements</p>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover mb-0">
                    <thead class="table-primary">
                    <tr>
                        <th>Course Name</th>
                        <th>Start Date</th>
                        <th>Completion Date</th>
                        <th>Progress</th>
                        <th>Status</th>
                        <th>Score</th>
                        <th>Certificate</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        List<Enrollment> enrollments = (List<Enrollment>) request.getAttribute("enrollments");
                        if (enrollments != null && !enrollments.isEmpty()) {
                            for (Enrollment e : enrollments) {
                                Cours c = e.getCourse();
                    %>
                    <tr>
                        <td><strong><%= c != null ? c.getTitle() : "" %></strong></td>
                        <td><%= e.getEnrollmentDate() != null ? e.getEnrollmentDate().toString().substring(0, 10) : "N/A" %></td>
                        <td>
                            <% if (e.getCompletionDate() != null) { %>
                                <span class="badge bg-success">
                                    <%= e.getCompletionDate().toString().substring(0, 10) %>
                                </span>
                            <% } else { %>
                                <span class="badge bg-warning">Chưa hoàn thành</span>
                            <% } %>
                        </td>
                        <td>
                            <div class="progress">
                                <div class="progress-bar progress-bar-striped"
                                     role="progressbar"
                                     style="width: <%= e.getProgressPercentage() != null ? e.getProgressPercentage() : 0 %>%"
                                     aria-valuenow="<%= e.getProgressPercentage() != null ? e.getProgressPercentage() : 0 %>"
                                     aria-valuemin="0"
                                     aria-valuemax="100">
                                    <%= e.getProgressPercentage() != null ? e.getProgressPercentage() : 0 %>%
                                </div>
                            </div>
                        </td>
                        <td>
                            <% if ("COMPLETED".equals(e.getStatus())) { %>
                                <span class="badge bg-success"><%= e.getStatus() %></span>
                            <% } else if ("ACTIVE".equals(e.getStatus())) { %>
                                <span class="badge bg-primary"><%= e.getStatus() %></span>
                            <% } else { %>
                                <span class="badge bg-secondary"><%= e.getStatus() %></span>
                            <% } %>
                        </td>
                        <td>
                            <% if (e.getGrade() != null) { %>
                                <span class="badge bg-info"><%= e.getGrade() %></span>
                            <% } else { %>
                                <span class="text-muted">Chưa có điểm</span>
                            <% } %>
                        </td>
                        <td>
                            <% if (Boolean.TRUE.equals(e.getCertificateIssued())) { %>
                                <span class="badge bg-success"><i class="fas fa-certificate"></i> Available</span>
                            <% } else { %>
                                <span class="badge bg-secondary">Not Available</span>
                            <% } %>
                        </td>
                        <td>
                            <a href="lessons?courseId=<%= c.getId() %>" class="btn btn-primary btn-sm btn-action">
                                <i class="fas fa-eye"></i> View Details
                            </a>
                            <% if ("COMPLETED".equals(e.getStatus())) { %>
                                <a href="feedback?courseId=<%= c.getId() %>" class="btn btn-warning btn-sm btn-action">
                                    <i class="fas fa-comment"></i> Feedback
                                </a>
                            <% } %>
                        </td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="8" class="text-center">
                            <div class="alert alert-info">
                                <i class="fas fa-info-circle me-2"></i>No enrolled courses found.
                            </div> add
                        </td>
                    </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap Icons -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
