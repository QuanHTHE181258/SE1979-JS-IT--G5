<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/layout/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
  <title>Thanh toán thành công</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body { background: #f5f6fa; }
    .success-card {
      max-width: 500px;
      margin: 80px auto;
      background: #fff;
      border-radius: 18px;
      box-shadow: 0 8px 32px rgba(102,126,234,0.10);
      padding: 40px 32px 32px 32px;
      text-align: center;
    }
    .success-icon {
      font-size: 60px;
      color: #4BB543;
    }
  </style>
</head>
<body>
<div class="success-card">
  <div class="success-icon mb-3">&#10004;</div>
  <h2 class="mb-3">Thanh toán thành công!</h2>
  <p>Cảm ơn bạn đã thanh toán. Bạn đã được ghi danh vào các khóa học.</p>
  <a href="/CourseManagement_war_exploded/enrollments" class="btn btn-success mt-3">Học Ngay</a>
</div>
</body>
</html>

