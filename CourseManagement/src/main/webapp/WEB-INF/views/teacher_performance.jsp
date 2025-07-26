<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/layout/header.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Teacher Performance</title>
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
                <h2 style="font-size:2.2rem; font-weight:800; color:#2c2c54; margin-bottom:38px; letter-spacing:1px; text-align:center;">Teacher Performance</h2>
                <c:forEach var="performance" items="${performanceList}">
                    <div style="background:#f5f5fa; border-radius:18px; box-shadow:0 2px 8px rgba(44,44,84,0.08); padding:36px; margin-bottom:36px;">
                        <h3 style="font-size:1.5rem; font-weight:700; color:#2c2c54;">${performance.teacherName}</h3>
                        <p style="color:#888; margin:10px 0 18px 0; font-size:1.05rem;">Courses Taught: ${performance.coursesTaught}</p>
                        <p style="color:#888; margin:10px 0 18px 0; font-size:1.05rem;">Average Rating: ${performance.averageRating}</p>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>
</body>
</html> 