<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit User</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .edit-form {
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
<div class="container mt-4">
    <div class="edit-form">
        <h2 class="form-title">Edit User</h2>

        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>

        <form method="POST" action="${pageContext.request.contextPath}/admin/users/edit">
            <input type="hidden" name="userId" value="${user.id}">

            <div class="form-group">
                <label class="form-label">Username</label>
                <input type="text" class="form-control" name="username" value="${user.username}" required>
            </div>

            <div class="form-group">
                <label class="form-label">Email</label>
                <input type="email" class="form-control" name="email" value="${user.email}" required>
            </div>

            <div class="form-group">
                <label class="form-label">First Name</label>
                <input type="text" class="form-control" name="firstName" value="${user.firstName}">
            </div>

            <div class="form-group">
                <label class="form-label">Last Name</label>
                <input type="text" class="form-control" name="lastName" value="${user.lastName}">
            </div>

            <div class="form-group">
                <label class="form-label">Phone Number</label>
                <input type="text" class="form-control" name="phoneNumber" value="${user.phoneNumber}">
            </div>

            <div class="mt-4 d-flex gap-2 justify-content-end">
                <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-secondary">Cancel</a>
                <button type="submit" class="btn btn-primary">Save Changes</button>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
