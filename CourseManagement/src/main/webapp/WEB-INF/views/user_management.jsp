<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Management</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
        }
        .user-list {
            margin-top: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }
        th, td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: left;
        }
        th {
            background-color: #f5f5f5;
        }
        .search-box {
            margin-bottom: 20px;
        }
        .search-box input {
            padding: 5px;
            width: 200px;
        }
        .search-box button {
            padding: 5px 10px;
            margin-left: 5px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>User Management</h1>
        
        <div class="search-box">
            <input type="text" id="searchInput" placeholder="Search users...">
            <button onclick="searchUsers()">Search</button>
        </div>

        <div class="user-list">
            <h2>Students</h2>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Username</th>
                        <th>Email</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${students}" var="student">
                        <tr>
                            <td>${student.id}</td>
                            <td>${student.username}</td>
                            <td>${student.email}</td>
                            <td>${student.isActive ? 'Active' : 'Inactive'}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <h2>Teachers</h2>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Username</th>
                        <th>Email</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${teachers}" var="teacher">
                        <tr>
                            <td>${teacher.id}</td>
                            <td>${teacher.username}</td>
                            <td>${teacher.email}</td>
                            <td>${teacher.isActive ? 'Active' : 'Inactive'}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <script>
        function searchUsers() {
            var searchTerm = document.getElementById('searchInput').value;
            // TODO: Implement search functionality
            console.log('Searching for:', searchTerm);
        }
    </script>
</body>
</html> 