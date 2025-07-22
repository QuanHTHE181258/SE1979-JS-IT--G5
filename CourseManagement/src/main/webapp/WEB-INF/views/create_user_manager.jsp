<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Create New User Manager</title>
    <link href="${pageContext.request.contextPath}/css/admincss.css" rel="stylesheet">
    <style>
        .form-container {
            max-width: 600px;
            margin: 20px auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            background-color: #f9f9f9;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
        }
        .form-group input, .form-group select {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
        }
        .form-actions {
            text-align: right;
        }
        .form-actions .btn {
            padding: 10px 15px;
            border-radius: 4px;
            border: none;
            cursor: pointer;
        }
        .btn-primary {
            background-color: #007bff;
            color: white;
        }
        .btn-secondary {
            background-color: #6c757d;
            color: white;
            margin-right: 10px;
        }
    </style>
</head>
<body>
    <div class="wrapper">
        <!-- Sidebar will be included or copied here if needed -->
        <div id="content">
            <div class="form-container">
                <h2>Create New User</h2>
                <c:if test="${not empty errorMessage}">
                    <p style="color:red;">${errorMessage}</p>
                </c:if>
                <form action="${pageContext.request.contextPath}/admin/users/create" method="post">
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
                            <option value="UserManager" selected>User Manager</option>
                        </select>
                    </div>
                    <div class="form-actions">
                        <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-secondary">Cancel</a>
                        <button type="submit" class="btn btn-primary">Create User</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html> 