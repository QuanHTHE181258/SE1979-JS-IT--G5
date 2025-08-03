<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/layout/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Lesson: ${lesson.title}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --secondary-gradient: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            --success-gradient: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            --card-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
            --card-shadow-hover: 0 20px 60px rgba(0, 0, 0, 0.15);
            --border-radius: 16px;
            --transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        }

        * {
            box-sizing: border-box;
        }

        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            margin: 0;
            padding: 0;
            min-height: 100vh;
        }

        .main-container {
            max-width: 100%;
            width: 100vw;
            margin: 0;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 0;
            box-shadow: none;
            overflow: visible;
            min-height: 100vh;
        }

        .lesson-header {
            background: var(--primary-gradient);
            color: white;
            padding: 3rem 2rem;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .lesson-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grain" width="100" height="100" patternUnits="userSpaceOnUse"><circle cx="25" cy="25" r="1" fill="white" opacity="0.1"/><circle cx="75" cy="75" r="1" fill="white" opacity="0.1"/><circle cx="50" cy="10" r="0.5" fill="white" opacity="0.05"/></pattern></defs><rect width="100" height="100" fill="url(%23grain)"/></svg>');
            animation: float 20s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-10px) rotate(1deg); }
        }

        .lesson-title {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 1rem;
            position: relative;
            z-index: 2;
            text-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .lesson-meta {
            font-size: 1.1rem;
            position: relative;
            z-index: 2;
        }

        .sidebar {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(20px);
            border-right: 1px solid rgba(0, 0, 0, 0.1);
            min-height: 600px;
            border-radius: 0;
        }

        .sidebar-header {
            background: var(--secondary-gradient);
            color: white;
            padding: 1.5rem;
            font-weight: 600;
            font-size: 1.1rem;
            border-radius: 0;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        }

        .lesson-nav {
            padding: 1.5rem;
            max-height: 70vh;
            overflow-y: auto;
            scrollbar-width: thin;
            scrollbar-color: rgba(0, 0, 0, 0.2) transparent;
        }

        .lesson-nav::-webkit-scrollbar {
            width: 6px;
        }

        .lesson-nav::-webkit-scrollbar-track {
            background: transparent;
        }

        .lesson-nav::-webkit-scrollbar-thumb {
            background: rgba(0, 0, 0, 0.2);
            border-radius: 3px;
        }

        .lesson-nav-item {
            display: block;
            padding: 1rem 1.5rem;
            margin-bottom: 0.75rem;
            color: #374151;
            text-decoration: none;
            border-radius: var(--border-radius);
            background: white;
            border: 1px solid rgba(0, 0, 0, 0.08);
            transition: var(--transition);
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            position: relative;
            overflow: hidden;
        }

        .lesson-nav-item::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 4px;
            height: 100%;
            background: var(--primary-gradient);
            transform: scaleY(0);
            transition: var(--transition);
            transform-origin: bottom;
        }

        .lesson-nav-item:hover {
            background: white;
            color: #1f2937;
            transform: translateY(-2px);
            box-shadow: var(--card-shadow);
        }

        .lesson-nav-item:hover::before {
            transform: scaleY(1);
        }

        .lesson-nav-item.active {
            background: var(--primary-gradient);
            color: white;
            border-color: transparent;
            box-shadow: var(--card-shadow);
        }

        .lesson-nav-item.active::before {
            transform: scaleY(1);
            background: rgba(255, 255, 255, 0.3);
        }

        .content-area {
            padding: 2.5rem;
            background: transparent;
        }

        .lesson-content {
            background: white;
            border: none;
            border-radius: var(--border-radius);
            padding: 2.5rem;
            margin-bottom: 2rem;
            line-height: 1.8;
            font-size: 1.1rem;
            box-shadow: var(--card-shadow);
            position: relative;
            overflow: hidden;
        }

        .lesson-content::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: var(--success-gradient);
        }

        .section-card {
            background: white;
            border: none;
            border-radius: var(--border-radius);
            margin-bottom: 2rem;
            overflow: hidden;
            box-shadow: var(--card-shadow);
            transition: var(--transition);
        }

        .section-card:hover {
            box-shadow: var(--card-shadow-hover);
            transform: translateY(-2px);
        }

        .section-header {
            background: var(--secondary-gradient);
            padding: 1.5rem 2rem;
            font-weight: 600;
            color: white;
            border-bottom: none;
            font-size: 1.1rem;
        }

        .section-body {
            padding: 2rem;
        }

        .quiz-item, .material-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 1.5rem;
            margin-bottom: 1rem;
            background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
            border: 1px solid rgba(0, 0, 0, 0.05);
            border-radius: var(--border-radius);
            transition: var(--transition);
            position: relative;
            overflow: hidden;
        }

        .quiz-item::before, .material-item::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.05) 0%, rgba(118, 75, 162, 0.05) 100%);
            opacity: 0;
            transition: var(--transition);
        }

        .quiz-item:hover, .material-item:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.1);
        }

        .quiz-item:hover::before, .material-item:hover::before {
            opacity: 1;
        }

        .quiz-btn, .material-link {
            background: var(--primary-gradient);
            color: white;
            border: none;
            padding: 0.75rem 1.5rem;
            border-radius: 50px;
            font-weight: 500;
            text-decoration: none;
            transition: var(--transition);
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
            position: relative;
            z-index: 2;
        }

        .quiz-btn:hover, .material-link:hover {
            color: white;
            transform: translateY(-1px);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
        }

        .navigation-buttons {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 3rem;
            padding-top: 2rem;
            border-top: 1px solid rgba(0, 0, 0, 0.1);
            gap: 1rem;
        }

        .nav-btn {
            background: var(--primary-gradient);
            color: white;
            border: none;
            padding: 1rem 2rem;
            border-radius: 50px;
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.75rem;
            transition: var(--transition);
            box-shadow: 0 4px 20px rgba(102, 126, 234, 0.3);
        }

        .nav-btn:hover {
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 8px 30px rgba(102, 126, 234, 0.4);
        }

        .badge-custom {
            padding: 0.75rem 1.5rem;
            border-radius: 50px;
            font-weight: 600;
            font-size: 0.9rem;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        .badge-free {
            background: var(--success-gradient);
            color: white;
        }

        .badge-premium {
            background: var(--secondary-gradient);
            color: white;
        }

        .empty-state {
            text-align: center;
            padding: 4rem 1rem;
            color: #6b7280;
        }

        .empty-state i {
            font-size: 4rem;
            margin-bottom: 1.5rem;
            opacity: 0.3;
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .btn-outline-secondary {
            border: 2px solid rgba(0, 0, 0, 0.1);
            color: #6b7280;
            background: white;
            border-radius: 50px;
            padding: 0.75rem 1.5rem;
            font-weight: 500;
            transition: var(--transition);
        }

        .btn-outline-secondary:hover {
            background: #f3f4f6;
            border-color: rgba(0, 0, 0, 0.2);
            color: #374151;
            transform: translateY(-1px);
        }

        .alert-danger {
            background: linear-gradient(135deg, #fee2e2 0%, #fecaca 100%);
            border: 1px solid #f87171;
            color: #dc2626;
            border-radius: var(--border-radius);
            padding: 1.5rem;
            box-shadow: var(--card-shadow);
        }

        @media (max-width: 768px) {
            .main-container {
                width: 100vw;
                margin: 0;
                border-radius: 0;
            }

            .lesson-header {
                padding: 2rem 1.5rem;
            }

            .lesson-title {
                font-size: 1.8rem;
            }

            .content-area {
                padding: 1.5rem;
            }

            .lesson-content {
                padding: 1.5rem;
                font-size: 1rem;
            }

            .section-body {
                padding: 1.5rem;
            }

            .quiz-item, .material-item {
                padding: 1rem;
                flex-direction: column;
                align-items: flex-start;
                gap: 1rem;
            }

            .navigation-buttons {
                flex-direction: column;
                gap: 1rem;
            }

            .nav-btn {
                width: 100%;
                justify-content: center;
            }
        }

        @media (max-width: 992px) {
            .sidebar {
                border-right: none;
                border-bottom: 1px solid rgba(0, 0, 0, 0.1);
            }
        }

        /* Smooth animations */
        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .section-card {
            animation: slideUp 0.6s ease-out;
        }

        .section-card:nth-child(2) {
            animation-delay: 0.1s;
        }

        .section-card:nth-child(3) {
            animation-delay: 0.2s;
        }

        /* Loading animation for content */
        .lesson-content {
            animation: slideUp 0.8s ease-out;
        }
    </style>
</head>
<body>
<div class="mt-0">
    <!-- Main Container -->
    <div class="main-container">
        <div class="lesson-header">
            <div class="lesson-title">
                <i class="fas fa-graduation-cap me-3"></i>
                ${lesson.title}
            </div>
            <div class="lesson-meta">
                    <span class="badge-custom ${lesson.isFreePreview ? 'badge-free' : 'badge-premium'}">
                        <i class="fas ${lesson.isFreePreview ? 'fa-unlock' : 'fa-crown'} me-2"></i>
                        ${lesson.isFreePreview ? 'Free Preview' : 'Premium Content'}
                    </span>
            </div>
        </div>

        <div class="row g-0">
            <div class="col-lg-3 col-12 sidebar">
                <div class="sidebar-header">
                    <i class="fas fa-list me-3"></i>Course Lessons
                </div>
                <div class="lesson-nav">
                    <c:forEach var="ls" items="${lessonList}" varStatus="status">
                        <a href="learning?lessonId=${ls.id}" class="lesson-nav-item ${ls.id == lesson.id ? 'active' : ''}">
                            <div class="d-flex align-items-center justify-content-between">
                                    <span class="fw-semibold">
                                        <span class="text-muted me-2">${status.index + 1}.</span>
                                        ${ls.title}
                                    </span>
                                <i class="fas fa-chevron-right small"></i>
                            </div>
                            <c:if test="${ls.isFreePreview}">
                                <small class="text-success mt-1 d-block">
                                    <i class="fas fa-unlock me-1"></i>Free Preview
                                </small>
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
                                <i class="fas fa-question-circle me-3"></i>
                                Practice Quizzes
                            </div>
                            <div class="section-body">
                                <c:forEach var="quiz" items="${quizzes}" varStatus="status">
                                    <div class="quiz-item">
                                        <div class="flex-grow-1">
                                            <h6 class="mb-2 fw-semibold fs-5">${quiz.title}</h6>
                                            <small class="text-muted">Quiz ${status.index + 1} • Test your knowledge</small>
                                        </div>
                                        <a href="take-quiz?action=start&lessonId=${lesson.id}" class="quiz-btn">
                                            <i class="fas fa-play me-2"></i>Start Quiz
                                        </a>
                                    </div>
                                </c:forEach>
                                <c:if test="${empty quizzes}">
                                    <div class="empty-state">
                                        <i class="fas fa-question-circle"></i>
                                        <div class="fw-medium">No quizzes available for this lesson</div>
                                        <small class="text-muted">Check back later for practice questions</small>
                                    </div>
                                </c:if>
                            </div>
                        </div>

                        <!-- Materials Section -->
                        <div class="section-card">
                            <div class="section-header">
                                <i class="fas fa-download me-3"></i>
                                Download Materials
                            </div>
                            <div class="section-body">
                                <c:forEach var="material" items="${materials}" varStatus="status">
                                    <div class="material-item">
                                        <div class="flex-grow-1">
                                            <h6 class="mb-2 fw-semibold fs-5">${material.title}</h6>
                                            <small class="text-muted">Learning Material ${status.index + 1} • Additional resources</small>
                                        </div>
                                        <c:if test="${not empty material.fileURL}">
                                            <a href="${material.fileURL}" target="_blank" class="material-link">
                                                <i class="fas fa-download me-2"></i>Download
                                            </a>
                                        </c:if>
                                        <c:if test="${empty material.fileURL}">
                                            <span class="badge bg-secondary rounded-pill">No file available</span>
                                        </c:if>
                                    </div>
                                </c:forEach>
                                <c:if test="${empty materials}">
                                    <div class="empty-state">
                                        <i class="fas fa-file-download"></i>
                                        <div class="fw-medium">No materials available for download</div>
                                        <small class="text-muted">All content is included in the lesson above</small>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                        <c:choose>
                            <c:when test="${isCompleted}">
                                <div class="text-end mb-4">
            <span class="badge bg-success px-3 py-2 rounded-pill fs-6">
                <i class="fas fa-check-circle me-1"></i> Đã hoàn thành
            </span>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="text-end mb-4">
                                    <form action="complete-lesson" method="post">
                                        <input type="hidden" name="lessonId" value="${lesson.id}" />
                                        <button type="submit" class="btn btn-success px-4 py-2 rounded-pill fw-semibold shadow-sm" style="background: var(--success-gradient); border: none;">
                                            <i class="fas fa-check-circle me-2"></i>Đã hoàn thành bài học
                                        </button>
                                    </form>
                                </div>
                            </c:otherwise>
                        </c:choose>


                        <!-- Navigation -->
                        <div class="navigation-buttons">
                            <c:if test="${not empty prevLessonId}">
                                <a href="learning?lessonId=${prevLessonId}" class="nav-btn">
                                    <i class="fas fa-chevron-left"></i>
                                    Previous Lesson
                                </a>
                            </c:if>
                            <c:if test="${empty prevLessonId}">
                                <div></div>
                            </c:if>

                            <a href="javascript:history.back()" class="btn btn-outline-secondary">
                                <i class="fas fa-arrow-left me-2"></i>Back to Course
                            </a>

                            <c:if test="${not empty nextLessonId}">
                                <a href="learning?lessonId=${nextLessonId}" class="nav-btn">
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
                            <i class="fas fa-exclamation-triangle me-3"></i>
                            <strong>Lesson not found!</strong> You don't have permission to view this content or the lesson doesn't exist.
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- FontAwesome for icons -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
</body>
</html>