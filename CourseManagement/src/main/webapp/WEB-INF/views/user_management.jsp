<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Management</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f6f8;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background-color: #ffffff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        h1 {
            margin-top: 0;
        }
        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .search-box input {
            padding: 8px;
            width: 220px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .search-box button {
            padding: 8px 14px;
            margin-left: 5px;
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .search-box button:hover {
            background-color: #2980b9;
        }
        .add-button {
            background-color: #2ecc71;
            color: white;
            padding: 8px 14px;
            text-decoration: none;
            border-radius: 4px;
            border: none;
            font-size: 14px;
        }
        .add-button:hover {
            background-color: #27ae60;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }
        th, td {
            padding: 12px;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f0f0f0;
            font-weight: bold;
        }
        tr:hover {
            background-color: #f9f9f9;
        }
        .section {
            margin-top: 40px;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="top-bar">
        <h1>User Management</h1>
        <a href="addUser.jsp" class="add-button">+ Add New User</a>
    </div>

    <div class="search-box">
        <input type="text" id="searchInput" placeholder="Search users...">
        <button onclick="searchUsers()">Search</button>
    </div>

    <div class="user-list section">
        <h2>Students</h2>
        <table>
            <thead>
            <tr>
                <th>ID</th>
                <th>Username</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${students}" var="student">
                <tr>
                    <td>${student.id}</td>
                    <td>${student.username}</td>
                    <td>${student.email}</td>
                    <td>${student.phoneNumber}</td>
                    <td>Active</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/admin/users/edit/${student.id}" class="btn btn-primary btn-sm">Edit</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <div class="user-list section">
        <h2>Teachers</h2>
        <table>
            <thead>
            <tr>
                <th>ID</th>
                <th>Username</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${teachers}" var="teacher">
                <tr>
                    <td>${teacher.id}</td>
                    <td>${teacher.username}</td>
                    <td>${teacher.email}</td>
                    <td>${teacher.phoneNumber}</td>
                    <td>Active</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/admin/users/edit/${teacher.id}" class="btn btn-primary btn-sm">Edit</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<script>
    function searchUsers() {
        var searchTerm = document.getElementById('searchInput').value;
        window.location.href = "${pageContext.request.contextPath}/admin/user-management?keyword=" + encodeURIComponent(searchTerm);
    }

</script>
</body>
</html>
