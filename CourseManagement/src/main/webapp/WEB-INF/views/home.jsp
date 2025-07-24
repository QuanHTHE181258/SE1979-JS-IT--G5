<%@ page import="project.demo.coursemanagement.utils.SessionUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Course Learning Web</title>
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
      .home-container {
        min-height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 20px;
      }
      .home-card {
        background: var(--bg-primary);
        border-radius: 20px;
        box-shadow: var(--shadow-medium);
        border: 1px solid var(--border-light);
        overflow: hidden;
        max-width: 1250px;
        width: 100%;
        margin: auto;
      }
      .home-header-section {
        background: var(--primary-gradient);
        color: var(--text-white);
        padding: 40px 30px 20px 30px;
        text-align: center;
      }
      .home-header-section h2 {
        font-weight: 300;
        font-size: 2rem;
        margin-bottom: 10px;
      }
      .home-header-section p {
        opacity: 0.9;
        font-size: 1rem;
      }
      .home-slider {
        width: 100%;
        height: 350px;
        overflow: hidden;
        position: relative;
        margin-bottom: 30px;
        border-radius: 20px;
        box-shadow: var(--shadow-light);
        background: var(--bg-secondary);
      }
      .home-slider .slides {
        width: 100%;
        height: 100%;
        position: relative;
        display: flex;
      }
      .home-slider .slide {
        width: 100%;
        height: 100%;
        border-radius: 20px;
        object-fit: cover;
        position: absolute;
        top: 0;
        left: 0;
        transform: translateX(100%);
        transition: transform 0.7s ease-in-out, opacity 0.7s ease-in-out;
        z-index: 1;
        opacity: 0;
      }
      .home-slider .slide.active {
        transform: translateX(0);
        opacity: 1;
        z-index: 2;
      }
      .home-slider .slide.exiting {
        transform: translateX(-100%);
        opacity: 0;
        z-index: 1;
      }
      .section-title {
        font-size: 1.5rem;
        font-weight: 600;
        color: var(--primary-500);
        margin-bottom: 20px;
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
    </style>
</head>
<body>
<div class="home-container">
  <div class="home-card">
    <div class="home-header-section">
      <h2>Welcome to Course Learning Web</h2>
      <p>Discover top-rated, paid, and free courses. Start learning today!</p>
    </div>
    <div class="profile-body" style="padding: 40px;">
      <div class="home-slider mb-5">
        <div class="slides">
          <img src="assets/images/slide1.jpg" class="slide active" alt="Slide 1">
          <img src="assets/images/slide2.jpg" class="slide" alt="Slide 2">
          <img src="assets/images/slide3.jpg" class="slide" alt="Slide 3">
        </div>
      </div>
      <div class="section-title">Highest Rating Courses</div>
      <ul class="course-list">
        <c:forEach var="course" items="${highestRatedCourses}">
          <li class="course-card">
            <div class="card-header">
              <span class="course-code">${course.courseID}</span>
              <h3 class="course-title">${course.courseTitle}</h3>
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
              <form action="CartServlet" method="post">
                <input type="hidden" name="action" value="add">
                <input type="hidden" name="courseId" value="${course.courseID}" />
                <button type="submit" class="join-btn">Add to cart</button>
              </form>
            </div>
          </li>
        </c:forEach>
      </ul>
      <div class="section-title">Paid Courses</div>
      <ul class="course-list">
        <c:forEach var="course" items="${paidCourses}">
          <li class="course-card">
            <div class="card-header">
              <span class="course-code">${course.courseID}</span>
              <h3 class="course-title">${course.courseTitle}</h3>
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
              <form action="CartServlet" method="post">
                <input type="hidden" name="action" value="add">
                <input type="hidden" name="courseId" value="${course.courseID}" />
                <button type="submit" class="join-btn">Add to cart</button>
              </form>
            </div>
          </li>
        </c:forEach>
      </ul>
      <div class="section-title">Free Courses</div>
      <ul class="course-list">
        <c:forEach var="course" items="${freeCourses}">
          <li class="course-card">
            <div class="card-header">
              <span class="course-code">${course.courseID}</span>
              <h3 class="course-title">${course.courseTitle}</h3>
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
              <form action="CartServlet" method="post">
                <input type="hidden" name="action" value="add">
                <input type="hidden" name="courseId" value="${course.courseID}" />
                <button type="submit" class="join-btn">Add to cart</button>
              </form>
            </div>
          </li>
        </c:forEach>
      </ul>
    </div>
  </div>
</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
<script>
  // Simple slider animation
  document.addEventListener('DOMContentLoaded', function() {
    const slides = document.querySelectorAll('.slide');
    let current = 0;
    setInterval(() => {
      slides[current].classList.remove('active');
      slides[current].classList.add('exiting');
      current = (current + 1) % slides.length;
      slides[current].classList.remove('exiting');
      slides[current].classList.add('active');
    }, 3500);
  });
</script>
</body>
</html>