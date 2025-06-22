<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Your Teaching Courses</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: #f8fafc; }
        .container { max-width: 1000px; margin: 40px auto; background: #fff; border-radius: 16px; box-shadow: 0 8px 32px 0 rgba(31,38,135,0.10); padding: 2.5rem 2rem; }
        .table thead { background: linear-gradient(135deg, #43cea2 0%, #185a9d 100%); color: #fff; }
        .table tbody tr:hover { background: #e0eafc; }
        .title { font-size: 2rem; font-weight: 700; color: #185a9d; margin-bottom: 2rem; text-align: center; }
    </style>
</head>
<body>
<div class="container">
    <div class="title"><i class="fas fa-chalkboard-teacher me-2"></i>Your Teaching Courses</div>
    <c:choose>
        <c:when test="${not empty courses}">
            <div class="table-responsive">
                <table class="table table-bordered align-middle">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Title</th>
                            <th>Description</th>
                            <th>Price</th>
                            <th>Rating</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="course" items="${courses}" varStatus="status">
                            <tr>
                                <td>${status.index + 1}</td>
                                <td class="fw-semibold text-primary">${course.title}</td>
                                <td><c:out value="${course.description}"/></td>
                                <td><span class="badge bg-success">${course.price}$</span></td>
                                <td><span class="badge bg-info text-dark">${course.rating}</span></td>
                                <td><span class="badge bg-secondary">${course.status}</span></td>
                                <td>
                                    <a href="course?id=${course.id}" class="btn btn-outline-info btn-sm mb-1"><i class="fas fa-eye me-1"></i>View Details</a>
                                    <a href="course-feedback?id=${course.id}" class="btn btn-outline-warning btn-sm mb-1"><i class="fas fa-comments me-1"></i>Feedback</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:when>
        <c:otherwise>
            <div class="alert alert-info text-center">You are not teaching any courses yet.</div>
        </c:otherwise>
    </c:choose>
</div>
<!-- FontAwesome for icon -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
</body>
</html>
