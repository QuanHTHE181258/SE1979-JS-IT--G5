<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="vi_VN" />
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Chỉnh Sửa Hồ Sơ - Hệ Thống Quản Lý Khóa Học</title>
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
      --warning: #ffc107;
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

    .edit-container {
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 20px;
      background: var(--bg-secondary);
    }

    .edit-card {
      background: var(--bg-primary);
      backdrop-filter: blur(10px);
      border-radius: 20px;
      box-shadow: var(--shadow-medium);
      border: 1px solid var(--border-light);
      overflow: hidden;
      max-width: 800px;
      width: 100%;
    }

    .edit-header {
      background: var(--primary-gradient);
      color: var(--text-white);
      padding: 40px 30px;
      text-align: center;
      position: relative;
    }

    .edit-header h2 {
      margin: 0;
      font-weight: 300;
      font-size: 2rem;
    }

    .edit-header p {
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

    .edit-body {
      padding: 40px;
    }

    .form-floating {
      margin-bottom: 25px;
    }

    .form-floating > .form-control {
      background: var(--bg-secondary);
      border: 2px solid var(--border-light);
      border-radius: 15px;
      padding: 1rem 0.75rem;
      font-size: 16px;
      transition: var(--transition-medium);
    }

    .form-floating > .form-control:focus {
      background: var(--bg-primary);
      border-color: var(--primary-500);
      box-shadow: 0 0 0 0.2rem var(--focus-ring);
    }

    .form-floating > label {
      color: var(--text-secondary);
      font-weight: 500;
    }

    .form-floating > .form-control:focus ~ label,
    .form-floating > .form-control:not(:placeholder-shown) ~ label {
      color: var(--primary-500);
      font-weight: 600;
    }

    .form-row {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 20px;
      margin-bottom: 25px;
    }

    @media (max-width: 768px) {
      .form-row {
        grid-template-columns: 1fr;
      }

      .edit-card {
        margin: 1rem;
        border-radius: 16px;
      }

      .edit-body {
        padding: 2rem 1.5rem;
      }
    }

    .input-icon {
      position: absolute;
      right: 15px;
      top: 50%;
      transform: translateY(-50%);
      color: var(--text-secondary);
      font-size: 18px;
      z-index: 5;
      pointer-events: none;
    }

    .form-floating.has-icon {
      position: relative;
    }

    .form-floating.has-icon > .form-control {
      padding-right: 50px;
    }

    .alert {
      border-radius: 15px;
      border: none;
      font-weight: 500;
      margin-bottom: 30px;
      padding: 20px;
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

    .alert ul {
      margin: 0;
      padding-left: 20px;
    }

    .action-buttons {
      display: flex;
      gap: 15px;
      justify-content: center;
      margin-top: 40px;
      flex-wrap: wrap;
    }

    .btn-action {
      padding: 15px 35px;
      border-radius: 15px;
      font-weight: 600;
      font-size: 16px;
      transition: var(--transition-medium);
      text-decoration: none;
      display: inline-flex;
      align-items: center;
      border: none;
      min-width: 150px;
      justify-content: center;
    }

    .btn-action i {
      margin-right: 10px;
      font-size: 18px;
    }

    .btn-save {
      background: var(--primary-gradient);
      color: var(--text-white);
    }

    .btn-save:hover {
      color: var(--text-white);
      transform: translateY(-3px);
      box-shadow: 0 15px 35px rgba(102, 126, 234, 0.4);
    }

    .btn-cancel {
      background: linear-gradient(135deg, var(--text-secondary) 0%, #495057 100%);
      color: var(--text-white);
    }

    .btn-cancel:hover {
      color: var(--text-white);
      transform: translateY(-3px);
      box-shadow: 0 15px 35px rgba(108, 117, 125, 0.4);
    }

    .avatar-preview {
      text-align: center;
      margin-bottom: 30px;
    }

    .avatar-img {
      width: 120px;
      height: 120px;
      border-radius: 50%;
      object-fit: cover;
      border: 4px solid var(--bg-primary);
      box-shadow: var(--shadow-light);
      background: var(--bg-secondary);
    }

    .form-section {
      background: var(--primary-50);
      border-radius: 15px;
      padding: 30px;
      margin-bottom: 30px;
      border: 1px solid var(--border-light);
    }

    .section-title {
      color: var(--text-primary);
      font-size: 1.3rem;
      font-weight: 600;
      margin-bottom: 25px;
      display: flex;
      align-items: center;
    }

    .section-title i {
      margin-right: 12px;
      color: var(--primary-500);
      font-size: 1.4rem;
    }

    .required-field::after {
      content: '*';
      color: var(--error);
      margin-left: 4px;
    }

    .help-text {
      font-size: 14px;
      color: var(--text-secondary);
      margin-top: 8px;
      font-style: italic;
    }

    .validation-feedback {
      display: block;
      width: 100%;
      margin-top: 8px;
      font-size: 14px;
      color: var(--error);
    }

    .form-control.is-invalid {
      border-color: var(--error);
      background-color: #fff5f5;
    }

    .form-control.is-valid {
      border-color: var(--success);
      background-color: #f8fff9;
    }

    .form-control.is-valid:focus {
      border-color: var(--success);
      box-shadow: 0 0 0 0.2rem rgba(40, 167, 69, 0.15);
    }

    .loading-overlay {
      position: fixed;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background: rgba(0, 0, 0, 0.7);
      display: none;
      align-items: center;
      justify-content: center;
      z-index: 9999;
    }

    .loading-spinner {
      color: var(--text-white);
      font-size: 2rem;
    }

    .character-count {
      font-size: 12px;
      color: var(--text-secondary);
      text-align: right;
      margin-top: 5px;
    }

    .character-count.warning {
      color: var(--warning);
    }

    .character-count.danger {
      color: var(--error);
    }

    @keyframes fadeInUp {
      from {
        opacity: 0;
        transform: translateY(30px);
      }
      to {
        opacity: 1;
        transform: translateY(0);
      }
    }

    .edit-card {
      animation: fadeInUp 0.6s ease-out;
    }

    .form-section {
      animation: fadeInUp 0.8s ease-out;
    }

    .form-floating > .form-control:focus {
      transform: scale(1.02);
    }
  </style>
</head>
<body>
<div class="edit-container">
  <div class="edit-card">
    <!-- Header -->
    <div class="edit-header">
      <a href="${pageContext.request.contextPath}/profile" class="back-button">
        <i class="fas fa-arrow-left"></i>
      </a>
      <h2>Chỉnh Sửa Hồ Sơ</h2>
      <p>Cập nhật thông tin cá nhân của bạn</p>
    </div>

    <!-- Body -->
    <div class="edit-body">
      <!-- Flash Messages -->
      <c:if test="${not empty message}">
        <div class="alert alert-${messageType} alert-dismissible fade show" role="alert">
          <i class="fas fa-info-circle me-2"></i>
            ${message}
          <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Đóng"></button>
        </div>
      </c:if>

      <!-- Validation Errors -->
      <c:if test="${not empty errors}">
        <div class="alert alert-danger" role="alert">
          <h6><i class="fas fa-exclamation-triangle me-2"></i>Vui lòng sửa các lỗi sau:</h6>
          <ul>
            <c:forEach var="error" items="${errors}">
              <li>${error}</li>
            </c:forEach>
          </ul>
        </div>
      </c:if>

      <!-- Avatar Preview -->
      <div class="avatar-preview">
        <c:choose>
          <c:when test="${not empty user.avatarUrl}">
            <img src="${pageContext.request.contextPath}${user.avatarUrl}"
                 alt="Ảnh đại diện"
                 class="avatar-img">
          </c:when>
          <c:otherwise>
            <img src="${pageContext.request.contextPath}/assets/images/default-avatar.png"
                 alt="Ảnh đại diện mặc định"
                 class="avatar-img">
          </c:otherwise>
        </c:choose>
        <div class="help-text mt-2">
          <a href="${pageContext.request.contextPath}/profile/avatar" class="text-decoration-none">
            <i class="fas fa-camera me-1"></i>Thay Đổi Ảnh Đại Diện
          </a>
        </div>
      </div>

      <!-- Edit Form -->
      <form action="${pageContext.request.contextPath}/profile/edit" method="post" id="editProfileForm" novalidate>

        <!-- Account Information Section -->
        <div class="form-section">
          <h5 class="section-title">
            <i class="fas fa-user-circle"></i>
            Thông Tin Tài Khoản
          </h5>

          <div class="form-row">
            <div class="form-floating has-icon">
              <input type="text"
                     class="form-control ${not empty errors and errors.contains('Username') ? 'is-invalid' : ''}"
                     id="username"
                     name="username"
                     value="${user.username}"
                     placeholder="Tên đăng nhập"
                     required
                     maxlength="20"
                     pattern="[a-zA-Z0-9_]{3,20}">
              <label for="username" class="required-field">Tên đăng nhập</label>
              <i class="fas fa-user input-icon"></i>
              <div class="character-count">
                <span id="usernameCount">0</span>/20
              </div>
              <div class="help-text">3-20 ký tự, chỉ chứa chữ cái, số và dấu gạch dưới</div>
            </div>

            <div class="form-floating has-icon">
              <input type="email"
                     class="form-control ${not empty errors and errors.contains('Email') ? 'is-invalid' : ''}"
                     id="email"
                     name="email"
                     value="${user.email}"
                     placeholder="Địa chỉ email"
                     required
                     maxlength="100">
              <label for="email" class="required-field">Địa chỉ Email</label>
              <i class="fas fa-envelope input-icon"></i>
              <div class="character-count">
                <span id="emailCount">0</span>/100
              </div>
            </div>
          </div>
        </div>

        <!-- Personal Information Section -->
        <div class="form-section">
          <h5 class="section-title">
            <i class="fas fa-id-card"></i>
            Thông Tin Cá Nhân
          </h5>

          <div class="form-row">
            <div class="form-floating has-icon">
              <input type="text"
                     class="form-control ${not empty errors and errors.contains('First Name') ? 'is-invalid' : ''}"
                     id="firstName"
                     name="firstName"
                     value="${user.firstName}"
                     placeholder="Họ"
                     maxlength="50"
                     pattern="[a-zA-ZÀ-ỹ\s]{2,50}">
              <label for="firstName">Họ</label>
              <i class="fas fa-user input-icon"></i>
              <div class="character-count">
                <span id="firstNameCount">0</span>/50
              </div>
            </div>

            <div class="form-floating has-icon">
              <input type="text"
                     class="form-control ${not empty errors and errors.contains('Last Name') ? 'is-invalid' : ''}"
                     id="lastName"
                     name="lastName"
                     value="${user.lastName}"
                     placeholder="Tên"
                     maxlength="50"
                     pattern="[a-zA-ZÀ-ỹ\s]{2,50}">
              <label for="lastName">Tên</label>
              <i class="fas fa-user input-icon"></i>
              <div class="character-count">
                <span id="lastNameCount">0</span>/50
              </div>
            </div>
          </div>

          <div class="form-row">
            <div class="form-floating has-icon">
              <input type="tel"
                     class="form-control ${not empty errors and errors.contains('Phone') ? 'is-invalid' : ''}"
                     id="phone"
                     name="phone"
                     value="${user.phoneNumber}"
                     placeholder="Số điện thoại"
                     maxlength="20"
                     pattern="[+]?[0-9]{10,15}">
              <label for="phone">Số Điện Thoại</label>
              <i class="fas fa-phone input-icon"></i>
              <div class="help-text">Tùy chọn - Bao gồm mã quốc gia nếu là số quốc tế</div>
            </div>

            <div class="form-floating has-icon">
              <input type="date"
                     class="form-control ${not empty errors and errors.contains('Date of Birth') ? 'is-invalid' : ''}"
                     id="dateOfBirth"
                     name="dateOfBirth"
                     value="${user.dateOfBirth}"
                     placeholder="Ngày sinh">
              <label for="dateOfBirth">Ngày Sinh</label>
              <i class="fas fa-calendar input-icon"></i>
              <div class="help-text">Tùy chọn - Phải ít nhất 13 tuổi</div>
            </div>
          </div>
        </div>

        <!-- Action Buttons -->
        <div class="action-buttons">
          <button type="submit" class="btn btn-action btn-save" id="saveButton">
            <i class="fas fa-save"></i>
            <span>Lưu Thay Đổi</span>
          </button>

          <a href="${pageContext.request.contextPath}/profile" class="btn btn-action btn-cancel">
            <i class="fas fa-times"></i>
            Hủy
          </a>
        </div>
      </form>
    </div>
  </div>
</div>

<!-- Loading Overlay -->
<div class="loading-overlay" id="loadingOverlay">
  <div class="loading-spinner">
    <i class="fas fa-spinner fa-spin"></i>
    <div class="mt-3">Đang lưu thay đổi...</div>
  </div>
</div>

<!-- Scripts -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
<script>
  document.addEventListener('DOMContentLoaded', function() {
    const form = document.getElementById('editProfileForm');
    const saveButton = document.getElementById('saveButton');
    const loadingOverlay = document.getElementById('loadingOverlay');

    // Character count functionality
    const inputs = [
      { id: 'username', countId: 'usernameCount', max: 20 },
      { id: 'email', countId: 'emailCount', max: 100 },
      { id: 'firstName', countId: 'firstNameCount', max: 50 },
      { id: 'lastName', countId: 'lastNameCount', max: 50 }
    ];

    inputs.forEach(input => {
      const element = document.getElementById(input.id);
      const counter = document.getElementById(input.countId);

      function updateCount() {
        const length = element.value.length;
        counter.textContent = length;
        counter.parentElement.classList.remove('warning', 'danger');

        if (length > input.max * 0.8) {
          counter.parentElement.classList.add('warning');
        }
        if (length > input.max * 0.95) {
          counter.parentElement.classList.add('danger');
        }
      }

      element.addEventListener('input', updateCount);
      updateCount(); // Initial count
    });

    // Real-time validation
    const usernameInput = document.getElementById('username');
    const emailInput = document.getElementById('email');
    const phoneInput = document.getElementById('phone');

    usernameInput.addEventListener('blur', function() {
      validateUsername(this.value);
    });

    emailInput.addEventListener('blur', function() {
      validateEmail(this.value);
    });

    phoneInput.addEventListener('blur', function() {
      validatePhone(this.value);
    });

    // Form validation functions
    function validateUsername(username) {
      const usernamePattern = /^[a-zA-Z0-9_]{3,20}$/;
      const isValid = username.length >= 3 && usernamePattern.test(username);

      toggleValidation(usernameInput, isValid);
      return isValid;
    }

    function validateEmail(email) {
      const emailPattern = /^[a-zA-Z0-9_+&*-]+(?:\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$/;
      const isValid = emailPattern.test(email);

      toggleValidation(emailInput, isValid);
      return isValid;
    }

    function validatePhone(phone) {
      if (!phone.trim()) return true; // Phone is optional

      const phonePattern = /^[+]?[0-9]{10,15}$/;
      const cleanPhone = phone.replace(/\s+/g, '');
      const isValid = phonePattern.test(cleanPhone);

      toggleValidation(phoneInput, isValid);
      return isValid;
    }

    function toggleValidation(element, isValid) {
      element.classList.remove('is-valid', 'is-invalid');
      if (isValid) {
        element.classList.add('is-valid');
      } else {
        element.classList.add('is-invalid');
      }
    }

    // Form submission
    form.addEventListener('submit', function(e) {
      e.preventDefault();

      // Validate all fields
      const isUsernameValid = validateUsername(usernameInput.value);
      const isEmailValid = validateEmail(emailInput.value);
      const isPhoneValid = validatePhone(phoneInput.value);

      if (!isUsernameValid || !isEmailValid || !isPhoneValid) {
        // Show error message
        showAlert('Vui lòng sửa các lỗi được đánh dấu trước khi lưu.', 'danger');
        return;
      }

      // Show loading
      showLoading(true);
      saveButton.disabled = true;

      // Submit form
      setTimeout(() => {
        form.submit();
      }, 500);
    });

    function showLoading(show) {
      loadingOverlay.style.display = show ? 'flex' : 'none';
    }

    function showAlert(message, type) {
      const alertHtml = `
      <div class="alert alert-${type} alert-dismissible fade show" role="alert">
        <i class="fas fa-exclamation-triangle me-2"></i>
        ${message}
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Đóng"></button>
      </div>
    `;

      const container = document.querySelector('.edit-body');
      container.insertAdjacentHTML('afterbegin', alertHtml);

      // Auto dismiss after 5 seconds
      setTimeout(() => {
        const alert = container.querySelector('.alert');
        if (alert) {
          alert.remove();
        }
      }, 5000);
    }

    // Auto-save indicator
    let autoSaveTimeout;
    const formInputs = form.querySelectorAll('input');

    formInputs.forEach(input => {
      input.addEventListener('input', function() {
        clearTimeout(autoSaveTimeout);

        // Show that changes are pending
        if (!saveButton.classList.contains('btn-warning')) {
          saveButton.classList.remove('btn-save');
          saveButton.classList.add('btn-warning');
          saveButton.querySelector('span').textContent = 'Lưu Thay Đổi*';
        }
      });
    });

    // Enhanced focus effects
    formInputs.forEach(input => {
      input.addEventListener('focus', function() {
        this.parentElement.style.transform = 'scale(1.02)';
      });

      input.addEventListener('blur', function() {
        this.parentElement.style.transform = 'scale(1)';
      });
    });

    // Date validation
    const dateInput = document.getElementById('dateOfBirth');
    dateInput.addEventListener('change', function() {
      const selectedDate = new Date(this.value);
      const today = new Date();
      const age = today.getFullYear() - selectedDate.getFullYear();

      if (selectedDate > today) {
        this.setCustomValidity('Ngày sinh không thể trong tương lai');
        toggleValidation(this, false);
      } else if (age < 13) {
        this.setCustomValidity('Bạn phải ít nhất 13 tuổi');
        toggleValidation(this, false);
      } else {
        this.setCustomValidity('');
        toggleValidation(this, true);
      }
    });

    // Keyboard shortcuts
    document.addEventListener('keydown', function(e) {
      // Ctrl+S to save
      if (e.ctrlKey && e.key === 's') {
        e.preventDefault();
        form.dispatchEvent(new Event('submit'));
      }

      // Escape to cancel
      if (e.key === 'Escape') {
        window.location.href = '${pageContext.request.contextPath}/profile';
      }
    });
  });
</script>
</body>
</html>