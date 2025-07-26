<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/layout/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Management - Admin</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background: #f4f6fb;
        }

        .wrapper {
            display: flex;
            min-height: 100vh;
        }

        .main-content {
            flex: 1;
            margin-left: 280px;
            padding: 2rem;
        }

        .content-box {
            background: #fff;
            border-radius: 10px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .card {
            background: #f8f9fa;
            border-radius: 8px;
            padding: 1.5rem;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 1.5rem;
        }

        .card-icon {
            font-size: 2rem;
            color: #4a90e2;
        }

        .card-content h3 {
            font-size: 1.2rem;
            margin-bottom: 0.5rem;
        }

        .btn {
            display: inline-block;
            padding: 0.5rem 1rem;
            background: #4a90e2;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            margin-top: 1rem;
        }

        @media (max-width: 768px) {
            .main-content {
                margin-left: 0;
                padding: 1rem;
            }
        }
    </style>
</head>
<body>
<!-- Include admin sidebar -->
<jsp:include page="_admin_sidebar.jsp" />

<div class="wrapper">
    <div class="main-content">
        <div class="content-box">
            <h2 style="margin-bottom: 2rem; text-align: center;">User Management</h2>

            <!-- Create User Manager Card -->
            <div class="card">
                <div class="card-icon">
                    <i class="fas fa-user-shield"></i>
                </div>
                <div class="card-content">
                    <h3>User Manager</h3>
                    <p>Create an account for managing users in the system</p>
                    <a href="${pageContext.request.contextPath}/admin/users/new?role=USER_MANAGER" class="btn">
                        <i class="fas fa-plus"></i> Create User Manager
                    </a>
                </div>
            </div>

            <!-- Manage Users Card -->
            <div class="card">
                <div class="card-icon">
                    <i class="fas fa-users-cog"></i>
                </div>
                <div class="card-content">
                    <h3>Manage Users</h3>
                    <p>View and manage all users in the system</p>
                    <a href="${pageContext.request.contextPath}/admin/user-management/list" class="btn">
                        <i class="fas fa-users"></i> View All Users
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>