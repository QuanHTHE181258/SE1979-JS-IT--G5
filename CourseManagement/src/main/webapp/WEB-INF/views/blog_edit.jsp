<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Blog</title>
    <link href="${pageContext.request.contextPath}/css/admincss.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        .wrapper { display: flex; }
        #sidebar { min-width: 250px; max-width: 250px; min-height: 100vh; }
        #content { width: 100%; }
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
                <a class="navbar-brand" href="#">Edit Blog</a>
            </div>
        </nav>
        <div class="container-fluid py-4">
            <div class="card shadow">
                <div class="card-header py-3">
                    <h2 class="m-0 font-weight-bold text-center">Edit Blog</h2>
                </div>
                <div class="card-body">
                    <form method="post" action="edit?id=${blog.id}">
                        <div class="mb-3">
                            <label for="title" class="form-label">Title</label>
                            <input type="text" class="form-control" id="title" name="title" value="${blog.title}" required>
                        </div>
                        <div class="mb-3">
                            <label for="content" class="form-label">Content</label>
                            <textarea class="form-control" id="content" name="content" required>${blog.content}</textarea>
                        </div>
                        <div class="mb-3">
                            <label for="imageURL" class="form-label">Image URL</label>
                            <input type="text" class="form-control" id="imageURL" name="imageURL" value="${blog.imageURL}">
                        </div>
                        <div class="mb-3">
                            <label for="status" class="form-label">Status</label>
                            <select class="form-select" id="status" name="status">
                                <option value="published" ${blog.status == 'published' ? 'selected' : ''}>Published</option>
                                <option value="draft" ${blog.status == 'draft' ? 'selected' : ''}>Draft</option>
                                <option value="hidden" ${blog.status == 'hidden' ? 'selected' : ''}>Hidden</option>
                            </select>
                        </div>
                        <div class="text-center">
                            <button type="submit" class="btn btn-primary">Update</button>
                            <a href="list" class="btn btn-secondary">Cancel</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html> 