<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Change Password - Course Management System</title>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
  <style>
    body {
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      min-height: 100vh;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    .password-container {
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 20px;
    }

    .password-card {
      background: rgba(255, 255, 255, 0.95);
      backdrop-filter: blur(10px);
      border-radius: 20px;
      box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
      border: 1px solid rgba(255, 255, 255, 0.2);
      overflow: hidden;
      max-width: 500px;
      width: 100%;
    }

    .password-header {
      background: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
      color: white;
      padding: 40px 30px;
      text-align: center;
      position: relative;
    }

    .password-header h2 {
      margin: 0;
      font-weight: 300;
      font-size: 2rem;
    }

    .password-header p {
      margin: 10px 0 0;
      opacity: 0.9;
      font-size: 0.95rem;
    }

    .back-button {
      position: absolute;
      left: 20px;
      top: 20px;
      color: white;
      text-decoration: none;
      font-size: 18px;
      transition: all 0.3s ease;
    }

    .back-button:hover {
      color: white;
      transform: translateX(-5px);
    }

    .password-body {
      padding: 40px;
    }

    .form-group {
      margin-bottom: 25px;
    }

    .form-label {
      color: #2c3e50;
      font-weight: 600;
      margin-bottom: 8px;
      display: flex;
      align-items: center;
    }

    .form-label i {
      margin-right: 8px;
      color: #fa709a;
    }

    .form-control {
      border: 2px solid #e9ecef;
      border-radius: 12px;
      padding: 12px 15px;
      font-size: 16px;
      transition: all 0.3s ease;
      background: #f8f9fa;
    }

    .form-control:focus {
      border-color: #fa709a;
      box-shadow: 0 0 0 0.2rem rgba(250, 112, 154, 0.25);
      background: white;
    }

    .password-input-group {
      position: relative;
    }

    .password-toggle {
      position: absolute;
      right: 15px;
      top: 50%;
      transform: translateY(-50%);
      background: none;
      border: none;
      color: #6c757d;
      cursor: pointer;
      padding: 0;
      font-size: 18px;
      transition: color 0.3s ease;
    }

    .password-toggle:hover {
      color: #fa709a;
    }

    .password-strength {
      margin-top: 10px;
    }

    .strength-meter {
      height: 6px;
      background: #e9ecef;
      border-radius: 3px;
      overflow: hidden;
      margin-bottom: 5px;
    }

    .strength-fill {
      height: 100%;
      transition: all 0.3s ease;
      border-radius: 3px;
    }

    .strength-weak {
      background: linear-gradient(90deg, #ff6b6b, #ff8e8e);
      width: 25%;
    }

    .strength-fair {
      background: linear-gradient(90deg, #feca57, #ff9ff3);
      width: 50%;
    }

    .strength-good {
      background: linear-gradient(90deg, #48dbfb, #0abde3);
      width: 75%;
    }

    .strength-strong {
      background: linear-gradient(90deg, #1dd1a1, #10ac84);
      width: 100%;
    }

    .strength-text {
      font-size: 12px;
      font-weight: 600;
      color: #6c757d;
    }

    .password-requirements {
      background: #f8f9fa;
      border-radius: 12px;
      padding: 15px;
      margin-top: 15px;
      border-left: 4px solid #fa709a;
    }

    .password-requirements h6 {
      color: #2c3e50;
      margin-bottom: 10px;
      font-weight: 600;
    }

    .requirement {
      display: flex;
      align-items: center;
      margin-bottom: 5px;
      font-size: 14px;
    }

    .requirement i {
      margin-right: 8px;
      width: 16px;
    }

    .requirement.met {
      color: #28a745;
    }

    .requirement.not-met {
      color: #6c757d;
    }

    .btn-change-password {
      background: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
      border: none;
      color: white;
      padding: 12px 30px;
      border-radius: 12px;
      font-weight: 600;
      font-size: 16px;
      transition: all 0.3s ease;
      width: 100%;
      margin-top: 20px;
    }

    .btn-change-password:hover {
      color: white;
      transform: translateY(-2px);
      box-shadow: 0 10px 25px rgba(250, 112, 154, 0.3);
    }

    .btn-change-password:disabled {
      opacity: 0.6;
      cursor: not-allowed;
      transform: none;
      box-shadow: none;
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

    .security-tips {
      background: #e7f3fe;
      border: 1px solid #bee5eb;
      border-radius: 12px;
      padding: 20px;
      margin-top: 25px;
    }

    .security-tips h6 {
      color: #0c5460;
      margin-bottom: 15px;
      font-weight: 600;
    }

    .security-tips ul {
      margin: 0;
      padding-left: 20px;
    }

    .security-tips li {
      color: #0c5460;
      margin-bottom: 5px;
      font-size: 14px;
    }

    .match-indicator {
      font-size: 12px;
      margin-top: 5px;
      font-weight: 600;
    }

    .match-yes {
      color: #28a745;
    }

    .match-no {
      color: #dc3545;
    }

    .loading-spinner {
      display: none;
      margin-right: 10px;
    }

    .btn-change-password.loading .loading-spinner {
      display: inline-block;
    }

    @media (max-width: 768px) {
      .password-container {
        padding: 10px;
      }

      .password-body {
        padding: 25px;
      }
    }
  </style>
</head>
<body>
<div class="password-container">
  <div class="password-card">
    <!-- Header -->
    <div class="password-header">
      <a href="${pageContext.request.contextPath}/profile" class="back-button">
        <i class="fas fa-arrow-left"></i>
      </a>
      <h2>Change Password</h2>
      <p>Update your account security</p>
    </div>

    <!-- Body -->
    <div class="password-body">
      <!-- Flash Messages -->
      <c:if test="${not empty messageType}">
        <div class="alert alert-${messageType} alert-dismissible fade show" role="alert">
          <i class="fas fa-info-circle me-2"></i>
          <c:if test="${not empty message}">
            ${message}
          </c:if>
          <c:if test="${not empty errors}">
            <ul class="mb-0">
              <c:forEach var="error" items="${errors}">
                <li>${error}</li>
              </c:forEach>
            </ul>
          </c:if>
          <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
      </c:if>

      <!-- Password Change Form -->
      <form action="${pageContext.request.contextPath}/profile/password" method="post" id="passwordForm">
        <!-- Current Password -->
        <div class="form-group">
          <label for="currentPassword" class="form-label">
            <i class="fas fa-key"></i>
            Current Password
          </label>
          <div class="password-input-group">
            <input type="password"
                   class="form-control"
                   id="currentPassword"
                   name="currentPassword"
                   required
                   placeholder="Enter your current password">
            <button type="button" class="password-toggle" data-target="currentPassword">
              <i class="fas fa-eye"></i>
            </button>
          </div>
        </div>

        <!-- New Password -->
        <div class="form-group">
          <label for="newPassword" class="form-label">
            <i class="fas fa-lock"></i>
            New Password
          </label>
          <div class="password-input-group">
            <input type="password"
                   class="form-control"
                   id="newPassword"
                   name="newPassword"
                   required
                   placeholder="Enter your new password">
            <button type="button" class="password-toggle" data-target="newPassword">
              <i class="fas fa-eye"></i>
            </button>
          </div>

          <!-- Password Strength Meter -->
          <div class="password-strength" id="passwordStrength" style="display: none;">
            <div class="strength-meter">
              <div class="strength-fill" id="strengthFill"></div>
            </div>
            <div class="strength-text" id="strengthText"></div>
          </div>
        </div>

        <!-- Confirm Password -->
        <div class="form-group">
          <label for="confirmPassword" class="form-label">
            <i class="fas fa-lock-open"></i>
            Confirm New Password
          </label>
          <div class="password-input-group">
            <input type="password"
                   class="form-control"
                   id="confirmPassword"
                   name="confirmPassword"
                   required
                   placeholder="Confirm your new password">
            <button type="button" class="password-toggle" data-target="confirmPassword">
              <i class="fas fa-eye"></i>
            </button>
          </div>
          <div class="match-indicator" id="matchIndicator"></div>
        </div>

        <!-- Password Requirements -->
        <div class="password-requirements">
          <h6><i class="fas fa-shield-alt me-2"></i>Password Requirements</h6>
          <div class="requirement" id="req-length">
            <i class="fas fa-times"></i>
            At least 6 characters long
          </div>
          <div class="requirement" id="req-upper">
            <i class="fas fa-times"></i>
            One uppercase letter
          </div>
          <div class="requirement" id="req-lower">
            <i class="fas fa-times"></i>
            One lowercase letter
          </div>
          <div class="requirement" id="req-number">
            <i class="fas fa-times"></i>
            One number
          </div>
          <div class="requirement" id="req-special">
            <i class="fas fa-times"></i>
            One special character (!@#$%^&*()_+-=[]{}|;:,.<>?)
          </div>
        </div>

        <!-- Submit Button -->
        <button type="submit" class="btn btn-change-password" id="submitBtn">
          <span class="loading-spinner">
            <i class="fas fa-spinner fa-spin"></i>
          </span>
          <i class="fas fa-key me-2"></i>
          Change Password
        </button>
      </form>

      <!-- Security Tips -->
      <div class="security-tips">
        <h6><i class="fas fa-lightbulb me-2"></i>Security Tips</h6>
        <ul>
          <li>Use a unique password that you don't use anywhere else</li>
          <li>Consider using a password manager</li>
          <li>Don't share your password with anyone</li>
          <li>Change your password regularly</li>
          <li>Log out from shared computers</li>
        </ul>
      </div>
    </div>
  </div>
</div>

<!-- Scripts -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
<script>
  document.addEventListener('DOMContentLoaded', function() {
    const passwordForm = document.getElementById('passwordForm');
    const currentPassword = document.getElementById('currentPassword');
    const newPassword = document.getElementById('newPassword');
    const confirmPassword = document.getElementById('confirmPassword');
    const submitBtn = document.getElementById('submitBtn');
    const strengthIndicator = document.getElementById('passwordStrength');
    const strengthFill = document.getElementById('strengthFill');
    const strengthText = document.getElementById('strengthText');
    const matchIndicator = document.getElementById('matchIndicator');

    // Password visibility toggles
    document.querySelectorAll('.password-toggle').forEach(button => {
      button.addEventListener('click', function() {
        const targetId = this.getAttribute('data-target');
        const targetInput = document.getElementById(targetId);
        const icon = this.querySelector('i');

        if (targetInput.type === 'password') {
          targetInput.type = 'text';
          icon.classList.remove('fa-eye');
          icon.classList.add('fa-eye-slash');
        } else {
          targetInput.type = 'password';
          icon.classList.remove('fa-eye-slash');
          icon.classList.add('fa-eye');
        }
      });
    });

    // Password strength checker
    newPassword.addEventListener('input', function() {
      const password = this.value;

      if (password.length === 0) {
        strengthIndicator.style.display = 'none';
        return;
      }

      strengthIndicator.style.display = 'block';

      // Check requirements
      const requirements = {
        length: password.length >= 6,
        upper: /[A-Z]/.test(password),
        lower: /[a-z]/.test(password),
        number: /\d/.test(password),
        special: /[!@#$%^&*()_+\-=\[\]{}|;:,.<>?]/.test(password)
      };

      // Update requirement indicators
      updateRequirement('req-length', requirements.length);
      updateRequirement('req-upper', requirements.upper);
      updateRequirement('req-lower', requirements.lower);
      updateRequirement('req-number', requirements.number);
      updateRequirement('req-special', requirements.special);

      // Calculate strength
      const metRequirements = Object.values(requirements).filter(Boolean).length;
      const strength = calculateStrength(password, metRequirements);

      // Update strength meter
      updateStrengthMeter(strength);

      // Check password match if confirm password has value
      if (confirmPassword.value) {
        checkPasswordMatch();
      }
    });

    // Password match checker
    confirmPassword.addEventListener('input', checkPasswordMatch);

    function updateRequirement(elementId, met) {
      const element = document.getElementById(elementId);
      const icon = element.querySelector('i');

      if (met) {
        element.classList.add('met');
        element.classList.remove('not-met');
        icon.classList.remove('fa-times');
        icon.classList.add('fa-check');
      } else {
        element.classList.add('not-met');
        element.classList.remove('met');
        icon.classList.remove('fa-check');
        icon.classList.add('fa-times');
      }
    }

    function calculateStrength(password, metRequirements) {
      if (password.length < 6) return 0;
      if (metRequirements < 3) return 1;
      if (metRequirements < 4) return 2;
      if (metRequirements < 5) return 3;
      return 4;
    }

    function updateStrengthMeter(strength) {
      const strengthClasses = ['', 'strength-weak', 'strength-fair', 'strength-good', 'strength-strong'];
      const strengthTexts = ['', 'Weak', 'Fair', 'Good', 'Strong'];

      strengthFill.className = 'strength-fill ' + (strengthClasses[strength] || '');
      strengthText.textContent = strengthTexts[strength] || '';
    }

    function checkPasswordMatch() {
      const newPass = newPassword.value;
      const confirmPass = confirmPassword.value;

      if (confirmPass.length === 0) {
        matchIndicator.textContent = '';
        return;
      }

      if (newPass === confirmPass) {
        matchIndicator.textContent = '✓ Passwords match';
        matchIndicator.className = 'match-indicator match-yes';
      } else {
        matchIndicator.textContent = '✗ Passwords do not match';
        matchIndicator.className = 'match-indicator match-no';
      }
    }

    // Form submission
    passwordForm.addEventListener('submit', function(e) {
      // Basic client-side validation
      if (!currentPassword.value || !newPassword.value || !confirmPassword.value) {
        e.preventDefault();
        alert('Please fill in all password fields.');
        return;
      }

      if (newPassword.value !== confirmPassword.value) {
        e.preventDefault();
        alert('New password and confirm password do not match.');
        return;
      }

      if (newPassword.value.length < 6) {
        e.preventDefault();
        alert('New password must be at least 6 characters long.');
        return;
      }

      // Show loading state
      submitBtn.classList.add('loading');
      submitBtn.disabled = true;
    });

    // Auto-focus on first field
    currentPassword.focus();
  });
</script>
</body>
</html>