<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/layout/header.jsp" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Chỉnh Sửa Thông Tin - Hệ Thống Học Trực Tuyến</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
  <style>
    :root {
      --primary-color: #007bff;
      --secondary-color: #6c757d;
      --success-color: #28a745;
      --danger-color: #dc3545;
      --warning-color: #ffc107;
      --info-color: #17a2b8;
      --light-color: #f8f9fa;
      --dark-color: #343a40;
      --font-family-sans-serif: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      --font-family-serif: Georgia, 'Times New Roman', Times, serif;
      --font-family-monospace: Menlo, Monaco, Consolas, 'Courier New', monospace;
    }

    body {
      font-family: var(--font-family-sans-serif);
      background-color: var(--light-color);
    }

    .container {
      max-width: 900px;
      margin: 0 auto;
      padding: 30px;
      background-color: #fff;
      border-radius: 8px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }

    .section-title {
      font-size: 1.5rem;
      font-weight: 600;
      margin-bottom: 20px;
      position: relative;
    }

    .section-title::after {
      content: '';
      position: absolute;
      width: 100%;
      height: 2px;
      bottom: -5px;
      left: 0;
      background: var(--primary-color);
    }

    .form-label {
      font-weight: 500;
      margin-bottom: 10px;
    }

    .form-control {
      border: 1px solid #ced4da;
      border-radius: 0.375rem;
      padding: 10px;
      font-size: 16px;
      transition: border-color 0.3s;
    }

    .form-control:focus {
      border-color: var(--primary-color);
      box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
    }

    .form-control.is-invalid {
      border-color: var(--danger-color);
      background-color: #fff5f5;
    }

    .form-control.is-valid {
      border-color: var(--success-color);
      background-color: #f8fff9;
    }

    .invalid-feedback {
      font-size: 0.875rem;
      color: var(--danger-color);
    }

    .btn-primary {
      background-color: var(--primary-color);
      border-color: var(--primary-color);
      padding: 10px 20px;
      font-size: 16px;
      border-radius: 0.375rem;
      transition: background-color 0.3s, transform 0.3s;
    }

    .btn-primary:hover {
      background-color: dark(var(--primary-color), 10%);
      transform: translateY(-2px);
    }

    .btn-secondary {
      background-color: var(--secondary-color);
      border-color: var(--secondary-color);
      padding: 10px 20px;
      font-size: 16px;
      border-radius: 0.375rem;
      transition: background-color 0.3s, transform 0.3s;
    }

    .btn-secondary:hover {
      background-color: darken(var(--secondary-color), 10%);
      transform: translateY(-2px);
    }

    .profile-sidebar {
      background-color: #fff;
      padding: 20px;
      border-radius: 0.375rem;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }

    .profile-header {
      margin-bottom: 20px;
    }

    .profile-avatar {
      width: 100px;
      height: 100px;
      border-radius: 50%;
      object-fit: cover;
      border: 4px solid var(--primary-color);
      box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 32px;
      color: var(--secondary-color);
      background-color: var(--light-color);
    }

    .profile-menu {
      list-style: none;
      padding: 0;
      margin: 0;
    }

    .menu-item {
      display: flex;
      align-items: center;
      padding: 10px;
      border-radius: 0.375rem;
      transition: background-color 0.3s;
      text-decoration: none;
      color: var(--dark-color);
    }

    .menu-item i {
      margin-right: 10px;
      font-size: 18px;
      color: var(--primary-color);
    }

    .menu-item:hover {
      background-color: rgba(0, 123, 255, 0.1);
    }

    .menu-item.active {
      background-color: rgba(0, 123, 255, 0.2);
      font-weight: 500;
    }

    @media (max-width: 576px) {
      .container {
        padding: 15px;
      }

      .section-title {
        font-size: 1.25rem;
      }

      .btn-primary,
      .btn-secondary {
        width: 100%;
        padding: 12px;
        font-size: 18px;
      }

      .profile-avatar {
        width: 80px;
        height: 80px;
      }
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
          <!-- Check if avatar URL exists and is not empty -->
          <%
            String avatarUrl = null;
            Object userObj = request.getAttribute("user");
            if (userObj != null) {
              try {
                project.demo.coursemanagement.entities.User user = (project.demo.coursemanagement.entities.User) userObj;
                avatarUrl = user.getAvatarUrl();
              } catch (Exception e) {
                // Handle silently
              }
            }
          %>

          <% if (avatarUrl != null && !avatarUrl.trim().isEmpty()) { %>
          <img src="${pageContext.request.contextPath}${user.avatarUrl}"
               alt="Ảnh đại diện"
               class="profile-avatar"
               onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';">
          <div class="profile-avatar" style="display: none;">
            <i class="bi bi-person-circle"></i>
          </div>
          <% } else { %>
          <div class="profile-avatar">
            <i class="bi bi-person-circle"></i>
          </div>
          <% } %>

          <h5 class="mt-3 mb-1">${user.firstName} ${user.lastName}</h5>
        </div>

        <div class="profile-menu">
          <a href="${pageContext.request.contextPath}/profile" class="menu-item">
            <i class="bi bi-person-circle"></i> Thông Tin Cá Nhân
          </a>
          <a href="${pageContext.request.contextPath}/profile/edit" class="menu-item active">
            <i class="bi bi-pencil-square"></i> Chỉnh Sửa Thông Tin
          </a>
          <a href="${pageContext.request.contextPath}/profile/avatar" class="menu-item">
            <i class="bi bi-camera"></i> Thay Đổi Ảnh Đại Diện
          </a>
          <a href="${pageContext.request.contextPath}/profile/password" class="menu-item">
            <i class="bi bi-key"></i> Đổi Mật Khẩu
          </a>
          <a href="${pageContext.request.contextPath}/profile/orders" class="menu-item">
            <i class="bi bi-clock-history"></i> Lịch Sử Giao Dịch
          </a>
        </div>
      </div>
    </div>

    <!-- Main Content -->
    <div class="col-lg-9">
      <div class="profile-content">
        <h3 class="section-title">Chỉnh Sửa Thông Tin Cá Nhân</h3>

        <!-- Display any error or success messages -->
        <% if (request.getAttribute("messageType") != null) { %>
        <div class="alert alert-<%= request.getAttribute("messageType") %> alert-dismissible fade show" role="alert">
          <% if (request.getAttribute("errors") != null) { %>
          <ul class="mb-0">
            <% for (String error : (java.util.List<String>) request.getAttribute("errors")) { %>
            <li><%= error %></li>
            <% } %>
          </ul>
          <% } else if (request.getAttribute("message") != null) { %>
          <%= request.getAttribute("message") %>
          <% } %>
          <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <% } %>

        <form action="${pageContext.request.contextPath}/profile/edit" method="post" class="needs-validation" novalidate>
          <div class="row mb-3">
            <div class="col-md-6">
              <label for="firstName" class="form-label">Họ <span class="text-danger">*</span></label>
              <input type="text" class="form-control" id="firstName" name="firstName"
                     value="${user.firstName}" required>
              <div class="invalid-feedback">Vui lòng nhập họ của bạn</div>
            </div>
            <div class="col-md-6">
              <label for="lastName" class="form-label">Tên <span class="text-danger">*</span></label>
              <input type="text" class="form-control" id="lastName" name="lastName"
                     value="${user.lastName}" required>
              <div class="invalid-feedback">Vui lòng nhập tên của bạn</div>
            </div>
          </div>

          <div class="mb-3">
            <label for="email" class="form-label">Email <span class="text-danger">*</span></label>
            <input type="email" class="form-control" id="email" name="email"
                   value="${user.email}" required>
            <div class="invalid-feedback">Vui lòng nhập email hợp lệ</div>
          </div>

          <div class="mb-3">
            <label for="phoneNumber" class="form-label">Số Điện Thoại</label>
            <input type="tel" class="form-control" id="phoneNumber" name="phoneNumber"
                   value="${user.phoneNumber}">
            <div class="invalid-feedback">Vui lòng nhập số điện thoại hợp lệ</div>
          </div>

          <div class="mb-4">
            <label for="dateOfBirth" class="form-label">Ngày Sinh</label>
            <input type="date" class="form-control" id="dateOfBirth" name="dateOfBirth"
                   value="${user.dateOfBirth}">
          </div>

          <div class="d-flex gap-3">
            <button type="submit" class="btn btn-primary">
              <i class="bi bi-check-circle me-2"></i>Lưu Thay Đổi
            </button>
            <a href="${pageContext.request.contextPath}/profile" class="btn btn-secondary">
              <i class="bi bi-x-circle me-2"></i>Hủy
            </a>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
  // Form validation
  (function () {
    'use strict'
    const forms = document.querySelectorAll('.needs-validation')
    Array.from(forms).forEach(form => {
      form.addEventListener('submit', event => {
        if (!form.checkValidity()) {
          event.preventDefault()
          event.stopPropagation()
        }
        form.classList.add('was-validated')
      }, false)
    })
  })()

  // Phone number validation
  document.getElementById('phoneNumber').addEventListener('input', function(e) {
    const value = e.target.value.replace(/\D/g, '');
    if (value.length > 0 && !/^[0-9]{10,11}$/.test(value)) {
      e.target.setCustomValidity('Số điện thoại phải có 10-11 chữ số');
    } else {
      e.target.setCustomValidity('');
    }
  });
</script>
</body>
</html>