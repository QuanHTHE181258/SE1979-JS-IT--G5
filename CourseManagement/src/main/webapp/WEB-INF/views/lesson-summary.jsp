<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lesson List</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        .lesson-card {
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-bottom: 1rem;
            padding: 1.25rem;
            transition: transform 0.2s;
            border: 1px solid #e9ecef;
        }
        .lesson-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.15);
            border-color: #0d6efd;
        }
        .lesson-number {
            color: #0d6efd;
            font-weight: bold;
            font-size: 1.1rem;
            margin-right: 10px;
            min-width: 80px;
            display: inline-block;
        }
        .stat-badge {
            background-color: #f8f9fa;
            border: 1px solid #e9ecef;
            color: #495057;
            padding: 0.35rem 0.75rem;
            border-radius: 20px;
            font-size: 0.875rem;
            margin-right: 0.5rem;
            display: inline-flex;
            align-items: center;
        }
        .stat-badge i {
            margin-right: 5px;
            font-size: 1rem;
        }
        .message {
            padding: 1rem;
            border-radius: 8px;
            background-color: #e9ecef;
            margin-bottom: 1rem;
        }
    </style>
</head>
<body>
    <div class="container mt-4">
        <div class="row mb-4">
            <div class="col">
                <h2 class="mb-3">Course Lessons</h2>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/" class="text-decoration-none">Home</a></li>
                        <li class="breadcrumb-item active">Lesson List</li>
                    </ol>
                </nav>
            </div>
        </div>

        <c:if test="${empty lessons}">
            <div class="alert alert-info">
                <i class="bi bi-info-circle me-2"></i>
                No lessons found in this course
            </div>
        </c:if>

        <div class="row">
            <div class="col-12">
                <c:forEach items="${lessons}" var="lessonStat">
                    <div class="lesson-card">
                        <div class="d-flex justify-content-between align-items-center flex-wrap">
                            <div class="d-flex align-items-center mb-2 mb-md-0">
                                <span class="lesson-number">Lesson ${lessonStat.order}</span>
                                <a href="${pageContext.request.contextPath}/learning?lessonId=${lessonStat.lesson.id}" class="h5 mb-0 text-decoration-none text-dark">${lessonStat.lesson.title}</a>
                            </div>
                            <div>
                                <span class="stat-badge">
                                    <i class="bi bi-question-circle-fill"></i>
                                    ${lessonStat.totalQuizzes} quizzes
                                </span>
                                <span class="stat-badge">
                                    <i class="bi bi-file-earmark-text-fill"></i>
                                    ${lessonStat.totalMaterials} materials
                                </span>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
