<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Create User Manager</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .create-form {
            max-width: 600px;
            margin: 2rem auto;
            padding: 2rem;
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .form-title {
            color: #2c3e50;
            margin-bottom: 1.5rem;
            padding-bottom: 0.5rem;
            border-bottom: 2px solid #3498db;
        }
        .form-group {
            margin-bottom: 1rem;
        }
        .form-label {
            font-weight: 500;
            color: #2c3e50;
        }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/layout/header.jsp" />
<jsp:include page="/WEB-INF/views/_admin_sidebar.jsp" />
<div class="container mt-4">
    <div class="create-form">
        <h2 class="form-title">Create User Manager</h2>

        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger">${errorMessage}</div>
        </c:if>

        <form method="POST" action="${pageContext.request.contextPath}/admin/users/create" id="createUserForm">
            <input type="hidden" name="roleName" value="Course Manager">

            <div class="form-group">
                <label class="form-label">Username*</label>
                <input type="text" class="form-control" name="username" value="${username}" required
                       pattern="[a-zA-Z0-9_]{3,20}"
                       title="Username must be between 3-20 characters and can only contain letters, numbers and underscore">
            </div>

            <div class="form-group">
                <label class="form-label">Email*</label>
                <input type="email" class="form-control" name="email" value="${email}" required>
            </div>

            <div class="form-group">
                <label class="form-label">Password*</label>
                <input type="password" class="form-control" name="password"
                       title="Password must be at least 8 characters long and contain at least one letter and one number">
            </div>

            <div class="form-group">
                <label class="form-label">Confirm Password*</label>
                <input type="password" class="form-control" name="confirmPassword" required>
            </div>

            <div class="form-group">
                <label class="form-label">First Name</label>
                <input type="text" class="form-control" name="firstName" value="${firstName}">
            </div>

            <div class="form-group">
                <label class="form-label">Last Name</label>
                <input type="text" class="form-control" name="lastName" value="${lastName}">
            </div>

            <div class="form-group">
                <label class="form-label">Phone Number</label>
                <input type="tel" class="form-control" name="phone" value="${phone}"
                       pattern="[0-9]{10,11}" title="Phone number must be 10-11 digits">
            </div>

            <div class="mt-4 d-flex gap-2 justify-content-end">
                <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-secondary">Cancel</a>
                <button type="submit" class="btn btn-primary">Create User Manager</button>
            </div>
        </form>
    </div>
</div>

<script>
    document.getElementById('createUserForm').addEventListener('submit', function(e) {
        var password = document.querySelector('input[name="password"]').value;
        var confirmPassword = document.querySelector('input[name="confirmPassword"]').value;

        if (password !== confirmPassword) {
            e.preventDefault();
            alert('Passwords do not match!');
        }
    });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
