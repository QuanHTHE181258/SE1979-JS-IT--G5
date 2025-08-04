<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/layout/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Course Lessons</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        * {
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            margin: 0;
            padding: 2rem 0;
        }

        .main-container {
            max-width: 1200px;
            margin: 0 auto;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 24px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1), 0 1px 3px rgba(0, 0, 0, 0.1);
            padding: 3rem;
            position: relative;
            overflow: hidden;
        }

        .main-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #667eea, #764ba2, #f093fb);
            border-radius: 24px 24px 0 0;
        }

        .page-header {
            text-align: center;
            margin-bottom: 3rem;
        }

        .page-title {
            font-size: 2.5rem;
            font-weight: 700;
            color: #2d3748;
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 1rem;
        }

        .page-title i {
            color: #667eea;
            font-size: 2.25rem;
        }

        .page-subtitle {
            color: #718096;
            font-size: 1.1rem;
            font-weight: 400;
        }

        .controls-section {
            background: #f7fafc;
            border-radius: 16px;
            padding: 2rem;
            margin-bottom: 2rem;
            border: 1px solid #e2e8f0;
        }

        .search-input, .status-select {
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            padding: 0.75rem 1rem;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: white;
        }

        .search-input:focus, .status-select:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            transform: translateY(-1px);
        }

        .btn-add-lesson {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 12px;
            padding: 0.75rem 1.5rem;
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
        }

        .btn-add-lesson:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
            color: white;
        }

        .table-container {
            background: white;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            border: 1px solid #e2e8f0;
        }

        .custom-table {
            margin: 0;
            border: none;
        }

        .custom-table thead {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }

        .custom-table thead th {
            color: #222;
            font-weight: 600;
            padding: 1.25rem 1rem;
            border: none;
            font-size: 0.95rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .custom-table tbody td {
            padding: 1.25rem 1rem;
            border-bottom: 1px solid #f1f5f9;
            vertical-align: middle;
        }

        .custom-table tbody tr {
            transition: all 0.3s ease;
        }

        .custom-table tbody tr:hover {
            background: linear-gradient(90deg, rgba(102, 126, 234, 0.05), rgba(118, 75, 162, 0.05));
            transform: translateX(4px);
        }

        .lesson-title {
            font-weight: 600;
            color: #2d3748;
            margin: 0;
        }

        .badge-custom {
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .badge-quiz {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            color: white;
        }

        .badge-material {
            background: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);
            color: white;
        }

        .badge-status {
            background: linear-gradient(135deg, #a8edea 0%, #fed6e3 100%);
            color: #2d3748;
        }

        .badge-preview-yes {
            background: linear-gradient(135deg, #d299c2 0%, #fef9d7 100%);
            color: #2d3748;
        }

        .badge-preview-no {
            background: linear-gradient(135deg, #fbc2eb 0%, #a6c1ee 100%);
            color: #2d3748;
        }

        .action-buttons {
            display: flex;
            gap: 0.5rem;
            flex-wrap: wrap;
        }

        .btn-action {
            padding: 0.5rem 1rem;
            border-radius: 8px;
            border: none;
            font-size: 0.85rem;
            font-weight: 500;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.25rem;
            transition: all 0.3s ease;
            min-width: 80px;
            justify-content: center;
        }

        .btn-view {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .btn-edit {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            color: white;
        }

        .btn-delete {
            background: linear-gradient(135deg, #ff9a9e 0%, #fecfef 100%);
            color: #2d3748;
        }

        .btn-change {
            background: linear-gradient(135deg, #a8edea 0%, #fed6e3 100%);
            color: #2d3748;
            font-size: 0.75rem;
            padding: 0.375rem 0.75rem;
            min-width: 70px;
        }

        .btn-action:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        }

        .preview-container {
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .pagination-container {
            display: flex;
            justify-content: center;
            margin-top: 2rem;
            padding: 2rem 0;
        }

        .pagination .page-link {
            border: 2px solid #e2e8f0;
            color: #4a5568;
            border-radius: 8px;
            margin: 0 0.25rem;
            padding: 0.75rem 1rem;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .pagination .page-link:hover {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-color: #667eea;
            transform: translateY(-1px);
        }

        .pagination .page-item.active .page-link {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-color: #667eea;
            color: white;
        }

        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            color: #718096;
        }

        .empty-state i {
            font-size: 4rem;
            color: #cbd5e0;
            margin-bottom: 1rem;
        }

        .empty-state h3 {
            color: #4a5568;
            margin-bottom: 1rem;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .main-container {
                margin: 1rem;
                padding: 2rem 1.5rem;
            }

            .page-title {
                font-size: 2rem;
                flex-direction: column;
                gap: 0.5rem;
            }

            .controls-section {
                padding: 1.5rem;
            }

            .action-buttons {
                flex-direction: column;
            }

            .btn-action {
                width: 100%;
            }

            .custom-table {
                font-size: 0.9rem;
            }

            .custom-table thead th,
            .custom-table tbody td {
                padding: 1rem 0.75rem;
            }
        }

        /* Loading Animation */
        .loading {
            position: relative;
            pointer-events: none;
        }

        .loading::after {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 16px;
            height: 16px;
            margin: -8px 0 0 -8px;
            border: 2px solid transparent;
            border-top: 2px solid currentColor;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
    </style>
</head>
<body>
<div class="main-container">
    <div class="page-header">
        <h1 class="page-title">
            <i class="fas fa-book-open"></i>
            Course Lessons
        </h1>
        <p class="page-subtitle">Manage lessons for Course #${courseId}</p>
    </div>

    <!-- Filter & Search Controls -->
    <div class="controls-section">
        <div class="row align-items-center">
            <div class="col-md-4 mb-3 mb-md-0">
                <div class="position-relative">
                    <i class="fas fa-search position-absolute" style="left: 1rem; top: 50%; transform: translateY(-50%); color: #718096;"></i>
                    <input type="text" id="searchInput" class="form-control search-input ps-5" placeholder="Search by lesson title...">
                </div>
            </div>
            <div class="col-md-3 mb-3 mb-md-0">
                <select id="statusFilter" class="form-select status-select">
                    <option value="">All Statuses</option>
                    <option value="published">Published</option>
                    <option value="draft">Draft</option>
                </select>
            </div>
            <div class="col-md-5 d-flex justify-content-end">
                <a href="add-lesson?courseId=${courseId}" class="btn-add-lesson">
                    <i class="fas fa-plus"></i>
                    Add New Lesson
                </a>
            </div>
        </div>
    </div>

    <c:choose>
        <c:when test="${not empty lessons}">
            <div class="table-container">
                <table class="table custom-table">
                    <thead>
                    <tr>
                        <th style="color:#222">#</th>
                        <th style="color:#222">Lesson Title</th>
                        <th style="color:#222">Quizzes</th>
                        <th style="color:#222">Materials</th>
                        <th style="color:#222">Status</th>
                        <th style="color:#222">Action</th>
                    </tr>
                    </thead>
                    <tbody id="lessonsTableBody">
                    <c:forEach var="ls" items="${lessons}">
                        <tr data-title="${ls.lesson.title}" data-status="${ls.lesson.status}">
                            <td>
                                <span class="fw-bold text-muted">#${ls.lesson.id}</span>
                            </td>
                            <td>
                                <h6 class="lesson-title">${ls.lesson.title}</h6>
                            </td>
                            <td>
                                <span class="badge badge-custom badge-quiz">${ls.totalQuizzes}</span>
                            </td>
                            <td>
                                <span class="badge badge-custom badge-material">${ls.totalMaterials}</span>
                            </td>
                            <td>
                                <div class="preview-container">
                                    <span class="badge badge-custom ${ls.lesson.isFreePreview ? 'badge-preview-yes' : 'badge-preview-no'}">
                                            ${ls.lesson.isFreePreview ? 'Free' : 'Premium'}
                                    </span>

                                </div>
                            </td>
                            <td>
                                <div class="action-buttons">
                                    <a href="lesson-details?id=${ls.lesson.id}" class="btn-action btn-view">
                                        <i class="fas fa-eye"></i>
                                        View
                                    </a>
                                    <a href="edit-lesson?id=${ls.lesson.id}" class="btn-action btn-edit">
                                        <i class="fas fa-edit"></i>
                                        Edit
                                    </a>
                                    <button class="btn-action btn-delete" onclick="deleteLesson(${ls.lesson.id})">
                                        <i class="fas fa-trash"></i>
                                        Delete
                                    </button>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- Pagination Controls -->
            <div class="pagination-container">
                <nav>
                    <ul class="pagination" id="pagination"></ul>
                </nav>
            </div>
        </c:when>
        <c:otherwise>
            <div class="empty-state">
                <i class="fas fa-book-open"></i>
                <h3>No Lessons Found</h3>
                <p>This course doesn't have any lessons yet. Start by adding your first lesson.</p>
                <a href="add-lesson?courseId=${courseId}" class="btn-add-lesson mt-3">
                    <i class="fas fa-plus"></i>
                    Add First Lesson
                </a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const rowsPerPage = 5;
        let currentPage = 1;

        function filterAndPaginate() {
            const search = document.getElementById('searchInput').value.toLowerCase();
            const status = document.getElementById('statusFilter').value;
            const rows = Array.from(document.querySelectorAll('#lessonsTableBody tr'));

            let filtered = rows.filter(row => {
                const title = row.getAttribute('data-title').toLowerCase();
                const stat = row.getAttribute('data-status');
                const matchSearch = title.includes(search);
                const matchStatus = !status || stat === status;
                return matchSearch && matchStatus;
            });

            // Pagination
            const totalPages = Math.ceil(filtered.length / rowsPerPage) || 1;
            if (currentPage > totalPages) currentPage = totalPages;

            filtered.forEach((row, i) => {
                row.style.display = (i >= (currentPage-1)*rowsPerPage && i < currentPage*rowsPerPage) ? '' : 'none';
            });

            rows.filter(r => !filtered.includes(r)).forEach(r => r.style.display = 'none');
            renderPagination(totalPages);
        }

        function renderPagination(totalPages) {
            const pag = document.getElementById('pagination');
            pag.innerHTML = '';

            for (let i = 1; i <= totalPages; i++) {
                const li = document.createElement('li');
                li.className = 'page-item' + (i === currentPage ? ' active' : '');
                const a = document.createElement('a');
                a.className = 'page-link';
                a.href = '#';
                a.textContent = i;
                a.onclick = (e) => {
                    e.preventDefault();
                    currentPage = i;
                    filterAndPaginate();
                };
                li.appendChild(a);
                pag.appendChild(li);
            }
        }

        // Event listeners
        document.getElementById('searchInput').addEventListener('input', () => {
            currentPage = 1;
            filterAndPaginate();
        });

        document.getElementById('statusFilter').addEventListener('change', () => {
            currentPage = 1;
            filterAndPaginate();
        });

        // Initial load
        filterAndPaginate();

        // Functions for actions
        window.deleteLesson = function(lessonId) {
            if (alert('Are you sure you want to delete this lesson? This action cannot be undone.')) {
                // Add loading state
                const deleteBtn = event.target.closest('.btn-delete');
                deleteBtn.classList.add('loading');
                deleteBtn.disabled = true;

                // TODO: Implement AJAX call to delete endpoint
                setTimeout(() => {
                    alert('Delete lesson ' + lessonId + ' (implement backend logic)');
                    deleteBtn.classList.remove('loading');
                    deleteBtn.disabled = false;
                }, 1000);
            }
        };

        window.changePreview = function(lessonId) {
            const changeBtn = event.target.closest('.btn-change');
            changeBtn.classList.add('loading');
            changeBtn.disabled = true;

            // TODO: Implement AJAX call to change preview endpoint
            setTimeout(() => {
                alert('Change preview for lesson ' + lessonId + ' (implement backend logic)');
                changeBtn.classList.remove('loading');
                changeBtn.disabled = false;
            }, 1000);
        };
    });
</script>
</body>
</html>