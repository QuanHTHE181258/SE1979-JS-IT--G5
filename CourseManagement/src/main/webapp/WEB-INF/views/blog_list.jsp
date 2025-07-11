<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Blog List</title>
    <style>
        body {
            background-color: #f8f9fa;
            font-family: Arial, sans-serif;
        }
        .container {
            margin: 40px auto;
            max-width: 1100px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.07);
            padding: 32px 24px;
        }
        h1 {
            font-size: 2rem;
            margin-bottom: 24px;
        }
        .btn {
            display: inline-block;
            padding: 6px 16px;
            border-radius: 4px;
            border: none;
            background: #6a5acd;
            color: #fff;
            text-decoration: none;
            font-size: 1rem;
            margin-bottom: 16px;
            transition: background 0.2s;
        }
        .btn:hover {
            background: #4a3a9a;
        }
        .table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 0;
        }
        .table th, .table td {
            padding: 12px 10px;
            border-bottom: 1px solid #e9ecef;
            text-align: left;
        }
        .table th {
            background: #f1f3f6;
            font-weight: bold;
        }
        .table tr:last-child td {
            border-bottom: none;
        }
        .action-btn {
            margin-right: 6px;
            padding: 4px 10px;
            font-size: 0.95rem;
            border-radius: 3px;
            border: none;
            color: #fff;
            background: #6a5acd;
            text-decoration: none;
            transition: background 0.2s;
        }
        .action-btn.edit { background: #28a745; }
        .action-btn.delete { background: #dc3545; }
        .action-btn:hover { opacity: 0.85; }
        .status {
            padding: 3px 10px;
            border-radius: 12px;
            font-size: 0.95em;
            color: #fff;
        }
        .status.published { background: #28a745; }
        .status.draft { background: #ffc107; color: #333; }
        .status.hidden { background: #6c757d; }
    </style>
</head>
<body>
<div class="container">
    <h1>Blog List</h1>
    <c:if test="${not empty sessionScope.currentUser && (sessionScope.currentUser.role eq 'INSTRUCTOR' || sessionScope.currentUser.role eq 'ADMIN')}">
        <a href="blog/create" class="btn">Create New Blog</a>
    </c:if>
    <table class="table">
        <thead>
            <tr>
                <th>Title</th>
                <th>Author</th>
                <th>Created At</th>
                <th>Status</th>
                <th style="width: 180px;">Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="blog" items="${blogList}">
                <tr>
                    <td>${blog.title}</td>
                    <td>${blog.authorID.username}</td>
                    <td>${blog.createdAt}</td>
                    <td>
                        <span class="status ${blog.status}">
                            ${blog.status}
                        </span>
                    </td>
                    <td>
                        <a href="blog/detail?id=${blog.id}" class="action-btn">View</a>
                        <c:if test="${sessionScope.currentUser.id == blog.authorID.id || sessionScope.currentUser.role eq 'ADMIN'}">
                            <a href="blog/edit?id=${blog.id}" class="action-btn edit">Edit</a>
                            <a href="blog/delete?id=${blog.id}" class="action-btn delete"
                               onclick="return confirm('Are you sure you want to delete?')">Delete</a>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html> 