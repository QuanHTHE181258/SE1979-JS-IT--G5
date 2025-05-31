<%--
  Created by IntelliJ IDEA.
  User: hoang
  Date: 5/26/2025
  Time: 8:46 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Course List</title>
    <style>
        table {
            border-collapse: collapse;
            width: 100%;
        }
        th, td {
            border: 1px solid black;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
<h1>Course List</h1>

<form method="get" action="course" style="margin-bottom: 20px;">
    <input type="text" name="search" placeholder="Search courses..." value="${param.search}" />
    <button type="submit">Search</button>
</form>

<table border="1">
    <thead>
    <tr>
        <th>Course Code</th>
        <th>Title</th>
        <th>Short Description</th>
        <th>Teacher</th>
        <th>Price</th>
        <th>Duration (Hours)</th>
        <th>Max Students</th>
        <th>Start Date</th>
        <th>End Date</th>
        <th>Action</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="courses" items="${courses}">
        <tr>
            <td>${courses.courseCode}</td>
            <td>${courses.title}</td>
            <td>${courses.shortDescription}</td>
            <td>${courses.teacherUsername}</td>
            <td>${courses.price}</td>
            <td>${courses.durationHours}</td>
            <td>${courses.maxStudents}</td>
            <td>${courses.startDate}</td>
            <td>${courses.endDate}</td>
            <td>
                <c:if test="${not empty sessionScope.currentUser}">
                    <form action="${pageContext.request.contextPath}/enroll" method="post">
                        <input type="hidden" name="userId" value="${sessionScope.currentUser.id}" />
                        <input type="hidden" name="courseId" value="${course.id}" />
                        <button type="submit">Enroll</button>
                    </form>
                </c:if>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
</body>
</html>
