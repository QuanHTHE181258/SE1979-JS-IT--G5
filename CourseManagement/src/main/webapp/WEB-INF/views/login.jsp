<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Login - Course Management System</title>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
  <style>
    body {
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      min-height: 100vh;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    .login-container {
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 20px;
    }

    .login-card {
      background: rgba(255, 255, 255, 0.95);
      backdrop-filter: blur(10px);
      border-radius: 20px;
      box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
      border: 1px solid rgba(255, 255, 255, 0.2);
      overflow: hidden;
      max-width: 400px;
      width: 100%;
    }

    .login-header {
      background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
      color: white;
      padding: 40px 30px 30px;
      text-align: center;
    }

    .login-header h2 {
      margin: 0;
      font-weight: 300;
      font-size: 2rem;
    }

    .login-header p {
      margin: 10px 0 0;
      opacity: 0.9;
      font-size: 0.95rem;
    }

    .login-body {
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

    .btn-login {
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

    .btn-login:hover {
      transform: translateY(-2px);
      box-shadow: 0 10px 25px rgba(79, 172, 254, 0.3);
      color: white;
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
      color: #6c757d;
      font-weight: 500;
      margin-bottom: 0;
    }

    .login-footer {
      text-align: center;
      padding: 20px 30px 30px;
      color: #6c757d;
      font-size: 14px;
    }

    .login-footer a {
      color: #4facfe;
      text-decoration: none;
      font-weight: 600;
    }

    .login-footer a:hover {
      text-decoration: underline;
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
      background: #f8f9fa;
      border-radius: 12px;
      padding: 20px;
      margin-bottom: 25px;
      border-left: 4px solid #4facfe;
    }

    .demo-credentials h6 {
      color: #495057;
      margin-bottom: 15px;
      font-weight: 600;
    }

    .demo-item {
      display: flex;
      justify-content: space-between;
      margin-bottom: 8px;
      font-size: 14px;
    }

    .demo-item:last-child {
      margin-bottom: 0;
    }

    .demo-role {
      font-weight: 600;
      color: #495057;
    }

    .demo-credentials-toggle {
      cursor: pointer;
      color: #4facfe;
      font-size: 14px;
      text-decoration: none;
      font-weight: 500;
    }

    .demo-credentials-toggle:hover {
      text-decoration: underline;
      color: #4facfe;
    }
  </style>
</head>
<body>
<div class="login-container">
  <div class="login-card">
    <!-- Header -->
    <div class="login-header">
      <i class="fas fa-graduation-cap fa-2x mb-3"></i>
      <h2>Welcome Back</h2>
      <p>Sign in to Course Management System</p>
    </div>

    <!-- Body -->
    <div class="login-body">
      <!-- Flash Messages -->
      <c:if test="${not empty message}">
        <div class="alert alert-${messageType} alert-dismissible fade show" role="alert">
          <i class="fas fa-info-circle me-2"></i>
            ${message}
          <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
      </c:if>

      <!-- Demo Credentials (only in development) -->
      <div class="demo-credentials" id="demoCredentials" style="display: none;">
        <h6><i class="fas fa-key me-2"></i>Demo Credentials</h6>
        <div class="demo-item">
          <span class="demo-role">Admin:</span>
          <span>admin / admin123</span>
        </div>
        <div class="demo-item">
          <span class="demo-role">Teacher:</span>
          <span>teacher / teacher123</span>
        </div>
        <div class="demo-item">
          <span class="demo-role">Student:</span>
          <span>student / student123</span>
        </div>
      </div>

      <a href="#" class="demo-credentials-toggle" onclick="toggleDemoCredentials()">
        <i class="fas fa-eye me-1"></i>Show Demo Credentials
      </a>

      <!-- Login Form -->
      <form action="${pageContext.request.contextPath}/login" method="post" id="loginForm">
        <div class="form-floating">
          <input type="text"
                 class="form-control"
                 id="identifier"
                 name="identifier"
                 placeholder="Username or Email"
                 value="${identifier}"
                 required
                 autocomplete="username">
          <label for="identifier">
            <i class="fas fa-user me-2"></i>Username or Email
          </label>
        </div>

        <div class="form-floating">
          <input type="password"
                 class="form-control"
                 id="password"
                 name="password"
                 placeholder="Password"
                 required
                 autocomplete="current-password">
          <label for="password">
            <i class="fas fa-lock me-2"></i>Password
          </label>
        </div>

        <div class="remember-me">
          <input type="checkbox"
                 class="form-check-input"
                 id="rememberMe"
                 name="rememberMe">
          <label class="form-check-label" for="rememberMe">
            Remember me
          </label>
        </div>

        <button type="submit" class="btn btn-login" id="loginBtn">
                        <span class="spinner-border spinner-border-sm loading" role="status">
                            <span class="visually-hidden">Loading...</span>
                        </span>
          <span class="btn-text">
                            <i class="fas fa-sign-in-alt me-2"></i>Sign In
                        </span>
        </button>
      </form>
    </div>

    <!-- Footer -->
    <div class="login-footer">
      <p>Don't have an account? <a href="${pageContext.request.contextPath}/register">Create Account</a></p>
      <p><a href="${pageContext.request.contextPath}/forgot-password">Forgot Password?</a></p>
      <p class="mb-0">&copy; 2024 Course Management System</p>
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
      showAlert('Please fill in all fields', 'danger');
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
      toggleLink.innerHTML = '<i class="fas fa-eye-slash me-1"></i>Hide Demo Credentials';
    } else {
      demoDiv.style.display = 'none';
      toggleLink.innerHTML = '<i class="fas fa-eye me-1"></i>Show Demo Credentials';
    }
  }

  // Quick fill demo credentials
  function fillCredentials(username, password) {
    document.getElementById('identifier').value = username;
    document.getElementById('password').value = password;
  }

  // Add click handlers for demo credentials
  document.addEventListener('DOMContentLoaded', function() {
    const demoItems = document.querySelectorAll('.demo-item');
    demoItems.forEach(item => {
      item.style.cursor = 'pointer';
      item.addEventListener('click', function() {
        const text = this.querySelector('span:last-child').textContent;
        const [username, password] = text.split(' / ');
        fillCredentials(username, password);
      });
    });
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