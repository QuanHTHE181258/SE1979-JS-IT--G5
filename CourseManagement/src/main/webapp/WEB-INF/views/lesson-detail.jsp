<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/layout/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lesson Detail - ${lesson.title}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #2d3748;
            --secondary-color: #4a5568;
            --accent-color: #38b2ac;
            --accent-light: #81e6d9;
            --success-color: #48bb78;
            --warning-color: #ed8936;
            --danger-color: #f56565;
            --bg-color: #f7fafc;
            --bg-white: #ffffff;
            --bg-gray-50: #f9fafb;
            --bg-gray-100: #f3f4f6;
            --text-primary: #2d3748;
            --text-secondary: #718096;
            --text-muted: #a0aec0;
            --border-color: #e2e8f0;
            --border-light: #edf2f7;
            --shadow: 0 1px 3px rgba(0,0,0,0.1);
            --shadow-md: 0 4px 6px rgba(0,0,0,0.1);
        }

        body {
            background-color: var(--bg-color);
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            color: var(--text-primary);
            line-height: 1.6;
        }

        .container-fluid {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 1rem;
        }

        .main-wrapper {
            background: var(--bg-white);
            border-radius: 8px;
            box-shadow: var(--shadow);
            overflow: hidden;
            border: 1px solid var(--border-color);
        }

        /* Sidebar */
        .sidebar {
            background: var(--bg-gray-50);
            border-right: 1px solid var(--border-color);
            padding: 1.5rem;
            min-height: 600px;
        }

        .sidebar-title {
            font-size: 1.125rem;
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .lesson-item {
            display: block;
            padding: 0.75rem;
            margin-bottom: 0.5rem;
            background: var(--bg-white);
            border: 1px solid var(--border-light);
            border-radius: 6px;
            text-decoration: none;
            color: var(--text-primary);
            transition: all 0.2s ease;
        }

        .lesson-item:hover {
            border-color: var(--accent-color);
            background: var(--bg-gray-50);
            color: var(--text-primary);
        }

        .lesson-item.active {
            background: var(--accent-color);
            color: white;
            border-color: var(--accent-color);
        }

        .lesson-number {
            font-weight: 600;
            font-size: 0.875rem;
            color: var(--text-secondary);
        }

        .lesson-item.active .lesson-number {
            color: rgba(255,255,255,0.8);
        }

        /* Main Content */
        .main-content {
            padding: 2rem;
        }

        .page-header {
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid var(--border-light);
        }

        .page-title {
            font-size: 1.875rem;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .page-title i {
            color: var(--accent-color);
        }

        .breadcrumb-nav {
            margin-bottom: 1rem;
        }

        .action-buttons {
            display: flex;
            gap: 0.75rem;
            flex-wrap: wrap;
        }

        /* Info Cards */
        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            margin-bottom: 2rem;
        }

        .info-card {
            background: var(--bg-gray-50);
            border: 1px solid var(--border-light);
            border-radius: 6px;
            padding: 1rem;
        }

        .info-label {
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
            color: var(--text-muted);
            margin-bottom: 0.25rem;
            letter-spacing: 0.05em;
        }

        .info-value {
            font-size: 1rem;
            font-weight: 600;
            color: var(--text-primary);
        }

        /* Content Sections */
        .content-section {
            margin-bottom: 2rem;
        }

        .section-title {
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .section-title i {
            color: var(--accent-color);
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
        }

        .lesson-content {
            background: var(--bg-gray-50);
            border: 1px solid var(--border-light);
            border-radius: 6px;
            padding: 1.5rem;
            min-height: 150px;
            line-height: 1.6;
        }

        /* Tables */
        .table {
            margin-bottom: 0;
        }

        .table thead th {
            background: var(--bg-gray-100);
            border-bottom: 1px solid var(--border-color);
            font-weight: 600;
            color: var(--text-primary);
            font-size: 0.875rem;
            padding: 0.75rem;
        }

        .table tbody td {
            padding: 0.75rem;
            border-bottom: 1px solid var(--border-light);
            vertical-align: middle;
        }

        .table tbody tr:hover {
            background: var(--bg-gray-50);
        }

        /* Buttons */
        .btn {
            border-radius: 6px;
            font-weight: 500;
            padding: 0.5rem 1rem;
            transition: all 0.15s ease;
            border-width: 1px;
            font-size: 0.875rem;
        }

        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }

        .btn-primary:hover {
            background-color: var(--secondary-color);
            border-color: var(--secondary-color);
        }

        .btn-success {
            background-color: var(--success-color);
            border-color: var(--success-color);
        }

        .btn-warning {
            background-color: var(--warning-color);
            border-color: var(--warning-color);
        }

        .btn-danger {
            background-color: var(--danger-color);
            border-color: var(--danger-color);
        }

        .btn-info {
            background-color: var(--accent-color);
            border-color: var(--accent-color);
        }

        .btn-outline-secondary {
            color: var(--text-secondary);
            border-color: var(--border-color);
            background: var(--bg-white);
        }

        .btn-outline-secondary:hover {
            background-color: var(--bg-gray-50);
            border-color: var(--accent-color);
            color: var(--accent-color);
        }

        .btn-outline-primary {
            color: var(--accent-color);
            border-color: var(--accent-color);
        }

        .btn-outline-primary:hover {
            background-color: var(--accent-color);
            border-color: var(--accent-color);
            color: white;
        }

        /* Badges */
        .badge {
            font-size: 0.75rem;
            font-weight: 500;
            padding: 0.25rem 0.5rem;
        }

        .bg-secondary {
            background-color: var(--text-secondary) !important;
        }

        .bg-success {
            background-color: var(--success-color) !important;
        }

        .bg-danger {
            background-color: var(--danger-color) !important;
        }

        /* Navigation */
        .nav-buttons {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 2rem;
            padding-top: 1rem;
            border-top: 1px solid var(--border-light);
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 2rem;
            color: var(--text-muted);
        }

        .empty-state i {
            font-size: 2rem;
            margin-bottom: 0.5rem;
            opacity: 0.5;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .container-fluid {
                margin: 1rem auto;
                padding: 0 0.5rem;
            }

            .main-content {
                padding: 1.5rem;
            }

            .page-title {
                font-size: 1.5rem;
            }

            .info-grid {
                grid-template-columns: 1fr;
            }

            .section-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 1rem;
            }

            .action-buttons {
                width: 100%;
                justify-content: stretch;
            }

            .action-buttons .btn {
                flex: 1;
            }
        }

        @media (max-width: 576px) {
            .sidebar {
                padding: 1rem;
            }

            .table-responsive {
                font-size: 0.875rem;
            }
        }
    </style>
</head>
<body>
<div class="container-fluid">
    <div class="main-wrapper">
        <div class="row g-0">
            <!-- Sidebar -->
            <div class="col-lg-3 col-md-4">
                <div class="sidebar">
                    <div class="sidebar-title">
                        <i class="fas fa-list"></i>
                        Lessons
                    </div>

                    <a href="add-lesson?courseId=${lesson.courseID.id}" class="btn btn-success w-100 mb-3">
                        <i class="fas fa-plus me-2"></i>Add Lesson
                    </a>

                    <div class="lesson-list">
                        <c:forEach var="ls" items="${lessonList}" varStatus="status">
                            <a href="lesson-details?id=${ls.id}"
                               class="lesson-item ${ls.id == lesson.id ? 'active' : ''}">
                                <div class="d-flex align-items-center justify-content-between">
                                    <div class="d-flex align-items-center gap-2">
                                        <span class="lesson-number">${status.index + 1}.</span>
                                        <span>${ls.title}</span>
                                    </div>
                                    <i class="fas fa-chevron-right small"></i>
                                </div>
                            </a>
                        </c:forEach>
                    </div>
                </div>
            </div>

            <!-- Main Content -->
            <div class="col-lg-9 col-md-8">
                <div class="main-content">
                    <c:if test="${not empty lesson}">
                        <!-- Page Header -->
                        <div class="page-header">
                            <div class="breadcrumb-nav">
                                <a href="javascript:history.back()" class="btn btn-outline-secondary">
                                    <i class="fas fa-arrow-left me-2"></i>Back
                                </a>
                            </div>

                            <h1 class="page-title">
                                <i class="fas fa-book-open"></i>
                                    ${lesson.title}
                            </h1>

                            <div class="action-buttons">
                                <a href="edit-lesson?id=${lesson.id}" class="btn btn-warning">
                                    <i class="fas fa-edit me-2"></i>Edit
                                </a>
                                <button onclick="showComingSoon()" class="btn btn-danger">
                                    <i class="fas fa-trash me-2"></i>Delete
                                </button>
                            </div>
                        </div>

                        <!-- Info Cards -->
                        <div class="info-grid">
                            <div class="info-card">
                                <div class="info-label">Lesson ID</div>
                                <div class="info-value">#${lesson.id}</div>
                            </div>
                            <div class="info-card">
                                <div class="info-label">Status</div>
                                <div class="info-value">
                                    <span class="badge bg-secondary">${lesson.status}</span>
                                </div>
                            </div>
                            <div class="info-card">
                                <div class="info-label">Free Preview</div>
                                <div class="info-value">
                                    <span class="badge ${lesson.isFreePreview ? 'bg-success' : 'bg-danger'}">
                                            ${lesson.isFreePreview ? 'Yes' : 'No'}
                                    </span>
                                </div>
                            </div>
                            <div class="info-card">
                                <div class="info-label">Created</div>
                                <div class="info-value">${lesson.createdAt}</div>
                            </div>
                        </div>

                        <!-- Lesson Content -->
                        <div class="content-section">
                            <h3 class="section-title">
                                <i class="fas fa-file-text"></i>
                                Content
                            </h3>
                            <div class="lesson-content">
                                <c:out value="${lesson.content}" escapeXml="false"/>
                            </div>
                        </div>

                        <!-- Quizzes -->
                        <div class="content-section">
                            <div class="section-header">
                                <h3 class="section-title">
                                    <i class="fas fa-question-circle"></i>
                                    Quizzes
                                </h3>
                                <a href="addQuiz?lessonId=${lesson.id}" class="btn btn-success">
                                    <i class="fas fa-plus me-2"></i>Add Quiz
                                </a>
                            </div>

                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Title</th>
                                        <th>Actions</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="quiz" items="${quizzes}" varStatus="status">
                                        <tr>
                                            <td><strong>${status.index + 1}</strong></td>
                                            <td>${quiz.title}</td>
                                            <td>
                                                <div class="btn-group btn-group-sm">
                                                    <a href="quiz-details?id=${quiz.id}" class="btn btn-info">
                                                        <i class="fas fa-eye"></i>
                                                    </a>
                                                    <a href="edit-quiz?quizId=${quiz.id}" class="btn btn-warning">
                                                        <i class="fas fa-edit"></i>
                                                    </a>
                                                    <button onclick="showComingSoon()" class="btn btn-danger">
                                                        <i class="fas fa-trash"></i>
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty quizzes}">
                                        <tr>
                                            <td colspan="3" class="empty-state">
                                                <i class="fas fa-inbox"></i>
                                                <div>No quizzes found</div>
                                            </td>
                                        </tr>
                                    </c:if>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <!-- Materials -->
                        <div class="content-section">
                            <div class="section-header">
                                <h3 class="section-title">
                                    <i class="fas fa-file-alt"></i>
                                    Materials
                                </h3>
                                <a href="${pageContext.request.contextPath}/course/material/add?lessonId=${lesson.id}"
                                   class="btn btn-success">
                                    <i class="fas fa-plus me-2"></i>Add Material
                                </a>
                            </div>

                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Title</th>
                                        <th>File</th>
                                        <th>Actions</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="material" items="${materials}" varStatus="status">
                                        <tr>
                                            <td><strong>${status.index + 1}</strong></td>
                                            <td>${material.title}</td>
                                            <td>
                                                <button class="btn btn-outline-primary btn-sm" onclick="showComingSoon()">
                                                    <i class="fas fa-download me-1"></i>Download
                                                </button>
                                            </td>
                                            <td>
                                                <div class="btn-group btn-group-sm">
                                                    <a href="edit-material?id=${material.id}" class="btn btn-warning">
                                                        <i class="fas fa-edit"></i>
                                                    </a>
                                                    <button class="btn btn-danger" onclick="showComingSoon()">
                                                        <i class="fas fa-trash"></i>
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>

                                    <c:if test="${empty materials}">
                                        <tr>
                                            <td colspan="4" class="empty-state">
                                                <i class="fas fa-folder-open"></i>
                                                <div>No materials found</div>
                                            </td>
                                        </tr>
                                    </c:if>

                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <!-- Navigation -->
                        <div class="nav-buttons">
                            <div>
                                <c:if test="${not empty prevLessonId}">
                                    <a href="lesson-details?id=${prevLessonId}" class="btn btn-primary">
                                        <i class="fas fa-chevron-left me-2"></i>Previous
                                    </a>
                                </c:if>
                            </div>
                            <div>
                                <c:if test="${not empty nextLessonId}">
                                    <a href="lesson-details?id=${nextLessonId}" class="btn btn-primary">
                                        Next<i class="fas fa-chevron-right ms-2"></i>
                                    </a>
                                </c:if>
                            </div>
                        </div>
                    </c:if>

                    <c:if test="${empty lesson}">
                        <div class="alert alert-danger text-center">
                            <i class="fas fa-exclamation-triangle mb-2 d-block"></i>
                            <h5>Lesson Not Found</h5>
                            <p class="mb-3">The requested lesson could not be found.</p>
                            <a href="javascript:history.back()" class="btn btn-primary">
                                <i class="fas fa-arrow-left me-2"></i>Go Back
                            </a>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    function showComingSoon() {
        alert("Coming Soon");
    }
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function deleteLesson(id) {
        if (confirm('Are you sure you want to delete this lesson?')) {
            window.location.href = 'delete-lesson?id=' + id;
        }
    }

    function deleteQuiz(id) {
        if (confirm('Are you sure you want to delete this quiz?')) {
            window.location.href = 'delete-quiz?id=' + id;
        }
    }

    function deleteMaterial(id) {
        if (confirm('Are you sure you want to delete this material?')) {
            window.location.href = 'edit-material?action=delete&id=' + id;
        }
    }
    function showComingSoon() {
        alert("Coming Soon");
    }

    // Smooth hover effects
    document.addEventListener('DOMContentLoaded', function () {
        const buttons = document.querySelectorAll('.btn');
        buttons.forEach(btn => {
            btn.addEventListener('mouseenter', function () {
                this.style.transform = 'translateY(-1px)';
            });

            btn.addEventListener('mouseleave', function () {
                this.style.transform = 'translateY(0)';
            });
        });
    });
    // Simple smooth scroll for back to top
    document.addEventListener('DOMContentLoaded', function() {
        // Add simple hover effects
        const buttons = document.querySelectorAll('.btn');
        buttons.forEach(btn => {
            btn.addEventListener('mouseenter', function() {
                this.style.transform = 'translateY(-1px)';
            });

            btn.addEventListener('mouseleave', function() {
                this.style.transform = 'translateY(0)';
            });
        });
    });
</script>
</body>
</html>