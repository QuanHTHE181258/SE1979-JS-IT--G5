<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/layout/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Ký - Hệ Thống Quản Lý Khóa Học</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            /* Purple Gradient Theme */
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --primary-500: #667eea;
            --primary-600: #5a69d4;
            --primary-50: #f3f1ff;
            --bg-primary: #ffffff;
            --bg-secondary: #f8f9fa;
            --text-primary: #2c3e50;
            --text-secondary: #6c757d;
            --text-white: #ffffff;
            --success: #28a745;
            --error: #dc3545;
            --border-light: #e9ecef;
            --shadow-light: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            --shadow-medium: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
            --focus-ring: rgba(102, 126, 234, 0.25);
            --transition-medium: all 0.3s ease-in-out;
        }

        body {
            background: var(--bg-primary);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .register-container {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            background: var(--bg-secondary);
        }

        .register-card {
            background: var(--bg-primary);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: var(--shadow-medium);
            border: 1px solid var(--border-light);
            overflow: hidden;
            max-width: 600px;
            width: 100%;
        }

        .register-header {
            background: var(--primary-gradient);
            color: var(--text-white);
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

        .form-control {
            border: 2px solid var(--border-light);
            border-radius: 12px;
            height: 60px;
            font-size: 16px;
            transition: var(--transition-medium);
        }

        .form-control:focus {
            border-color: var(--primary-500);
            box-shadow: 0 0 0 0.25rem var(--focus-ring);
        }

        .form-floating label {
            color: var(--text-secondary);
            font-weight: 500;
        }

        .form-select {
            border: 2px solid var(--border-light);
            border-radius: 12px;
            height: 60px;
            font-size: 16px;
            transition: var(--transition-medium);
        }

        .form-select:focus {
            border-color: var(--primary-500);
            box-shadow: 0 0 0 0.25rem var(--focus-ring);
        }

        .btn-register {
            background: var(--primary-gradient);
            border: none;
            border-radius: 12px;
            height: 50px;
            font-weight: 600;
            font-size: 16px;
            width: 100%;
            transition: var(--transition-medium);
            color: var(--text-white);
        }

        .btn-register:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.3);
            color: var(--text-white);
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
            background: rgba(40, 167, 69, 0.1);
            border-left: 4px solid var(--success);
            color: var(--success);
        }

        .alert-danger {
            background: rgba(220, 53, 69, 0.1);
            border-left: 4px solid var(--error);
            color: var(--error);
        }

        .alert-info {
            background: var(--primary-50);
            border-left: 4px solid var(--primary-500);
            color: var(--primary-600);
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
            color: var(--text-secondary);
            font-weight: 500;
        }

        .form-check-label a {
            color: var(--primary-500);
            text-decoration: none;
        }

        .form-check-label a:hover {
            color: var(--primary-600);
            text-decoration: underline;
        }

        .register-footer {
            text-align: center;
            padding: 20px 30px 30px;
            color: var(--text-secondary);
            font-size: 14px;
        }

        .register-footer a {
            color: var(--primary-500);
            text-decoration: none;
            font-weight: 600;
        }

        .register-footer a:hover {
            text-decoration: underline;
            color: var(--primary-600);
        }

        .password-requirements {
            background: var(--primary-50);
            border-radius: 8px;
            padding: 15px;
            margin-top: 10px;
            font-size: 12px;
            color: var(--text-secondary);
            border: 1px solid var(--border-light);
        }

        .password-requirements ul {
            margin: 0;
            padding-left: 20px;
            list-style-type: none;
        }

        .password-requirements li {
            margin-bottom: 5px;
            transition: all 0.3s ease;
        }

        .password-requirements li.met {
            color: var(--success);
        }

        .password-requirements li.not-met {
            color: var(--text-secondary);
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

            .register-card {
                margin: 1rem;
                border-radius: 16px;
            }

            .register-body {
                padding: 2rem 1.5rem;
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
            color: var(--text-secondary);
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
            <h2>Tạo Tài Khoản</h2>
            <p>Tham gia Hệ Thống Quản Lý Khóa Học</p>
        </div>

        <!-- Body -->
        <div class="register-body">
            <!-- Flash Messages -->
            <c:if test="${not empty message}">
                <div class="alert alert-${messageType} alert-dismissible fade show" role="alert">
                    <i class="fas fa-info-circle me-2"></i>
                        ${message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Đóng"></button>
                </div>
            </c:if>

            <!-- Error Messages -->
            <c:if test="${not empty errors}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fas fa-exclamation-triangle me-2"></i>
                    <strong>Vui lòng sửa các lỗi sau:</strong>
                    <ul class="mt-2 mb-0">
                        <c:forEach var="error" items="${errors}">
                            <li>${error}</li>
                        </c:forEach>
                    </ul>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Đóng"></button>
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
                               placeholder="Tên đăng nhập"
                               value="${formData.username}"
                               required
                               pattern="[a-zA-Z0-9_]{3,20}"
                               title="Tên đăng nhập phải có 3-20 ký tự, chỉ chứa chữ cái, số và dấu gạch dưới">
                        <label for="username">
                            <i class="fas fa-user me-2"></i>Tên đăng nhập
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
                            <i class="fas fa-envelope me-2"></i>Địa chỉ Email
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
                               placeholder="Họ"
                               value="${formData.firstName}"
                               required
                               pattern="[a-zA-ZÀ-ỹ\s]{2,50}"
                               title="Họ phải có 2-50 ký tự, chỉ chứa chữ cái">
                        <label for="firstName">
                            <i class="fas fa-id-badge me-2"></i>Họ
                        </label>
                    </div>

                    <div class="form-floating">
                        <input type="text"
                               class="form-control"
                               id="lastName"
                               name="lastName"
                               placeholder="Tên"
                               value="${formData.lastName}"
                               required
                               pattern="[a-zA-ZÀ-ỹ\s]{2,50}"
                               title="Tên phải có 2-50 ký tự, chỉ chứa chữ cái">
                        <label for="lastName">
                            <i class="fas fa-id-badge me-2"></i>Tên
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
                               placeholder="Mật khẩu"
                               required
                               minlength="6">
                        <label for="password">
                            <i class="fas fa-lock me-2"></i>Mật khẩu
                        </label>
                    </div>

                    <div class="form-floating">
                        <input type="password"
                               class="form-control"
                               id="confirmPassword"
                               name="confirmPassword"
                               placeholder="Xác nhận mật khẩu"
                               required
                               minlength="6">
                        <label for="confirmPassword">
                            <i class="fas fa-lock me-2"></i>Xác nhận mật khẩu
                        </label>
                    </div>
                </div>

                <!-- Password Requirements -->
                <div class="password-requirements">
                    <strong>Yêu cầu mật khẩu:</strong>
                    <ul>
                        <li id="req-length" class="not-met"><i class="fas fa-times me-2"></i>Ít nhất 6 ký tự</li>
                        <li id="req-case" class="not-met"><i class="fas fa-times me-2"></i>Chứa chữ hoa và chữ thường</li>
                        <li id="req-number" class="not-met"><i class="fas fa-times me-2"></i>Chứa ít nhất một số</li>
                        <li id="req-special" class="not-met"><i class="fas fa-times me-2"></i>Chứa ít nhất một ký tự đặc biệt (!@#$%^&*)</li>
                    </ul>
                </div>

                <!-- Optional Fields Row -->
                <div class="two-column">
                    <div class="form-floating">
                        <input type="tel"
                               class="form-control"
                               id="phoneNumber"
                               name="phoneNumber"
                               placeholder="Số điện thoại"
                               value="${formData.phoneNumber}"
                               pattern="[+]?[0-9]{10,15}"
                               title="Số điện thoại phải có 10-15 chữ số">
                        <label for="phoneNumber">
                            <i class="fas fa-phone me-2"></i>Số điện thoại (Tùy chọn)
                        </label>
                    </div>

                    <div class="form-floating">
                        <input type="date"
                               class="form-control"
                               id="dateOfBirth"
                               name="dateOfBirth"
                               value="${formData.dateOfBirth}">
                        <label for="dateOfBirth">
                            <i class="fas fa-calendar me-2"></i>Ngày sinh (Tùy chọn)
                        </label>
                        <div class="help-text">Phải ít nhất 13 tuổi</div>
                    </div>
                </div>

                <!-- Role Selection -->
                <div class="form-floating">
                    <select class="form-select" id="role" name="role" required>
                        <option value="">Chọn vai trò của bạn...</option>
                        <c:forEach var="roleOption" items="${roleOptions}">
                            <option value="${roleOption.key}"
                                ${formData.role == roleOption.key ? 'selected' : ''}>
                                    ${roleOption.value}
                            </option>
                        </c:forEach>
                    </select>
                    <label for="role">
                        <i class="fas fa-user-tag me-2"></i>Tôi là...
                    </label>
                </div>

                <div class="role-description" id="roleDescription">
                    Chọn vai trò để xem mô tả
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
                        Tôi đồng ý với <a href="#" target="_blank">Điều khoản và Điều kiện</a>
                        và <a href="#" target="_blank">Chính sách Bảo mật</a>
                    </label>
                </div>

                <div class="form-check">
                    <input class="form-check-input"
                           type="checkbox"
                           id="subscribeNewsletter"
                           name="subscribeNewsletter">
                    <label class="form-check-label" for="subscribeNewsletter">
                        <i class="fas fa-envelope me-1"></i>
                        Đăng ký nhận bản tin cập nhật và thông báo khóa học
                    </label>
                </div>

                <!-- Submit Button -->
                <button type="submit" class="btn btn-register" id="registerBtn">
                    <span class="spinner-border spinner-border-sm loading" role="status">
                        <span class="visually-hidden">Đang tải...</span>
                    </span>
                    <span class="btn-text">
                        <i class="fas fa-user-plus me-2"></i>Tạo Tài Khoản
                    </span>
                </button>
            </form>
        </div>

        <!-- Footer -->
        <div class="register-footer">
            <p>Đã có tài khoản? <a href="${pageContext.request.contextPath}/login">Đăng Nhập</a></p>
            <p class="mb-0">&copy; 2024 Hệ Thống Quản Lý Khóa Học</p>
        </div>
    </div>
</div>

<!-- Scripts -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
<script>
    // Role descriptions
    const roleDescriptions = {
        '1': 'Với vai trò Học viên, bạn có thể đăng ký các khóa học, truy cập tài liệu học tập, nộp bài tập và theo dõi tiến độ học tập.',
        '2': 'Với vai trò Giảng viên, bạn có thể tạo khóa học, quản lý học viên, tải lên tài liệu, tạo bài tập và chấm điểm.'
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
            showAlert('Mật khẩu xác nhận không khớp', 'danger');
            return;
        }

        // Terms validation
        if (!agreeToTerms) {
            e.preventDefault();
            showAlert('Bạn phải đồng ý với Điều khoản và Điều kiện', 'danger');
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

    // Show alert function
    function showAlert(message, type) {
        const alertDiv = document.createElement('div');
        alertDiv.className = `alert alert-${type} alert-dismissible fade show`;
        alertDiv.innerHTML = `
            <i class="fas fa-exclamation-triangle me-2"></i>
            ${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Đóng"></button>
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

    // Real-time password validation
    document.getElementById('password').addEventListener('input', function() {
        const password = this.value;

        // Check requirements
        const hasLength = password.length >= 6;
        const hasUpper = /[A-Z]/.test(password);
        const hasLower = /[a-z]/.test(password);
        const hasNumber = /\d/.test(password);
        const hasSpecial = /[!@#$%^&*()_+\-=\[\]{}|;:,.<>?]/.test(password);

        // Update requirement indicators
        updateRequirement('req-length', hasLength);
        updateRequirement('req-case', hasUpper && hasLower);
        updateRequirement('req-number', hasNumber);
        updateRequirement('req-special', hasSpecial);

        // Check confirm password match if it has a value
        const confirmPassword = document.getElementById('confirmPassword').value;
        if (confirmPassword) {
            const passwordsMatch = password === confirmPassword;
            document.getElementById('confirmPassword').classList.toggle('is-valid', passwordsMatch);
            document.getElementById('confirmPassword').classList.toggle('is-invalid', !passwordsMatch);
        }
    });

    // Check password match on confirm password input
    document.getElementById('confirmPassword').addEventListener('input', function() {
        const password = document.getElementById('password').value;
        const confirmPassword = this.value;

        if (confirmPassword) {
            const passwordsMatch = password === confirmPassword;
            this.classList.toggle('is-valid', passwordsMatch);
            this.classList.toggle('is-invalid', !passwordsMatch);
        }
    });

    // Function to update requirement status
    function updateRequirement(reqId, isMet) {
        const reqElement = document.getElementById(reqId);
        const icon = reqElement.querySelector('i');

        if (isMet) {
            reqElement.classList.remove('not-met');
            reqElement.classList.add('met');
            icon.classList.remove('fa-times');
            icon.classList.add('fa-check');
        } else {
            reqElement.classList.remove('met');
            reqElement.classList.add('not-met');
            icon.classList.remove('fa-check');
            icon.classList.add('fa-times');
        }
    }
</script>
</body>
</html>-floating {
margin-bottom: 20px;
}

.form