<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="en_US" />
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>My Profile - Course Management System</title>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
  <style>
    body {
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      min-height: 100vh;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    .profile-container {
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 20px;
    }

    .profile-card {
      background: rgba(255, 255, 255, 0.95);
      backdrop-filter: blur(10px);
      border-radius: 20px;
      box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
      border: 1px solid rgba(255, 255, 255, 0.2);
      overflow: hidden;
      max-width: 900px;
      width: 100%;
    }

    .profile-header {
      background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
      color: white;
      padding: 40px 30px;
      text-align: center;
      position: relative;
    }

    .profile-header h2 {
      margin: 0;
      font-weight: 300;
      font-size: 2rem;
    }

    .profile-header p {
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

    .profile-body {
      padding: 40px;
    }

    .avatar-section {
      text-align: center;
      margin-bottom: 50px; /* Increased from 40px */
    }

    .avatar-container {
      position: relative;
      display: inline-block;
      margin-bottom: 30px; /* Increased from 20px */
    }

    .avatar-img {
      width: 200px; /* Increased from 150px */
      height: 200px; /* Increased from 150px */
      border-radius: 50%;
      object-fit: cover;
      border: 6px solid #fff; /* Increased from 5px */
      box-shadow: 0 8px 30px rgba(0, 0, 0, 0.15); /* Enhanced shadow */
      background: #f0f0f0;
      transition: all 0.3s ease; /* Added smooth transition */
      cursor: pointer; /* Added cursor pointer */
    }

    .avatar-img:hover {
      transform: scale(1.05); /* Added hover effect */
      box-shadow: 0 12px 40px rgba(0, 0, 0, 0.2);
    }

    .avatar-overlay {
      position: absolute;
      bottom: 5px; /* Adjusted position */
      right: 5px; /* Adjusted position */
      background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
      color: white;
      width: 50px; /* Increased from 45px */
      height: 50px; /* Increased from 45px */
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      cursor: pointer;
      transition: all 0.3s ease;
      border: 4px solid #fff; /* Increased from 3px */
      font-size: 20px; /* Increased from 18px */
    }

    .avatar-overlay:hover {
      transform: scale(1.15); /* Increased from 1.1 */
      box-shadow: 0 8px 20px rgba(79, 172, 254, 0.5); /* Enhanced shadow */
    }

    /* Enhanced styling for the name section */
    .avatar-section h3 {
      margin-top: 15px; /* Added more space above name */
      margin-bottom: 20px; /* Added space below name */
      font-size: 1.8rem; /* Made name bigger */
      font-weight: 600;
      color: #2c3e50;
    }

    .completion-badge {
      background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
      color: white;
      padding: 10px 25px; /* Increased padding */
      border-radius: 25px; /* More rounded */
      display: inline-block;
      font-weight: 600;
      font-size: 15px; /* Slightly bigger */
      margin-bottom: 30px;
      box-shadow: 0 4px 15px rgba(240, 147, 251, 0.3); /* Added shadow */
    }

    .info-section {
      background: #f8f9fa;
      border-radius: 15px;
      padding: 30px;
      margin-bottom: 30px;
    }

    .info-grid {
      display: grid;
      grid-template-columns: repeat(2, 1fr);
      gap: 25px;
    }

    @media (max-width: 768px) {
      .info-grid {
        grid-template-columns: 1fr;
      }
    }

    .info-item {
      background: white;
      padding: 20px;
      border-radius: 12px;
      border: 2px solid #e9ecef;
      transition: all 0.3s ease;
    }

    .info-item:hover {
      border-color: #4facfe;
      transform: translateY(-2px);
      box-shadow: 0 5px 15px rgba(79, 172, 254, 0.1);
    }

    .info-label {
      color: #6c757d;
      font-size: 14px;
      font-weight: 600;
      margin-bottom: 8px;
      display: flex;
      align-items: center;
    }

    .info-label i {
      margin-right: 8px;
      color: #4facfe;
    }

    .info-value {
      color: #2c3e50;
      font-size: 16px;
      font-weight: 500;
    }

    .stats-section {
      margin-top: 30px;
    }

    .stats-grid {
      display: grid;
      grid-template-columns: repeat(4, 1fr);
      gap: 20px;
    }

    @media (max-width: 768px) {
      .stats-grid {
        grid-template-columns: repeat(2, 1fr);
      }
    }

    .stat-card {
      background: white;
      padding: 25px;
      border-radius: 15px;
      text-align: center;
      border: 2px solid #e9ecef;
      transition: all 0.3s ease;
    }

    .stat-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
    }

    .stat-icon {
      font-size: 32px;
      margin-bottom: 15px;
    }

    .stat-value {
      font-size: 28px;
      font-weight: 700;
      color: #2c3e50;
      margin-bottom: 5px;
    }

    .stat-label {
      color: #6c757d;
      font-size: 14px;
      font-weight: 500;
    }

    .action-buttons {
      display: flex;
      gap: 15px;
      justify-content: center;
      margin-top: 30px;
      flex-wrap: wrap;
    }

    .btn-action {
      padding: 12px 30px;
      border-radius: 12px;
      font-weight: 600;
      font-size: 16px;
      transition: all 0.3s ease;
      text-decoration: none;
      display: inline-flex;
      align-items: center;
      border: none;
    }

    .btn-action i {
      margin-right: 8px;
    }

    .btn-edit {
      background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
      color: white;
    }

    .btn-edit:hover {
      color: white;
      transform: translateY(-2px);
      box-shadow: 0 10px 25px rgba(79, 172, 254, 0.3);
    }

    .btn-password {
      background: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
      color: white;
    }

    .btn-password:hover {
      color: white;
      transform: translateY(-2px);
      box-shadow: 0 10px 25px rgba(250, 112, 154, 0.3);
    }

    .btn-logout {
      background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
      color: white;
    }

    .btn-logout:hover {
      color: white;
      transform: translateY(-2px);
      box-shadow: 0 10px 25px rgba(245, 87, 108, 0.3);
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

    .role-badge {
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      color: white;
      padding: 5px 15px;
      border-radius: 20px;
      font-size: 12px;
      font-weight: 600;
      display: inline-block;
      margin-left: 10px;
    }

    .verified-badge {
      color: #28a745;
      font-size: 18px;
      margin-left: 8px;
    }

    .unverified-badge {
      color: #ffc107;
      font-size: 18px;
      margin-left: 8px;
    }
  </style>
</head>
<body>
<div class="profile-container">
  <div class="profile-card">
    <!-- Header -->
    <div class="profile-header">
      <a href="${pageContext.request.contextPath}/student-dashboard" class="back-button">
        <i class="fas fa-arrow-left"></i>
      </a>
      <h2>My Profile</h2>
      <p>Manage your personal information</p>
    </div>

    <!-- Body -->
    <div class="profile-body">
      <!-- Flash Messages -->
      <c:if test="${not empty message}">
        <div class="alert alert-${messageType} alert-dismissible fade show" role="alert">
          <i class="fas fa-info-circle me-2"></i>
            ${message}
          <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
      </c:if>

      <!-- Avatar Section -->
      <div class="avatar-section">
        <div class="avatar-container">
          <c:choose>
            <c:when test="${not empty user.avatarUrl}">
              <img src="${pageContext.request.contextPath}${user.avatarUrl}"
                   alt="Profile Avatar"
                   class="avatar-img"
                   id="avatarImg">
            </c:when>
            <c:otherwise>
              <img src="${pageContext.request.contextPath}/assets/images/default-avatar.png"
                   alt="Default Avatar"
                   class="avatar-img"
                   id="avatarImg">
            </c:otherwise>
          </c:choose>
          <a href="${pageContext.request.contextPath}/profile/avatar" class="avatar-overlay" title="Change Avatar">
            <i class="fas fa-camera"></i>
          </a>
        </div>

        <h3>${user.firstName} ${user.lastName}
          <span class="role-badge">${sessionScope.userRole}</span>
        </h3>

        <div class="completion-badge">
          <i class="fas fa-chart-line me-2"></i>
          Profile ${profileStats.profileCompletionPercentage}% Complete
        </div>
      </div>

      <!-- Personal Information Section -->
      <div class="info-section">
        <h4 class="mb-4">
          <i class="fas fa-user-circle me-2"></i>
          Personal Information
        </h4>

        <div class="info-grid">
          <div class="info-item">
            <div class="info-label">
              <i class="fas fa-user"></i>
              Username
            </div>
            <div class="info-value">${user.username}</div>
          </div>

          <div class="info-item">
            <div class="info-label">
              <i class="fas fa-envelope"></i>
              Email Address
            </div>
            <div class="info-value">
              ${user.email}
              <!-- Email verification is not supported in the new User entity -->
              <i class="fas fa-exclamation-circle unverified-badge" title="Not Verified"></i>
            </div>
          </div>

          <div class="info-item">
            <div class="info-label">
              <i class="fas fa-phone"></i>
              Phone Number
            </div>
            <div class="info-value">
              <c:choose>
                <c:when test="${not empty user.phoneNumber}">
                  ${user.phoneNumber}
                </c:when>
                <c:otherwise>
                  <span class="text-muted">Not provided</span>
                </c:otherwise>
              </c:choose>
            </div>
          </div>

          <div class="info-item">
            <div class="info-label">
              <i class="fas fa-calendar"></i>
              Date of Birth
            </div>
            <div class="info-value">
              <c:choose>
                <c:when test="${not empty user.dateOfBirth}">
                  <c:set var="datePattern" value="dd MMM yyyy" />
                  <fmt:parseDate value="${user.dateOfBirth}" pattern="yyyy-MM-dd" var="parsedDate" type="date" />
                  <fmt:formatDate value="${parsedDate}" pattern="${datePattern}" />
                </c:when>
                <c:otherwise>
                  <span class="text-muted">Not provided</span>
                </c:otherwise>
              </c:choose>
            </div>
          </div>
        </div>
      </div>

      <!-- Statistics Section -->
      <div class="stats-section">
        <h4 class="mb-4">
          <i class="fas fa-chart-bar me-2"></i>
          Account Statistics
        </h4>

        <div class="stats-grid">
          <div class="stat-card">
            <div class="stat-icon" style="color: #4facfe;">
              <i class="fas fa-user-clock"></i>
            </div>
            <div class="stat-value">${profileStats.accountAgeFormatted}</div>
            <div class="stat-label">Account Age</div>
          </div>

          <div class="stat-card">
            <div class="stat-icon" style="color: #00f2fe;">
              <i class="fas fa-sign-in-alt"></i>
            </div>
            <div class="stat-value">${profileStats.lastLoginFormatted}</div>
            <div class="stat-label">Last Login</div>
          </div>

          <c:if test="${sessionScope.userRole == 'USER'}">
            <div class="stat-card">
              <div class="stat-icon" style="color: #fa709a;">
                <i class="fas fa-book"></i>
              </div>
              <div class="stat-value">12</div>
              <div class="stat-label">Enrolled Courses</div>
            </div>

            <div class="stat-card">
              <div class="stat-icon" style="color: #fee140;">
                <i class="fas fa-certificate"></i>
              </div>
              <div class="stat-value">3</div>
              <div class="stat-label">Certificates</div>
            </div>
          </c:if>

          <c:if test="${sessionScope.userRole == 'TEACHER'}">
            <div class="stat-card">
              <div class="stat-icon" style="color: #fa709a;">
                <i class="fas fa-chalkboard-teacher"></i>
              </div>
              <div class="stat-value">8</div>
              <div class="stat-label">Courses Created</div>
            </div>

            <div class="stat-card">
              <div class="stat-icon" style="color: #fee140;">
                <i class="fas fa-users"></i>
              </div>
              <div class="stat-value">156</div>
              <div class="stat-label">Total Students</div>
            </div>
          </c:if>
        </div>
      </div>

      <!-- Action Buttons -->
      <div class="action-buttons">
        <a href="${pageContext.request.contextPath}/profile/edit" class="btn btn-action btn-edit">
          <i class="fas fa-user-edit"></i>
          Edit Profile
        </a>

        <a href="${pageContext.request.contextPath}/profile/password" class="btn btn-action btn-password">
          <i class="fas fa-key"></i>
          Change Password
        </a>

        <a href="${pageContext.request.contextPath}/logout" class="btn btn-action btn-logout">
          <i class="fas fa-sign-out-alt"></i>
          Logout
        </a>
      </div>
    </div>
  </div>
</div>

<!-- Avatar Modal -->
<div class="modal fade" id="avatarModal" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Change Avatar</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body text-center">
        <img src="" id="modalAvatar" class="img-fluid rounded mb-3" style="max-height: 300px;">
        <div class="d-grid gap-2">
          <a href="${pageContext.request.contextPath}/profile/avatar" class="btn btn-primary">
            <i class="fas fa-upload me-2"></i>Upload New Avatar
          </a>
          <c:if test="${not empty user.avatarUrl}">
            <form action="${pageContext.request.contextPath}/profile/delete-avatar" method="post" style="display: inline;">
              <button type="submit" class="btn btn-danger w-100">
                <i class="fas fa-trash me-2"></i>Remove Avatar
              </button>
            </form>
          </c:if>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- Scripts -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
<script>
  // Avatar click to show modal
  document.getElementById('avatarImg').addEventListener('click', function() {
    const modal = new bootstrap.Modal(document.getElementById('avatarModal'));
    document.getElementById('modalAvatar').src = this.src;
    modal.show();
  });

  // Animate stats on page load
  document.addEventListener('DOMContentLoaded', function() {
    const statValues = document.querySelectorAll('.stat-value');
    statValues.forEach(stat => {
      const finalValue = stat.textContent;
      if (!isNaN(finalValue)) {
        let currentValue = 0;
        const increment = Math.ceil(finalValue / 30);
        const timer = setInterval(() => {
          currentValue += increment;
          if (currentValue >= finalValue) {
            currentValue = finalValue;
            clearInterval(timer);
          }
          stat.textContent = currentValue;
        }, 50);
      }
    });
  });

  // Progress bar animation
  const completionPercentage = ${profileStats.profileCompletionPercentage};
  const progressBar = document.createElement('div');
  progressBar.style.cssText = `
        position: fixed;
        top: 0;
        left: 0;
        height: 3px;
        background: linear-gradient(90deg, #4facfe 0%, #00f2fe 100%);
        width: 0%;
        transition: width 1s ease;
        z-index: 9999;
    `;
  document.body.appendChild(progressBar);

  setTimeout(() => {
    progressBar.style.width = completionPercentage + '%';
  }, 100);
</script>
</body>
</html>
