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

        .btn-save {
            background-color: #2ecc71;
            color: white;
            padding: 0.5rem 2rem;
        }

        .btn-cancel {
            background-color: #95a5a6;
            color: white;
            padding: 0.5rem 2rem;
        }
    </style>
</head>
<body>
<c:set var="active" value="users" scope="request"/>
<jsp:include page="/WEB-INF/layout/header.jsp" />
<jsp:include page="/WEB-INF/views/_admin_sidebar.jsp" />

<div class="container mt-4">
    <div class="edit-form">
        <h2 class="form-title">Edit User</h2>

        <form method="POST" action="${pageContext.request.contextPath}/admin/users/edit" id="editUserForm" class="needs-validation" novalidate>
            <input type="hidden" name="userId" value="${user.id}">

            <div class="form-group">
                <label class="form-label">Username</label>
                <input type="text" class="form-control" name="username" value="${user.username}" required
                       pattern="[a-zA-Z0-9_]{3,20}"
                       title="Username must be 3-20 characters and can only contain letters, numbers, and underscore">
                <div class="invalid-feedback">
                    Please enter a valid username (3-20 characters, letters, numbers, underscore only)
                </div>
            </div>

            <div class="form-group">
                <label class="form-label">Email</label>
                <input type="email" class="form-control" name="email" value="${user.email}" required
                       pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$"
                       title="Please enter a valid email address">
                <div class="invalid-feedback">
                    Please enter a valid email address
                </div>
            </div>

            <div class="form-group">
                <label class="form-label">First Name</label>
                <input type="text" class="form-control" name="firstName" value="${user.firstName}"
                       pattern="[A-Za-z\s]{2,50}"
                       title="First name should only contain letters and spaces (2-50 characters)">
                <div class="invalid-feedback">
                    First name should only contain letters (2-50 characters)
                </div>
            </div>

            <div class="form-group">
                <label class="form-label">Last Name</label>
                <input type="text" class="form-control" name="lastName" value="${user.lastName}"
                       pattern="[A-Za-z\s]{2,50}"
                       title="Last name should only contain letters and spaces (2-50 characters)">
                <div class="invalid-feedback">
                    Last name should only contain letters (2-50 characters)
                </div>
            </div>

            <div class="form-group">
                <label class="form-label">Phone Number</label>
                <input type="text" class="form-control" name="phone" value="${user.phoneNumber}"
                       pattern="[0-9]{10,11}"
                       title="Phone number must be 10-11 digits">
                <div class="invalid-feedback">
                    Please enter a valid phone number (10-11 digits)
                </div>
            </div>

            <div class="form-group">
                <label class="form-label">Role</label>
                <select class="form-control" name="roleName" required>
                    <option value="">Select a role</option>
                    <option value="STUDENT" ${user.role.roleName == 'STUDENT' ? 'selected' : ''}>Student</option>
                    <option value="TEACHER" ${user.role.roleName == 'TEACHER' ? 'selected' : ''}>Teacher</option>
                </select>
                <div class="invalid-feedback">
                    Please select a role
                </div>
            </div>

            <div class="form-group">
                <div class="form-check">
                    <input type="checkbox" class="form-check-input" name="isActive" value="true" ${user.active ? 'checked' : ''}>
                    <label class="form-check-label">Active</label>
                </div>
            </div>

            <div class="mt-4 d-flex gap-2 justify-content-end">
                <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-cancel">Cancel</a>
                <button type="submit" class="btn btn-save">Save Changes</button>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    (function() {
        'use strict'
        const form = document.getElementById('editUserForm')

        form.addEventListener('submit', function(event) {
            if (!form.checkValidity()) {
                event.preventDefault()
                event.stopPropagation()
            }

            // Validate email format
            const email = document.querySelector('input[name="email"]')
            if (!email.value.match(/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/)) {
                email.setCustomValidity('Please enter a valid email address')
                event.preventDefault()
            } else {
                email.setCustomValidity('')
            }

            // Validate phone number
            const phone = document.querySelector('input[name="phone"]')
            if (phone.value && !phone.value.match(/^[0-9]{10,11}$/)) {
                phone.setCustomValidity('Phone number must be 10-11 digits')
                event.preventDefault()
            } else {
                phone.setCustomValidity('')
            }

            form.classList.add('was-validated')
        }, false)
    })()
</script>
</body>
</html>
