<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Đặt Lại Mật Khẩu - Hệ Thống Quản Lý Khóa Học</title>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
  <style>
    :root {
      /* Purple Gradient Theme */
      --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      --primary-500: #667eea;
      --primary-600: #5a69d4;
      --bg-primary: #ffffff;
      --bg-secondary: #f8f9fa;
      --text-primary: #2c3e50;
      --text-secondary: #6c757d;
      --text-white: #ffffff;
      --success: #28a745;
      --warning: #ffc107;
      --error: #dc3545;
      --info: #17a2b8;
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

    .reset-password-container {
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 20px;
      background: var(--bg-secondary);
    }

    .reset-password-card {
      background: var(--bg-primary);
      backdrop-filter: blur(10px);
      border-radius: 20px;
      box-shadow: var(--shadow-medium);
      border: 1px solid var(--border-light);
      overflow: hidden;
      max-width: 400px;
      width: 100%;
    }

    .reset-password-header {
      background: var(--primary-gradient);
      color: var(--text-white);
      padding: 40px 30px 30px;
      text-align: center;
    }

    .reset-password-header h2 {
      margin: 0;
      font-weight: 300;
      font-size: 2rem;
    }

    .reset-password-header p {
      margin: 10px 0 0;
      opacity: 0.9;
      font-size: 0.95rem;
    }

    .reset-password-body {
      padding: 40px 30px;
    }

    .form-floating {
      margin-bottom: 20px;
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

    .btn-submit {
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

    .btn-submit:hover {
      transform: translateY(-2px);
      box-shadow: 0 10px 25px rgba(102, 126, 234, 0.3);
      color: var(--text-white);
    }

    .btn-submit:active {
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
      background: rgba(102, 126, 234, 0.1);
      border-left: 4px solid var(--primary-500);
      color: var(--primary-600);
    }

    .reset-password-footer {
      text-align: center;
      padding: 20px 30px 30px;
      color: var(--text-secondary);
      font-size: 14px;
    }

    .reset-password-footer a {
      color: var(--primary-500);
      text-decoration: none;
      font-weight: 600;
    }

    .reset-password-footer a:hover {
      text-decoration: underline;
      color: var(--primary-600);
    }

    .loading {
      display: none;
    }

    .btn-submit.loading .spinner-border {
      display: inline-block;
    }

    .btn-submit.loading .btn-text {
      display: none;
    }

    .password-strength {
      height: 5px;
      margin-top: -15px;
      margin-bottom: 20px;
      border-radius: 5px;
      transition: var(--transition-medium);
      background: var(--border-light);
    }

    .password-strength-text {
      font-size: 12px;
      margin-top: -15px;
      margin-bottom: 20px;
      color: var(--text-secondary);
    }

    .password-toggle {
      position: absolute;
      right: 15px;
      top: 20px;
      cursor: pointer;
      color: var(--text-secondary);
      transition: var(--transition-medium);
    }

    .password-toggle:hover {
      color: var(--primary-500);
    }

    /* Password Strength Colors */
    .strength-very-weak {
      background: var(--error) !important;
    }

    .strength-weak {
      background: #ff6b35 !important;
    }

    .strength-fair {
      background: var(--warning) !important;
    }

    .strength-good {
      background: var(--info) !important;
    }

    .strength-strong {
      background: var(--success) !important;
    }

    .strength-very-strong {
      background: var(--primary-500) !important;
    }

    @media (max-width: 576px) {
      .reset-password-card {
        margin: 1rem;
        border-radius: 16px;
      }

      .reset-password-body {
        padding: 2rem 1.5rem;
      }
    }
  </style>
</head>
<body>
<div class="reset-password-container">
  <div class="reset-password-card">
    <!-- Header -->
    <div class="reset-password-header">
      <i class="fas fa-lock-open fa-2x mb-3"></i>
      <h2>Đặt Lại Mật Khẩu</h2>
      <p>Tạo mật khẩu mới cho tài khoản của bạn</p>
    </div>

    <!-- Body -->
    <div class="reset-password-body">
      <!-- Flash Messages -->
      <c:if test="${not empty message}">
        <div class="alert alert-${messageType} alert-dismissible fade show" role="alert">
          <i class="fas fa-info-circle me-2"></i>
            ${message}
          <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Đóng"></button>
        </div>
      </c:if>

      <!-- Reset Password Form -->
      <form action="${pageContext.request.contextPath}/reset-password" method="post" id="resetPasswordForm">
        <input type="hidden" name="token" value="${token}">

        <div class="form-floating position-relative">
          <input type="password"
                 class="form-control"
                 id="newPassword"
                 name="newPassword"
                 placeholder="Mật khẩu mới"
                 required>
          <label for="newPassword">
            <i class="fas fa-lock me-2"></i>Mật khẩu mới
          </label>
          <span class="password-toggle" onclick="togglePasswordVisibility('newPassword')">
            <i class="fas fa-eye" id="newPasswordToggle"></i>
          </span>
        </div>

        <div class="password-strength" id="passwordStrength"></div>
        <div class="password-strength-text" id="passwordStrengthText">Độ mạnh mật khẩu</div>

        <div class="form-floating position-relative">
          <input type="password"
                 class="form-control"
                 id="confirmPassword"
                 name="confirmPassword"
                 placeholder="Xác nhận mật khẩu"
                 required>
          <label for="confirmPassword">
            <i class="fas fa-lock me-2"></i>Xác nhận mật khẩu
          </label>
          <span class="password-toggle" onclick="togglePasswordVisibility('confirmPassword')">
            <i class="fas fa-eye" id="confirmPasswordToggle"></i>
          </span>
        </div>

        <button type="submit" class="btn btn-submit" id="submitBtn">
          <span class="spinner-border spinner-border-sm loading" role="status">
            <span class="visually-hidden">Đang tải...</span>
          </span>
          <span class="btn-text">
            <i class="fas fa-save me-2"></i>Đặt Lại Mật Khẩu
          </span>
        </button>
      </form>
    </div>

    <!-- Footer -->
    <div class="reset-password-footer">
      <p><a href="${pageContext.request.contextPath}/login"><i class="fas fa-arrow-left me-1"></i> Quay lại Đăng nhập</a></p>
      <p class="mb-0">&copy; 2024 Hệ Thống Quản Lý Khóa Học</p>
    </div>
  </div>
</div>

<!-- Scripts -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
<script>
  // Form validation and submission
  document.getElementById('resetPasswordForm').addEventListener('submit', function(e) {
    const newPassword = document.getElementById('newPassword').value;
    const confirmPassword = document.getElementById('confirmPassword').value;
    const submitBtn = document.getElementById('submitBtn');

    // Basic validation
    if (!newPassword || !confirmPassword) {
      e.preventDefault();
      showAlert('Vui lòng điền đầy đủ thông tin', 'danger');
      return;
    }

    // Password match validation
    if (newPassword !== confirmPassword) {
      e.preventDefault();
      showAlert('Mật khẩu xác nhận không khớp', 'danger');
      return;
    }

    // Password strength validation
    if (getPasswordStrength(newPassword) < 2) {
      e.preventDefault();
      showAlert('Mật khẩu quá yếu. Vui lòng chọn mật khẩu mạnh hơn.', 'danger');
      return;
    }

    // Show loading state
    submitBtn.classList.add('loading');
    submitBtn.disabled = true;

    // Re-enable button after 10 seconds (fallback)
    setTimeout(() => {
      submitBtn.classList.remove('loading');
      submitBtn.disabled = false;
    }, 10000);
  });

  // Password strength meter
  document.getElementById('newPassword').addEventListener('input', function() {
    const password = this.value;
    const strength = getPasswordStrength(password);
    updatePasswordStrengthUI(strength);
  });

  // Get password strength (0-4)
  function getPasswordStrength(password) {
    let strength = 0;

    if (password.length >= 8) strength++;
    if (password.match(/[a-z]/) && password.match(/[A-Z]/)) strength++;
    if (password.match(/\d/)) strength++;
    if (password.match(/[^a-zA-Z\d]/)) strength++;

    return strength;
  }

  // Update password strength UI
  function updatePasswordStrengthUI(strength) {
    const strengthBar = document.getElementById('passwordStrength');
    const strengthText = document.getElementById('passwordStrengthText');

    // Remove all strength classes
    strengthBar.className = 'password-strength';

    // Update text and style
    switch(strength) {
      case 0:
        strengthText.textContent = 'Rất yếu';
        strengthBar.style.width = '20%';
        strengthBar.classList.add('strength-very-weak');
        break;
      case 1:
        strengthText.textContent = 'Yếu';
        strengthBar.style.width = '40%';
        strengthBar.classList.add('strength-weak');
        break;
      case 2:
        strengthText.textContent = 'Trung bình';
        strengthBar.style.width = '60%';
        strengthBar.classList.add('strength-fair');
        break;
      case 3:
        strengthText.textContent = 'Mạnh';
        strengthBar.style.width = '80%';
        strengthBar.classList.add('strength-good');
        break;
      case 4:
        strengthText.textContent = 'Rất mạnh';
        strengthBar.style.width = '100%';
        strengthBar.classList.add('strength-very-strong');
        break;
      default:
        strengthText.textContent = 'Độ mạnh mật khẩu';
        strengthBar.style.width = '0%';
    }
  }

  // Toggle password visibility
  function togglePasswordVisibility(inputId) {
    const input = document.getElementById(inputId);
    const icon = document.getElementById(inputId + 'Toggle');

    if (input.type === 'password') {
      input.type = 'text';
      icon.classList.remove('fa-eye');
      icon.classList.add('fa-eye-slash');
    } else {
      input.type = 'password';
      icon.classList.remove('fa-eye-slash');
      icon.classList.add('fa-eye');
    }
  }

  // Show alert function
  function showAlert(message, type) {
    const alertDiv = document.createElement('div');
    alertDiv.className = `alert alert-${type} alert-dismissible fade show`;
    alertDiv.innerHTML = `
      <i class="fas fa-exclamation-triangle me-2"></i>
      ${message}
      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Đóng"></button>
    `;

    const form = document.getElementById('resetPasswordForm');
    form.parentNode.insertBefore(alertDiv, form);

    // Auto dismiss after 5 seconds
    setTimeout(() => {
      alertDiv.remove();
    }, 5000);
  }

  // Auto-focus on first input
  document.getElementById('newPassword').focus();
</script>
</body>
</html>