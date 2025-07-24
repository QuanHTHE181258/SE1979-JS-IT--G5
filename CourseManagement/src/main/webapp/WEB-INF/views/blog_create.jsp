<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Create Blog</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body style="margin:0; font-family: 'Segoe UI', Arial, sans-serif; background: #f4f6fb;">
<div style="display:flex; min-height:100vh;">
    <!-- Sidebar -->
    <nav style="width:250px; background:#343a40; color:#fff; min-height:100vh; display:flex; flex-direction:column;">
        <div style="padding:32px 0 24px 32px;">
            <h3 style="margin:0; font-size:1.7rem; font-weight:700; letter-spacing:1px;">Admin Panel</h3>
        </div>
        <ul style="list-style:none; padding:0; margin:0; flex:1;">
            <li>
                <a href="${pageContext.request.contextPath}/admin" style="color:#fff; text-decoration:none; display:flex; align-items:center; padding:14px 32px;">
                    <i class="fas fa-tachometer-alt" style="margin-right:14px;"></i> Dashboard
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/user-management" style="color:#fff; text-decoration:none; display:flex; align-items:center; padding:14px 32px;">
                    <i class="fas fa-users" style="margin-right:14px;"></i> User Management
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/courses" style="color:#fff; text-decoration:none; display:flex; align-items:center; padding:14px 32px;">
                    <i class="fas fa-book" style="margin-right:14px;"></i> Courses Management
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/orders" style="color:#fff; text-decoration:none; display:flex; align-items:center; padding:14px 32px;">
                    <i class="fas fa-shopping-cart" style="margin-right:14px;"></i> Order Management
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/revenue-analytics" style="color:#fff; text-decoration:none; display:flex; align-items:center; padding:14px 32px;">
                    <i class="fas fa-chart-bar" style="margin-right:14px;"></i> Revenue Analytics
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/teacher-performance" style="color:#fff; text-decoration:none; display:flex; align-items:center; padding:14px 32px;">
                    <i class="fas fa-chart-line" style="margin-right:14px;"></i> Teacher Performance
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/blog/list" style="color:#fff; text-decoration:none; display:flex; align-items:center; padding:14px 32px;">
                    <i class="fas fa-blog" style="margin-right:14px;"></i> Blog Management
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/logout" style="color:#fff; text-decoration:none; display:flex; align-items:center; padding:14px 32px; font-weight:500;">
                    <i class="fas fa-sign-out-alt" style="margin-right:14px;"></i> Logout
                </a>
            </li>
        </ul>
    </nav>
    <!-- Main content -->
    <div style="flex:1; padding:48px 0; background:#f4f6fb;">
        <div style="max-width:900px; margin:auto;">
            <div style="background:#fff; border-radius:22px; box-shadow:0 4px 24px rgba(44,44,84,0.13); padding:40px 48px 48px 48px; margin-bottom:36px;">
                <h2 style="font-size:2.2rem; font-weight:800; color:#2c2c54; margin-bottom:38px; letter-spacing:1px; text-align:center;">Create Blog</h2>
                <c:if test="${not empty error}">
                    <div style="color:red; margin-bottom:20px;">${error}</div>
                </c:if>
                <form action="${pageContext.request.contextPath}/admin/blog/create" method="post" style="max-width:600px; margin:auto;">
                    <div style="margin-bottom:16px;">
                        <label for="title" style="display:block; font-weight:600; margin-bottom:8px;">Title:</label>
                        <input type="text" id="title" name="title" required style="width:100%; padding:8px; border:1px solid #ccc; border-radius:4px;">
                    </div>
                    <div style="margin-bottom:16px;">
                        <label for="content" style="display:block; font-weight:600; margin-bottom:8px;">Content:</label>
                        <textarea id="content" name="content" rows="5" required style="width:100%; padding:8px; border:1px solid #ccc; border-radius:4px;"></textarea>
                    </div>
                    <div style="margin-bottom:16px;">
                        <label for="imageURL" style="display:block; font-weight:600; margin-bottom:8px;">Image URL:</label>
                        <input type="text" id="imageURL" name="imageURL" style="width:100%; padding:8px; border:1px solid #ccc; border-radius:4px;">
                    </div>
                    <div style="margin-bottom:16px;">
                        <label for="status" style="display:block; font-weight:600; margin-bottom:8px;">Status:</label>
                        <select id="status" name="status" style="width:100%; padding:8px; border:1px solid #ccc; border-radius:4px;">
                            <option value="draft">Draft</option>
                            <option value="published">Published</option>
                        </select>
                    </div>
                    <div style="text-align:right;">
                        <button type="submit" class="btn btn-primary" style="background-color:#007bff; color:white; padding:10px 15px; border-radius:4px; border:none;">Create Blog</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html> 