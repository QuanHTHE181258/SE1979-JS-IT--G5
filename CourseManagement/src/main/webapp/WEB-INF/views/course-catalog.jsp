<%--
  Created by IntelliJ IDEA.
  User: hoang
  Date: 7/20/2025
  Time: 1:43 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/layout/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Course Catalog</title>
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
    .catalog-container {
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 20px;
    }
    .catalog-card {
      background: var(--bg-primary);
      border-radius: 20px;
      box-shadow: var(--shadow-medium);
      border: 1px solid var(--border-light);
      overflow: hidden;
      max-width: 1250px;
      width: 100%;
      margin: auto;
    }
    .catalog-header-section {
      background: var(--primary-gradient);
      color: var(--text-white);
      padding: 40px 30px 20px 30px;
      text-align: center;
    }
    .catalog-header-section h2 {
      font-weight: 300;
      font-size: 2rem;
      margin-bottom: 10px;
    }
    .catalog-header-section p {
      opacity: 0.9;
      font-size: 1rem;
    }
    .catalog-body {
      padding: 40px;
    }
    .filter-form {
      display: flex;
      gap: 15px;
      flex-wrap: wrap;
      margin-bottom: 30px;
      align-items: center;
      justify-content: center;
    }
    .filter-form select,
    .filter-form button {
      padding: 8px 16px;
      border-radius: 8px;
      border: 2px solid var(--border-light);
      font-size: 15px;
      background: var(--bg-secondary);
      color: var(--text-primary);
      transition: var(--transition-medium);
    }
    .filter-form button {
      background: var(--primary-gradient);
      color: var(--text-white);
      font-weight: 600;
      border: none;
    }
    .filter-form button:hover {
      background: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
      color: var(--text-white);
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
    .pagination a {
      background: var(--bg-secondary);
      color: var(--primary-500);
      border-radius: 8px;
      padding: 8px 16px;
      text-decoration: none;
      font-weight: 600;
      border: 2px solid var(--border-light);
      margin: 0 5px;
      transition: var(--transition-medium);
      display: inline-block;
    }
    .pagination a.current,
    .pagination a:hover {
      background: var(--primary-gradient);
      color: var(--text-white);
      border-color: var(--primary-500);
    }
    .no-course-message {
      color: var(--text-secondary);
      font-style: italic;
      text-align: center;
      margin-top: 30px;
    }
  </style>
</head>
<body>
<div class="catalog-container">
  <div class="catalog-card">
    <div class="catalog-header-section">
      <h2>Course Catalog</h2>
      <p>Filter and explore all available courses</p>
    </div>
    <div class="catalog-body">
      <form action="courseCatalog" method="get" class="filter-form">
        <select name="category">
          <option value="">--Category--</option>
          <option value="Lập trình" <c:if test="${category == 'Lập trình'}">selected</c:if>>Lập trình</option>
          <option value="Thiết kế web" <c:if test="${category == 'Thiết kế web'}">selected</c:if>>Thiết kế web</option>
          <option value="Cơ sở dữ liệu" <c:if test="${category == 'Cơ sở dữ liệu'}">selected</c:if>>Cơ sở dữ liệu</option>
        </select>
        <select name="priceRange">
          <option value="">--Price--</option>
          <option value="Free" <c:if test="${priceRange == 'Free'}">selected</c:if>>Miễn phí</option>
          <option value="Under100000" <c:if test="${priceRange == 'Under100000'}">selected</c:if>>Dưới 100,000</option>
          <option value="100000to500000" <c:if test="${priceRange == '100000to500000'}">selected</c:if>>100,000 - 500,000</option>
          <option value="Above500000" <c:if test="${priceRange == 'Above500000'}">selected</c:if>>Trên 500,000</option>
        </select>
        <select name="ratingRange">
          <option value="">--Rating--</option>
          <option value="Under2" <c:if test="${ratingRange == 'Under2'}">selected</c:if>>Dưới 2</option>
          <option value="2to4" <c:if test="${ratingRange == '2to4'}">selected</c:if>>2 - 4</option>
          <option value="Above4" <c:if test="${ratingRange == 'Above4'}">selected</c:if>>Trên 4</option>
        </select>
        <select name="status">
          <option value="">--Status--</option>
          <option value="active" <c:if test="${status == 'active'}">selected</c:if>>Active</option>
          <option value="inactive" <c:if test="${status == 'inactive'}">selected</c:if>>Inactive</option>
          <option value="draft" <c:if test="${status == 'draft'}">selected</c:if>>Draft</option>
        </select>
        <button type="submit"><i class="fas fa-filter me-2"></i>Filter</button>
      </form>
      <c:choose>
        <c:when test="${empty courses}">
          <p class="no-course-message">No course found</p>
        </c:when>
        <c:otherwise>
          <ul class="course-list">
            <c:forEach var="course" items="${courses}">
              <li class="course-card">
                <div class="card-header">
                  <span class="course-code">${course.courseID}</span>
                  <h3 class="course-title">
                    <a href="courseDetails?courseID=${course.courseID}">${course.courseTitle}</a>
                  </h3>
                  <p class="course-teacher">${course.teacherName}</p>
                </div>
                <div class="card-body">
                  <p class="course-desc">${course.courseDescription}</p>
                  <div class="course-detail">
                    <p><strong>Price:</strong> $${course.price}</p>
                    <p><strong>Rating:</strong> ${course.rating}</p>
                    <p><strong>Category:</strong> ${course.categories}</p>
                    <p><strong>Status:</strong> ${course.courseStatus}</p>
                  </div>
                </div>
                <div class="card-footer">
                  <a href="login"><button class="join-btn">JOIN</button></a>
                </div>
              </li>
            </c:forEach>
          </ul>
          <div class="pagination">
            <c:forEach var="i" begin="1" end="${totalPages}">
              <c:choose>
                <c:when test="${i == currentPage}">
                  <a class="current">${i}</a>
                </c:when>
                <c:otherwise>
                  <a href="courseCatalog?page=${i}&category=${category}&priceRange=${priceRange}&ratingRange=${ratingRange}&status=${status}">${i}</a>
                </c:otherwise>
              </c:choose>
            </c:forEach>
          </div>
        </c:otherwise>
      </c:choose>
    </div>
  </div>
</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
</body>
</html>
