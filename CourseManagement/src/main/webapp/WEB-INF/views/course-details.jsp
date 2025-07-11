<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Course Details</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-RvQxD1xVB3LHsb6sSrFyeCxoUAREci8hPbgGacXRKrKaQjgr3+0pmSOriBGobgoa6qX3OyUrqGzivfqvbtvU6FQ==">
    <link rel="stylesheet" href="css/course-details-style.css">
    <meta charset="UTF-8">
</head>
<body>
<div class="home-header">
    <div class="home-header-logo"><a href="home" style="text-decoration: none; color: white">Courses Learning Web</a></div>
    <div class="home-header-courses"><a href="course" style="text-decoration: none; color: white">Courses</a></div>
    <div class="home-header-searchbar">
        <input type="text" placeholder="Search..." class="search-input" name="search">
        <span class="search-icon"><i class="fas fa-search"></i></span>
    </div>
    <div class="home-header-login"><a href="login" style="text-decoration: none; color: white">Login</a></div>
    <div class="home-header-register"><a href="register" style="text-decoration: none; color: white">Register</a></div>
</div>

<div class="course-detail-container">
    <c:if test="${not empty error}">
        <div class="alert alert-error">${error}</div>
    </c:if>

    <c:choose>
        <c:when test="${not empty course}">
            <h2>${course.courseTitle}</h2>
            <p><strong>Description:</strong> ${course.courseDescription}</p>
            <p><strong>Price:</strong> $<fmt:formatNumber value="${course.price}" type="number" maxFractionDigits="2"/></p>
            <p><strong>Rating:</strong> ${course.rating}</p>
            <p><strong>Teacher:</strong> <a href="instructorInfo">${course.teacherName}</a></p>
            <c:if test="${not empty course.categories}">
                <p><strong>Categories:</strong> ${course.categories}</p>
            </c:if>
            <c:if test="${not empty course.courseStatus}">
                <p><strong>Status:</strong> ${course.courseStatus}</p>
            </c:if>
            <c:set var="createdAtInstant" value="${course.createdAt}" />
            <fmt:parseDate value="${createdAtInstant}" pattern="yyyy-MM-dd'T'HH:mm:ss.SSSX" var="parsedDate" type="both" />
            <p><strong>Created At:</strong> <fmt:formatDate value="${parsedDate}" pattern="HH:mm dd-MM-yyyy"/></p>
            <div class="card-footer">
                <a href="login">
                    <button class="join-btn">JOIN</button>
                </a>
            </div>

            <!-- Danh sách Lessons -->
            <div class="lessons-section">
                <h3>Lessons</h3>
                <c:choose>
                    <c:when test="${not empty lessons and not empty lessons}">
                        <ul class="lesson-list">
                            <c:forEach var="lesson" items="${lessons}">
                                <li class="lesson-item">
                                    <strong> Title:</strong> ${lesson.title}
                                    <c:if test="${not empty lesson.status}">
                                        <span class="lesson-status"> (Status: ${lesson.status})</span>
                                    </c:if>
                                    <c:if test="${lesson.isFreePreview}">
                                        <span class="lesson-preview"> (Free Preview)</span>
                                    </c:if>
                                    <br>
                                    <c:set var="lessonCreatedAt" value="${lesson.createdAt}" />
                                    <fmt:parseDate value="${lessonCreatedAt}" pattern="yyyy-MM-dd'T'HH:mm:ss.SSSX" var="parsedLessonDate" type="both" />
                                    <small><strong>Created:</strong> <fmt:formatDate value="${parsedLessonDate}" pattern="HH:mm dd-MM-yyyy"/></small>
                                </li>
                            </c:forEach>
                        </ul>
                    </c:when>
                    <c:otherwise>
                        <p class="no-data">No lessons available for this course.</p>
                    </c:otherwise>
                </c:choose>
            </div>
            <!-- Danh sách Feedbacks -->
            <div class="feedbacks-section">
                <h3>Feedbacks</h3>
                <c:choose>
                    <c:when test="${not empty feedbacks and not empty feedbacks}">
                        <ul class="feedback-list">
                            <c:forEach var="feedback" items="${feedbacks}">
                                <li class="feedback-item">
                                    <strong>User:</strong> ${feedback.userName}
                                    <c:if test="${not empty feedback.rating}">
                                        <span class="feedback-rating"> (Rating: ${feedback.rating}/5)</span>
                                    </c:if>
                                    <br>
                                    <c:if test="${not empty feedback.comment}">
                                        <span class="feedback-comment">${feedback.comment}</span>
                                    </c:if>
                                    <br>
                                    <c:set var="feedbackCreatedAt" value="${feedback.createdAt}" />
                                    <fmt:parseDate value="${feedbackCreatedAt}" pattern="yyyy-MM-dd'T'HH:mm:ss.SSSX" var="parsedFeedbackDate" type="both" />
                                    <small><strong>Created:</strong> <fmt:formatDate value="${parsedFeedbackDate}" pattern="HH:mm dd-MM-yyyy"/></small>
                                </li>
                            </c:forEach>
                        </ul>
                    </c:when>
                    <c:otherwise>
                        <p class="no-data">No feedbacks available for this course.</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </c:when>
        <c:otherwise>
            <p class="no-data">No course data available.</p>
        </c:otherwise>
    </c:choose>
</div>

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