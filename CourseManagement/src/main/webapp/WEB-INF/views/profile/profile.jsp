<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/layout/header.jsp" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Thông Tin Cá Nhân - Hệ Thống Học Trực Tuyến</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
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

    .profile-container {
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 20px;
    }

    .profile-card {
      background: var(--bg-primary);
      backdrop-filter: blur(10px);
      border-radius: 20px;
      box-shadow: var(--shadow-medium);
      border: 1px solid var(--border-light);
      overflow: hidden;
      max-width: 900px;
      width: 100%;
    }

    .profile-header {
      background: var(--primary-gradient);
      color: var(--text-white);
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
      color: var(--text-white);
      text-decoration: none;
      font-size: 18px;
      transition: var(--transition-medium);
    }

    .back-button:hover {
      color: var(--text-white);
      transform: translateX(-5px);
    }

    .profile-body {
      padding: 40px;
    }

    .avatar-section {
      text-align: center;
      margin-bottom: 50px;
    }

    .avatar-container {
      position: relative;
      display: inline-block;
      margin-bottom: 30px;
    }

    .avatar-img {
      width: 200px;
      height: 200px;
      border-radius: 50%;
      object-fit: cover;
      border: 6px solid var(--bg-primary);
      box-shadow: var(--shadow-medium);
      background: var(--bg-secondary);
      transition: var(--transition-medium);
      cursor: pointer;
    }

    .avatar-img:hover {
      transform: scale(1.05);
      box-shadow: 0 12px 40px rgba(0, 0, 0, 0.2);
    }

    .avatar-overlay {
      position: absolute;
      bottom: 5px;
      right: 5px;
      background: var(--primary-gradient);
      color: var(--text-white);
      width: 50px;
      height: 50px;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      cursor: pointer;
      transition: var(--transition-medium);
      border: 4px solid var(--bg-primary);
      font-size: 20px;
    }

    .avatar-overlay:hover {
      transform: scale(1.15);
      box-shadow: 0 8px 20px rgba(102, 126, 234, 0.5);
    }

    .avatar-section h3 {
      margin-top: 15px;
      margin-bottom: 20px;
      font-size: 1.8rem;
      font-weight: 600;
      color: var(--text-primary);
    }

    .completion-badge {
      background: var(--primary-gradient);
      color: var(--text-white);
      padding: 10px 25px;
      border-radius: 25px;
      display: inline-block;
      font-weight: 600;
      font-size: 15px;
      margin-bottom: 30px;
      box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
    }

    .info-section {
      background: var(--bg-secondary);
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
      background: var(--bg-primary);
      padding: 20px;
      border-radius: 12px;
      border: 2px solid var(--border-light);
      transition: var(--transition-medium);
    }

    .info-item:hover {
      border-color: var(--primary-500);
      transform: translateY(-2px);
      box-shadow: 0 5px 15px rgba(102, 126, 234, 0.1);
    }

    .info-label {
      color: var(--text-secondary);
      font-size: 14px;
      font-weight: 600;
      margin-bottom: 8px;
      display: flex;
      align-items: center;
    }

    .info-label i {
      margin-right: 8px;
      color: var(--primary-500);
    }

    .info-value {
      color: var(--text-primary);
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
      background: var(--bg-primary);
      padding: 25px;
      border-radius: 15px;
      text-align: center;
      border: 2px solid var(--border-light);
      transition: var(--transition-medium);
    }

    .stat-card:hover {
      transform: translateY(-5px);
      box-shadow: var(--shadow-medium);
    }

    .stat-icon {
      font-size: 32px;
      margin-bottom: 15px;
    }

    .stat-value {
      font-size: 28px;
      font-weight: 700;
      color: var(--text-primary);
      margin-bottom: 5px;
    }

    .stat-label {
      color: var(--text-secondary);
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
      transition: var(--transition-medium);
      text-decoration: none;
      display: inline-flex;
      align-items: center;
      border: none;
    }

    .btn-action i {
      margin-right: 8px;
    }

    .btn-edit {
      background: var(--primary-gradient);
      color: var(--text-white);
    }

    .btn-edit:hover {
      color: var(--text-white);
      transform: translateY(-2px);
      box-shadow: 0 10px 25px rgba(102, 126, 234, 0.3);
    }

    .btn-password {
      background: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
      color: var(--text-white);
    }

    .btn-password:hover {
      color: var(--text-white);
      transform: translateY(-2px);
      box-shadow: 0 10px 25px rgba(250, 112, 154, 0.3);
    }

    .btn-logout {
      background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
      color: var(--text-white);
    }

    .btn-logout:hover {
      color: var(--text-white);
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

    .role-badge {
      background: var(--primary-gradient);
      color: var(--text-white);
      padding: 5px 15px;
      border-radius: 20px;
      font-size: 12px;
      font-weight: 600;
      display: inline-block;
      margin-left: 10px;
    }

    .verified-badge {
      color: var(--success);
      font-size: 18px;
      margin-left: 8px;
    }

    .unverified-badge {
      color: var(--warning);
      font-size: 18px;
      margin-left: 8px;
    }

    /* New styles for recent enrollments section */
    .recent-enrollments {
      margin-top: 30px;
    }

    .enrollment-item {
      background: white;
      border-radius: 12px;
      padding: 20px;
      margin-bottom: 15px;
      border: 2px solid #e9ecef;
      transition: all 0.3s ease;
    }

    .enrollment-item:hover {
      border-color: #4facfe;
      transform: translateY(-2px);
      box-shadow: 0 5px 15px rgba(79, 172, 254, 0.1);
    }

    .enrollment-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 10px;
    }

    .enrollment-title {
      font-size: 16px;
      font-weight: 600;
      color: #2c3e50;
      margin: 0;
    }

    .enrollment-status {
      padding: 4px 12px;
      border-radius: 20px;
      font-size: 12px;
      font-weight: 600;
      text-transform: uppercase;
    }

    .status-active {
      background: rgba(40, 167, 69, 0.1);
      color: var(--success);
    }

    .status-completed {
      background: rgba(23, 162, 184, 0.1);
      color: var(--info);
    }

    .status-inactive {
      background: rgba(220, 53, 69, 0.1);
      color: var(--error);
    }

    .enrollment-progress {
      margin-top: 10px;
    }

    .progress {
      height: 8px;
      border-radius: 10px;
      background: var(--border-light);
    }

    .progress-bar {
      border-radius: 10px;
      background: var(--primary-gradient);
    }

    .enrollment-meta {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-top: 10px;
      font-size: 12px;
      color: var(--text-secondary);
    }

    .certificate-badge {
      background: linear-gradient(135deg, var(--warning) 0%, #fab1a0 100%);
      color: var(--text-primary);
      padding: 2px 8px;
      border-radius: 12px;
      font-size: 11px;
      font-weight: 600;
      display: inline-flex;
      align-items: center;
    }

    .certificate-badge i {
      margin-right: 4px;
    }
  </style>
</head>
<body>

<div class="container py-5">
  <div class="row">
    <!-- Sidebar Menu -->
    <div class="col-lg-3">
      <div class="profile-sidebar">
        <div class="profile-header text-center mb-4">
          <img src="${user.avatarURL}" alt="Avatar" class="profile-avatar">
          <h5 class="mt-3 mb-1">${user.firstName} ${user.lastName}</h5>
          <p class="text-muted mb-0">${user.email}</p>
        </div>

        <div class="profile-menu">
          <a href="profile" class="menu-item active">
            <i class="bi bi-person-circle"></i> Thông Tin Cá Nhân
          </a>
          <a href="edit-profile" class="menu-item">
            <i class="bi bi-pencil-square"></i> Chỉnh Sửa Thông Tin
          </a>
          <a href="avatar" class="menu-item">
            <i class="bi bi-camera"></i> Thay Đổi Ảnh Đại Diện
          </a>
          <a href="password" class="menu-item">
            <i class="bi bi-key"></i> Đổi Mật Khẩu
          </a>
          <a href="order-history" class="menu-item">
            <i class="bi bi-clock-history"></i> Lịch Sử Giao Dịch
          </a>
        </div>
      </div>
    </div>

    <!-- Main Content -->
    <div class="col-lg-9">
      <div class="profile-content">
        <h3 class="section-title">Thông Tin Cá Nhân</h3>

        <div class="info-section">
          <div class="info-item">
            <label>Họ và Tên:</label>
            <span>${user.firstName} ${user.lastName}</span>
          </div>

          <div class="info-item">
            <label>Email:</label>
            <span>${user.email}</span>
          </div>

          <div class="info-item">
            <label>Số Điện Thoại:</label>
            <span>${user.phoneNumber}</span>
          </div>

          <div class="info-item">
            <label>Ngày Sinh:</label>
            <span>${user.dateOfBirth}</span>
          </div>

          <div class="info-item">
            <label>Ngày Tham Gia:</label>
            <span>${user.createdAt}</span>
          </div>

          <div class="info-item">
            <label>Lần Đăng Nhập Cuối:</label>
            <span>${user.lastLogin}</span>
          </div>
        </div>

        <div class="mt-4">
          <a href="edit-profile" class="btn btn-primary">
            <i class="bi bi-pencil-square me-2"></i>Chỉnh Sửa Thông Tin
          </a>
        </div>
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>