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
            <!-- Filter Form (React-style onchange) -->
            <form id="filterForm" class="row g-2 align-items-center mb-4">
                <div class="col-md-2">
                    <input type="text" class="form-control" id="filterTitle" placeholder="Search by title">
                </div>
                <div class="col-md-2">
                    <select class="form-select" id="filterStatus">
                        <option value="">All Statuses</option>
                        <option value="ACTIVE">Active</option>
                        <option value="COMPLETED">Completed</option>
                        <option value="CANCELLED">Cancelled</option>
                    </select>
                </div>
                <div class="col-md-2">
                    <input type="number" class="form-control" id="filterMinScore" placeholder="Min Score">
                </div>
                <div class="col-md-2">
                    <input type="number" class="form-control" id="filterMaxScore" placeholder="Max Score">
                </div>
                <div class="col-md-2">
                    <select class="form-select" id="filterCertificate">
                        <option value="">All Certificates</option>
                        <option value="yes">Has Certificate</option>
                        <option value="no">No Certificate</option>
                    </select>
                </div>
                <div class="col-md-2">
                    <input type="number" class="form-control" id="filterMinProgress" placeholder="Min Progress">
                </div>
                <div class="col-md-2">
                    <input type="number" class="form-control" id="filterMaxProgress" placeholder="Max Progress">
                </div>
            </form>
            <!-- End Filter Form -->

            <div class="table-responsive">
                <table class="table table-hover mb-0" id="enrollmentsTable">
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
                    <tbody id="enrollmentsBody">
                    </tbody>
                </table>
            </div>
            <nav>
                <ul class="pagination justify-content-center mt-4" id="pagination"></ul>
            </nav>

            <script>
                // Convert enrollments from server to JS array
                var enrollments = [
                        <% if (request.getAttribute("enrollments") != null) {
                            List<Enrollment> enrollments = (List<Enrollment>) request.getAttribute("enrollments");
                            if (!enrollments.isEmpty()) {
                                for (int i = 0; i < enrollments.size(); i++) {
                                    Enrollment e = enrollments.get(i);
                                    Cours c = e.getCourse();
                        %>{
                        courseName: "<%= c != null ? c.getTitle().replace("\"", "\\\"") : "" %>",
                        courseId: <%= c != null ? c.getId() : 0 %>,
                        enrollmentDate: "<%= e.getEnrollmentDate() != null ? e.getEnrollmentDate().toString().substring(0, 10) : "" %>",
                        completionDate: "<%= e.getCompletionDate() != null ? e.getCompletionDate().toString().substring(0, 10) : "" %>",
                        progress: <%= e.getProgressPercentage() != null ? e.getProgressPercentage() : 0 %>,
                        status: "<%= e.getStatus() %>",
                        score: <%= e.getGrade() != null ? e.getGrade() : 0 %>,
                        certificate: "<%= Boolean.TRUE.equals(e.getCertificateIssued()) ? "yes" : "no" %>",
                        price: <%= c != null && c.getPrice() != null ? c.getPrice() : 0 %>
                    }<%= (i < enrollments.size() - 1) ? "," : "" %>
                    <%          }
                        }
                    } %>
                ];

                // Pagination and filter state
                var currentPage = 1;
                var pageSize = 5;

                function filterAndRender() {
                    // Get filter values
                    var title = document.getElementById('filterTitle').value.toLowerCase();
                    var status = document.getElementById('filterStatus').value;
                    var minScore = parseFloat(document.getElementById('filterMinScore').value) || null;
                    var maxScore = parseFloat(document.getElementById('filterMaxScore').value) || null;
                    var certificate = document.getElementById('filterCertificate').value;
                    var minProgress = parseFloat(document.getElementById('filterMinProgress').value) || null;
                    var maxProgress = parseFloat(document.getElementById('filterMaxProgress').value) || null;
                    var minPrice = null;
                    var maxPrice = null;

                    var filtered = enrollments.filter(function(e) {
                        if (title && e.courseName.toLowerCase().indexOf(title) === -1) return false;
                        if (status && e.status !== status) return false;
                        if (certificate && e.certificate !== certificate) return false;
                        if (minScore !== null && e.score < minScore) return false;
                        if (maxScore !== null && e.score > maxScore) return false;
                        if (minProgress !== null && e.progress < minProgress) return false;
                        if (maxProgress !== null && e.progress > maxProgress) return false;
                        if (minPrice !== null && e.price < minPrice) return false;
                        if (maxPrice !== null && e.price > maxPrice) return false;
                        return true;
                    });

                    // Pagination
                    var totalPages = Math.ceil(filtered.length / pageSize) || 1;
                    if (currentPage > totalPages) currentPage = totalPages;
                    var start = (currentPage - 1) * pageSize;
                    var end = start + pageSize;
                    var pageData = filtered.slice(start, end);

                    // Render table
                    var tbody = document.getElementById('enrollmentsBody');
                    var htmlRows = pageData.map(function(e) {
                        var completionDateHtml = e.completionDate && e.completionDate !== 'null' && e.completionDate !== ''
                            ? '<span class="badge bg-success">' + e.completionDate + '</span>'
                            : '<span class="badge bg-warning">Chưa hoàn thành</span>';

                        var statusHtml = '';
                        if (e.status === 'COMPLETED') {
                            statusHtml = '<span class="badge bg-success">COMPLETED</span>';
                        } else if (e.status === 'ACTIVE') {
                            statusHtml = '<span class="badge bg-primary">ACTIVE</span>';
                        } else {
                            statusHtml = '<span class="badge bg-secondary">' + e.status + '</span>';
                        }

                        var scoreHtml = e.score ? '<span class="badge bg-info">' + e.score + '</span>' : '<span class="text-muted">Not found score</span>';

                        var certificateHtml = e.certificate === 'yes'
                            ? '<span class="badge bg-success"><i class="fas fa-certificate"></i> Available</span>'
                            : '<span class="badge bg-secondary">Not Available</span>';

                        var actionsHtml = '<a href="lessons?courseId=' + e.courseId + '" class="btn btn-primary btn-sm btn-action"><i class="fas fa-eye"></i> View Details</a>';
                        if (e.status === 'COMPLETED') {
                            actionsHtml += '<a href="feedback?courseId=' + e.courseId + '" class="btn btn-warning btn-sm btn-action"><i class="fas fa-comment"></i> Feedback</a>';
                        }

                        return '<tr>' +
                            '<td><strong>' + e.courseName + '</strong></td>' +
                            '<td>' + (e.enrollmentDate || 'N/A') + '</td>' +
                            '<td>' + completionDateHtml + '</td>' +
                            '<td><div class="progress"><div class="progress-bar progress-bar-striped" role="progressbar" style="width: ' + e.progress + '%" aria-valuenow="' + e.progress + '" aria-valuemin="0" aria-valuemax="100">' + e.progress + '%</div></div></td>' +
                            '<td>' + statusHtml + '</td>' +
                            '<td>' + scoreHtml + '</td>' +
                            '<td>' + certificateHtml + '</td>' +
                            '<td>' + actionsHtml + '</td>' +
                            '</tr>';
                    }).join('');
                    tbody.innerHTML = htmlRows;

                    // Render pagination
                    var pagination = document.getElementById('pagination');
                    var pagHtml = '';
                    for (var i = 1; i <= totalPages; i++) {
                        pagHtml += '<li class="page-item' + (i === currentPage ? ' active' : '') + '"><a class="page-link" href="#" onclick="gotoPage(' + i + ');return false;">' + i + '</a></li>';
                    }
                    pagination.innerHTML = '<li class="page-item' + (currentPage === 1 ? ' disabled' : '') + '"><a class="page-link" href="#" onclick="gotoPage(' + (currentPage - 1) + ');return false;">Previous</a></li>' +
                        pagHtml +
                        '<li class="page-item' + (currentPage === totalPages ? ' disabled' : '') + '"><a class="page-link" href="#" onclick="gotoPage(' + (currentPage + 1) + ');return false;">Next</a></li>';
                }

                function gotoPage(page) {
                    currentPage = page;
                    filterAndRender();
                }

                // Attach onchange handlers
                var filterElements = document.querySelectorAll('#filterForm input, #filterForm select');
                for (var i = 0; i < filterElements.length; i++) {
                    filterElements[i].addEventListener('input', function() {
                        currentPage = 1;
                        filterAndRender();
                    });
                    filterElements[i].addEventListener('change', function() {
                        currentPage = 1;
                        filterAndRender();
                    });
                }

                // Initial render
                filterAndRender();
            </script>
        </div>
    </div>

    <!-- Feedback Messages -->
    <c:if test="${param.message == 'feedback_added'}">
        <div class="alert alert-success alert-dismissible fade show mt-3" role="alert">
            <i class="fas fa-check-circle me-2"></i>Thank you for your feedback!
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <c:if test="${param.error != null}">
        <div class="alert alert-danger alert-dismissible fade show mt-3" role="alert">
            <i class="fas fa-exclamation-circle me-2"></i>
            <c:choose>
                <c:when test="${param.error == 'not_completed'}">
                    You can only provide feedback for completed courses.
                </c:when>
                <c:when test="${param.error == 'already_feedback'}">
                    You have already provided feedback for this course.
                </c:when>
                <c:when test="${param.error == 'feedback_failed'}">
                    Failed to submit feedback. Please try again.
                </c:when>
                <c:when test="${param.error == 'invalid_parameters'}">
                    Invalid input parameters. Please try again.
                </c:when>
                <c:otherwise>
                    An error occurred. Please try again later.
                </c:otherwise>
            </c:choose>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
</div> <!-- Close container -->

<!-- Bootstrap Icons -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

