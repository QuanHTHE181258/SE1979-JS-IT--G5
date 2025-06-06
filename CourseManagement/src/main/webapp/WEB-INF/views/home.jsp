<%--
  Created by IntelliJ IDEA.
  User: hoang
  Date: 5/24/2025
  Time: 9:50 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <title>Course Learning Web</title>
    <link rel="stylesheet" href="css/home-style.css">
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
        <div class="home-header-profile"><a href="profile" style="text-decoration: none; color: white">Profile</a></div>

    </div>
    <%-- Content container --%>
    <div class="home-content">
        <%-- Most Popular Courses --%>
        <div class="home-most-views">
            <h2>Most Popular Courses</h2>
            <ul class="course-list">
                <c:forEach var="course" items="${mostPopularCourses}">
                    <li class="course-card col-3">
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
                                    <fmt:formatDate value="${course.startDateAsDate}" pattern="dd/MM/yyyy" type="date"/>
                                </p>
                                <p><strong>End Date:</strong>
                                    <fmt:formatDate value="${course.endDateAsDate}" pattern="dd/MM/yyyy" type="date"/>
                                </p>
                            </div>
                        </div>
                        <div class="card-footer">
                            <button class="join-btn">JOIN</button>
                        </div>
                    </li>
                </c:forEach>
            </ul>
        </div>
        <%-- Paid Courses --%>
        <div class="home-paid-course">
            <h2>Paid Courses</h2>
            <ul class="course-list">
                <c:forEach var="course" items="${paidCourses}">
                    <li class="course-card col-3">
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
                                    <fmt:formatDate value="${course.startDateAsDate}" pattern="yyyy-MM-dd" type="date" />
                                </p>
                                <p><strong>End Date:</strong>
                                    <fmt:formatDate value="${course.endDateAsDate}" pattern="yyyy-MM-dd" type="date" />
                                </p>
                            </div>
                        </div>
                        <div class="card-footer">
                            <button class="join-btn">JOIN</button>
                        </div>
                    </li>
                </c:forEach>
            </ul>
        </div>
        <%-- Free Courses --%>
        <div class="home-free-course">
            <h2>Free Courses</h2>
            <ul class="course-list">
                <c:forEach var="course" items="${freeCourses}">
                    <li class="course-card col-3">
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
                                    <fmt:formatDate value="${course.startDateAsDate}" pattern="yyyy-MM-dd" type="date" />
                                </p>
                                <p><strong>End Date:</strong>
                                    <fmt:formatDate value="${course.endDateAsDate}" pattern="yyyy-MM-dd" type="date" />
                                </p>
                            </div>
                        </div>
                        <div class="card-footer">
                            <button class="join-btn">JOIN</button>
                        </div>
                    </li>
                </c:forEach>
            </ul>
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