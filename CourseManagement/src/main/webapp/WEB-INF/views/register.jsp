<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Course Management System</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .register-container {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .register-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            overflow: hidden;
            max-width: 600px;
            width: 100%;
        }

        .register-header {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            color: white;
            padding: 30px;
            text-align: center;
        }

        .register-header h2 {
            margin: 0;
            font-weight: 300;
            font-size: 2rem;
        }

        .register-header p {
            margin: 10px 0 0;
            opacity: 0.9;
            font-size: 0.95rem;
        }

        .register-body {
            padding: 40px 30px;
        }

        .form-floating {
            margin-bottom: 20px;
        }

        .form-control {
            border: 2px solid #e9ecef;
            border-radius: 12px;
            height: 60px;
            font-size: 16px;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            border-color: #4facfe;
            box-shadow: 0 0 0 0.25rem rgba(79, 172, 254, 0.15);
        }

        .form-floating label {
            color: #6c757d;
            font-weight: 500;
        }

        .form-select {
            border: 2px solid #e9ecef;
            border-radius: 12px;
            height: 60px;
            font-size: 16px;
            transition: all 0.3s ease;
        }

        .form-select:focus {
            border-color: #4facfe;
            box-shadow: 0 0 0 0.25rem rgba(79, 172, 254, 0.15);
        }

        .btn-register {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            border: none;
            border-radius: 12px;
            height: 50px;
            font-weight: 600;
            font-size: 16px;
            width: 100%;
            transition: all 0.3s ease;
            color: white;
        }

        .btn-register:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(79, 172, 254, 0.3);
            color: white;
        }

        .btn-register:active {
            transform: translateY(0);
        }

        .alert {
            border-radius: 12px;
            border: none;
            font-weight: 500;
            margin-bottom: 25px;
        }

        .alert-success {
            background: linear-gradient(135deg, #a8edea 0%, #fed6e3 100%);
            color: #155724;
        }

        .alert-danger {
            background: linear-gradient(135deg, #ffecd2 0%, #fcb69f 100%);
            color: #721c24;
        }

        .alert-info {
            background: linear-gradient(135deg, #a8edea 0%, #fed6e3 100%);
            color: #0c5460;
        }

        .form-check {
            margin-bottom: 20px;
        }

        .form-check-input {
            width: 18px;
            height: 18px;
            margin-right: 10px;
        }

        .form-check-label {
            color: #6c757d;
            font-weight: 500;
        }

        .register-footer {
            text-align: center;
            padding: 20px 30px 30px;
            color: #6c757d;
            font-size: 14px;
        }

        .register-footer a {
            color: #4facfe;
            text-decoration: none;
            font-weight: 600;
        }

        .register-footer a:hover {
            text-decoration: underline;
        }

        .password-requirements {
            background: #f8f9fa;
            border-radius: 8px;
            padding: 15px;
            margin-top: 10px;
            font-size: 12px;
            color: #6c757d;
        }

        .password-requirements ul {
            margin: 0;
            padding-left: 20px;
        }

        .two-column {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
        }

        @media (max-width: 768px) {
            .two-column {
                grid-template-columns: 1fr;
            }
        }

        .loading {
            display: none;
        }

        .btn-register.loading .spinner-border {
            display: inline-block;
        }

        .btn-register.loading .btn-text {
            display: none;
        }

        .role-description {
            font-size: 0.8rem;
            color: #6c757d;
            margin-top: 5px;
        }
    </style>
</head>
<body>
<div class="register-container">
    <div class="register-card">
        <!-- Header -->
        <div class="register-header">
            <i class="fas fa-user-plus fa-2x mb-3"></i>
            <h2>Create Account</h2>
            <p>Join Course Management System</p>
        </div>

        <!-- Body -->
        <div class="register-body">
            <!-- Flash Messages -->
            <c:if test="${not empty message}">
                <div class="alert alert-${messageType} alert-dismissible fade show" role="alert">
                    <i class="fas fa-info-circle me-2"></i>
                        ${message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <!-- Error Messages -->
            <c:if test="${not empty errors}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fas fa-exclamation-triangle me-2"></i>
                    <strong>Please fix the following errors:</strong>
                    <ul class="mt-2 mb-0">
                        <c:forEach var="error" items="${errors}">
                            <li>${error}</li>
                        </c:forEach>
                    </ul>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <!-- Registration Form -->
            <form action="${pageContext.request.contextPath}/register" method="post" id="registerForm">
                <!-- Username and Email Row -->
                <div class="two-column">
                    <div class="form-floating">
                        <input type="text"
                               class="form-control"
                               id="username"
                               name="username"
                               placeholder="Username"
                               value="${formData.username}"
                               required
                               pattern="[a-zA-Z0-9_]{3,20}"
                               title="Username must be 3-20 characters, letters, numbers, and underscores only">
                        <label for="username">
                            <i class="fas fa-user me-2"></i>Username
                        </label>
                    </div>

                    <div class="form-floating">
                        <input type="email"
                               class="form-control"
                               id="email"
                               name="email"
                               placeholder="Email"
                               value="${formData.email}"
                               required>
                        <label for="email">
                            <i class="fas fa-envelope me-2"></i>Email Address
                        </label>
                    </div>
                </div>

                <!-- Name Row -->
                <div class="two-column">
                    <div class="form-floating">
                        <input type="text"
                               class="form-control"
                               id="firstName"
                               name="firstName"
                               placeholder="First Name"
                               value="${formData.firstName}"
                               required
                               pattern="[a-zA-ZÀ-ỹ\s]{2,50}"
                               title="First name must be 2-50 characters, letters only">
                        <label for="firstName">
                            <i class="fas fa-id-badge me-2"></i>First Name
                        </label>
                    </div>

                    <div class="form-floating">
                        <input type="text"
                               class="form-control"
                               id="lastName"
                               name="lastName"
                               placeholder="Last Name"
                               value="${formData.lastName}"
                               required
                               pattern="[a-zA-ZÀ-ỹ\s]{2,50}"
                               title="Last name must be 2-50 characters, letters only">
                        <label for="lastName">
                            <i class="fas fa-id-badge me-2"></i>Last Name
                        </label>
                    </div>
                </div>

                <!-- Password Row -->
                <div class="two-column">
                    <div class="form-floating">
                        <input type="password"
                               class="form-control"
                               id="password"
                               name="password"
                               placeholder="Password"
                               required
                               minlength="6">
                        <label for="password">
                            <i class="fas fa-lock me-2"></i>Password
                        </label>
                    </div>

                    <div class="form-floating">
                        <input type="password"
                               class="form-control"
                               id="confirmPassword"
                               name="confirmPassword"
                               placeholder="Confirm Password"
                               required
                               minlength="6">
                        <label for="confirmPassword">
                            <i class="fas fa-lock me-2"></i>Confirm Password
                        </label>
                    </div>
                </div>

                <!-- Password Requirements -->
                <div class="password-requirements">
                    <strong>Password Requirements:</strong>
                    <ul>
                        <li>At least 6 characters long</li>
                        <li>Contains uppercase and lowercase letters</li>
                        <li>Contains at least one number</li>
                        <li>Contains at least one special character (!@#$%^&*)</li>
                    </ul>
                </div>

                <!-- Optional Fields Row -->
                <div class="two-column">
                    <div class="form-floating">
                        <input type="tel"
                               class="form-control"
                               id="phoneNumber"
                               name="phoneNumber"
                               placeholder="Phone Number"
                               value="${formData.phoneNumber}"
                               pattern="[+]?[0-9]{10,15}"
                               title="Phone number must be 10-15 digits">
                        <label for="phoneNumber">
                            <i class="fas fa-phone me-2"></i>Phone (Optional)
                        </label>
                    </div>

                    <div class="form-floating">
                        <input type="date"
                               class="form-control"
                               id="dateOfBirth"
                               name="dateOfBirth"
                               value="${formData.dateOfBirth}"
                               max="2010-01-01">
                        <label for="dateOfBirth">
                            <i class="fas fa-calendar me-2"></i>Date of Birth (Optional)
                        </label>
                    </div>
                </div>

                <!-- Role Selection -->
                <div class="form-floating">
                    <select class="form-select" id="role" name="role" required>
                        <option value="">Choose your role...</option>
                        <c:forEach var="roleOption" items="${roleOptions}">
                            <option value="${roleOption.key}"
                                ${formData.role == roleOption.key ? 'selected' : ''}>
                                    ${roleOption.value}
                            </option>
                        </c:forEach>
                    </select>
                    <label for="role">
                        <i class="fas fa-user-tag me-2"></i>I am a...
                    </label>
                </div>

                <div class="role-description" id="roleDescription">
                    Select your role to see description
                </div>

                <!-- Terms and Newsletter -->
                <div class="form-check">
                    <input class="form-check-input"
                           type="checkbox"
                           id="agreeToTerms"
                           name="agreeToTerms"
                           required>
                    <label class="form-check-label" for="agreeToTerms">
                        <i class="fas fa-check-circle me-1"></i>
                        I agree to the <a href="#" target="_blank">Terms and Conditions</a>
                        and <a href="#" target="_blank">Privacy Policy</a>
                    </label>
                </div>

                <div class="form-check">
                    <input class="form-check-input"
                           type="checkbox"
                           id="subscribeNewsletter"
                           name="subscribeNewsletter">
                    <label class="form-check-label" for="subscribeNewsletter">
                        <i class="fas fa-envelope me-1"></i>
                        Subscribe to our newsletter for updates and course announcements
                    </label>
                </div>

                <!-- Submit Button -->
                <button type="submit" class="btn btn-register" id="registerBtn">
                        <span class="spinner-border spinner-border-sm loading" role="status">
                            <span class="visually-hidden">Loading...</span>
                        </span>
                    <span class="btn-text">
                            <i class="fas fa-user-plus me-2"></i>Create Account
                        </span>
                </button>
            </form>
        </div>

        <!-- Footer -->
        <div class="register-footer">
            <p>Already have an account? <a href="${pageContext.request.contextPath}/login">Sign In</a></p>
            <p class="mb-0">&copy; 2024 Course Management System</p>
        </div>
    </div>
</div>

<!-- Scripts -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
<script>
    // Role descriptions
    const roleDescriptions = {
        'USER': 'As a Student, you can enroll in courses, access learning materials, submit assignments, and track your progress.',
        'TEACHER': 'As a Teacher, you can create courses, manage students, upload materials, create assignments, and grade submissions.'
    };

    // Update role description
    document.getElementById('role').addEventListener('change', function() {
        const description = document.getElementById('roleDescription');
        const selectedRole = this.value;

        if (selectedRole && roleDescriptions[selectedRole]) {
            description.textContent = roleDescriptions[selectedRole];
            description.style.display = 'block';
        } else {
            description.style.display = 'none';
        }
    });

    // Form validation and submission
    document.getElementById('registerForm').addEventListener('submit', function(e) {
        const password = document.getElementById('password').value;
        const confirmPassword = document.getElementById('confirmPassword').value;
        const agreeToTerms = document.getElementById('agreeToTerms').checked;
        const registerBtn = document.getElementById('registerBtn');

        // Password match validation
        if (password !== confirmPassword) {
            e.preventDefault();
            showAlert('Passwords do not match', 'danger');
            return;
        }

        // Terms validation
        if (!agreeToTerms) {
            e.preventDefault();
            showAlert('You must agree to the Terms and Conditions', 'danger');
            return;
        }

        // Show loading state
        registerBtn.classList.add('loading');
        registerBtn.disabled = true;

        // Re-enable button after 15 seconds (fallback)
        setTimeout(() => {
            registerBtn.classList.remove('loading');
            registerBtn.disabled = false;
        }, 15000);
    });

    // Password strength indicator
    document.getElementById('password').addEventListener('input', function() {
        const password = this.value;
        // Could add password strength indicator here
    });

    // Show alert function
    function showAlert(message, type) {
        const alertDiv = document.createElement('div');
        alertDiv.className = `alert alert-${type} alert-dismissible fade show`;
        alertDiv.innerHTML = `
                <i class="fas fa-exclamation-triangle me-2"></i>
                ${message}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            `;

        const form = document.getElementById('registerForm');
        form.parentNode.insertBefore(alertDiv, form);

        // Auto dismiss after 5 seconds
        setTimeout(() => {
            alertDiv.remove();
        }, 5000);
    }

    // Auto-focus on first input
    document.getElementById('username').focus();

    // Real-time username validation
    document.getElementById('username').addEventListener('blur', function() {
        const username = this.value;
        if (username.length >= 3) {
            // Could add AJAX call to check username availability
        }
    });

    // Real-time email validation
    document.getElementById('email').addEventListener('blur', function() {
        const email = this.value;
        if (email.includes('@')) {
            // Could add AJAX call to check email availability
        }
    });
</script>
</body>
</html>
