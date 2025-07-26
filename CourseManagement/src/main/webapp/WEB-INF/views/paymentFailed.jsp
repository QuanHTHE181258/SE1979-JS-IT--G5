<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/layout/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
  <title>Thanh toán thất bại</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body { background: #f5f6fa; }
    .fail-card {
      max-width: 500px;
      margin: 80px auto;
      background: #fff;
      border-radius: 18px;
      box-shadow: 0 8px 32px rgba(234,102,102,0.10);
      padding: 40px 32px 32px 32px;
      text-align: center;
    }
    .fail-icon {
      font-size: 60px;
      color: #d9534f;
    }
  </style>
</head>
<body>
<div class="fail-card">
  <div class="fail-icon mb-3">&#10008;</div>
  <h2 class="mb-3">Thanh toán thất bại!</h2>
  <p>Giao dịch không thành công. Vui lòng thử lại hoặc liên hệ hỗ trợ.</p>
  <a href="/CourseManagement_war_exploded/home" class="btn btn-danger mt-3">Thử lại</a>
</div>
</body>
</html>

