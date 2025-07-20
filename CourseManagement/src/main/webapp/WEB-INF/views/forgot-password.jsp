<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Forgot Password - Course Management System</title>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
  <style>
    body {
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      min-height: 100vh;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    .forgot-password-container {
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 20px;
    }

    .forgot-password-card {
      background: rgba(255, 255, 255, 0.95);
      backdrop-filter: blur(10px);
      border-radius: 20px;
      box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
      border: 1px solid rgba(255, 255, 255, 0.2);
      overflow: hidden;
      max-width: 400px;
      width: 100%;
    }

    .forgot-password-header {
      background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
      color: white;
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

    .btn-submit {
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

    .btn-submit:hover {
      transform: translateY(-2px);
      box-shadow: 0 10px 25px rgba(79, 172, 254, 0.3);
      color: white;
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

    .forgot-password-footer {
      text-align: center;
      padding: 20px 30px 30px;
      color: #6c757d;
      font-size: 14px;
    }

    .forgot-password-footer a {
      color: #4facfe;
      text-decoration: none;
      font-weight: 600;
    }

    .forgot-password-footer a:hover {
      text-decoration: underline;
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
  </style>
</head>
<body>
<div class="forgot-password-container">
  <div class="forgot-password-card">
    <!-- Header -->
    <div class="forgot-password-header">
      <i class="fas fa-key fa-2x mb-3"></i>
      <h2>Forgot Password</h2>
      <p>Enter your email to reset your password</p>
    </div>

    <!-- Body -->
    <div class="forgot-password-body">
      <!-- Flash Messages -->
      <c:if test="${not empty message}">
        <div class="alert alert-${messageType} alert-dismissible fade show" role="alert">
          <i class="fas fa-info-circle me-2"></i>
            ${message}
          <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
      </c:if>

      <!-- Forgot Password Form -->
      <form action="${pageContext.request.contextPath}/forgot-password" method="post" id="forgotPasswordForm">
        <div class="form-floating">
          <input type="email"
                 class="form-control"
                 id="email"
                 name="email"
                 placeholder="Email Address"
                 required
                 autocomplete="email">
          <label for="email">
            <i class="fas fa-envelope me-2"></i>Email Address
          </label>
        </div>

        <button type="submit" class="btn btn-submit" id="submitBtn">
          <span class="spinner-border spinner-border-sm loading" role="status">
            <span class="visually-hidden">Loading...</span>
          </span>
          <span class="btn-text">
            <i class="fas fa-paper-plane me-2"></i>Send Reset Link
          </span>
        </button>
      </form>
    </div>

    <!-- Footer -->
    <div class="forgot-password-footer">
      <p><a href="${pageContext.request.contextPath}/login"><i class="fas fa-arrow-left me-1"></i> Back to Login</a></p>
      <p class="mb-0">&copy; 2024 Course Management System</p>
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

    // Basic validation
    if (!email) {
      e.preventDefault();
      showAlert('Please enter your email address', 'danger');
      return;
    }

    // Email format validation
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(email)) {
      e.preventDefault();
      showAlert('Please enter a valid email address', 'danger');
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

  // Show alert function
  function showAlert(message, type) {
    const alertDiv = document.createElement('div');
    alertDiv.className = `alert alert-${type} alert-dismissible fade show`;
    alertDiv.innerHTML = `
      <i class="fas fa-exclamation-triangle me-2"></i>
      ${message}
      <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    `;

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