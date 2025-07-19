<%--
  Created by IntelliJ IDEA.
  User: hoang
  Date: 7/18/2025
  Time: 10:32 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<html>
<head>
  <title>Instructor Info</title>
</head>
<body>
  <h2>Instructor Information</h2>
      <c:if test="${not empty instructor}">
        <p><strong>Username:</strong> ${instructor.username}</p>
        <p><strong>Full Name:</strong> ${instructor.fullName}</p>
        <p><strong>Email:</strong> ${instructor.email}</p>
        <p><strong>Phone:</strong> ${instructor.phoneNumber}</p>
          <c:if test="${empty instructor}">
          <p>Instructor not found.</p>
          </c:if>
      </c:if>
      <c:forEach var="course" items="${courses}">
        <div class="course-card">
          <h4>${course.courseID}. ${course.courseTitle}</h4>
          <p>${course.courseDescription}</p>
          <p><strong>Rating:</strong> $${course.rating}</p>
          <p><strong>Price:</strong> $${course.price}</p>
          <p><strong>Status:</strong> ${course.courseStatus}</p>
          <a href="login">
            <button>Join</button>
          </a>
        </div>
      </c:forEach>

</body>
</html>

