<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Create Course Manager</title>
    <link href="${pageContext.request.contextPath}/css/admincss.css" rel="stylesheet">
    <style>
        .form-container {
            max-width: 600px;
            margin: 2rem auto;
            padding: 2rem;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        .wrapper {
            display: flex;
        }
        #sidebar {
            min-width: 250px;
            max-width: 250px;
            min-height: 100vh;
        }
        #content {
            width: 100%;
        }
    </style>
</head>
<body>
    <div class="wrapper">
        <nav id="sidebar" class="bg-dark text-white">
            <div class="sidebar-header">
                <h3>Admin Panel</h3>
            </div>
            <ul class="list-unstyled components">
                 <li>
                    <a href="${pageContext.request.contextPath}/admin/dashboard">
                        <i class="fas fa-home"></i> Dashboard
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/admin/users">
                        <i class="fas fa-users"></i> User Management
                    </a>
                </li>
                <li class="active">
                    <a href="${pageContext.request.contextPath}/admin/courses">
                        <i class="fas fa-book"></i> Course Management
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/admin/orders">
                        <i class="fas fa-shopping-cart"></i> Order Management
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/admin/revenue-analytics">
                        <i class="fas fa-chart-bar"></i> Revenue Analytics
                    </a>
                </li>
            </ul>
        </nav>

        <div id="content">
            <nav class="navbar navbar-expand-lg navbar-light bg-light">
                <div class="container-fluid">
                    <a class="navbar-brand" href="#">Create Course Manager</a>
                </div>
            </nav>

            <div class="container-fluid py-4">
                <div class="form-container">
                    <h2 class="text-center mb-4">New Course Manager Account</h2>
                    
                    <%-- Display Error Messages --%>
                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger" role="alert">
                            ${errorMessage}
                        </div>
                    </c:if>

                    <%-- Display Success Messages --%>
                    <c:if test="${not empty successMessage}">
                        <div class="alert alert-success" role="alert">
                            ${successMessage}
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/admin/courses/new" method="POST">
                        <input type="hidden" name="role" value="COURSE_MANAGER">
                        
                        <div class="mb-3">
                            <label for="username" class="form-label">Username</label>
                            <input type="text" class="form-control" id="username" name="username" required>
                        </div>
                        <div class="mb-3">
                            <label for="email" class="form-label">Email</label>
                            <input type="email" class="form-control" id="email" name="email" required>
                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label">Password</label>
                            <input type="password" class="form-control" id="password" name="password" required>
                        </div>
                         <div class="mb-3">
                            <label for="fullName" class="form-label">Full Name</label>
                            <input type="text" class="form-control" id="fullName" name="fullName" required>
                        </div>
                        <div class="text-center">
                            <button type="submit" class="btn btn-primary">Create Account</button>
                            <a href="${pageContext.request.contextPath}/admin/courses" class="btn btn-secondary">Cancel</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html> 