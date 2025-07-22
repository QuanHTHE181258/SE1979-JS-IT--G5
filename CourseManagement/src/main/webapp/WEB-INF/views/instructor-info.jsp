<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
  <title>Instructor Info</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      padding: 20px;
    }

    .instructor-info {
      margin-bottom: 30px;
    }

    .course-card {
      border: 1px solid #ccc;
      padding: 16px;
      margin-bottom: 16px;
      border-radius: 8px;
    }

    .join-button {
      display: inline-block;
      background-color: #28a745;
      color: white;
      padding: 8px 12px;
      text-decoration: none;
      border-radius: 4px;
    }

    .pagination {
      display: flex;
      list-style: none;
      padding-left: 0;
      gap: 8px;
    }

    .pagination li {
      display: inline-block;
    }

    .pagination li a {
      display: inline-block;
      padding: 6px 12px;
      border: 1px solid #ccc;
      text-decoration: none;
      color: #333;
    }

    .pagination li.active a {
      background-color: #007bff;
      color: white;
      border-color: #007bff;
    }
  </style>
</head>
<body>

<h2>Instructor Information</h2>

<div class="instructor-info">
  <p><strong>Full Name:</strong> ${instructor.fullName}</p>
  <p><strong>Email:</strong> ${instructor.email}</p>
  <p><strong>Username:</strong> ${instructor.username}</p>
  <p><strong>Phone number:</strong> ${instructor.phoneNumber}</p>
</div>

<h3>Courses Taught by ${instructor.fullName}</h3>

<c:if test="${empty courses}">
  <p>This instructor has no courses.</p>
</c:if>

<c:forEach var="course" items="${courses}">
  <div class="course-card">
    <h4>${course.courseID}. ${course.courseTitle}</h4>
    <p>${course.courseDescription}</p>
    <p><strong>Price:</strong> $${course.price}</p>
    <p><strong>Rating:</strong> ${course.rating}</p>
    <p><strong>Status:</strong> ${course.courseStatus}</p>

    <a href="login.jsp" class="join-button">Join</a>
  </div>
</c:forEach>

<c:if test="${totalPages > 1}">
  <ul class="pagination">
    <c:if test="${currentPage > 1}">
      <li><a href="instructorInfo?username=${instructor.username}&page=${currentPage - 1}">&laquo; Prev</a></li>
    </c:if>

    <c:forEach var="i" begin="1" end="${totalPages}">
      <li class="${i == currentPage ? 'active' : ''}">
        <a href="instructorInfo?username=${instructor.username}&page=${i}">${i}</a>
      </li>
    </c:forEach>

    <c:if test="${currentPage < totalPages}">
      <li><a href="instructorInfo?username=${instructor.username}&page=${currentPage + 1}">Next &raquo;</a></li>
    </c:if>
  </ul>
</c:if>

</body>
</html>
