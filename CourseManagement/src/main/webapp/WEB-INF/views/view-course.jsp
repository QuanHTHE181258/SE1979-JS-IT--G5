<%@ page import="project.demo.coursemanagement.utils.SessionUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/layout/header.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Course List</title>
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
    .course-container {
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 20px;
    }
    .course-card-main {
      background: var(--bg-primary);
      border-radius: 20px;
      box-shadow: var(--shadow-medium);
      border: 1px solid var(--border-light);
      overflow: hidden;
      max-width: 1250px;
      width: 100%;
      margin: auto;
    }
    .course-header-section {
      background: var(--primary-gradient);
      color: var(--text-white);
      padding: 40px 30px 20px 30px;
      text-align: center;
    }
    .course-header-section h2 {
      font-weight: 300;
      font-size: 2rem;
      margin-bottom: 10px;
    }
    .course-header-section p {
      opacity: 0.9;
      font-size: 1rem;
    }
    .course-list-section {
      padding: 40px;
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
    .card-header {
      margin-bottom: 10px;
    }
    .course-code {
      font-size: 13px;
      color: var(--primary-600);
      font-weight: 600;
      margin-bottom: 5px;
      display: block;
    }
    .course-title {
      font-size: 1.2rem;
      font-weight: 700;
      color: var(--text-primary);
      margin-bottom: 5px;
    }
    .course-title a {
      color: var(--primary-500);
      text-decoration: none;
      transition: color 0.2s;
    }
    .course-title a:hover {
      color: #fa709a;
      text-decoration: underline;
    }
    .course-teacher {
      font-size: 14px;
      color: var(--text-secondary);
      margin-bottom: 10px;
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
<div class="course-container">
  <div class="course-card-main">
    <div class="course-header-section">
      <h2>Course List</h2>
      <p>Browse all available courses and enroll today!</p>
    </div>
    <div class="course-list-section">
      <a href="courseCatalog" class="btn btn-outline-primary mb-4"><i class="fas fa-filter me-2"></i>Filter</a>
      <ul class="course-list">
        <c:forEach var="course" items="${courses}">
          <li class="course-card">
            <div class="card-header">
              <span class="course-code">${course.courseID}</span>
              <h3 class="course-title"><a href="courseDetails?courseID=${course.courseID}">${course.courseTitle}</a></h3>
              <p class="course-teacher">${course.teacherName}</p>
            </div>
            <div class="card-body">
              <p class="course-desc">${course.courseDescription}</p>
              <div class="course-detail">
                <p><strong>Price:</strong> ${course.price}VNĐ</p>
                <p><strong>Rating:</strong> ${course.rating}</p>
                <p><strong>Category:</strong> ${course.categories}</p>
                <p><strong>Status:</strong> ${course.courseStatus}</p>
              </div>
            </div>
            <div class="card-footer">
              <form action="CartServlet" method="post">
                <input type="hidden" name="action" value="add">
                <input type="hidden" name="courseId" value="${course.courseID}" />
                <button type="submit" class="join-btn">Add to cart</button>
              </form>
            </div>
          </li>
        </c:forEach>
      </ul>
      <div class="pagination">
        <c:if test="${totalPages > 1}">
          <ul class="pagination-list">
            <c:if test="${currentPage > 1}">
              <li class="page-item">
                <a href="course?page=${currentPage - 1}${searchKeyword != null ? '&search=' : ''}${searchKeyword != null ? searchKeyword : ''}"
                   class="page-link">&laquo; Previous</a>
              </li>
            </c:if>
            <c:forEach begin="1" end="${totalPages}" var="i">
              <li class="page-item ${i == currentPage ? 'active' : ''}">
                <a href="course?page=${i}${searchKeyword != null ? '&search=' : ''}${searchKeyword != null ? searchKeyword : ''}"
                   class="page-link">${i}</a>
              </li>
            </c:forEach>
            <c:if test="${currentPage < totalPages}">
              <li class="page-item">
                <a href="course?page=${currentPage + 1}${searchKeyword != null ? '&search=' : ''}${searchKeyword != null ? searchKeyword : ''}"
                   class="page-link">Next &raquo;</a>
              </li>
            </c:if>
          </ul>
        </c:if>
      </div>
    </div>
  </div>
</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
</body>
</html>
