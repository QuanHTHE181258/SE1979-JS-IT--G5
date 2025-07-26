<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/layout/header.jsp" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Đăng Nhập - Hệ Thống Học Trực Tuyến</title>
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
      margin: 0;
      overflow-x: hidden;
    }

    .login-container {
      min-height: 100vh;
      display: flex;
      background: var(--bg-primary);
    }

    .welcome-section {
      flex: 1;
      background: var(--primary-gradient);
      display: flex;
      align-items: center;
      justify-content: center;
      flex-direction: column;
      color: var(--text-white);
      position: relative;
      overflow: hidden;
    }

    .welcome-section::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background: url("data:image/svg+xml,%3Csvg width='60' height='60' viewBox='0 0 60 60' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='none' fill-rule='evenodd'%3E%3Cg fill='%23ffffff' fill-opacity='0.05'%3E%3Ccircle cx='30' cy='30' r='2'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E");
      opacity: 0.3;
    }

    .welcome-content {
      text-align: center;
      z-index: 2;
      position: relative;
      max-width: 500px;
      padding: 2rem;
    }

    .welcome-content h1 {
      font-size: 3.5rem;
      font-weight: 300;
      margin-bottom: 1rem;
      text-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    }

    .welcome-content p {
      font-size: 1.2rem;
      opacity: 0.9;
      margin-bottom: 2rem;
      line-height: 1.6;
    }

    .welcome-features {
      list-style: none;
      padding: 0;
      margin: 0;
    }

    .welcome-features li {
      display: flex;
      align-items: center;
      justify-content: center;
      margin-bottom: 1rem;
      font-size: 1rem;
      opacity: 0.8;
    }

    .welcome-features li i {
      margin-right: 0.75rem;
      font-size: 1.2rem;
    }

    .login-section {
      flex: 1;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 2rem;
      background: var(--bg-secondary);
    }

    .login-card {
      background: var(--bg-primary);
      backdrop-filter: blur(10px);
      border-radius: 20px;
      box-shadow: var(--shadow-medium);
      border: 1px solid var(--border-light);
      overflow: hidden;
      max-width: 450px;
      width: 100%;
    }

    .login-header {
      background: var(--primary-gradient);
      color: var(--text-white);
      padding: 30px;
      text-align: center;
    }

    .login-header h2 {
      margin: 0;
      font-weight: 600;
      font-size: 1.75rem;
    }

    .login-header p {
      margin: 10px 0 0;
      opacity: 0.9;
      font-size: 0.9rem;
    }

    .login-body {
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

    .btn-login {
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

    .btn-login:hover {
      transform: translateY(-2px);
      box-shadow: 0 10px 25px rgba(102, 126, 234, 0.3);
      color: var(--text-white);
    }

    .btn-login:active {
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

    .remember-me {
      display: flex;
      align-items: center;
      margin-bottom: 25px;
    }

    .form-check-input {
      margin-right: 10px;
      width: 18px;
      height: 18px;
    }

    .form-check-label {
      color: var(--text-secondary);
      font-weight: 500;
      margin-bottom: 0;
    }

    .login-footer {
      text-align: center;
      padding: 20px 30px 30px;
      color: var(--text-secondary);
      font-size: 14px;
    }

    .login-footer a {
      color: var(--primary-500);
      text-decoration: none;
      font-weight: 600;
    }

    .login-footer a:hover {
      text-decoration: underline;
      color: var(--primary-600);
    }

    .loading {
      display: none;
    }

    .btn-login.loading .spinner-border {
      display: inline-block;
    }

    .btn-login.loading .btn-text {
      display: none;
    }

    .demo-credentials {
      background: var(--primary-50);
      border-radius: 12px;
      padding: 20px;
      margin-bottom: 25px;
      border-left: 4px solid var(--primary-500);
    }

    .demo-credentials h6 {
      color: var(--text-primary);
      margin-bottom: 15px;
      font-weight: 600;
    }

    .demo-item {
      display: flex;
      justify-content: space-between;
      margin-bottom: 8px;
      font-size: 14px;
      cursor: pointer;
      padding: 4px;
      border-radius: 4px;
      transition: var(--transition-medium);
    }

    .demo-item:hover {
      background: rgba(102, 126, 234, 0.1);
    }

    .demo-item:last-child {
      margin-bottom: 0;
    }

    .demo-role {
      font-weight: 600;
      color: var(--text-primary);
    }

    .demo-credentials-toggle {
      cursor: pointer;
      color: var(--primary-500);
      font-size: 14px;
      text-decoration: none;
      font-weight: 500;
      margin-bottom: 15px;
      display: inline-block;
    }

    .demo-credentials-toggle:hover {
      text-decoration: underline;
      color: var(--primary-600);
    }

    @media (max-width: 768px) {
      .login-container {
        flex-direction: column;
      }

      .welcome-section {
        min-height: 40vh;
        padding: 2rem 1rem;
      }

      .welcome-content h1 {
        font-size: 2.5rem;
      }

      .welcome-content p {
        font-size: 1rem;
      }

      .login-section {
        padding: 1rem;
      }

      .login-card {
        margin: 0;
        border-radius: 16px;
      }

      .login-body {
        padding: 2rem 1.5rem;
      }

      .welcome-features {
        display: none;
      }
    }

    @media (max-width: 576px) {
      .welcome-content h1 {
        font-size: 2rem;
      }

      .welcome-section {
        min-height: 30vh;
      }
    }
  </style>
</head>
<body>
<div class="login-container">
  <!-- Welcome Section -->
  <div class="welcome-section">
    <div class="welcome-content">
      <i class="fas fa-graduation-cap fa-4x mb-4"></i>
      <h1>Chào Mừng Trở Lại</h1>
      <p>Khám phá thế giới kiến thức không giới hạn cùng với hệ thống học trực tuyến hiện đại và ti��n lợi</p>

      <ul class="welcome-features">
        <li>
          <i class="fas fa-book-open"></i>
          Truy cập hàng nghìn khóa học chất lượng cao
        </li>
        <li>
          <i class="fas fa-users"></i>
          Tương tác với cộng đồng học viên toàn cầu
        </li>
        <li>
          <i class="fas fa-trophy"></i>
          Nhận chứng chỉ được công nhận
        </li>
        <li>
          <i class="fas fa-clock"></i>
          Học tập mọi lúc, mọi nơi theo lịch trình riêng
        </li>
      </ul>
    </div>
  </div>

  <!-- Login Section -->
  <div class="login-section">
    <div class="login-card">
      <!-- Header -->
      <div class="login-header">
        <h2>Đăng Nhập</h2>
        <p>Đăng nhập vào tài khoản của bạn</p>
      </div>

      <!-- Body -->
      <div class="login-body">
        <!-- Flash Messages -->
        <c:if test="${not empty message}">
          <div class="alert alert-${messageType} alert-dismissible fade show" role="alert">
            <i class="fas fa-info-circle me-2"></i>
              ${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Đóng"></button>
          </div>
        </c:if>

        <!-- Demo Credentials -->
        <a href="#" class="demo-credentials-toggle" onclick="toggleDemoCredentials()">
          <i class="fas fa-eye me-1"></i>Xem tài khoản demo
        </a>

        <div class="demo-credentials" id="demoCredentials" style="display: none;">
          <h6><i class="fas fa-key me-2"></i>Tài khoản thử nghiệm</h6>
          <div class="demo-item" onclick="fillCredentials('admin', 'admin123')">
            <span class="demo-role">Quản trị viên:</span>
            <span>admin / admin123</span>
          </div>
          <div class="demo-item" onclick="fillCredentials('teacher', 'teacher123')">
            <span class="demo-role">Giảng viên:</span>
            <span>teacher / teacher123</span>
          </div>
          <div class="demo-item" onclick="fillCredentials('student', 'student123')">
            <span class="demo-role">Học viên:</span>
            <span>student / student123</span>
          </div>
        </div>

        <!-- Login Form -->
        <form action="${pageContext.request.contextPath}/login" method="post" id="loginForm">
          <div class="form-floating">
            <input type="text"
                   class="form-control"
                   id="identifier"
                   name="identifier"
                   placeholder="Tên đăng nhập hoặc Email"
                   value="${identifier}"
                   required
                   autocomplete="username">
            <label for="identifier">
              <i class="fas fa-user me-2"></i>Tên đăng nhập hoặc Email
            </label>
          </div>

          <div class="form-floating">
            <input type="password"
                   class="form-control"
                   id="password"
                   name="password"
                   placeholder="Mật khẩu"
                   required
                   autocomplete="current-password">
            <label for="password">
              <i class="fas fa-lock me-2"></i>Mật khẩu
            </label>
          </div>

          <div class="remember-me">
            <input type="checkbox"
                   class="form-check-input"
                   id="rememberMe"
                   name="rememberMe">
            <label class="form-check-label" for="rememberMe">
              Ghi nhớ đăng nhập
            </label>
          </div>

          <button type="submit" class="btn btn-login" id="loginBtn">
                        <span class="spinner-border spinner-border-sm loading" role="status">
                            <span class="visually-hidden">Đang tải...</span>
                        </span>
            <span class="btn-text">
                            <i class="fas fa-sign-in-alt me-2"></i>Đăng Nhập
                        </span>
          </button>
        </form>
      </div>

      <div class="login-footer">
        <p>Chưa có tài khoản? <a href="${pageContext.request.contextPath}/register">Tạo Tài Khoản</a></p>
        <p><a href="${pageContext.request.contextPath}/forgot-password">Quên Mật Khẩu?</a></p>
        <p class="mb-0">&copy; 2024 Hệ Thống Quản Lý Khóa Học</p>
      </div>
    </div>
  </div>

  <!-- Scripts -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
  <script>
    // Form validation and submission
    document.getElementById('loginForm').addEventListener('submit', function(e) {
      const identifier = document.getElementById('identifier').value.trim();
      const password = document.getElementById('password').value;
      const loginBtn = document.getElementById('loginBtn');

      // Basic validation
      if (!identifier || !password) {
        e.preventDefault();
        showAlert('Vui lòng điền đầy đủ thông tin', 'danger');
        return;
      }

      // Show loading state
      loginBtn.classList.add('loading');
      loginBtn.disabled = true;

      // Re-enable button after 10 seconds (fallback)
      setTimeout(() => {
        loginBtn.classList.remove('loading');
        loginBtn.disabled = false;
      }, 10000);
    });

    // Demo credentials toggle
    function toggleDemoCredentials() {
      const demoDiv = document.getElementById('demoCredentials');
      const toggleLink = document.querySelector('.demo-credentials-toggle');

      if (demoDiv.style.display === 'none') {
        demoDiv.style.display = 'block';
        toggleLink.innerHTML = '<i class="fas fa-eye-slash me-1"></i>Ẩn Tài Khoản Demo';
      } else {
        demoDiv.style.display = 'none';
        toggleLink.innerHTML = '<i class="fas fa-eye me-1"></i>Hiển thị Tài Khoản Demo';
      }
    }

    // Quick fill demo credentials
    function fillCredentials(username, password) {
      document.getElementById('identifier').value = username;
      document.getElementById('password').value = password;
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

      const form = document.getElementById('loginForm');
      form.parentNode.insertBefore(alertDiv, form);

      // Auto dismiss after 5 seconds
      setTimeout(() => {
        alertDiv.remove();
      }, 5000);
    }

    // Auto-focus on first input
    document.getElementById('identifier').focus();

    // Enter key support
    document.addEventListener('keypress', function(e) {
      if (e.key === 'Enter') {
        document.getElementById('loginForm').submit();
      }
    });
  </script>
</body>
</html>