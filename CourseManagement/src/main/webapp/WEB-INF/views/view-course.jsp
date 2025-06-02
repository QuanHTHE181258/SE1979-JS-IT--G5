<%--
  Created by IntelliJ IDEA.
  User: hoang
  Date: 5/26/2025
  Time: 8:46 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="project.demo.coursemanagement.utils.SessionUtil" %>
<%@ page import="project.demo.coursemanagement.entities.User" %>
<%@ page import="project.demo.coursemanagement.entities.Course" %>
<%@ page import="project.demo.coursemanagement.dto.CourseDTO" %>
<%@ page import="java.util.List" %>
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
    <input type="text" name="search" placeholder="Search courses..." value="${param.search}"/>
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
    <%
        // Get the list of courses from request attribute
        List<CourseDTO> listCourseDto = (List<CourseDTO>) request.getAttribute("listCourseDto");

        // Get current user once
        User currentUser = SessionUtil.getUserFromSession(request);
        request.setAttribute("currentUser", currentUser);

        if (listCourseDto != null) {
            for (CourseDTO course : listCourseDto) {
    %>
    <tr>
        <td><%= course.getCourseCode() %>
        </td>
        <td><%= course.getTitle() %>
        </td>
        <td><%= course.getShortDescription() %>
        </td>
        <td><%= course.getTeacherUsername() %>
        </td>
        <td><%= course.getPrice() %>
        </td>
        <td><%= course.getDurationHours() %>
        </td>
        <td><%= course.getMaxStudents() %>
        </td>
        <td><%= course.getStartDate() %>
        </td>
        <td><%= course.getEndDate() %>
        </td>
        <td>
            <% if (currentUser != null) { %>
            <form action="<%= request.getContextPath() %>/enrollment" method="post">
                <input type="hidden" name="courseId" value="<%= course.getId() %>"/>
                <button type="submit">Enroll</button>
            </form>
            <% } %>
        </td>
    </tr>
    <%
        } // end for
    } else {
    %>
    <tr>
        <td colspan="10">No courses available.</td>
    </tr>
    <%
        }
    %>
    </tbody>


</table>
</body>
</html>
