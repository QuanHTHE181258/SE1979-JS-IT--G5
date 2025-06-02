<%--
  Created by IntelliJ IDEA.
  User: hoang
  Date: 5/26/2025
  Time: 8:46 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <title>Course List</title>
    <link rel="stylesheet" href="css/view-course-style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
<%-- Header --%>
<div class="home-header">
    <div class="home-header-logo"><a href="home" style="text-decoration: none; color: white">Courses Learning Web</a></div>
    <div class="home-header-courses"><a href="course" style="text-decoration: none; color: white">Courses</a></div>
    <div class="home-header-searchbar">
        <input type="text" placeholder="Search..." class="search-input">
        <span class="search-icon"><i class="fas fa-search"></i></span>
    </div>
    <div class="home-header-login"><a href="login" style="text-decoration: none; color: white">Login</a></div>
    <div class="home-header-register"><a href="register" style="text-decoration: none; color: white">Register</a></div>
</div>

<%-- Content --%>
<div class="container">
    <h1>Course List</h1>
    <ul class="course-list">
        <c:forEach var="course" items="${courses}">
            <li class="course-card">
                <div class="card-header">
                    <span class="course-code">${course.courseCode}</span>
                    <h3 class="course-title">${course.title}</h3>
                    <p class="course-teacher">${course.teacherUsername}</p>
                </div>
                <div class="card-body">
                    <p class="course-desc">${course.shortDescription}</p>
                    <div class="course-detail">
                        <p><strong>Price:</strong> $${course.price}</p>
                        <p><strong>Duration:</strong> ${course.durationHours} hours</p>
                        <p><strong>Max Students:</strong> ${course.maxStudents}</p>
                        <p><strong>Start Date:</strong>
                            <fmt:formatDate value="${course.startDateAsDate}" pattern="dd/MM/yyyy" />
                        </p>
                        <p><strong>End Date:</strong>
                            <fmt:formatDate value="${course.endDateAsDate}" pattern="dd/MM/yyyy" />
                        </p>
                    </div>
                </div>
                <div class="card-footer">
                    <button class="join-btn">JOIN</button>
                </div>
            </li>
        </c:forEach>
    </ul>
    <div class="pagination">
        <c:if test="${totalPages > 1}">
            <c:forEach begin="1" end="${totalPages}" var="i">
                <a href="course?page=${i}" class="${i == currentPage ? 'active' : ''}">${i}</a>
            </c:forEach>
        </c:if>
    </div>
</div>

<%-- Footer --%>
<div class="home-footer">
    <div class="footer-content">
        <h3>Courses Learning Web</h3>
        <p>Email: example@gmail.com</p>
        <p>Phone: 000-000-0000</p>
        <p>Address: 123 Learning Street, Education City</p>
        <div class="social-icons">
            <a href="https://facebook.com" target="_blank"><i class="fab fa-facebook-f"></i></a>
            <a href="https://instagram.com" target="_blank"><i class="fab fa-instagram"></i></a>
            <a href="https://github.com" target="_blank"><i class="fab fa-github"></i></a>
        </div>
        <p>© 2025 Courses Learning Web. All rights reserved.</p>
    </div>
</div>
</body>
</html>