<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Reset Password - Course Management System</title>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
  <style>
    body {
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      min-height: 100vh;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    .reset-password-container {
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 20px;
    }

    .reset-password-card {
      background: rgba(255, 255, 255, 0.95);
      backdrop-filter: blur(10px);
      border-radius: 20px;
      box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
      border: 1px solid rgba(255, 255, 255, 0.2);
      overflow: hidden;
      max-width: 400px;
      width: 100%;
    }

    .reset-password-header {
      background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
      color: white;
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

    .reset-password-footer {
      text-align: center;
      padding: 20px 30px 30px;
      color: #6c757d;
      font-size: 14px;
    }

    .reset-password-footer a {
      color: #4facfe;
      text-decoration: none;
      font-weight: 600;
    }

    .reset-password-footer a:hover {
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

    .password-strength {
      height: 5px;
      margin-top: -15px;
      margin-bottom: 20px;
      border-radius: 5px;
      transition: all 0.3s ease;
    }

    .password-strength-text {
      font-size: 12px;
      margin-top: -15px;
      margin-bottom: 20px;
      color: #6c757d;
    }

    .password-toggle {
      position: absolute;
      right: 15px;
      top: 20px;
      cursor: pointer;
      color: #6c757d;
    }
  </style>
</head>
<body>
<div class="reset-password-container">
  <div class="reset-password-card">
    <!-- Header -->
    <div class="reset-password-header">
      <i class="fas fa-lock-open fa-2x mb-3"></i>
      <h2>Reset Password</h2>
      <p>Create a new password for your account</p>
    </div>

    <!-- Body -->
    <div class="reset-password-body">
      <!-- Flash Messages -->
      <c:if test="${not empty message}">
        <div class="alert alert-${messageType} alert-dismissible fade show" role="alert">
          <i class="fas fa-info-circle me-2"></i>
            ${message}
          <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
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
                 placeholder="New Password"
                 required>
          <label for="newPassword">
            <i class="fas fa-lock me-2"></i>New Password
          </label>
          <span class="password-toggle" onclick="togglePasswordVisibility('newPassword')">
            <i class="fas fa-eye" id="newPasswordToggle"></i>
          </span>
        </div>
        
        <div class="password-strength" id="passwordStrength"></div>
        <div class="password-strength-text" id="passwordStrengthText">Password strength</div>

        <div class="form-floating position-relative">
          <input type="password"
                 class="form-control"
                 id="confirmPassword"
                 name="confirmPassword"
                 placeholder="Confirm Password"
                 required>
          <label for="confirmPassword">
            <i class="fas fa-lock me-2"></i>Confirm Password
          </label>
          <span class="password-toggle" onclick="togglePasswordVisibility('confirmPassword')">
            <i class="fas fa-eye" id="confirmPasswordToggle"></i>
          </span>
        </div>

        <button type="submit" class="btn btn-submit" id="submitBtn">
          <span class="spinner-border spinner-border-sm loading" role="status">
            <span class="visually-hidden">Loading...</span>
          </span>
          <span class="btn-text">
            <i class="fas fa-save me-2"></i>Reset Password
          </span>
        </button>
      </form>
    </div>

    <!-- Footer -->
    <div class="reset-password-footer">
      <p><a href="${pageContext.request.contextPath}/login"><i class="fas fa-arrow-left me-1"></i> Back to Login</a></p>
      <p class="mb-0">&copy; 2024 Course Management System</p>
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
      showAlert('Please fill in all fields', 'danger');
      return;
    }

    // Password match validation
    if (newPassword !== confirmPassword) {
      e.preventDefault();
      showAlert('Passwords do not match', 'danger');
      return;
    }

    // Password strength validation
    if (getPasswordStrength(newPassword) < 2) {
      e.preventDefault();
      showAlert('Password is too weak. Please choose a stronger password.', 'danger');
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
    
    // Update text
    switch(strength) {
      case 0:
        strengthText.textContent = 'Very weak';
        strengthBar.style.width = '25%';
        strengthBar.style.backgroundColor = '#ff4d4d';
        break;
      case 1:
        strengthText.textContent = 'Weak';
        strengthBar.style.width = '50%';
        strengthBar.style.backgroundColor = '#ffa64d';
        break;
      case 2:
        strengthText.textContent = 'Medium';
        strengthBar.style.width = '75%';
        strengthBar.style.backgroundColor = '#ffff4d';
        break;
      case 3:
        strengthText.textContent = 'Strong';
        strengthBar.style.width = '90%';
        strengthBar.style.backgroundColor = '#4dff4d';
        break;
      case 4:
        strengthText.textContent = 'Very strong';
        strengthBar.style.width = '100%';
        strengthBar.style.backgroundColor = '#4d4dff';
        break;
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
      <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
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