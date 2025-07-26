<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/layout/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Course Details</title>
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
    .course-card {
      background: var(--bg-primary);
      border-radius: 20px;
      box-shadow: var(--shadow-medium);
      border: 1px solid var(--border-light);
      overflow: hidden;
      max-width: 1250px;
      width: 100%;
      margin: auto;
    }
    .course-header {
      background: var(--primary-gradient);
      color: var(--text-white);
      padding: 40px 30px 20px 30px;
      text-align: center;
    }
    .course-header h2 {
      font-weight: 300;
      font-size: 2rem;
      margin-bottom: 10px;
    }
    .course-header p {
      opacity: 0.9;
      font-size: 1rem;
    }
    .course-body {
      padding: 40px;
    }
    .course-detail-section {
      background: var(--bg-secondary);
      border-radius: 15px;
      padding: 30px;
      margin-bottom: 30px;
      box-shadow: var(--shadow-light);
    }
    .course-detail-section h3 {
      color: var(--primary-500);
      font-size: 1.3rem;
      font-weight: 600;
      margin-bottom: 20px;
    }
    .course-detail-section p,
    .course-detail-section a {
      font-size: 15px;
      color: var(--text-secondary);
    }
    .card-footer {
      margin-top: 20px;
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
    .lessons-section, .feedbacks-section {
      margin-bottom: 30px;
    }
    .lesson-list, .feedback-list {
      list-style: none;
      padding: 0;
    }
    .lesson-item, .feedback-item {
      background: var(--bg-primary);
      border-radius: 12px;
      border: 2px solid var(--border-light);
      padding: 18px;
      margin-bottom: 12px;
      transition: var(--transition-medium);
    }
    .lesson-item:hover, .feedback-item:hover {
      border-color: var(--primary-500);
      transform: translateY(-2px);
      box-shadow: 0 5px 15px rgba(102, 126, 234, 0.1);
    }
    .lesson-status, .lesson-preview {
      font-size: 13px;
      margin-left: 8px;
      color: var(--info);
    }
    .feedback-rating {
      color: var(--warning);
      font-weight: 600;
      margin-left: 8px;
    }
    .feedback-comment {
      color: var(--text-primary);
      font-style: italic;
      margin-left: 8px;
    }
    .alert-error {
      background: rgba(220, 53, 69, 0.1);
      border-left: 4px solid var(--error);
      color: var(--error);
      border-radius: 12px;
      padding: 12px 20px;
      margin-bottom: 20px;
    }
    .no-data {
      color: var(--text-secondary);
      font-style: italic;
      margin-top: 10px;
    }
  </style>
</head>
<body>
<div class="course-container">
  <div class="course-card">
    <div class="course-header">
      <h2>Course Details</h2>
      <p>Explore course information, lessons, and feedbacks</p>
    </div>
    <div class="course-body">
      <c:if test="${not empty error}">
        <div class="alert-error">${error}</div>
      </c:if>
      <c:choose>
        <c:when test="${not empty course}">
          <div class="course-detail-section mb-4">
            <h3>${course.courseTitle}</h3>
            <p><strong>Description:</strong> ${course.courseDescription}</p>
            <p><strong>Price:</strong> $<fmt:formatNumber value="${course.price}" type="number" maxFractionDigits="2"/></p>
            <p><strong>Rating:</strong> ${course.rating}</p>
            <p><strong>Teacher:</strong> <a href="instructorInfo?username=${course.teacherName}">${course.teacherName}</a></p>
            <c:if test="${not empty course.categories}">
              <p><strong>Categories:</strong> ${course.categories}</p>
            </c:if>
            <c:if test="${not empty course.courseStatus}">
              <p><strong>Status:</strong> ${course.courseStatus}</p>
            </c:if>
            <c:set var="createdAtInstant" value="${course.createdAt}" />
            <fmt:parseDate value="${createdAtInstant}" pattern="yyyy-MM-dd'T'HH:mm:ss.SSSX" var="parsedDate" type="both" />
            <p><strong>Created At:</strong> <fmt:formatDate value="${parsedDate}" pattern="dd-MM-yyyy"/></p>
            <div class="card-footer">
              <form action="CartServlet" method="post">
                <input type="hidden" name="action" value="add">
                <input type="hidden" name="courseId" value="${course.courseID}" />
                <button type="submit" class="join-btn">Add to cart</button>
              </form>
            </div>
          </div>
          <div class="lessons-section">
            <h3>Lessons</h3>
            <c:choose>
              <c:when test="${not empty lessons}">
                <ul class="lesson-list">
                  <c:forEach var="lesson" items="${lessons}">
                    <li class="lesson-item">
                      <strong>Title:</strong> <a href="lessonPreview?lessonID=${lesson.lessonID}">${lesson.title}</a>
                      <c:if test="${not empty lesson.status}">
                        <span class="lesson-status">(Status: ${lesson.status})</span>
                      </c:if>
                      <c:if test="${lesson.isFreePreview}">
                        <span class="lesson-preview">(Free Preview)</span>
                      </c:if>
                      <br>
                      <c:set var="lessonCreatedAt" value="${lesson.createdAt}" />
                      <fmt:parseDate value="${lessonCreatedAt}" pattern="yyyy-MM-dd'T'HH:mm:ss.SSSX" var="parsedLessonDate" type="both" />
                      <small><strong>Created:</strong> <fmt:formatDate value="${parsedLessonDate}" pattern="HH:mm dd-MM-yyyy"/></small>
                    </li>
                  </c:forEach>
                </ul>
              </c:when>
              <c:otherwise>
                <p class="no-data">No lessons available for this course.</p>
              </c:otherwise>
            </c:choose>
          </div>
          <div class="feedbacks-section">
            <h3>Feedbacks</h3>
            <c:choose>
              <c:when test="${not empty feedbacks}">
                <ul class="feedback-list">
                  <c:forEach var="feedback" items="${feedbacks}">
                    <li class="feedback-item">
                      <strong>User:</strong> ${feedback.userName}
                      <c:if test="${not empty feedback.rating}">
                        <span class="feedback-rating">(Rating: ${feedback.rating}/5)</span>
                      </c:if>
                      <br>
                      <c:if test="${not empty feedback.comment}">
                        <span class="feedback-comment">${feedback.comment}</span>
                      </c:if>
                      <br>
                      <c:set var="feedbackCreatedAt" value="${feedback.createdAt}" />
                      <fmt:parseDate value="${feedbackCreatedAt}" pattern="yyyy-MM-dd'T'HH:mm:ss.SSSX" var="parsedFeedbackDate" type="both" />
                      <small><strong>Created:</strong> <fmt:formatDate value="${parsedFeedbackDate}" pattern="HH:mm dd-MM-yyyy"/></small>
                    </li>
                  </c:forEach>
                </ul>
              </c:when>
              <c:otherwise>
                <p class="no-data">No feedbacks available for this course.</p>
              </c:otherwise>
            </c:choose>
          </div>
        </c:when>
        <c:otherwise>
          <p class="no-data">No course data available.</p>
        </c:otherwise>
      </c:choose>
    </div>
  </div>
</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
</body>
</html>