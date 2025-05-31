<%@ page contentType="text/html;charset=UTF-8" language="java" import="project.demo.coursemanagement.entities.Course" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>${course.title}</title>
</head>
<body>
<h1>Course Details</h1>

<c:if test="${not empty course}">
    <p><strong>Course Code:</strong> ${course.courseCode}</p>
    <p><strong>Title:</strong> ${course.title}</p>
    <p><strong>Description:</strong> ${course.description}</p>
    <p><strong>Short Description:</strong> ${course.shortDescription}</p>

    <p><strong>Teacher:</strong> ${course.teacher.firstName} ${course.teacher.lastName}</p>
    <p><strong>Category:</strong> ${course.category.name}</p>
    <p><strong>Category:</strong> ${course.category.categoryName}</p> <!-- Assuming Category has getName() -->

    <p><strong>Price:</strong> $${course.price}</p>
    <p><strong>Duration:</strong> ${course.durationHours} hours</p>
    <p><strong>Level:</strong> ${course.level}</p>
    <p><strong>Max Students:</strong> ${course.maxStudents}</p>
    <p><strong>Enrollment Period:</strong> ${course.enrollmentStartDate} to ${course.enrollmentEndDate}</p>
    <p><strong>Course Dates:</strong> ${course.startDate} to ${course.endDate}</p>
</c:if>

<c:if test="${empty course}">
    <p style="color:red;">Course not found.</p>
</c:if>
</body>
</html>
