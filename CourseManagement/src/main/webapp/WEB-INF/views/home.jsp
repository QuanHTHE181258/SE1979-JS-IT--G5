<%@ page import="project.demo.coursemanagement.utils.SessionUtil" %><%--
  Created by IntelliJ IDEA.
  User: hoang
  Date: 5/24/2025
  Time: 9:50 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <title>Course Learning Web</title>
    <link rel="stylesheet" href="css/home-style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .home-slider {
            width: 80%;
            height: 500px;
            overflow: hidden;
            position: relative;
            margin-bottom: 30px;
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
            border-radius: 10px;
            object-fit: contain;
            position: absolute;
            top: 0;
            left: 0;
            transform: translateX(100%);
            transition: transform 0.7s ease-in-out, opacity 0.7s ease-in-out;
            z-index: 1;
            opacity: 0;
        }

        .home-slider h2 {
            font-size: 24px;
            color: #333;
            margin-bottom: 15px;
            text-align: center;
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
    </style>
</head>
<body>
    <%-- Header --%>
    <div class="home-header">
        <div class="home-header-logo"><a href="home" style="text-decoration: none; color: white">Courses Learning Web</a></div>
        <div class="home-header-courses"><a href="course" style="text-decoration: none; color: white">Courses</a></div>
        <div class="home-header-searchbar">
            <input type="text" placeholder="Search..." class="search-input">
            <span class="search-icon"><i class="fas fa-search"></i></span>
        </div>
            <%if(SessionUtil.isUserLoggedIn(request)){ %>
                    <div><a href="CartServlet" style="text-decoration: none; color: white">Cart</a></div>
            <% } else { %>
                <div class="home-header-login"><a href="login" style="text-decoration: none; color: white">Login</a></div>
                <div class="home-header-register"><a href="register" style="text-decoration: none; color: white">Register</a></div>
                <div class="home-header-profile"><a href="profile" style="text-decoration: none; color: white">Profile</a></div>
           <%}%>


    </div>
    <%-- Content container --%>
    <div class="home-content">
        <div class="home-slider">
            <h2>News</h2>
            <div class="slides">
                <img src="assets/images/slide1.jpg" class="slide active" alt="Slide 1">
                <img src="assets/images/slide2.jpg" class="slide" alt="Slide 2">
                <img src="assets/images/slide3.jpg" class="slide" alt="Slide 3">
            </div>
        </div>
        <%-- Most Popular Courses --%>
        <div class="home-most-views">
            <h2>Highest Rating Courses</h2>
            <ul class="course-list">
                <c:forEach var="course" items="${highestRatedCourses}">
                    <li class="course-card col-3">
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

                                <button type="submit" class="join-btn">Add to card</button>
                            </form>
                        </div>
                    </li>
                </c:forEach>
            </ul>
        </div>
        <%-- Paid Courses --%>
        <div class="home-paid-course">
            <h2>Paid Courses</h2>
            <ul class="course-list">
                <c:forEach var="course" items="${paidCourses}">
                    <li class="course-card col-3">
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

                                <button type="submit" class="join-btn">Add to card</button>
                            </form>
                        </div>
                    </li>
                </c:forEach>
            </ul>
        </div>
        <%-- Free Courses --%>
        <div class="home-free-course">
            <h2>Free Courses</h2>
            <ul class="course-list">
                <c:forEach var="course" items="${freeCourses}">
                    <li class="course-card col-3">
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

                                <button type="submit" class="join-btn">Add to card</button>
                            </form>
                        </div>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </div>
    <%-- Footer --%>
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
            <p>© 2025 Courses Learning Web. All rights reserved.</p>
        </div>
    </div>

    <script>
        let currentSlide = 0;
        const slides = document.querySelectorAll('.slide');

        function showSlide(index) {
            slides.forEach((slide, i) => {
                slide.classList.remove('active', 'exiting', 'entering');
                if (i === index) {
                    slide.classList.add('entering');
                    setTimeout(() => slide.classList.replace('entering', 'active'), 50);
                } else if (i === currentSlide) {
                    slide.classList.add('exiting');
                }
            });
            currentSlide = index;
        }

        function nextSlide() {
            const nextIndex = (currentSlide + 1) % slides.length;
            showSlide(nextIndex);
        }

        document.addEventListener('DOMContentLoaded', () => {
            showSlide(currentSlide); // Khởi tạo slide đầu tiên
            setInterval(nextSlide, 5000);
        });
    </script>
</body>
</html>