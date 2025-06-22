<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Course Details</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-RvQxD1xVB3LHsb6sSrFyeCxoUAREci8hPbgGacXRKrKaQjgr3+0pmSOriBGobgoa6qX3OyUrqGzivfqvbtvU6FQ==">
    <link rel="stylesheet" href="css/course-catalog-style.css">
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
            <p><strong>Teacher:</strong> ${course.teacherName}</p>
            <c:if test="${not empty course.categories}">
                <p><strong>Categories:</strong> ${course.categories}</p>
            </c:if>
            <c:if test="${not empty course.courseStatus}">
                <p><strong>Status:</strong> ${course.courseStatus}</p>
            </c:if>
            <c:set var="createdAtInstant" value="${course.createdAt}" />
            <fmt:parseDate value="${createdAtInstant}" pattern="yyyy-MM-dd'T'HH:mm:ss.SSSX" var="parsedDate" type="both" />
            <p><strong>Created At:</strong> <fmt:formatDate value="${parsedDate}" pattern="HH:mm dd-MM-yyyy"/></p>
        </c:when>
        <c:otherwise>
            <p class="no-data">No course data available.</p>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>