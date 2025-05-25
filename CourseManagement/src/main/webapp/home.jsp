<%--
  Created by IntelliJ IDEA.
  User: hoang
  Date: 5/24/2025
  Time: 9:50 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Course Learning Web</title>
    <link rel="stylesheet" href="css/home-style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <%--  Header  --%>
    <div class="home-header">
        <div class="home-header-logo"><a href="home.jsp" style="text-decoration: none; color: white">Courses Learning Web</a></div>
        <div class="home-header-courses"><a href="courses" style="text-decoration: none; color: white">Courses</a></div>
        <div class="home-header-searchbar">
            <input type="text" placeholder="Search..." class="search-input">
            <span class="search-icon"><i class="fas fa-search"></i></span>
        </div>
        <div class="home-header-login"><a href="login" style="text-decoration: none; color: white">Login</a></div>
        <div class="home-header-register"><a href="register" style="text-decoration: none; color: white">Register</a></div>
    </div>
    <%--  Content container  --%>
    <div class="home-content">
        <%-- Most Viewed Courses --%>
        <div class="home-most-views">
            <h2>Most Viewed Courses</h2>
            <ul class="course-list">
                <li><a href="#">Introduction to Python Programming</a></li>
                <li><a href="#">Web Development with HTML & CSS</a></li>
                <li><a href="#">Data Science Fundamentals</a></li>
            </ul>
        </div>
        <%-- Paid Courses --%>
        <div class="home-paid-course">
            <h2>Paid Courses</h2>
            <ul class="course-list">
                <li><a href="#">Advanced JavaScript Mastery - $49</a></li>
                <li><a href="#">Full-Stack Development Bootcamp - $99</a></li>
                <li><a href="#">Machine Learning Pro - $79</a></li>
            </ul>
        </div>
        <%-- Free Courses --%>
        <div class="home-free-course">
            <h2>Free Courses</h2>
            <ul class="course-list">
                <li><a href="#">Basics of Graphic Design</a></li>
                <li><a href="#">Introduction to SQL</a></li>
                <li><a href="#">Beginner Guitar Lessons</a></li>
            </ul>
        </div>
    </div>

    <%--  Footer  --%>
    <div class="home-footer">
        <div class="footer-content">
            <h3>Courses Learning Web</h3>
            <p>Email: example@gmail.com</p>
            <p>Phone: 000-000-0000</p>
            <p>Address: 123 Learning Street, Education City</p>
            <div class="social-icons">
                <a href="https://facebook.com" target="_blank"><i class="fab fa-facebook-f"></i></a>
                <a href="https://instagram.com" target="_blank"><i class="fab fa-instagram"></i></a>
                <a href="https://github.com" target="_blank"><i class="fab fa-github"></i></a>
            </div>
            <p>&copy; 2025 Courses Learning Web. All rights reserved.</p>
        </div>
    </div>

</body>
</html>
