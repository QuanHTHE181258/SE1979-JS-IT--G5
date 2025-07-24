<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Instructor Info</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
  <style>
    :root {
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
    .instructor-container {
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 20px;
    }
    .instructor-card {
      background: var(--bg-primary);
      border-radius: 20px;
      box-shadow: var(--shadow-medium);
      border: 1px solid var(--border-light);
      overflow: hidden;
      max-width: 1250px;
      width: 100%;
      margin: auto;
    }
    .instructor-header {
      background: var(--primary-gradient);
      color: var(--text-white);
      padding: 40px 30px 20px 30px;
      text-align: center;
    }
    .instructor-header h2 {
      font-weight: 300;
      font-size: 2rem;
      margin-bottom: 10px;
    }
    .instructor-header p {
      opacity: 0.9;
      font-size: 1rem;
    }
    .instructor-body {
      padding: 40px;
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
    .courses-section {
      margin-top: 30px;
    }
    .course-list {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
      gap: 25px;
      list-style: none;
      padding: 0;
    }
    .course-card {
      background: var(--bg-secondary);
      border-radius: 15px;
      box-shadow: var(--shadow-light);
      border: 2px solid var(--border-light);
      padding: 20px;
      transition: var(--transition-medium);
      display: flex;
      flex-direction: column;
      justify-content: space-between;
    }
    .course-card:hover {
      border-color: var(--primary-500);
      transform: translateY(-2px);
      box-shadow: 0 5px 15px rgba(102, 126, 234, 0.1);
    }
    .course-title {
      font-size: 1.2rem;
      font-weight: 700;
      color: var(--primary-500);
      margin-bottom: 5px;
    }
    .course-desc {
      font-size: 15px;
      color: var(--text-secondary);
      margin-bottom: 10px;
    }
    .course-detail p {
      font-size: 14px;
      margin-bottom: 4px;
    }
    .card-footer {
      margin-top: 10px;
      text-align: right;
    }
    .join-btn {
      background: var(--primary-gradient);
      color: var(--text-white);
      border: none;
      border-radius: 10px;
      padding: 8px 20px;
      font-weight: 600;
      font-size: 15px;
      transition: var(--transition-medium);
    }
    .join-btn:hover {
      background: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
      color: var(--text-white);
      box-shadow: 0 10px 25px rgba(250, 112, 154, 0.3);
    }
    .pagination {
      margin-top: 40px;
      text-align: center;
    }
    .pagination-list {
      display: inline-flex;
      gap: 8px;
      padding: 0;
      list-style: none;
    }
    .page-item {
      display: inline-block;
    }
    .page-link {
      background: var(--bg-secondary);
      color: var(--primary-500);
      border-radius: 8px;
      padding: 8px 16px;
      text-decoration: none;
      font-weight: 600;
      border: 2px solid var(--border-light);
      transition: var(--transition-medium);
    }
    .page-item.active .page-link,
    .page-link:hover {
      background: var(--primary-gradient);
      color: var(--text-white);
      border-color: var(--primary-500);
    }
  </style>
</head>
<body>
<div class="instructor-container">
  <div class="instructor-card">
    <div class="instructor-header">
      <h2>Instructor Information</h2>
      <p>Details and courses taught by this instructor</p>
    </div>
    <div class="instructor-body">
      <div class="info-section mb-4">
        <div class="info-grid">
          <div class="info-item">
            <div class="info-label"><i class="fas fa-user"></i>Full Name</div>
            <div class="info-value">${instructor.fullName}</div>
          </div>
          <div class="info-item">
            <div class="info-label"><i class="fas fa-envelope"></i>Email</div>
            <div class="info-value">${instructor.email}</div>
          </div>
          <div class="info-item">
            <div class="info-label"><i class="fas fa-user-circle"></i>Username</div>
            <div class="info-value">${instructor.username}</div>
          </div>
          <div class="info-item">
            <div class="info-label"><i class="fas fa-phone"></i>Phone Number</div>
            <div class="info-value">${instructor.phoneNumber}</div>
          </div>
        </div>
      </div>
      <div class="courses-section">
        <h4 class="mb-4"><i class="fas fa-chalkboard-teacher me-2"></i>Courses Taught by ${instructor.fullName}</h4>
        <c:if test="${empty courses}">
          <p class="text-muted">This instructor has no courses.</p>
        </c:if>
        <ul class="course-list">
          <c:forEach var="course" items="${courses}">
            <li class="course-card">
              <div class="course-title">${course.courseID}. ${course.courseTitle}</div>
              <div class="course-desc">${course.courseDescription}</div>
              <div class="course-detail">
                <p><strong>Price:</strong> $${course.price}</p>
                <p><strong>Rating:</strong> ${course.rating}</p>
                <p><strong>Status:</strong> ${course.courseStatus}</p>
              </div>
              <div class="card-footer">
                <a href="login.jsp" class="join-btn">Join</a>
              </div>
            </li>
          </c:forEach>
        </ul>
        <c:if test="${totalPages > 1}">
          <div class="pagination">
            <ul class="pagination-list">
              <c:if test="${currentPage > 1}">
                <li class="page-item">
                  <a href="instructorInfo?username=${instructor.username}&page=${currentPage - 1}" class="page-link">&laquo; Prev</a>
                </li>
              </c:if>
              <c:forEach var="i" begin="1" end="${totalPages}">
                <li class="page-item ${i == currentPage ? 'active' : ''}">
                  <a href="instructorInfo?username=${instructor.username}&page=${i}" class="page-link">${i}</a>
                </li>
              </c:forEach>
              <c:if test="${currentPage < totalPages}">
                <li class="page-item">
                  <a href="instructorInfo?username=${instructor.username}&page=${currentPage + 1}" class="page-link">Next &raquo;</a>
                </li>
              </c:if>
            </ul>
          </div>
        </c:if>
      </div>
    </div>
  </div>
</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
</body>
</html>
