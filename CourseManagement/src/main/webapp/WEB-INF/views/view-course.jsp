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
                    <span class="course-code">${course.courseID}</span>
                    <h3 class="course-title"><a href="catalog?courseID=${course.courseID}">${course.courseTitle}</a></h3>
                    <p class="course-teacher">${course.teacherName}</p>
                </div>
                <div class="card-body">
                    <p class="course-desc">${course.courseDescription}</p>
                    <div class="course-detail">
                        <p><strong>Price:</strong> $${course.price}</p>
                        <p><strong>Rating:</strong> ${course.rating}</p>
                        <p><strong>Category:</strong> ${course.categories}</p>
                        <p><strong>Status:</strong> ${course.courseStatus}</p>
                    </div>
                </div>
                <div class="card-footer">
                    <button class="join-btn">JOIN</button>
                </div>
            </li>
        </c:forEach>
    </ul>

    <%-- Enhanced Pagination Controls --%>
    <div class="pagination">
        <c:if test="${totalPages > 1}">
            <ul class="pagination-list">
                <%-- Previous button --%>
                <c:if test="${currentPage > 1}">
                    <li class="page-item">
                        <a href="course?page=${currentPage - 1}${searchKeyword != null ? '&search=' : ''}${searchKeyword != null ? searchKeyword : ''}" class="page-link">&laquo; Previous</a>
                    </li>
                </c:if>

                <%-- Page numbers --%>
                <c:forEach begin="1" end="${totalPages}" var="i">
                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                        <a href="course?page=${i}${searchKeyword != null ? '&search=' : ''}${searchKeyword != null ? searchKeyword : ''}" class="page-link">${i}</a>
                    </li>
                </c:forEach>

                <%-- Next button --%>
                <c:if test="${currentPage < totalPages}">
                    <li class="page-item">
                        <a href="course?page=${currentPage + 1}${searchKeyword != null ? '&search=' : ''}${searchKeyword != null ? searchKeyword : ''}" class="page-link">Next &raquo;</a>
                    </li>
                </c:if>
            </ul>
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
