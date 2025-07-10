<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="en_US" />
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Edit Profile - Course Management System</title>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
  <style>
    body {
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      min-height: 100vh;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    .edit-container {
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 20px;
    }

    .edit-card {
      background: rgba(255, 255, 255, 0.95);
      backdrop-filter: blur(10px);
      border-radius: 20px;
      box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
      border: 1px solid rgba(255, 255, 255, 0.2);
      overflow: hidden;
      max-width: 800px;
      width: 100%;
    }

    .edit-header {
      background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
      color: white;
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
      color: white;
      text-decoration: none;
      font-size: 18px;
      transition: all 0.3s ease;
    }

    .back-button:hover {
      color: white;
      transform: translateX(-5px);
    }

    .edit-body {
      padding: 40px;
    }

    .form-floating {
      margin-bottom: 25px;
    }

    .form-floating > .form-control {
      background: rgba(248, 249, 250, 0.8);
      border: 2px solid #e9ecef;
      border-radius: 15px;
      padding: 1rem 0.75rem;
      font-size: 16px;
      transition: all 0.3s ease;
    }

    .form-floating > .form-control:focus {
      background: white;
      border-color: #4facfe;
      box-shadow: 0 0 0 0.2rem rgba(79, 172, 254, 0.15);
    }

    .form-floating > label {
      color: #6c757d;
      font-weight: 500;
    }

    .form-floating > .form-control:focus ~ label,
    .form-floating > .form-control:not(:placeholder-shown) ~ label {
      color: #4facfe;
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
    }

    .input-icon {
      position: absolute;
      right: 15px;
      top: 50%;
      transform: translateY(-50%);
      color: #6c757d;
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
      background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%);
      color: #155724;
    }

    .alert-danger {
      background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%);
      color: #721c24;
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
      transition: all 0.3s ease;
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
      background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
      color: white;
    }

    .btn-save:hover {
      color: white;
      transform: translateY(-3px);
      box-shadow: 0 15px 35px rgba(79, 172, 254, 0.4);
    }

    .btn-cancel {
      background: linear-gradient(135deg, #6c757d 0%, #495057 100%);
      color: white;
    }

    .btn-cancel:hover {
      color: white;
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
      border: 4px solid #fff;
      box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
      background: #f0f0f0;
    }

    .form-section {
      background: rgba(248, 249, 250, 0.5);
      border-radius: 15px;
      padding: 30px;
      margin-bottom: 30px;
      border: 1px solid rgba(0, 0, 0, 0.05);
    }

    .section-title {
      color: #2c3e50;
      font-size: 1.3rem;
      font-weight: 600;
      margin-bottom: 25px;
      display: flex;
      align-items: center;
    }

    .section-title i {
      margin-right: 12px;
      color: #4facfe;
      font-size: 1.4rem;
    }

    .required-field::after {
      content: '*';
      color: #dc3545;
      margin-left: 4px;
    }

    .help-text {
      font-size: 14px;
      color: #6c757d;
      margin-top: 8px;
      font-style: italic;
    }

    .validation-feedback {
      display: block;
      width: 100%;
      margin-top: 8px;
      font-size: 14px;
      color: #dc3545;
    }

    .form-control.is-invalid {
      border-color: #dc3545;
      background-color: #fff5f5;
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
      color: white;
      font-size: 2rem;
    }

    .character-count {
      font-size: 12px;
      color: #6c757d;
      text-align: right;
      margin-top: 5px;
    }

    .character-count.warning {
      color: #ffc107;
    }

    .character-count.danger {
      color: #dc3545;
    }

    /* Custom animations */
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

    /* Focus enhancement */
    .form-floating > .form-control:focus {
      transform: scale(1.02);
    }

    /* Success state */
    .form-control.is-valid {
      border-color: #28a745;
      background-color: #f8fff9;
    }

    .form-control.is-valid:focus {
      border-color: #28a745;
      box-shadow: 0 0 0 0.2rem rgba(40, 167, 69, 0.15);
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
      <h2>Edit Profile</h2>
      <p>Update your personal information</p>
    </div>

    <!-- Body -->
    <div class="edit-body">
      <!-- Flash Messages -->
      <c:if test="${not empty message}">
        <div class="alert alert-${messageType} alert-dismissible fade show" role="alert">
          <i class="fas fa-info-circle me-2"></i>
            ${message}
          <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
      </c:if>

      <!-- Validation Errors -->
      <c:if test="${not empty errors}">
        <div class="alert alert-danger" role="alert">
          <h6><i class="fas fa-exclamation-triangle me-2"></i>Please correct the following errors:</h6>
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
                 alt="Profile Avatar"
                 class="avatar-img">
          </c:when>
          <c:otherwise>
            <img src="${pageContext.request.contextPath}/assets/images/default-avatar.png"
                 alt="Default Avatar"
                 class="avatar-img">
          </c:otherwise>
        </c:choose>
        <div class="help-text mt-2">
          <a href="${pageContext.request.contextPath}/profile/avatar" class="text-decoration-none">
            <i class="fas fa-camera me-1"></i>Change Avatar
          </a>
        </div>
      </div>

      <!-- Edit Form -->
      <form action="${pageContext.request.contextPath}/profile/edit" method="post" id="editProfileForm" novalidate>

        <!-- Account Information Section -->
        <div class="form-section">
          <h5 class="section-title">
            <i class="fas fa-user-circle"></i>
            Account Information
          </h5>

          <div class="form-row">
            <div class="form-floating has-icon">
              <input type="text"
                     class="form-control ${not empty errors and errors.contains('Username') ? 'is-invalid' : ''}"
                     id="username"
                     name="username"
                     value="${user.username}"
                     placeholder="Username"
                     required
                     maxlength="20"
                     pattern="[a-zA-Z0-9_]{3,20}">
              <label for="username" class="required-field">Username</label>
              <i class="fas fa-user input-icon"></i>
              <div class="character-count">
                <span id="usernameCount">0</span>/20
              </div>
              <div class="help-text">3-20 characters, letters, numbers, and underscores only</div>
            </div>

            <div class="form-floating has-icon">
              <input type="email"
                     class="form-control ${not empty errors and errors.contains('Email') ? 'is-invalid' : ''}"
                     id="email"
                     name="email"
                     value="${user.email}"
                     placeholder="Email Address"
                     required
                     maxlength="100">
              <label for="email" class="required-field">Email Address</label>
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
            Personal Information
          </h5>

          <div class="form-row">
            <div class="form-floating has-icon">
              <input type="text"
                     class="form-control ${not empty errors and errors.contains('First Name') ? 'is-invalid' : ''}"
                     id="firstName"
                     name="firstName"
                     value="${user.firstName}"
                     placeholder="First Name"
                     maxlength="50"
                     pattern="[a-zA-ZÀ-ỹ\s]{2,50}">
              <label for="firstName">First Name</label>
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
                     placeholder="Last Name"
                     maxlength="50"
                     pattern="[a-zA-ZÀ-ỹ\s]{2,50}">
              <label for="lastName">Last Name</label>
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
                     placeholder="Phone Number"
                     maxlength="20"
                     pattern="[+]?[0-9]{10,15}">
              <label for="phone">Phone Number</label>
              <i class="fas fa-phone input-icon"></i>
              <div class="help-text">Optional - Include country code if international</div>
            </div>

            <div class="form-floating has-icon">
              <input type="date"
                     class="form-control ${not empty errors and errors.contains('Date of Birth') ? 'is-invalid' : ''}"
                     id="dateOfBirth"
                     name="dateOfBirth"
                     value="${user.dateOfBirth}"
                     placeholder="Date of Birth">
              <label for="dateOfBirth">Date of Birth</label>
              <i class="fas fa-calendar input-icon"></i>
              <div class="help-text">Optional - Must be at least 13 years old</div>
            </div>
          </div>
        </div>

        <!-- Action Buttons -->
        <div class="action-buttons">
          <button type="submit" class="btn btn-action btn-save" id="saveButton">
            <i class="fas fa-save"></i>
            <span>Save Changes</span>
          </button>

          <a href="${pageContext.request.contextPath}/profile" class="btn btn-action btn-cancel">
            <i class="fas fa-times"></i>
            Cancel
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
    <div class="mt-3">Saving changes...</div>
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
        showAlert('Please correct the highlighted errors before saving.', 'danger');
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
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
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
          saveButton.querySelector('span').textContent = 'Save Changes*';
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
        this.setCustomValidity('Date of birth cannot be in the future');
        toggleValidation(this, false);
      } else if (age < 13) {
        this.setCustomValidity('You must be at least 13 years old');
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