<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Create Course Manager</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #3498db;
            --danger-color: #e74c3c;
            --success-color: #2ecc71;
            --warning-color: #f1c40f;
            --dark-color: #2c3e50;
            --light-color: #ecf0f1;
            --sidebar-width: 280px;
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
            margin-left: var(--sidebar-width);
            padding: 2rem;
        }

        .content-header {
            margin-bottom: 2rem;
            padding: 1rem;
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .form-container {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            padding: 2rem;
            max-width: 800px;
            margin: 0 auto;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-label {
            font-weight: 600;
            color: var(--dark-color);
            margin-bottom: 0.5rem;
        }

        .form-control {
            border: 1px solid #e1e1e1;
            border-radius: 5px;
            padding: 0.75rem 1rem;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(52, 152, 219, 0.25);
        }

        .btn-submit {
            background: var(--primary-color);
            color: white;
            padding: 0.75rem 2rem;
            border: none;
            border-radius: 5px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-submit:hover {
            background: #2980b9;
            transform: translateY(-2px);
        }

        .btn-back {
            background: #95a5a6;
            color: white;
            padding: 0.75rem 2rem;
            border: none;
            border-radius: 5px;
            font-weight: 600;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
        }

        .btn-back:hover {
            background: #7f8c8d;
            transform: translateY(-2px);
            color: white;
        }

        .form-title {
            color: var(--dark-color);
            margin-bottom: 2rem;
            text-align: center;
        }

        .error-message {
            color: var(--danger-color);
            background: #fde8e8;
            padding: 1rem;
            border-radius: 5px;
            margin-bottom: 1.5rem;
            font-size: 0.9rem;
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
<c:set var="active" value="courses" scope="request"/>
<%@ include file="/WEB-INF/layout/header.jsp" %>
<%@ include file="_admin_sidebar.jsp" %>

<div class="wrapper">
    <div class="main-content">
        <div class="content-header">
            <h1 class="h3 mb-0">Create Course Manager</h1>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin">Dashboard</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/courses">Course Management</a></li>
                    <li class="breadcrumb-item active">Create Manager</li>
                </ol>
            </nav>
        </div>

        <div class="form-container">
            <h2 class="form-title">Create Course Manager Account</h2>

            <c:if test="${not empty errorMessage}">
                <div class="error-message">
                    <i class="fas fa-exclamation-circle me-2"></i>${errorMessage}
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/admin/courses/new" method="POST" id="courseManagerForm" novalidate>
                <input type="hidden" name="roleName" value="Course Manager">

                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="form-label" for="username">Username</label>
                            <input type="text" class="form-control" id="username" name="username" required
                                   pattern="[a-zA-Z0-9_]{3,20}"
                                   title="Username must be 3-20 characters and can only contain letters, numbers, and underscore">
                            <div class="invalid-feedback">
                                Please enter a valid username (3-20 characters, letters, numbers, underscore only)
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="form-label" for="email">Email</label>
                            <input type="email" class="form-control" id="email" name="email" required
                                   pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$"
                                   title="Please enter a valid email address">
                            <div class="invalid-feedback">
                                Please enter a valid email address
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="form-label" for="firstName">First Name</label>
                            <input type="text" class="form-control" id="firstName" name="firstName" required
                                   pattern="[A-Za-z\s]{2,50}"
                                   title="First name should only contain letters and spaces (2-50 characters)">
                            <div class="invalid-feedback">
                                Please enter a valid first name (2-50 characters, letters only)
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="form-label" for="lastName">Last Name</label>
                            <input type="text" class="form-control" id="lastName" name="lastName" required
                                   pattern="[A-Za-z\s]{2,50}"
                                   title="Last name should only contain letters and spaces (2-50 characters)">
                            <div class="invalid-feedback">
                                Please enter a valid last name (2-50 characters, letters only)
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="form-label" for="password">Password</label>
                            <input type="password" class="form-control" id="password" name="password" required
                                   pattern="^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$"
                                   title="Password must be at least 8 characters long and contain at least one letter and one number">
                            <div class="invalid-feedback">
                                Password must be at least 8 characters with at least one letter and one number
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="form-label" for="phone">Phone Number</label>
                            <input type="tel" class="form-control" id="phone" name="phone" required
                                   pattern="[0-9]{10,11}"
                                   title="Phone number must be 10-11 digits">
                            <div class="invalid-feedback">
                                Please enter a valid phone number (10-11 digits)
                            </div>
                        </div>
                    </div>
                </div>

                <div class="text-center mt-4">
                    <a href="${pageContext.request.contextPath}/admin/courses" class="btn-back me-2">
                        <i class="fas fa-arrow-left me-2"></i>Back
                    </a>
                    <button type="submit" class="btn-submit">
                        <i class="fas fa-user-plus me-2"></i>Create Account
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    (function () {
        'use strict'

        const form = document.getElementById('courseManagerForm')

        form.addEventListener('submit', function (event) {
            if (!form.checkValidity()) {
                event.preventDefault()
                event.stopPropagation()
            }

            // Custom password validation
            const password = document.getElementById('password')
            if (password.value.length < 8 ||
                !/[A-Za-z]/.test(password.value) ||
                !/[0-9]/.test(password.value)) {
                password.setCustomValidity('Password requirements not met')
                event.preventDefault()
            } else {
                password.setCustomValidity('')
            }

            form.classList.add('was-validated')
        }, false)
    })()
</script>
</body>
</html>
