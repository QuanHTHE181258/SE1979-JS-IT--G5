<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Lesson: ${lesson.title}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .main-container {
            max-width: 100%;
            width: 95vw;
            margin: 20px auto;
            background: #fff;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.1);
            overflow: hidden;
        }
        .lesson-header {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            color: white;
            padding: 2rem;
            text-align: center;
        }
        .lesson-title {
            font-size: 2.2rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }
        .lesson-meta {
            opacity: 0.9;
            font-size: 1rem;
        }
        .sidebar {
            background: #f8fafc;
            border-right: 1px solid #e2e8f0;
            min-height: 600px;
        }
        .sidebar-header {
            background: #185a9d;
            color: white;
            padding: 1rem;
            font-weight: 600;
        }
        .lesson-nav {
            padding: 1rem;
            max-height: 70vh;
            overflow-y: auto;
        }
        .lesson-nav-item {
            display: block;
            padding: 0.75rem 1rem;
            margin-bottom: 0.5rem;
            color: #4a5568;
            text-decoration: none;
            border-radius: 8px;
            border: 1px solid #e2e8f0;
            transition: all 0.3s ease;
        }
        .lesson-nav-item:hover {
            background: #edf2f7;
            color: #2d3748;
            transform: translateY(-1px);
        }
        .lesson-nav-item.active {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            color: white;
            border-color: #4facfe;
        }
        .content-area {
            padding: 2rem;
        }
        .lesson-content {
            background: #f9fafb;
            border: 1px solid #e5e7eb;
            border-radius: 12px;
            padding: 2rem;
            margin-bottom: 2rem;
            line-height: 1.7;
            font-size: 1.1rem;
        }
        .section-card {
            background: white;
            border: 1px solid #e5e7eb;
            border-radius: 12px;
            margin-bottom: 1.5rem;
            overflow: hidden;
            box-shadow: 0 4px 6px rgba(0,0,0,0.05);
        }
        .section-header {
            background: linear-gradient(135deg, #a8edea 0%, #fed6e3 100%);
            padding: 1rem 1.5rem;
            font-weight: 600;
            color: #2d3748;
            border-bottom: 1px solid #e5e7eb;
        }
        .section-body {
            padding: 1.5rem;
        }
        .quiz-item, .material-item {
            display: flex;
            align-items: center;
            justify-content: between;
            padding: 1rem;
            margin-bottom: 0.75rem;
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            transition: all 0.3s ease;
        }
        .quiz-item:hover, .material-item:hover {
            background: #edf2f7;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        .quiz-btn {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 6px;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        .quiz-btn:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
        }
        .material-link {
            background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 6px;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        .material-link:hover {
            color: white;
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(17, 153, 142, 0.4);
        }
        .navigation-buttons {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 2rem;
            padding-top: 2rem;
            border-top: 1px solid #e5e7eb;
        }
        .nav-btn {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            color: white;
            border: none;
            padding: 0.75rem 1.5rem;
            border-radius: 8px;
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s ease;
        }
        .nav-btn:hover {
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(79, 172, 254, 0.4);
        }
        .badge-custom {
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-weight: 500;
            font-size: 0.9rem;
        }
        .badge-free {
            background: linear-gradient(135deg, #84fab0 0%, #8fd3f4 100%);
            color: #2d3748;
        }
        .badge-premium {
            background: linear-gradient(135deg, #ffecd2 0%, #fcb69f 100%);
            color: #2d3748;
        }
        .empty-state {
            text-align: center;
            padding: 3rem 1rem;
            color: #6b7280;
        }
        .empty-state i {
            font-size: 3rem;
            margin-bottom: 1rem;
            opacity: 0.5;
        }
        @media (max-width: 768px) {
            .main-container {
                width: 98vw;
                margin: 10px auto;
                border-radius: 10px;
            }
            .lesson-header {
                padding: 1.5rem;
            }
            .lesson-title {
                font-size: 1.8rem;
            }
            .content-area {
                padding: 1rem;
            }
            .lesson-content {
                padding: 1.5rem;
                font-size: 1rem;
            }
        }
    </style>
</head>
<body>
<div class="main-container">
    <div class="lesson-header">
        <div class="lesson-title">
            <i class="fas fa-graduation-cap me-2"></i>
            ${lesson.title}
        </div>
        <div class="lesson-meta">
            <span class="badge-custom ${lesson.isFreePreview ? 'badge-free' : 'badge-premium'}">
                <i class="fas ${lesson.isFreePreview ? 'fa-unlock' : 'fa-crown'} me-1"></i>
                ${lesson.isFreePreview ? 'Free Preview' : 'Premium Content'}
            </span>
        </div>
    </div>

    <div class="row g-0">
        <div class="col-lg-3 col-12 sidebar">
            <div class="sidebar-header">
                <i class="fas fa-list me-2"></i>Course Lessons
            </div>
            <div class="lesson-nav">
                <c:forEach var="ls" items="${lessonList}" varStatus="status">
                    <a href="lesson-details?id=${ls.id}" class="lesson-nav-item ${ls.id == lesson.id ? 'active' : ''}">
                        <div class="d-flex align-items-center justify-content-between">
                            <span class="fw-semibold">
                                <span class="text-muted me-2">${status.index + 1}.</span>
                                ${ls.title}
                            </span>
                            <i class="fas fa-chevron-right small"></i>
                        </div>
                        <c:if test="${ls.isFreePreview}">
                            <small class="text-success"><i class="fas fa-unlock me-1"></i>Free</small>
                        </c:if>
                    </a>
                </c:forEach>
            </div>
        </div>

        <div class="col-lg-9 col-12">
            <div class="content-area">
                <c:if test="${not empty lesson}">
                    <!-- Lesson Content -->
                    <div class="lesson-content">
                        <c:out value="${lesson.content}" escapeXml="false"/>
                    </div>

                    <!-- Quizzes Section -->
                    <div class="section-card">
                        <div class="section-header">
                            <i class="fas fa-question-circle me-2"></i>
                            Practice Quizzes
                        </div>
                        <div class="section-body">
                            <c:forEach var="quiz" items="${quizzes}" varStatus="status">
                                <div class="quiz-item">
                                    <div class="flex-grow-1">
                                        <h6 class="mb-1 fw-semibold">${quiz.title}</h6>
                                        <small class="text-muted">Quiz ${status.index + 1}</small>
                                    </div>
                                    <a href="quiz-details?id=${quiz.id}" class="quiz-btn">
                                        <i class="fas fa-play me-1"></i>Start Quiz
                                    </a>
                                </div>
                            </c:forEach>
                            <c:if test="${empty quizzes}">
                                <div class="empty-state">
                                    <i class="fas fa-question-circle"></i>
                                    <div>No quizzes available for this lesson</div>
                                </div>
                            </c:if>
                        </div>
                    </div>

                    <!-- Materials Section -->
                    <div class="section-card">
                        <div class="section-header">
                            <i class="fas fa-download me-2"></i>
                            Download Materials
                        </div>
                        <div class="section-body">
                            <c:forEach var="material" items="${materials}" varStatus="status">
                                <div class="material-item">
                                    <div class="flex-grow-1">
                                        <h6 class="mb-1 fw-semibold">${material.title}</h6>
                                        <small class="text-muted">Learning Material ${status.index + 1}</small>
                                    </div>
                                    <c:if test="${not empty material.fileURL}">
                                        <a href="${material.fileURL}" target="_blank" class="material-link">
                                            <i class="fas fa-download me-1"></i>Download
                                        </a>
                                    </c:if>
                                    <c:if test="${empty material.fileURL}">
                                        <span class="badge bg-secondary">No file available</span>
                                    </c:if>
                                </div>
                            </c:forEach>
                            <c:if test="${empty materials}">
                                <div class="empty-state">
                                    <i class="fas fa-file-download"></i>
                                    <div>No materials available for download</div>
                                </div>
                            </c:if>
                        </div>
                    </div>

                    <!-- Navigation -->
                    <div class="navigation-buttons">
                        <c:if test="${not empty prevLessonId}">
                            <a href="lesson-details?id=${prevLessonId}" class="nav-btn">
                                <i class="fas fa-chevron-left"></i>
                                Previous Lesson
                            </a>
                        </c:if>
                        <c:if test="${empty prevLessonId}">
                            <div></div>
                        </c:if>

                        <a href="javascript:history.back()" class="btn btn-outline-secondary">
                            <i class="fas fa-arrow-left me-1"></i>Back to Course
                        </a>

                        <c:if test="${not empty nextLessonId}">
                            <a href="lesson-details?id=${nextLessonId}" class="nav-btn">
                                Next Lesson
                                <i class="fas fa-chevron-right"></i>
                            </a>
                        </c:if>
                        <c:if test="${empty nextLessonId}">
                            <div></div>
                        </c:if>
                    </div>

                </c:if>
                <c:if test="${empty lesson}">
                    <div class="alert alert-danger">
                        <i class="fas fa-exclamation-triangle me-2"></i>
                        Lesson not found or you don't have permission to view this content.
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</div>

<!-- FontAwesome for icons -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
</body>
</html>