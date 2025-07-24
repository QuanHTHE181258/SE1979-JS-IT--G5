<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Management - Admin</title>
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
                <a href="${pageContext.request.contextPath}/admin"
                   style="color:#fff; text-decoration:none; display:flex; align-items:center; padding:14px 32px;
                   <c:if test='${request.servletPath == "/admin"}'>border-left:5px solid #6a82fb; background:#23272b; font-weight:500;</c:if>">
                    <i class="fas fa-tachometer-alt" style="margin-right:14px;"></i> Dashboard
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/user-management"
                   style="color:#fff; text-decoration:none; display:flex; align-items:center; padding:14px 32px;
                   <c:if test='${request.servletPath == "/admin/user-management"}'>border-left:5px solid #6a82fb; background:#23272b; font-weight:500;</c:if>">
                    <i class="fas fa-users" style="margin-right:14px;"></i> User Management
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/courses"
                   style="color:#fff; text-decoration:none; display:flex; align-items:center; padding:14px 32px;
                   <c:if test='${request.servletPath == "/admin/courses"}'>border-left:5px solid #6a82fb; background:#23272b; font-weight:500;</c:if>">
                    <i class="fas fa-book" style="margin-right:14px;"></i> Courses Management
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/orders"
                   style="color:#fff; text-decoration:none; display:flex; align-items:center; padding:14px 32px;
                   <c:if test='${request.servletPath == "/admin/orders"}'>border-left:5px solid #6a82fb; background:#23272b; font-weight:500;</c:if>">
                    <i class="fas fa-shopping-cart" style="margin-right:14px;"></i> Order Management
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/revenue-analytics"
                   style="color:#fff; text-decoration:none; display:flex; align-items:center; padding:14px 32px;
                   <c:if test='${request.servletPath == "/admin/revenue-analytics"}'>border-left:5px solid #6a82fb; background:#23272b; font-weight:500;</c:if>">
                    <i class="fas fa-chart-bar" style="margin-right:14px;"></i> Revenue Analytics
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/teacher-performance"
                   style="color:#fff; text-decoration:none; display:flex; align-items:center; padding:14px 32px;
                   <c:if test='${request.servletPath == "/teacher-performance"}'>border-left:5px solid #6a82fb; background:#23272b; font-weight:500;</c:if>">
                    <i class="fas fa-chart-line" style="margin-right:14px;"></i> Teacher Performance
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/logout"
                   style="color:#fff; text-decoration:none; display:flex; align-items:center; padding:14px 32px; font-weight:500;">
                    <i class="fas fa-sign-out-alt" style="margin-right:14px;"></i> Logout
                </a>
            </li>
        </ul>
    </nav>
    <!-- Main content -->
    <div style="flex:1; display:flex; flex-direction:column;">
        <!-- Top Navbar -->
        <nav style="background:#fff; box-shadow:0 2px 8px rgba(44,44,84,0.04); padding:18px 48px; display:flex; align-items:center; justify-content:space-between;">
            <div style="font-size:1.4rem; font-weight:700; color:#2c2c54; letter-spacing:1px;">
                Course Management System
            </div>
            <div style="display:flex; align-items:center;">
                <a href="${pageContext.request.contextPath}/admin/profile" style="display:flex; align-items:center; color:#2c2c54; text-decoration:none; margin-right:24px;">
                    <c:choose>
                        <c:when test="${not empty sessionScope.user.avatar.url}">
                            <img src="${pageContext.request.contextPath}/assets/avatar/${sessionScope.user.avatar.url}" style="border-radius:50%; width:36px; height:36px; object-fit:cover;"/>
                        </c:when>
                        <c:otherwise>
                            <img src="${pageContext.request.contextPath}/assets/avatar/default_avatar.png" style="border-radius:50%; width:36px; height:36px; object-fit:cover;"/>
                        </c:otherwise>
                    </c:choose>
                    <span style="margin-left:12px; font-weight:600; font-size:1.1rem;">${sessionScope.user.username}</span>
                </a>
                <a href="${pageContext.request.contextPath}/logout" style="color:#dc3545; border:1.5px solid #dc3545; border-radius:7px; padding:7px 18px; text-decoration:none; font-weight:600; font-size:1rem;">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </a>
            </div>
        </nav>
        <!-- Content -->
        <div style="flex:1; padding:48px 0; background:#f4f6fb;">
            <div style="max-width:900px; margin:auto;">
                <div style="background:#fff; border-radius:22px; box-shadow:0 4px 24px rgba(44,44,84,0.13); padding:40px 48px 48px 48px; margin-bottom:36px;">
                    <h2 style="font-size:2.2rem; font-weight:800; color:#2c2c54; margin-bottom:38px; letter-spacing:1px; text-align:center;">User Management</h2>
                    <!-- Card 1 -->
                    <div style="background:#f5f5fa; border-radius:18px; box-shadow:0 2px 8px rgba(44,44,84,0.08); padding:36px; margin-bottom:36px; display:flex; align-items:center;">
                        <div style="flex-shrink:0;">
                            <i class="fas fa-user-shield" style="font-size:2.7rem; color:#6a82fb; margin-right:36px;"></i>
                        </div>
                        <div>
                            <div style="font-size:1.25rem; font-weight:700; color:#2c2c54;">User Manager</div>
                            <div style="color:#888; margin:10px 0 18px 0; font-size:1.05rem;">Create an account for managing users in the system</div>
                            <a href="${pageContext.request.contextPath}/admin/users/new?role=USER_MANAGER"
                               style="display:inline-block; background:#6a82fb; color:#fff; font-weight:600; padding:12px 28px; border-radius:9px; text-decoration:none; box-shadow:0 2px 8px rgba(44,44,84,0.08); font-size:1rem; transition:background 0.2s;">
                                <i class="fas fa-user-shield"></i> Create User Manager
                            </a>
                        </div>
                    </div>
                    <!-- Card 2 -->
                    <div style="background:#f5f5fa; border-radius:18px; box-shadow:0 2px 8px rgba(44,44,84,0.08); padding:36px; display:flex; align-items:center;">
                        <div style="flex-shrink:0;">
                            <i class="fas fa-users-cog" style="font-size:2.7rem; color:#fc5c7d; margin-right:36px;"></i>
                        </div>
                        <div>
                            <div style="font-size:1.25rem; font-weight:700; color:#2c2c54;">Manage Users</div>
                            <div style="color:#888; margin:10px 0 18px 0; font-size:1.05rem;">Go to the user management interface to manage all users in the system</div>
                            <a href="${pageContext.request.contextPath}/admin/user-management/list"
                               style="display:inline-block; background:#fc5c7d; color:#fff; font-weight:600; padding:12px 28px; border-radius:9px; text-decoration:none; box-shadow:0 2px 8px rgba(44,44,84,0.08); font-size:1rem; transition:background 0.2s;">
                                <i class="fas fa-users-cog"></i> Go to User Management
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>