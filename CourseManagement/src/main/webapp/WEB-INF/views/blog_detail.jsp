<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Blog Detail</title>
    <style>
        body { background: #f8f9fa; font-family: Arial, sans-serif; }
        .container {
            margin: 40px auto; max-width: 800px; background: #fff;
            border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.07); padding: 32px 24px;
        }
        .blog-title { font-size: 2rem; font-weight: bold; margin-bottom: 12px; }
        .blog-meta { color: #888; margin-bottom: 18px; }
        .blog-image { max-width: 100%; margin-bottom: 18px; border-radius: 6px; }
        .blog-content { font-size: 1.1rem; margin-bottom: 24px; }
        .status { padding: 3px 10px; border-radius: 12px; font-size: 0.95em; color: #fff; }
        .status.published { background: #28a745; }
        .status.draft { background: #ffc107; color: #333; }
        .status.hidden { background: #6c757d; }
        .action-btn { margin-right: 8px; padding: 6px 16px; border-radius: 4px; border: none; color: #fff; background: #6a5acd; text-decoration: none; transition: background 0.2s; }
        .action-btn.edit { background: #28a745; }
        .action-btn.delete { background: #dc3545; }
        .action-btn:hover { opacity: 0.85; }
    </style>
</head>
<body>
<div class="container">
    <c:if test="${not empty blog}">
        <div class="blog-title">${blog.title}</div>
        <div class="blog-meta">
            By <b>${blog.authorID.username}</b> | 
            <fmt:formatDate value="${blog.createdAt}" pattern="yyyy-MM-dd HH:mm"/>
            <span class="status ${blog.status}">${blog.status}</span>
        </div>
        <c:if test="${not empty blog.imageURL}">
            <img src="${blog.imageURL}" alt="Blog Image" class="blog-image"/>
        </c:if>
        <div class="blog-content">${blog.content}</div>
        <c:if test="${sessionScope.currentUser.id == blog.authorID.id || sessionScope.currentUser.role eq 'ADMIN'}">
            <a href="edit?id=${blog.id}" class="action-btn edit">Edit</a>
            <a href="delete?id=${blog.id}" class="action-btn delete" onclick="return confirm('Are you sure you want to delete?')">Delete</a>
        </c:if>
    </c:if>
    <c:if test="${empty blog}">
        <div>Blog not found.</div>
    </c:if>
</div>
</body>
</html> 