<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Blog List</title>
    <link href="${pageContext.request.contextPath}/css/admincss.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        .wrapper { display: flex; }
        #sidebar { min-width: 250px; max-width: 250px; min-height: 100vh; }
        #content { width: 100%; }
        .table-responsive { margin-top: 1rem; }
        .btn-group { margin-bottom: 1rem; }
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
                <a class="navbar-brand" href="#">Blog Management</a>
            </div>
        </nav>
        <div class="container-fluid py-4">
            <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                <h1 class="h2">Blog List</h1>
                <c:if test="${not empty sessionScope.currentUser && (sessionScope.currentUser.role eq 'INSTRUCTOR' || sessionScope.currentUser.role eq 'ADMIN')}">
                    <a href="create" class="btn btn-primary">
                        <i class="fas fa-plus"></i> Create New Blog
                    </a>
                </c:if>
            </div>
            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead>
                        <tr>
                            <th>Title</th>
                            <th>Author</th>
                            <th>Created At</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="blog" items="${blogList}">
                            <tr>
                                <td>${blog.title}</td>
                                <td>${blog.authorID.username}</td>
                                <td>${blog.createdAt}</td>
                                <td>
                                    <span class="badge bg-${blog.status == 'published' ? 'success' : blog.status == 'draft' ? 'warning' : 'secondary'}">
                                        ${blog.status}
                                    </span>
                                </td>
                                <td>
                                    <a href="detail?id=${blog.id}" class="btn btn-sm btn-info">
                                        <i class="fas fa-eye"></i>
                                    </a>
                                    <c:if test="${sessionScope.currentUser.id == blog.authorID.id || sessionScope.currentUser.role eq 'ADMIN'}">
                                        <a href="edit?id=${blog.id}" class="btn btn-sm btn-warning">
                                            <i class="fas fa-edit"></i>
                                        </a>
                                        <a href="delete?id=${blog.id}" class="btn btn-sm btn-danger" onclick="return confirm('Are you sure you want to delete?')">
                                            <i class="fas fa-trash"></i>
                                        </a>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
</body>
</html> 