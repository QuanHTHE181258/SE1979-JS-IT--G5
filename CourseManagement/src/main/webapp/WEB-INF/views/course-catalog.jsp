<%--
  Created by IntelliJ IDEA.
  User: hoang
  Date: 7/20/2025
  Time: 1:43 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <title>Course Catalog</title>
    <style>
        body {
            margin: 0;
            font-family: "Work Sans", sans-serif;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        .course-list {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
            padding: 0;
        }

        .course-list li {
            margin: 10px 0;
            font-size: 16px;
        }

        .course-list li a {
            text-decoration: none;
            color: #007bff;
            transition: color 0.3s;
        }

        .course-list li a:hover {
            color: #0056b3;
        }

        .course-card {
            background: linear-gradient(135deg, #7f5af0, #5c3ec5);
            color: white;
            border-radius: 15px;
            padding: 17px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            width: 400px;
            flex-shrink: 0;
        }

        .course-card:hover {
            cursor: pointer;
        }

        .card-header {
            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
            padding-bottom: 10px;
            margin-bottom: 10px;
        }

        .course-code {
            font-size: 12px;
            background: #5ce1e6;
            padding: 4px 8px;
            border-radius: 8px;
            color: black;
            display: inline-block;
            margin-bottom: 10px;
        }

        .course-title {
            margin: 0;
            font-size: 18px;
            font-weight: bold;
        }

        .course-teacher {
            font-size: 14px;
            opacity: 0.9;
        }

        .card-body {
            font-size: 14px;
            margin-top: 10px;
            background: white;
            color: black;
            padding: 5px 15px;
            border-radius: 15px;
        }

        .course-details p {
            margin: 4px 0;
        }

        .card-footer {
            margin-top: 15px;
            text-align: center;
        }

        .join-btn {
            background-color: white;
            color: #5c3ec5;
            border: none;
            padding: 10px 20px;
            border-radius: 10px;
            font-weight: bold;
            cursor: pointer;
            transition: background 0.3s;
        }

        .join-btn:hover {
            background-color: #f0f0f0;
        }

        .pagination {
            display: flex;
            justify-content: center;
            margin-top: 30px;
        }

        .pagination a {
            margin: 0 5px;
            padding: 8px 12px;
            background-color: #f0f0f0;
            color: #333;
            text-decoration: none;
            border-radius: 5px;
        }

        .pagination a.current {
            background-color: #5c3ec5;
            color: white;
            font-weight: bold;
        }
    </style>
</head>
<body>
<form action="courseCatalog" method="get">
    <select name="category">
        <option value="">--Category--</option>
        <option value="Lập trình">Lập trình</option>
        <option value="Thiết kế web">Thiết kế web</option>
        <option value="Cơ sở dữ liệu">Cơ sở dữ liệu</option>
    </select>

    <select name="priceRange">
        <option value="">--Price--</option>
        <option value="0-100000">0 - 100,000</option>
        <option value="100000-200000">100,000 - 200,000</option>
        <option value="200000-300000">200,000 - 300,000</option>
        <option value="300000-400000">300,000 - 400,000</option>
        <option value="400000-500000">400,000 - 500,000</option>
        <option value="500000-">500,000+</option>
    </select>

    <select name="ratingRange">
        <option value="">--Rating--</option>
        <option value="0-1">0 - 1</option>
        <option value="1-2">1 - 2</option>
        <option value="2-3">2 - 3</option>
        <option value="3-4">3 - 4</option>
        <option value="4-5">4 - 5</option>
    </select>

    <select name="status">
        <option value="">--Status--</option>
        <option value="active">Active</option>
        <option value="inactive">Inactive</option>
        <option value="draft">Draft</option>
    </select>

    <button type="submit">Filter</button>
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
                            <a href="courseDetails?courseID=${course.courseID}">
                                    ${course.courseTitle}
                            </a>
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
                        <a href="courseCatalog?page=${i}
                        &category=${category}
                        &priceRange=${priceRange}
                        &ratingRange=${ratingRange}
                        &status=${status}">
                                ${i}
                        </a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </div>
    </c:otherwise>
</c:choose>

</body>
</html>
