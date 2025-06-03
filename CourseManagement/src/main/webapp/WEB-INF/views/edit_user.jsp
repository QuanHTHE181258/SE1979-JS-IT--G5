<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><c:choose><c:when test="${not empty user}">Edit User</c:when><c:otherwise>Create New User</c:otherwise></c:choose></title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f6f8;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background-color: #ffffff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        h1 {
            margin-top: 0;
            text-align: center;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        .form-group input[type="text"],
        .form-group input[type="email"],
        .form-group select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box; /* Include padding and border in the element's total width and height */
        }
        .form-actions {
            margin-top: 20px;
            text-align: right;
        }
        .btn {
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        .btn-primary {
            background-color: #007bff;
            color: white;
        }
        .btn-primary:hover {
            background-color: #0056b3;
        }
        .btn-secondary {
            background-color: #6c757d;
            color: white;
            margin-right: 5px;
        }
        .btn-secondary:hover {
            background-color: #545b62;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1><c:choose><c:when test="${not empty user}">Edit User</c:when><c:otherwise>Create New User</c:otherwise></c:choose></h1>
        <c:if test="${not empty errorMessage}">
            <p style="color: red;">${errorMessage}</p>
        </c:if>
        <form action="${pageContext.request.contextPath}/admin/users/<c:choose><c:when test="${not empty user}">update</c:when><c:otherwise>create</c:otherwise></c:choose>" method="post">
            <c:if test="${not empty user}">
                <input type="hidden" name="userId" value="${user.id}">
            </c:if>
            
            <div class="form-group">
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" value="${user.username}" required>
            </div>
            
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" value="${user.email}" required>
            </div>
            
            <c:if test="${empty user}">
                <div class="form-group">
                    <label for="password">Password:</label>
                    <input type="password" id="password" name="password" required>
                </div>
            </c:if>
            
            <div class="form-group">
                <label for="firstName">First Name:</label>
                <input type="text" id="firstName" name="firstName" value="${user.firstName}">
            </div>
            
            <div class="form-group">
                <label for="lastName">Last Name:</label>
                <input type="text" id="lastName" name="lastName" value="${user.lastName}">
            </div>
            
            <div class="form-group">
                <label for="phone">Phone:</label>
                <input type="text" id="phone" name="phone" value="${user.phone}">
            </div>
            
            <div class="form-group">
                <label for="role">Role:</label>
                <select id="role" name="roleName">
                    <c:forEach items="${roles}" var="role">
                        <c:choose>
                            <c:when test="${not empty user}">
                                <%-- When editing, only allow selecting USER or TEACHER --%>
                                <c:if test="${role.roleName == 'USER' || role.roleName == 'TEACHER'}">
                                    <option value="${role.roleName}" ${user.role.roleName == role.roleName ? 'selected' : ''}>${role.roleName}</option>
                                </c:if>
                            </c:when>
                            <c:otherwise>
                                <%-- When creating, allow selecting any role, default to roleName from request --%>
                                <%-- Filter to only show USER_MANAGER when creating --%>
                                <c:if test="${role.roleName == 'USER_MANAGER'}">
                                    <option value="${role.roleName}" ${roleName == role.roleName ? 'selected' : ''}>${role.roleName}</option>
                                </c:if>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </select>
            </div>
            
            <div class="form-group">
                <label for="isActive">Is Active:</label>
                <select id="isActive" name="isActive">
                    <option value="true" <c:if test="${empty user || user.isActive}">selected</c:if>>Yes</option>
                    <option value="false" <c:if test="${not empty user && !user.isActive}">selected</c:if>>No</option>
                </select>
            </div>
            
            <div class="form-actions">
                <a href="${pageContext.request.contextPath}/admin/user-management" class="btn btn-secondary">Cancel</a>
                <button type="submit" class="btn btn-primary"><c:choose><c:when test="${not empty user}">Save Changes</c:when><c:otherwise>Create User</c:otherwise></c:choose></button>
            </div>
        </form>
    </div>
</body>
</html> 