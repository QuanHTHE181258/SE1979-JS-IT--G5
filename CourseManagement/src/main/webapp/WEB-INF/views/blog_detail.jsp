<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Blog Detail</title>
    <link href="${pageContext.request.contextPath}/css/admincss.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        .wrapper { display: flex; }
        #sidebar { min-width: 250px; max-width: 250px; min-height: 100vh; }
        #content { width: 100%; }
        .blog-content { margin-top: 1rem; }
        .blog-meta { color: #6c757d; margin-bottom: 1rem; }
        .blog-image { max-width: 100%; margin: 1rem 0; border-radius: 8px; }
    </style>
</head>
<body>
<div class="wrapper">
    <nav id="sidebar" class="">
        <div class="sidebar-header">
            <h3>Admin Panel</h3>
        </div>
        <ul class="components">
            <li><a href="${pageContext.request.contextPath}/admin/dashboard"><i class="fas fa-home"></i> Dashboard</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/courses"><i class="fas fa-book"></i> Courses</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/orders"><i class="fas fa-shopping-cart"></i> Orders</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/users"><i class="fas fa-users"></i> Users</a></li>
            <li class="active"><a href="${pageContext.request.contextPath}/blog/list"><i class="fas fa-blog"></i> Blog Management</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/revenue-analytics"><i class="fas fa-chart-bar"></i> Revenue Analytics</a></li>
        </ul>
    </nav>
    <div id="content">
        <nav class="navbar navbar-expand-lg">
            <div class="container-fluid">
                <a class="navbar-brand" href="#">Blog Detail</a>
            </div>
        </nav>
        <div class="container-fluid py-4">
            <div class="card shadow">
                <div class="card-header py-3">
                    <h2 class="m-0 font-weight-bold">${blog.title}</h2>
                </div>
                <div class="card-body">
                    <c:if test="${not empty blog}">
                        <div class="blog-meta">
                            <i class="fas fa-user"></i> By <b>${blog.authorID.username}</b> | 
                            <i class="fas fa-calendar"></i> ${blog.createdAt} |
                            <span class="badge bg-${blog.status == 'published' ? 'success' : blog.status == 'draft' ? 'warning' : 'secondary'}">
                                ${blog.status}
                            </span>
                        </div>
                        <c:if test="${not empty blog.imageURL}">
                            <img src="${blog.imageURL}" alt="Blog Image" class="blog-image"/>
                        </c:if>
                        <div class="blog-content">
                            ${blog.content}
                        </div>
                        <div class="mt-3">
                            <c:if test="${sessionScope.loggedInUser != null && sessionScope.loggedInUser.id == blog.authorID.id}">
                                <a href="edit?id=${blog.id}" class="btn btn-warning">
                                    <i class="fas fa-edit"></i> Edit
                                </a>
                            </c:if>
                            <a href="list" class="btn btn-secondary">
                                <i class="fas fa-arrow-left"></i> Back to List
                            </a>
                        </div>
                    </c:if>
                    <c:if test="${empty blog}">
                        <div class="alert alert-warning">Blog not found.</div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html> 