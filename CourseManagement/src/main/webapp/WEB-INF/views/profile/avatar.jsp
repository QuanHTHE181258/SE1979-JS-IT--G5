<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="en_US" />
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Change Avatar - Course Management System</title>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
  <style>
    body {
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      min-height: 100vh;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    .avatar-container {
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 20px;
    }

    .avatar-card {
      background: rgba(255, 255, 255, 0.95);
      backdrop-filter: blur(10px);
      border-radius: 20px;
      box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
      border: 1px solid rgba(255, 255, 255, 0.2);
      overflow: hidden;
      max-width: 600px;
      width: 100%;
    }

    .avatar-header {
      background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
      color: white;
      padding: 40px 30px;
      text-align: center;
      position: relative;
    }

    .avatar-header h2 {
      margin: 0;
      font-weight: 300;
      font-size: 2rem;
    }

    .avatar-header p {
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

    .avatar-body {
      padding: 40px;
    }

    .current-avatar-section {
      text-align: center;
      margin-bottom: 40px;
    }

    .current-avatar {
      width: 200px;
      height: 200px;
      border-radius: 50%;
      object-fit: cover;
      border: 6px solid #fff;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
      background: #f0f0f0;
      margin-bottom: 20px;
      transition: all 0.3s ease;
    }

    .current-avatar:hover {
      transform: scale(1.05);
      box-shadow: 0 15px 40px rgba(0, 0, 0, 0.3);
    }

    .avatar-status {
      color: #6c757d;
      font-size: 16px;
      margin-bottom: 10px;
    }

    .upload-section {
      background: rgba(248, 249, 250, 0.7);
      border-radius: 20px;
      padding: 40px;
      margin-bottom: 30px;
      border: 2px dashed #dee2e6;
      text-align: center;
      transition: all 0.3s ease;
      position: relative;
      overflow: hidden;
    }

    .upload-section.dragover {
      border-color: #4facfe;
      background: rgba(79, 172, 254, 0.1);
      transform: scale(1.02);
    }

    .upload-icon {
      font-size: 4rem;
      color: #4facfe;
      margin-bottom: 20px;
      transition: all 0.3s ease;
    }

    .upload-section.dragover .upload-icon {
      transform: scale(1.2);
      animation: bounce 0.6s ease-in-out;
    }

    @keyframes bounce {
      0%, 20%, 60%, 100% { transform: translateY(0) scale(1.2); }
      40% { transform: translateY(-10px) scale(1.2); }
      80% { transform: translateY(-5px) scale(1.2); }
    }

    .upload-text {
      color: #2c3e50;
      font-size: 1.2rem;
      font-weight: 600;
      margin-bottom: 15px;
    }

    .upload-subtext {
      color: #6c757d;
      font-size: 14px;
      margin-bottom: 25px;
    }

    .file-input-wrapper {
      position: relative;
      display: inline-block;
    }

    .file-input {
      position: absolute;
      opacity: 0;
      width: 100%;
      height: 100%;
      cursor: pointer;
    }

    .file-input-button {
      background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
      color: white;
      padding: 15px 35px;
      border-radius: 15px;
      font-weight: 600;
      font-size: 16px;
      border: none;
      cursor: pointer;
      transition: all 0.3s ease;
      display: inline-flex;
      align-items: center;
      box-shadow: 0 5px 15px rgba(79, 172, 254, 0.3);
    }

    .file-input-button:hover {
      transform: translateY(-3px);
      box-shadow: 0 10px 25px rgba(79, 172, 254, 0.4);
    }

    .file-input-button i {
      margin-right: 10px;
      font-size: 18px;
    }

    .preview-section {
      display: none;
      background: rgba(248, 249, 250, 0.7);
      border-radius: 20px;
      padding: 30px;
      margin-bottom: 30px;
      text-align: center;
    }

    .preview-image {
      width: 150px;
      height: 150px;
      border-radius: 50%;
      object-fit: cover;
      border: 4px solid #fff;
      box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
      margin-bottom: 20px;
    }

    .preview-info {
      color: #6c757d;
      font-size: 14px;
      margin-bottom: 20px;
    }

    .file-requirements {
      background: rgba(255, 255, 255, 0.8);
      border-radius: 15px;
      padding: 25px;
      margin-bottom: 30px;
    }

    .requirements-title {
      color: #2c3e50;
      font-size: 1.1rem;
      font-weight: 600;
      margin-bottom: 15px;
      display: flex;
      align-items: center;
    }

    .requirements-title i {
      margin-right: 10px;
      color: #4facfe;
    }

    .requirements-list {
      list-style: none;
      padding: 0;
      margin: 0;
    }

    .requirements-list li {
      color: #6c757d;
      font-size: 14px;
      margin-bottom: 8px;
      display: flex;
      align-items: center;
    }

    .requirements-list li i {
      margin-right: 10px;
      color: #28a745;
      font-size: 12px;
    }

    .action-buttons {
      display: flex;
      gap: 15px;
      justify-content: center;
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
      min-width: 160px;
      justify-content: center;
    }

    .btn-action i {
      margin-right: 10px;
      font-size: 18px;
    }

    .btn-upload {
      background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
      color: white;
    }

    .btn-upload:hover {
      color: white;
      transform: translateY(-3px);
      box-shadow: 0 15px 35px rgba(40, 167, 69, 0.4);
    }

    .btn-upload:disabled {
      background: #6c757d;
      cursor: not-allowed;
      transform: none;
      box-shadow: none;
    }

    .btn-remove {
      background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
      color: white;
    }

    .btn-remove:hover {
      color: white;
      transform: translateY(-3px);
      box-shadow: 0 15px 35px rgba(220, 53, 69, 0.4);
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
      text-align: center;
    }

    /* Progress bar */
    .upload-progress {
      display: none;
      margin-top: 20px;
    }

    .progress {
      height: 10px;
      border-radius: 10px;
      background: rgba(0, 0, 0, 0.1);
      overflow: hidden;
    }

    .progress-bar {
      background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
      height: 100%;
      border-radius: 10px;
      transition: width 0.3s ease;
    }

    /* Animations */
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

    .avatar-card {
      animation: fadeInUp 0.6s ease-out;
    }

    .upload-section {
      animation: fadeInUp 0.8s ease-out;
    }

    /* File validation feedback */
    .validation-feedback {
      color: #dc3545;
      font-size: 14px;
      margin-top: 10px;
      display: none;
    }

    .validation-feedback.show {
      display: block;
    }

    /* Responsive adjustments */
    @media (max-width: 768px) {
      .current-avatar {
        width: 150px;
        height: 150px;
      }

      .upload-section {
        padding: 30px 20px;
      }

      .action-buttons {
        flex-direction: column;
        align-items: center;
      }

      .btn-action {
        width: 100%;
        max-width: 280px;
      }
    }
  </style>
</head>
<body>
<div class="avatar-container">
  <div class="avatar-card">
    <!-- Header -->
    <div class="avatar-header">
      <a href="${pageContext.request.contextPath}/profile" class="back-button">
        <i class="fas fa-arrow-left"></i>
      </a>
      <h2>Change Avatar</h2>
      <p>Upload a new profile picture</p>
    </div>

    <!-- Body -->
    <div class="avatar-body">
      <!-- Flash Messages -->
      <c:if test="${not empty message}">
        <div class="alert alert-${messageType} alert-dismissible fade show" role="alert">
          <i class="fas fa-info-circle me-2"></i>
            ${message}
          <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
      </c:if>

      <!-- Current Avatar Section -->
      <div class="current-avatar-section">
        <c:choose>
          <c:when test="${not empty user.avatarUrl}">
            <img src="${pageContext.request.contextPath}${user.avatarUrl}"
                 alt="Current Avatar"
                 class="current-avatar"
                 id="currentAvatar">
            <div class="avatar-status">
              <i class="fas fa-check-circle text-success me-2"></i>
              Current Profile Picture
            </div>
          </c:when>
          <c:otherwise>
            <img src="${pageContext.request.contextPath}/assets/images/default-avatar.png"
                 alt="Default Avatar"
                 class="current-avatar"
                 id="currentAvatar">
            <div class="avatar-status">
              <i class="fas fa-user-circle text-muted me-2"></i>
              No profile picture set
            </div>
          </c:otherwise>
        </c:choose>
      </div>

      <!-- Upload Section -->
      <div class="upload-section" id="uploadSection">
        <div class="upload-icon">
          <i class="fas fa-cloud-upload-alt"></i>
        </div>
        <div class="upload-text">Choose a new avatar</div>
        <div class="upload-subtext">
          Drag and drop an image here, or click to browse
        </div>

        <form action="${pageContext.request.contextPath}/profile/avatar"
              method="post"
              enctype="multipart/form-data"
              id="avatarForm">
          <div class="file-input-wrapper">
            <input type="file"
                   name="avatar"
                   id="avatarInput"
                   class="file-input"
                   accept="image/jpeg,image/jpg,image/png,image/gif"
                   required>
            <button type="button" class="file-input-button">
              <i class="fas fa-folder-open"></i>
              Browse Files
            </button>
          </div>
        </form>

        <div class="validation-feedback" id="validationFeedback"></div>

        <div class="upload-progress" id="uploadProgress">
          <div class="progress">
            <div class="progress-bar" id="progressBar" style="width: 0%"></div>
          </div>
          <div class="mt-2 text-center">
            <small class="text-muted">Uploading... <span id="progressText">0%</span></small>
          </div>
        </div>
      </div>

      <!-- Preview Section -->
      <div class="preview-section" id="previewSection">
        <img src="" alt="Preview" class="preview-image" id="previewImage">
        <div class="preview-info">
          <strong>Preview:</strong> <span id="fileName"></span>
          <br>
          <small>Size: <span id="fileSize"></span></small>
        </div>
      </div>

      <!-- File Requirements -->
      <div class="file-requirements">
        <div class="requirements-title">
          <i class="fas fa-info-circle"></i>
          File Requirements
        </div>
        <ul class="requirements-list">
          <li>
            <i class="fas fa-circle"></i>
            Supported formats: JPG, JPEG, PNG, GIF
          </li>
          <li>
            <i class="fas fa-circle"></i>
            Maximum file size: 5MB
          </li>
          <li>
            <i class="fas fa-circle"></i>
            Recommended size: 400x400 pixels or larger
          </li>
          <li>
            <i class="fas fa-circle"></i>
            Square images work best for circular avatars
          </li>
        </ul>
      </div>

      <!-- Action Buttons -->
      <div class="action-buttons">
        <button type="submit"
                form="avatarForm"
                class="btn btn-action btn-upload"
                id="uploadBtn"
                disabled>
          <i class="fas fa-upload"></i>
          Upload Avatar
        </button>

        <c:if test="${not empty user.avatarUrl}">
          <button type="button"
                  class="btn btn-action btn-remove"
                  id="removeBtn"
                  data-bs-toggle="modal"
                  data-bs-target="#removeModal">
            <i class="fas fa-trash"></i>
            Remove Avatar
          </button>
        </c:if>

        <a href="${pageContext.request.contextPath}/profile" class="btn btn-action btn-cancel">
          <i class="fas fa-times"></i>
          Cancel
        </a>
      </div>
    </div>
  </div>
</div>

<!-- Remove Confirmation Modal -->
<c:if test="${not empty user.avatarUrl}">
  <div class="modal fade" id="removeModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content" style="border-radius: 20px; border: none;">
        <div class="modal-header" style="background: linear-gradient(135deg, #dc3545 0%, #c82333 100%); color: white; border-radius: 20px 20px 0 0;">
          <h5 class="modal-title">
            <i class="fas fa-exclamation-triangle me-2"></i>
            Remove Avatar
          </h5>
          <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
        </div>
        <div class="modal-body text-center" style="padding: 30px;">
          <img src="${pageContext.request.contextPath}${user.avatarUrl}"
               alt="Avatar to remove"
               style="width: 100px; height: 100px; border-radius: 50%; object-fit: cover; margin-bottom: 20px;">
          <p class="mb-0">Are you sure you want to remove your current avatar?</p>
          <small class="text-muted">This action cannot be undone.</small>
        </div>
        <div class="modal-footer" style="border: none; padding: 0 30px 30px;">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
          <form action="${pageContext.request.contextPath}/profile/delete-avatar" method="post" style="display: inline;">
            <button type="submit" class="btn btn-danger">
              <i class="fas fa-trash me-2"></i>Remove Avatar
            </button>
          </form>
        </div>
      </div>
    </div>
  </div>
</c:if>

<!-- Loading Overlay -->
<div class="loading-overlay" id="loadingOverlay">
  <div class="loading-spinner">
    <i class="fas fa-spinner fa-spin"></i>
    <div class="mt-3">Processing your avatar...</div>
  </div>
</div>

<!-- Scripts -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
<script>
  document.addEventListener('DOMContentLoaded', function() {
    const uploadSection = document.getElementById('uploadSection');
    const avatarInput = document.getElementById('avatarInput');
    const avatarForm = document.getElementById('avatarForm');
    const uploadBtn = document.getElementById('uploadBtn');
    const previewSection = document.getElementById('previewSection');
    const previewImage = document.getElementById('previewImage');
    const fileName = document.getElementById('fileName');
    const fileSize = document.getElementById('fileSize');
    const validationFeedback = document.getElementById('validationFeedback');
    const loadingOverlay = document.getElementById('loadingOverlay');
    const uploadProgress = document.getElementById('uploadProgress');
    const progressBar = document.getElementById('progressBar');
    const progressText = document.getElementById('progressText');

    // File input event listener
    avatarInput.addEventListener('change', function(e) {
      const file = e.target.files[0];
      if (file) {
        validateAndPreviewFile(file);
      }
    });

    // Drag and drop functionality
    uploadSection.addEventListener('dragover', function(e) {
      e.preventDefault();
      uploadSection.classList.add('dragover');
    });

    uploadSection.addEventListener('dragleave', function(e) {
      e.preventDefault();
      uploadSection.classList.remove('dragover');
    });

    uploadSection.addEventListener('drop', function(e) {
      e.preventDefault();
      uploadSection.classList.remove('dragover');

      const files = e.dataTransfer.files;
      if (files.length > 0) {
        const file = files[0];
        avatarInput.files = files;
        validateAndPreviewFile(file);
      }
    });

    // Form submission
    avatarForm.addEventListener('submit', function(e) {
      e.preventDefault();

      if (!avatarInput.files[0]) {
        showValidationError('Please select a file to upload.');
        return;
      }

      uploadAvatar();
    });

    // File validation and preview
    function validateAndPreviewFile(file) {
      clearValidationError();

      // Validate file type
      const allowedTypes = ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'];
      if (!allowedTypes.includes(file.type)) {
        showValidationError('Invalid file type. Please upload a JPG, PNG, or GIF image.');
        resetFileInput();
        return;
      }

      // Validate file size (5MB)
      const maxSize = 5 * 1024 * 1024;
      if (file.size > maxSize) {
        showValidationError('File size too large. Maximum allowed size is 5MB.');
        resetFileInput();
        return;
      }

      // Show preview
      const reader = new FileReader();
      reader.onload = function(e) {
        previewImage.src = e.target.result;
        fileName.textContent = file.name;
        fileSize.textContent = formatFileSize(file.size);

        previewSection.style.display = 'block';
        uploadBtn.disabled = false;

        // Animate preview appearance
        previewSection.style.opacity = '0';
        previewSection.style.transform = 'translateY(20px)';
        setTimeout(() => {
          previewSection.style.transition = 'all 0.3s ease';
          previewSection.style.opacity = '1';
          previewSection.style.transform = 'translateY(0)';
        }, 100);
      };

      reader.readAsDataURL(file);
    }

    // Upload avatar with progress
    function uploadAvatar() {
      const formData = new FormData(avatarForm);

      uploadProgress.style.display = 'block';
      uploadBtn.disabled = true;
      uploadBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Uploading...';

      // Simulate progress (since we can't track real progress with form submission)
      let progress = 0;
      const progressInterval = setInterval(() => {
        progress += Math.random() * 15;
        if (progress > 90) progress = 90;

        progressBar.style.width = progress + '%';
        progressText.textContent = Math.round(progress) + '%';
      }, 200);

      // Submit form after a delay to show progress
      setTimeout(() => {
        clearInterval(progressInterval);
        progressBar.style.width = '100%';
        progressText.textContent = '100%';

        loadingOverlay.style.display = 'flex';
        avatarForm.submit();
      }, 2000);
    }

    // Utility functions
    function showValidationError(message) {
      validationFeedback.textContent = message;
      validationFeedback.classList.add('show');
    }

    function clearValidationError() {
      validationFeedback.classList.remove('show');
    }

    function resetFileInput() {
      avatarInput.value = '';
      previewSection.style.display = 'none';
      uploadBtn.disabled = true;
      uploadBtn.innerHTML = '<i class="fas fa-upload me-2"></i>Upload Avatar';
    }

    function formatFileSize(bytes) {
      if (bytes === 0) return '0 Bytes';
      const k = 1024;
      const sizes = ['Bytes', 'KB', 'MB', 'GB'];
      const i = Math.floor(Math.log(bytes) / Math.log(k));
      return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
    }

    // Click to upload functionality
    uploadSection.addEventListener('click', function(e) {
      if (e.target === uploadSection || e.target.closest('.file-input-button')) {
        avatarInput.click();
      }
    });

    // Keyboard shortcuts
    document.addEventListener('keydown', function(e) {
      // Escape to cancel
      if (e.key === 'Escape') {
        window.location.href = '${pageContext.request.contextPath}/profile';
      }

      // Enter to upload (if file selected)
      if (e.key === 'Enter' && !uploadBtn.disabled) {
        avatarForm.dispatchEvent(new Event('submit'));
      }
    });

    // Avatar hover effect
    const currentAvatar = document.getElementById('currentAvatar');
    if (currentAvatar) {
      currentAvatar.addEventListener('click', function() {
        this.style.transform = 'scale(1.1)';
        setTimeout(() => {
          this.style.transform = 'scale(1)';
        }, 200);
      });
    }
  });
</script>
</body>
</html>