<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Create Course Manager</title>
    <link href="${pageContext.request.contextPath}/css/admincss.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
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
        <nav id="sidebar" class="">
            <div class="sidebar-header">
                <h3>Admin Panel</h3>
            </div>
            <ul class="components">
                 <li><a href="${pageContext.request.contextPath}/admin/dashboard"><i class="fas fa-home"></i> Dashboard</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/users"><i class="fas fa-users"></i> User Management</a></li>
                <li class="active"><a href="${pageContext.request.contextPath}/admin/courses"><i class="fas fa-book"></i> Course Management</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/orders"><i class="fas fa-shopping-cart"></i> Order Management</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/revenue-analytics"><i class="fas fa-chart-bar"></i> Revenue Analytics</a></li>
            </ul>
        </nav>
        <div id="content">
            <nav class="navbar navbar-expand-lg">
                <div class="container-fluid">
                    <a class="navbar-brand" href="#">Create Course Manager</a>
                </div>
            </nav>
            <div class="container-fluid py-4">
                <div class="card shadow">
                    <div class="card-header py-3">
                        <h2 class="m-0 font-weight-bold text-center">New Course Manager Account</h2>
                    </div>
                    <div class="card-body">
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

                        <div class="form-container">
                            <h2>Create New Course Manager</h2>
                            <c:if test="${not empty errorMessage}">
                                <p style="color:red;">${errorMessage}</p>
                            </c:if>
                            <form action="${pageContext.request.contextPath}/admin/courses/new" method="post">
                                <div class="form-group">
                                    <label for="username">Username:</label>
                                    <input type="text" id="username" name="username" value="${username}" required>
                                </div>
                                <div class="form-group">
                                    <label for="email">Email:</label>
                                    <input type="email" id="email" name="email" value="${email}" required>
                                </div>
                                <div class="form-group">
                                    <label for="password">Password:</label>
                                    <input type="password" id="password" name="password" required>
                                </div>
                                <div class="form-group">
                                    <label for="firstName">First Name:</label>
                                    <input type="text" id="firstName" name="firstName" value="${firstName}">
                                </div>
                                <div class="form-group">
                                    <label for="lastName">Last Name:</label>
                                    <input type="text" id="lastName" name="lastName" value="${lastName}">
                                </div>
                                <div class="form-group">
                                    <label for="phone">Phone:</label>
                                    <input type="text" id="phone" name="phone" value="${phone}">
                                </div>
                                <div class="form-group">
                                    <label for="role">Role:</label>
                                    <select id="role" name="roleName">
                                        <option value="CourseManager" selected>Course Manager</option>
                                    </select>
                                </div>
                                <div class="form-actions">
                                    <a href="${pageContext.request.contextPath}/admin/courses" class="btn btn-secondary">Cancel</a>
                                    <button type="submit" class="btn btn-primary">Create Account</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html> 