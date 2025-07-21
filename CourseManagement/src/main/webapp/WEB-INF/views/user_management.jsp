<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Management</title>
    <link href="${pageContext.request.contextPath}/css/admincss.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        .table-container { padding: 20px; }
        .table-title { margin-bottom: 20px; }
        .table-wrapper {
            background: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }
        .search-form { margin-bottom: 20px; }
    </style>
</head>
<body>
<div class="wrapper">
    <jsp:include page="_admin_sidebar.jsp" />
    <div id="content">
        <nav class="navbar navbar-expand-lg">
            <div class="container-fluid">
                <a class="navbar-brand" href="#">User List</a>
            </div>
        </nav>
        <div class="table-container">
            <div class="search-form">
                <form action="${pageContext.request.contextPath}/admin/user-management" method="get" class="form-inline">
                    <input type="text" name="keyword" class="form-control mr-sm-2" placeholder="Search by name or email" value="${keyword}">
                    <button type="submit" class="btn btn-primary">Search</button>
                </form>
            </div>

            <!-- Students Table -->
            <div class="table-wrapper">
                <h4 class="table-title">Students</h4>
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Username</th>
                            <th>Email</th>
                            <th>Full Name</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${students}" var="student">
                            <tr>
                                <td>${student.id}</td>
                                <td>${student.username}</td>
                                <td>${student.email}</td>
                                <td>${student.firstName} ${student.lastName}</td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/admin/users/edit/${student.id}" class="btn btn-sm btn-warning">Edit</a>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty students}">
                            <tr><td colspan="5">No students found.</td></tr>
                        </c:if>
                    </tbody>
                </table>
            </div>

            <!-- Teachers Table -->
            <div class="table-wrapper mt-4">
                <h4 class="table-title">Teachers</h4>
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Username</th>
                            <th>Email</th>
                            <th>Full Name</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${teachers}" var="teacher">
                            <tr>
                                <td>${teacher.id}</td>
                                <td>${teacher.username}</td>
                                <td>${teacher.email}</td>
                                <td>${teacher.firstName} ${teacher.lastName}</td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/admin/users/edit/${teacher.id}" class="btn btn-sm btn-warning">Edit</a>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty teachers}">
                            <tr><td colspan="5">No teachers found.</td></tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
</body>
</html>
