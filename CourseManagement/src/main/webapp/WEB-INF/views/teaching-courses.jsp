<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/layout/header.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Teaching Courses</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --secondary-gradient: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            --success-gradient: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            --card-shadow: 0 10px 30px rgba(0,0,0,0.1);
            --hover-shadow: 0 15px 40px rgba(0,0,0,0.15);
            --border-radius: 15px;
        }

        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .main-container {
            max-width: 1200px;
            margin: 2rem auto;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: var(--border-radius);
            box-shadow: var(--card-shadow);
            padding: 3rem 2.5rem;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .page-title {
            font-size: 2.5rem;
            font-weight: 800;
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 3rem;
            text-align: center;
            position: relative;
        }

        .page-title::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            height: 4px;
            background: var(--primary-gradient);
            border-radius: 2px;
        }

        .filter-card {
            background: rgba(255, 255, 255, 0.8);
            border-radius: var(--border-radius);
            padding: 1.5rem;
            margin-bottom: 2rem;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            border: 1px solid rgba(255, 255, 255, 0.3);
        }

        .form-control, .form-select {
            border: 2px solid rgba(102, 126, 234, 0.1);
            border-radius: 10px;
            padding: 0.75rem 1rem;
            transition: all 0.3s ease;
            background: rgba(255, 255, 255, 0.9);
        }

        .form-control:focus, .form-select:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
            background: #fff;
        }

        .courses-table {
            background: rgba(255, 255, 255, 0.95);
            border-radius: var(--border-radius);
            overflow: hidden;
            box-shadow: var(--card-shadow);
            border: none;
        }

        .courses-table thead {
            background: var(--primary-gradient);
            color: #fff;
        }

        .courses-table thead th {
            border: none;
            padding: 1.2rem 1rem;
            font-weight: 600;
            letter-spacing: 0.5px;
            text-transform: uppercase;
            font-size: 0.85rem;
        }

        .courses-table tbody tr {
            transition: all 0.3s ease;
            border: none;
            background: rgba(255, 255, 255, 0.8);
        }

        .courses-table tbody tr:hover {
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.1), rgba(118, 75, 162, 0.1));
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        .courses-table tbody td {
            padding: 1.2rem 1rem;
            border: none;
            border-bottom: 1px solid rgba(0,0,0,0.05);
            vertical-align: middle;
        }

        .course-title {
            font-weight: 600;
            color: #4a5568;
            font-size: 1.1rem;
        }

        .course-description {
            color: #718096;
            line-height: 1.5;
            max-width: 250px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .badge {
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-weight: 500;
            font-size: 0.85rem;
            letter-spacing: 0.3px;
        }

        .badge.price-badge {
            background: var(--success-gradient);
            color: white;
            box-shadow: 0 3px 10px rgba(79, 172, 254, 0.3);
        }

        .badge.rating-badge {
            background: linear-gradient(135deg, #ffd89b 0%, #19547b 100%);
            color: white;
            box-shadow: 0 3px 10px rgba(255, 216, 155, 0.3);
        }

        .badge.status-badge {
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
        }

        .badge.status-active { background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%); color: white; }
        .badge.status-inactive { background: linear-gradient(135deg, #fc4a1a 0%, #f7b733 100%); color: white; }
        .badge.status-draft { background: linear-gradient(135deg, #8360c3 0%, #2ebf91 100%); color: white; }

        .action-buttons {
            display: flex;
            gap: 0.5rem;
            flex-wrap: wrap;
        }

        .btn-modern {
            border-radius: 8px;
            padding: 0.5rem 1rem;
            font-weight: 500;
            font-size: 0.85rem;
            border: none;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.3rem;
        }

        .btn-view {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .btn-view:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
            color: white;
        }

        .btn-feedback {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            color: white;
        }

        .btn-feedback:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(240, 147, 251, 0.4);
            color: white;
        }

        .pagination {
            margin-top: 2rem;
        }

        .page-link {
            border: none;
            padding: 0.75rem 1rem;
            margin: 0 0.2rem;
            border-radius: 8px;
            color: #667eea;
            background: rgba(255, 255, 255, 0.8);
            transition: all 0.3s ease;
        }

        .page-link:hover {
            background: var(--primary-gradient);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);
        }

        .page-item.active .page-link {
            background: var(--primary-gradient);
            color: white;
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);
        }

        .no-courses-card {
            background: rgba(255, 255, 255, 0.9);
            border-radius: var(--border-radius);
            padding: 3rem;
            text-align: center;
            box-shadow: var(--card-shadow);
            border: 1px solid rgba(255, 255, 255, 0.3);
        }

        .no-courses-icon {
            font-size: 4rem;
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 1rem;
        }

        .filter-title {
            font-weight: 600;
            color: #4a5568;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        @media (max-width: 768px) {
            .main-container {
                margin: 1rem;
                padding: 2rem 1.5rem;
            }

            .page-title {
                font-size: 2rem;
            }

            .action-buttons {
                flex-direction: column;
            }

            .course-description {
                max-width: 150px;
            }
        }

        .loading-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(255, 255, 255, 0.9);
            display: none;
            justify-content: center;
            align-items: center;
            z-index: 9999;
        }

        .loading-spinner {
            width: 50px;
            height: 50px;
            border: 4px solid #f3f3f3;
            border-top: 4px solid #667eea;
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
<div class="loading-overlay" id="loadingOverlay">
    <div class="loading-spinner"></div>
</div>

<div class="main-container">
    <div class="page-title">
        <i class="fas fa-chalkboard-teacher me-3"></i>
        Your Teaching Courses
    </div>

    <!-- Filter & Search Controls -->
    <div class="filter-card">
        <div class="filter-title">
            <i class="fas fa-filter"></i>
            Filter & Search Options
        </div>
        <div class="row">
            <div class="col-md-6 col-lg-4 mb-3">
                <label for="searchInput" class="form-label">
                    <i class="fas fa-search me-1"></i>Search Courses
                </label>
                <input type="text" id="searchInput" class="form-control"
                       placeholder="Search by title or description...">
            </div>
            <div class="col-md-6 col-lg-3 mb-3">
                <label for="statusFilter" class="form-label">
                    <i class="fas fa-toggle-on me-1"></i>Status Filter
                </label>
                <select id="statusFilter" class="form-select">
                    <option value="">All Statuses</option>
                    <option value="active">Active</option>
                    <option value="inactive">Inactive</option>
                    <option value="draft">Draft</option>
                </select>
            </div>
            <div class="col-md-12 col-lg-5 mb-3 d-flex align-items-end">
                <button type="button" class="btn btn-outline-secondary me-2" onclick="clearFilters()">
                    <i class="fas fa-times me-1"></i>Clear Filters
                </button>
                <div class="ms-auto">
                    <small class="text-muted">
                        <span id="resultCount">0</span> courses found
                    </small>
                </div>
            </div>
        </div>
    </div>

    <c:choose>
        <c:when test="${not empty courses}">
            <div class="table-responsive">
                <table class="table courses-table align-middle">
                    <thead>
                    <tr>
                        <th style="width: 60px;">#</th>
                        <th style="width: 25%;">Title</th>
                        <th style="width: 30%;">Description</th>
                        <th style="width: 100px;">Price</th>
                        <th style="width: 80px;">Rating</th>
                        <th style="width: 100px;">Status</th>
                        <th style="width: 200px;">Actions</th>
                    </tr>
                    </thead>
                    <tbody id="coursesTableBody">
                    <c:forEach var="course" items="${courses}" varStatus="status">
                        <tr data-title="${course.title}" data-description="${course.description}" data-status="${course.status}">
                            <td class="text-center fw-bold">${status.index + 1}</td>
                            <td class="course-title">${course.title}</td>
                            <td class="course-description" title="${course.description}">
                                <c:out value="${course.description}"/>
                            </td>
                            <td>
                                        <span class="badge price-badge">
                                            <i class="fas fa-dollar-sign me-1"></i>{course.price}VNĐ
                                        </span>
                            </td>
                            <td>
                                        <span class="badge rating-badge">
                                            <i class="fas fa-star me-1"></i>${course.rating}
                                        </span>
                            </td>
                            <td>
                                        <span class="badge status-badge status-${course.status}">
                                            <c:choose>
                                                <c:when test="${course.status == 'active'}">
                                                    <i class="fas fa-check-circle me-1"></i>Active
                                                </c:when>
                                                <c:when test="${course.status == 'inactive'}">
                                                    <i class="fas fa-pause-circle me-1"></i>Inactive
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="fas fa-edit me-1"></i>Draft
                                                </c:otherwise>
                                            </c:choose>
                                        </span>
                            </td>
                            <td>
                                <div class="action-buttons">
                                    <a href="course-lessons?id=${course.id}" class="btn-modern btn-view">
                                        <i class="fas fa-eye"></i>View Details
                                    </a>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>

                <!-- Pagination Controls -->
                <nav aria-label="Course pagination">
                    <ul class="pagination justify-content-center" id="pagination"></ul>
                </nav>
            </div>
        </c:when>
        <c:otherwise>
            <div class="no-courses-card">
                <div class="no-courses-icon">
                    <i class="fas fa-graduation-cap"></i>
                </div>
                <h4 class="mb-3">No Teaching Courses Yet</h4>
                <p class="text-muted mb-4">You haven't created any courses yet. Start your teaching journey by creating your first course!</p>
                <button class="btn btn-modern btn-view">
                    <i class="fas fa-plus me-2"></i>Create Your First Course
                </button>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    const rowsPerPage = 6;
    let currentPage = 1;
    let allRows = [];

    function showLoading() {
        document.getElementById('loadingOverlay').style.display = 'flex';
    }

    function hideLoading() {
        setTimeout(() => {
            document.getElementById('loadingOverlay').style.display = 'none';
        }, 300);
    }

    function updateResultCount(count) {
        document.getElementById('resultCount').textContent = count;
    }

    function filterAndPaginate() {
        const search = document.getElementById('searchInput').value.toLowerCase().trim();
        const status = document.getElementById('statusFilter').value;

        let filtered = allRows.filter(row => {
            const title = row.getAttribute('data-title').toLowerCase();
            const desc = row.getAttribute('data-description').toLowerCase();
            const stat = row.getAttribute('data-status');

            const matchSearch = !search || title.includes(search) || desc.includes(search);
            const matchStatus = !status || stat === status;

            return matchSearch && matchStatus;
        });

        updateResultCount(filtered.length);

        // Pagination
        const totalPages = Math.ceil(filtered.length / rowsPerPage) || 1;
        if (currentPage > totalPages) currentPage = totalPages;

        // Show/hide rows
        allRows.forEach(row => row.style.display = 'none');

        const startIndex = (currentPage - 1) * rowsPerPage;
        const endIndex = startIndex + rowsPerPage;

        filtered.slice(startIndex, endIndex).forEach(row => {
            row.style.display = '';
        });

        renderPagination(totalPages, filtered.length);

        // Add animation to visible rows
        setTimeout(() => {
            const visibleRows = document.querySelectorAll('#coursesTableBody tr[style=""]');
            visibleRows.forEach((row, index) => {
                row.style.opacity = '0';
                row.style.transform = 'translateY(20px)';
                setTimeout(() => {
                    row.style.transition = 'all 0.3s ease';
                    row.style.opacity = '1';
                    row.style.transform = 'translateY(0)';
                }, index * 100);
            });
        }, 50);
    }

    function renderPagination(totalPages, totalResults) {
        const pag = document.getElementById('pagination');
        pag.innerHTML = '';

        if (totalPages <= 1) return;

        // Previous button
        if (currentPage > 1) {
            const prevLi = document.createElement('li');
            prevLi.className = 'page-item';
            const prevA = document.createElement('a');
            prevA.className = 'page-link';
            prevA.href = '#';
            prevA.innerHTML = '<i class="fas fa-chevron-left"></i>';
            prevA.onclick = (e) => {
                e.preventDefault();
                currentPage--;
                filterAndPaginate();
            };
            prevLi.appendChild(prevA);
            pag.appendChild(prevLi);
        }

        // Page numbers
        const startPage = Math.max(1, currentPage - 2);
        const endPage = Math.min(totalPages, currentPage + 2);

        if (startPage > 1) {
            addPageButton(1);
            if (startPage > 2) {
                const ellipsis = document.createElement('li');
                ellipsis.className = 'page-item disabled';
                ellipsis.innerHTML = '<span class="page-link">...</span>';
                pag.appendChild(ellipsis);
            }
        }

        for (let i = startPage; i <= endPage; i++) {
            addPageButton(i);
        }

        if (endPage < totalPages) {
            if (endPage < totalPages - 1) {
                const ellipsis = document.createElement('li');
                ellipsis.className = 'page-item disabled';
                ellipsis.innerHTML = '<span class="page-link">...</span>';
                pag.appendChild(ellipsis);
            }
            addPageButton(totalPages);
        }

        // Next button
        if (currentPage < totalPages) {
            const nextLi = document.createElement('li');
            nextLi.className = 'page-item';
            const nextA = document.createElement('a');
            nextA.className = 'page-link';
            nextA.href = '#';
            nextA.innerHTML = '<i class="fas fa-chevron-right"></i>';
            nextA.onclick = (e) => {
                e.preventDefault();
                currentPage++;
                filterAndPaginate();
            };
            nextLi.appendChild(nextA);
            pag.appendChild(nextLi);
        }

        function addPageButton(pageNum) {
            const li = document.createElement('li');
            li.className = 'page-item' + (pageNum === currentPage ? ' active' : '');
            const a = document.createElement('a');
            a.className = 'page-link';
            a.href = '#';
            a.textContent = pageNum;
            a.onclick = (e) => {
                e.preventDefault();
                currentPage = pageNum;
                filterAndPaginate();
            };
            li.appendChild(a);
            pag.appendChild(li);
        }
    }

    function clearFilters() {
        document.getElementById('searchInput').value = '';
        document.getElementById('statusFilter').value = '';
        currentPage = 1;
        filterAndPaginate();
    }

    // Debounce function for search input
    function debounce(func, wait) {
        let timeout;
        return function executedFunction(...args) {
            const later = () => {
                clearTimeout(timeout);
                func(...args);
            };
            clearTimeout(timeout);
            timeout = setTimeout(later, wait);
        };
    }

    // Event listeners
    document.addEventListener('DOMContentLoaded', function() {
        showLoading();

        // Cache all rows
        allRows = Array.from(document.querySelectorAll('#coursesTableBody tr'));

        // Set up event listeners
        const searchInput = document.getElementById('searchInput');
        const statusFilter = document.getElementById('statusFilter');

        if (searchInput) {
            searchInput.addEventListener('input', debounce(() => {
                currentPage = 1;
                filterAndPaginate();
            }, 300));
        }

        if (statusFilter) {
            statusFilter.addEventListener('change', () => {
                currentPage = 1;
                filterAndPaginate();
            });
        }

        // Initial load
        filterAndPaginate();
        hideLoading();
    });

    // Add smooth scrolling to pagination
    document.addEventListener('click', function(e) {
        if (e.target.closest('.page-link')) {
            setTimeout(() => {
                document.querySelector('.courses-table').scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }, 100);
        }
    });
</script>
</body>
</html>