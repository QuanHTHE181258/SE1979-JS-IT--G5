<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="project.demo.coursemanagement.dto.CourseDTO" %>

<html>
<head>
    <title>Manage Courses</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            backdrop-filter: blur(10px);
        }

        .header {
            text-align: center;
            margin-bottom: 40px;
        }

        .header h1 {
            color: #2c3e50;
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 10px;
            background: linear-gradient(45deg, #667eea, #764ba2);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .header p {
            color: #7f8c8d;
            font-size: 1.1rem;
        }

        .search-section {
            background: white;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08);
            margin-bottom: 30px;
            border: 1px solid rgba(102, 126, 234, 0.1);
        }

        .search-form {
            display: flex;
            gap: 15px;
            align-items: center;
            flex-wrap: wrap;
        }

        .search-input, .search-select {
            padding: 12px 16px;
            border: 2px solid #e9ecef;
            border-radius: 10px;
            font-size: 14px;
            transition: all 0.3s ease;
            background: white;
        }

        .search-input {
            flex: 1;
            min-width: 250px;
        }

        .search-select {
            min-width: 160px;
        }

        .search-input:focus, .search-select:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .search-btn {
            background: linear-gradient(45deg, #667eea, #764ba2);
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 10px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .search-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(102, 126, 234, 0.3);
        }

        .courses-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(380px, 1fr));
            gap: 25px;
            margin-bottom: 40px;
        }

        .course-card {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
            transition: all 0.3s ease;
            border: 1px solid rgba(102, 126, 234, 0.1);
        }

        .course-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
        }

        .card-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 20px;
            position: relative;
        }

        .card-header::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            width: 0;
            height: 0;
            border-left: 10px solid transparent;
            border-right: 10px solid transparent;
            border-top: 10px solid #764ba2;
        }

        .course-code {
            background: rgba(255, 255, 255, 0.2);
            display: inline-block;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            margin-bottom: 8px;
            letter-spacing: 0.5px;
        }

        .course-title {
            font-size: 1.3rem;
            font-weight: 700;
            margin-bottom: 5px;
            line-height: 1.3;
        }

        .course-teacher {
            font-size: 0.9rem;
            opacity: 0.9;
        }

        .card-body {
            padding: 25px;
        }

        .course-description {
            color: #6c757d;
            font-size: 14px;
            line-height: 1.6;
            margin-bottom: 20px;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .course-meta {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
            margin-bottom: 20px;
        }

        .meta-item {
            display: flex;
            flex-direction: column;
        }

        .meta-label {
            font-size: 11px;
            color: #8e9aaf;
            text-transform: uppercase;
            font-weight: 600;
            letter-spacing: 0.5px;
            margin-bottom: 4px;
        }

        .meta-value {
            font-size: 14px;
            color: #2c3e50;
            font-weight: 600;
        }

        .course-badges {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
            margin-bottom: 20px;
        }

        .badge {
            padding: 4px 10px;
            border-radius: 15px;
            font-size: 11px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.3px;
        }

        .badge-category {
            background: #e3f2fd;
            color: #1976d2;
        }

        .badge-level {
            background: #f3e5f5;
            color: #7b1fa2;
        }

        .badge-status {
            background: #e8f5e8;
            color: #2e7d32;
        }

        .badge-inactive {
            background: #ffebee;
            color: #c62828;
        }

        .course-dates {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 20px;
        }

        .dates-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 12px;
            font-size: 12px;
        }

        .date-item {
            display: flex;
            justify-content: space-between;
        }

        .date-label {
            color: #6c757d;
            font-weight: 500;
        }

        .date-value {
            color: #2c3e50;
            font-weight: 600;
        }

        .card-actions {
            display: flex;
            gap: 10px;
            padding-top: 15px;
            border-top: 1px solid #f1f3f4;
        }

        .action-btn {
            flex: 1;
            padding: 10px;
            border: none;
            border-radius: 8px;
            font-size: 13px;
            font-weight: 600;
            text-decoration: none;
            text-align: center;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 0.3px;
        }

        .btn-update {
            background: #4CAF50;
            color: white;
        }

        .btn-update:hover {
            background: #45a049;
            transform: translateY(-1px);
        }

        .btn-delete {
            background: #f44336;
            color: white;
        }

        .btn-delete:hover {
            background: #da190b;
            transform: translateY(-1px);
        }

        .empty-state {
            text-align: center;
            padding: 60px 20px;
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
        }

        .empty-icon {
            font-size: 4rem;
            color: #bdc3c7;
            margin-bottom: 20px;
        }

        .empty-title {
            font-size: 1.5rem;
            color: #2c3e50;
            margin-bottom: 10px;
        }

        .empty-text {
            color: #7f8c8d;
            font-size: 1rem;
        }

        .pagination {
            display: flex;
            justify-content: center;
            gap: 8px;
            margin-top: 40px;
        }

        .page-link {
            padding: 12px 16px;
            background: white;
            color: #667eea;
            text-decoration: none;
            border-radius: 8px;
            border: 2px solid #e9ecef;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .page-link:hover, .page-link.active {
            background: linear-gradient(45deg, #667eea, #764ba2);
            color: white;
            border-color: #667eea;
            transform: translateY(-2px);
        }

        @media (max-width: 768px) {
            .container {
                padding: 15px;
            }

            .courses-grid {
                grid-template-columns: 1fr;
            }

            .search-form {
                flex-direction: column;
                align-items: stretch;
            }

            .search-input, .search-select {
                min-width: auto;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <h1>Course Management</h1>
        <p>Manage and organize your courses with ease</p>
    </div>

    <div class="search-section">
        <form class="search-form" method="get" action="">
            <input type="text" name="keyword" placeholder="Search course title..." value="${keyword}" class="search-input"/>

            <select name="categoryId" class="search-select">
                <option value="">All Categories</option>
                <option value="1" ${categoryId == 1 ? 'selected' : ''}>Programming</option>
                <option value="2" ${categoryId == 2 ? 'selected' : ''}>Design</option>
                <option value="3" ${categoryId == 3 ? 'selected' : ''}>Business</option>
                <option value="4" ${categoryId == 4 ? 'selected' : ''}>Language</option>
                <option value="5" ${categoryId == 5 ? 'selected' : ''}>Other</option>
            </select>

            <button type="submit" class="search-btn">Search</button>
        </form>
    </div>

    <c:choose>
        <c:when test="${not empty courses}">
            <div class="courses-grid">
                <c:forEach var="course" items="${courses}">
                    <div class="course-card">
                        <div class="card-header">
                            <div class="course-code">${course.courseCode}</div>
                            <div class="course-title">${course.title}</div>
                            <div class="course-teacher"> ${course.teacherUsername}</div>
                        </div>

                        <div class="card-body">
                            <div class="course-description">
                                    ${course.shortDescription}
                                <c:if test="${not empty course.description and course.description != course.shortDescription}">
                                    - ${course.description}
                                </c:if>
                            </div>

                            <div class="course-badges">
                                    <span class="badge badge-category">
                                        <c:choose>
                                            <c:when test="${course.categoryId == 1}"> Programming</c:when>
                                            <c:when test="${course.categoryId == 2}"> Design</c:when>
                                            <c:when test="${course.categoryId == 3}"> Business</c:when>
                                            <c:when test="${course.categoryId == 4}"> Language</c:when>
                                            <c:when test="${course.categoryId == 5}"> Other</c:when>
                                            <c:otherwise> Unknown</c:otherwise>
                                        </c:choose>
                                    </span>
                                <span class="badge badge-level"> ${course.level}</span>
                                <c:choose>
                                    <c:when test="${course.published and course.active}">
                                        <span class="badge badge-status"> Active</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge badge-inactive"> Inactive</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <div class="course-meta">
                                <div class="meta-item">
                                    <span class="meta-label">Price</span>
                                    <span class="meta-value">$${course.price}</span>
                                </div>
                                <div class="meta-item">
                                    <span class="meta-label">Duration</span>
                                    <span class="meta-value">${course.durationHours}h</span>
                                </div>
                                <div class="meta-item">
                                    <span class="meta-label">Max Students</span>
                                    <span class="meta-value">${course.maxStudents}</span>
                                </div>
                                <div class="meta-item">
                                    <span class="meta-label">Lessons</span>
                                    <span class="meta-value">${course.lessonCount}</span>
                                </div>
                            </div>

                            <div class="course-dates">
                                <div class="dates-grid">
                                    <div class="date-item">
                                        <span class="date-label">Enrollment:</span>
                                        <span class="date-value">
                                                <c:out value="${course.enrollmentStartDate != null ? fn:substring(course.enrollmentStartDate, 0, 10) : 'Not set'}" />
                                            </span>
                                    </div>
                                    <div class="date-item">
                                        <span class="date-label">To:</span>
                                        <span class="date-value">
                                                <c:out value="${course.enrollmentEndDate != null ? fn:substring(course.enrollmentEndDate, 0, 10) : 'Not set'}" />
                                            </span>
                                    </div>
                                    <div class="date-item">
                                        <span class="date-label">Start:</span>
                                        <span class="date-value">
                                                <c:out value="${course.startDate != null ? fn:substring(course.startDate, 0, 10) : 'Not set'}" />
                                            </span>
                                    </div>
                                    <div class="date-item">
                                        <span class="date-label">End:</span>
                                        <span class="date-value">
                                                <c:out value="${course.endDate != null ? fn:substring(course.endDate, 0, 10) : 'Not set'}" />
                                            </span>
                                    </div>
                                </div>
                            </div>

                            <div class="card-actions">
                                <a href="update-course?code=${course.courseCode}" class="action-btn btn-update">
                                    Update
                                </a>
                                <a href="delete-course?code=${course.courseCode}" class="action-btn btn-delete"
                                   onclick="return confirm('Are you sure you want to delete this course?')">
                                    Delete
                                </a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:when>
        <c:otherwise>
            <div class="empty-state">
                <div class="empty-icon"></div>
                <div class="empty-title">No courses found</div>
                <div class="empty-text">Try adjusting your search criteria or add a new course</div>
            </div>
        </c:otherwise>
    </c:choose>

    <c:if test="${totalPages > 1}">
        <div class="pagination">
            <c:forEach var="i" begin="1" end="${totalPages}">
                <a href="?keyword=${keyword}&categoryId=${categoryId}&page=${i}"
                   class="page-link ${i == currentPage ? 'active' : ''}">
                        ${i}
                </a>
            </c:forEach>
        </div>
    </c:if>
</div>
</body>
</html>