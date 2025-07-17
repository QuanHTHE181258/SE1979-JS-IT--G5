<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="project.demo.coursemanagement.entities.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Enrolled Courses</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .progress {
            height: 20px;
        }
        .badge {
            font-size: 14px;
        }
        .btn-action {
            margin: 2px;
        }
        .table > tbody > tr > td {
            vertical-align: middle;
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <div class="card">
        <div class="card-header bg-primary text-white">
            <h2 class="mb-0"><i class="fas fa-graduation-cap me-2"></i>My Enrolled Courses</h2>
        </div>
        <div class="card-body">
            <table class="table table-striped table-hover">
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
                        <a href="course-details?id=<%= c.getId() %>" class="btn btn-primary btn-sm btn-action">
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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
