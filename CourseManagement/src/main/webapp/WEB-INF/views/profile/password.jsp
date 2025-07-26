<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/layout/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Đổi Mật Khẩu - Hệ Thống Quản Lý Khóa Học</title>
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

    .password-container {
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 20px;
      background: var(--bg-secondary);
    }

    .password-card {
      background: var(--bg-primary);
      backdrop-filter: blur(10px);
      border-radius: 20px;
      box-shadow: var(--shadow-medium);
      border: 1px solid var(--border-light);
      overflow: hidden;
      max-width: 500px;
      width: 100%;
    }

    .password-header {
      background: var(--primary-gradient);
      color: var(--text-white);
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
      color: var(--text-white);
      text-decoration: none;
      font-size: 18px;
      transition: var(--transition-medium);
    }

    .back-button:hover {
      color: var(--text-white);
      transform: translateX(-5px);
    }

    .password-body {
      padding: 40px;
    }

    .form-group {
      margin-bottom: 25px;
    }

    .form-label {
      color: var(--text-primary);
      font-weight: 600;
      margin-bottom: 8px;
      display: flex;
      align-items: center;
    }

    .form-label i {
      margin-right: 8px;
      color: var(--primary-500);
    }

    .form-control {
      border: 2px solid var(--border-light);
      border-radius: 12px;
      padding: 12px 15px;
      font-size: 16px;
      transition: var(--transition-medium);
      background: var(--bg-secondary);
    }

    .form-control:focus {
      border-color: var(--primary-500);
      box-shadow: 0 0 0 0.2rem var(--focus-ring);
      background: var(--bg-primary);
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
      color: var(--text-secondary);
      cursor: pointer;
      padding: 0;
      font-size: 18px;
      transition: color 0.3s ease;
    }

    .password-toggle:hover {
      color: var(--primary-500);
    }

    .password-strength {
      margin-top: 10px;
    }

    .strength-meter {
      height: 6px;
      background: var(--border-light);
      border-radius: 3px;
      overflow: hidden;
      margin-bottom: 5px;
    }

    .strength-fill {
      height: 100%;
      transition: var(--transition-medium);
      border-radius: 3px;
    }

    .strength-weak {
      background: linear-gradient(90deg, var(--error), #ff8e8e);
      width: 25%;
    }

    .strength-fair {
      background: linear-gradient(90deg, var(--warning), #ffdd57);
      width: 50%;
    }

    .strength-good {
      background: linear-gradient(90deg, var(--info), #0abde3);
      width: 75%;
    }

    .strength-strong {
      background: linear-gradient(90deg, var(--success), #10ac84);
      width: 100%;
    }

    .strength-text {
      font-size: 12px;
      font-weight: 600;
      color: var(--text-secondary);
    }

    .password-requirements {
      background: var(--primary-50);
      border-radius: 12px;
      padding: 15px;
      margin-top: 15px;
      border-left: 4px solid var(--primary-500);
    }

    .password-requirements h6 {
      color: var(--text-primary);
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
      color: var(--success);
    }

    .requirement.not-met {
      color: var(--text-secondary);
    }

    .btn-change-password {
      background: var(--primary-gradient);
      border: none;
      color: var(--text-white);
      padding: 12px 30px;
      border-radius: 12px;
      font-weight: 600;
      font-size: 16px;
      transition: var(--transition-medium);
      width: 100%;
      margin-top: 20px;
    }

    .btn-change-password:hover {
      color: var(--text-white);
      transform: translateY(-2px);
      box-shadow: 0 10px 25px rgba(102, 126, 234, 0.3);
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

    .security-tips {
      background: rgba(23, 162, 184, 0.1);
      border: 1px solid rgba(23, 162, 184, 0.2);
      border-radius: 12px;
      padding: 20px;
      margin-top: 25px;
    }

    .security-tips h6 {
      color: var(--info);
      margin-bottom: 15px;
      font-weight: 600;
    }

    .security-tips ul {
      margin: 0;
      padding-left: 20px;
    }

    .security-tips li {
      color: var(--info);
      margin-bottom: 5px;
      font-size: 14px;
    }

    .match-indicator {
      font-size: 12px;
      margin-top: 5px;
      font-weight: 600;
    }

    .match-yes {
      color: var(--success);
    }

    .match-no {
      color: var(--error);
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

      .password-card {
        margin: 1rem;
        border-radius: 16px;
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
      <h2>Đổi Mật Khẩu</h2>
      <p>Cập nhật bảo mật tài khoản của bạn</p>
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
          <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Đóng"></button>
        </div>
      </c:if>

      <!-- Password Change Form -->
      <form action="${pageContext.request.contextPath}/profile/password" method="post" id="passwordForm">
        <!-- Current Password -->
        <div class="form-group">
          <label for="currentPassword" class="form-label">
            <i class="fas fa-key"></i>
            Mật khẩu hiện tại
          </label>
          <div class="password-input-group">
            <input type="password"
                   class="form-control"
                   id="currentPassword"
                   name="currentPassword"
                   required
                   placeholder="Nhập mật khẩu hiện tại">
            <button type="button" class="password-toggle" data-target="currentPassword">
              <i class="fas fa-eye"></i>
            </button>
          </div>
        </div>

        <!-- New Password -->
        <div class="form-group">
          <label for="newPassword" class="form-label">
            <i class="fas fa-lock"></i>
            Mật khẩu mới
          </label>
          <div class="password-input-group">
            <input type="password"
                   class="form-control"
                   id="newPassword"
                   name="newPassword"
                   required
                   placeholder="Nhập mật khẩu mới">
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
            Xác nhận mật khẩu mới
          </label>
          <div class="password-input-group">
            <input type="password"
                   class="form-control"
                   id="confirmPassword"
                   name="confirmPassword"
                   required
                   placeholder="Xác nhận mật khẩu mới">
            <button type="button" class="password-toggle" data-target="confirmPassword">
              <i class="fas fa-eye"></i>
            </button>
          </div>
          <div class="match-indicator" id="matchIndicator"></div>
        </div>

        <!-- Password Requirements -->
        <div class="password-requirements">
          <h6><i class="fas fa-shield-alt me-2"></i>Yêu Cầu Mật Khẩu</h6>
          <div class="requirement" id="req-length">
            <i class="fas fa-times"></i>
            Ít nhất 6 ký tự
          </div>
          <div class="requirement" id="req-upper">
            <i class="fas fa-times"></i>
            Một chữ cái viết hoa
          </div>
          <div class="requirement" id="req-lower">
            <i class="fas fa-times"></i>
            Một chữ cái viết thường
          </div>
          <div class="requirement" id="req-number">
            <i class="fas fa-times"></i>
            Một chữ số
          </div>
          <div class="requirement" id="req-special">
            <i class="fas fa-times"></i>
            Một ký tự đặc biệt (!@#$%^&*()_+-=[]{}|;:,.<>?)
          </div>
        </div>

        <!-- Submit Button -->
        <button type="submit" class="btn btn-change-password" id="submitBtn">
          <span class="loading-spinner">
            <i class="fas fa-spinner fa-spin"></i>
          </span>
          <i class="fas fa-key me-2"></i>
          Đổi Mật Khẩu
        </button>
      </form>

      <!-- Security Tips -->
      <div class="security-tips">
        <h6><i class="fas fa-lightbulb me-2"></i>Mẹo Bảo Mật</h6>
        <ul>
          <li>Sử dụng mật khẩu duy nhất không dùng ở nơi khác</li>
          <li>Cân nhắc sử dụng trình quản lý mật khẩu</li>
          <li>Không chia sẻ mật khẩu với bất kỳ ai</li>
          <li>Thay đổi mật khẩu định kỳ</li>
          <li>Đăng xuất khỏi máy tính dùng chung</li>
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
      const strengthTexts = ['', 'Yếu', 'Khá', 'Tốt', 'Mạnh'];

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
        matchIndicator.textContent = '✓ Mật khẩu khớp';
        matchIndicator.className = 'match-indicator match-yes';
      } else {
        matchIndicator.textContent = '✗ Mật khẩu không khớp';
        matchIndicator.className = 'match-indicator match-no';
      }
    }

    // Form submission
    passwordForm.addEventListener('submit', function(e) {
      // Basic client-side validation
      if (!currentPassword.value || !newPassword.value || !confirmPassword.value) {
        e.preventDefault();
        alert('Vui lòng điền tất cả các trường mật khẩu.');
        return;
      }

      if (newPassword.value !== confirmPassword.value) {
        e.preventDefault();
        alert('Mật khẩu mới và xác nhận mật khẩu không khớp.');
        return;
      }

      if (newPassword.value.length < 6) {
        e.preventDefault();
        alert('Mật khẩu mới phải có ít nhất 6 ký tự.');
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