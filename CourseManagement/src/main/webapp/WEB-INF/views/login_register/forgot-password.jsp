<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/layout/header.jsp" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Quên Mật Khẩu - Hệ Thống Học Trực Tuyến</title>
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

    .forgot-password-container {
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 20px;
      background: var(--bg-secondary);
    }

    .forgot-password-card {
      background: var(--bg-primary);
      backdrop-filter: blur(10px);
      border-radius: 20px;
      box-shadow: var(--shadow-medium);
      border: 1px solid var(--border-light);
      overflow: hidden;
      max-width: 400px;
      width: 100%;
    }

    .forgot-password-header {
      background: var(--primary-gradient);
      color: var(--text-white);
      padding: 40px 30px 30px;
      text-align: center;
    }

    .forgot-password-header h2 {
      margin: 0;
      font-weight: 300;
      font-size: 2rem;
    }

    .forgot-password-header p {
      margin: 10px 0 0;
      opacity: 0.9;
      font-size: 0.95rem;
    }

    .forgot-password-body {
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

    .forgot-password-footer {
      text-align: center;
      padding: 20px 30px 30px;
      color: var(--text-secondary);
      font-size: 14px;
    }

    .forgot-password-footer a {
      color: var(--primary-500);
      text-decoration: none;
      font-weight: 600;
    }

    .forgot-password-footer a:hover {
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

    @media (max-width: 576px) {
      .forgot-password-card {
        margin: 1rem;
        border-radius: 16px;
      }

      .forgot-password-body {
        padding: 2rem 1.5rem;
      }
    }
  </style>
</head>
<body>
<div class="forgot-password-container">
  <div class="forgot-password-card">
    <!-- Header -->
    <div class="forgot-password-header">
      <i class="fas fa-key fa-2x mb-3"></i>
      <h2>Quên Mật Khẩu</h2>
      <p>Nhập email để khôi phục mật khẩu của bạn</p>
    </div>

    <!-- Body -->
    <div class="forgot-password-body">
      <!-- Flash Messages -->
      <c:if test="${not empty message}">
        <div class="alert alert-${messageType} alert-dismissible fade show" role="alert">
          <i class="fas fa-info-circle me-2"></i>
            ${message}
          <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Đóng"></button>
        </div>
      </c:if>

      <!-- Forgot Password Form -->
      <form action="${pageContext.request.contextPath}/forgot-password" method="post" id="forgotPasswordForm">
        <div class="form-floating">
          <input type="email"
                 class="form-control"
                 id="email"
                 name="email"
                 placeholder="Địa chỉ email"
                 required
                 autocomplete="email">
          <label for="email">
            <i class="fas fa-envelope me-2"></i>Địa chỉ email
          </label>
        </div>

        <button type="submit" class="btn btn-submit" id="submitBtn">
                    <span class="spinner-border spinner-border-sm loading" role="status">
                        <span class="visually-hidden">Đang xử lý...</span>
                    </span>
          <span class="btn-text">
                        <i class="fas fa-paper-plane me-2"></i>Gửi Liên Kết Khôi Phục
                    </span>
        </button>
      </form>
    </div>

    <!-- Footer -->
    <div class="forgot-password-footer">
      <p><a href="${pageContext.request.contextPath}/login">
        <i class="fas fa-arrow-left me-1"></i>Quay lại Đăng nhập</a>
      </p>
      <p class="mb-0">&copy; 2024 Hệ Thống Học Trực Tuyến</p>
    </div>
  </div>
</div>

<!-- Scripts -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
<script>
  // Form validation and submission
  document.getElementById('forgotPasswordForm').addEventListener('submit', function(e) {
    const email = document.getElementById('email').value.trim();
    const submitBtn = document.getElementById('submitBtn');

    // Kiểm tra cơ bản
    if (!email) {
      e.preventDefault();
      showAlert('Vui lòng nhập địa chỉ email của bạn', 'danger');
      return;
    }

    // Kiểm tra định dạng email
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(email)) {
      e.preventDefault();
      showAlert('Vui lòng nhập địa chỉ email hợp lệ', 'danger');
      return;
    }

    // Hiển thị trạng thái loading
    submitBtn.classList.add('loading');
    submitBtn.disabled = true;

    // Khôi phục nút sau 10 giây (phòng trường hợp lỗi)
    setTimeout(() => {
      submitBtn.classList.remove('loading');
      submitBtn.disabled = false;
    }, 10000);
  });


  const form = document.getElementById('forgotPasswordForm');
  form.parentNode.insertBefore(alertDiv, form);

  // Auto dismiss after 5 seconds
  setTimeout(() => {
    alertDiv.remove();
  }, 5000);
  }

  // Auto-focus on email input
  document.getElementById('email').focus();
</script>
</body>
</html>