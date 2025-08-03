<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản Lý Danh Sách Người Dùng</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .user-section {
            margin-bottom: 2rem;
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            padding: 1.5rem;
        }
        .section-title {
            color: #2c3e50;
            margin-bottom: 1.5rem;
            padding-bottom: 0.5rem;
            border-bottom: 2px solid #3498db;
        }

        .user-table {
            width: 100%;
            margin-bottom: 1rem;
        }

        .user-table th {
            background-color: #f8f9fa;
            padding: 12px;
            font-weight: 600;
        }

        .user-table td {
            padding: 12px;
            vertical-align: middle;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            object-fit: cover;
        }

        .search-filter-box {
            margin-bottom: 1.5rem;
            padding: 1rem;
            background-color: #f8f9fa;
            border-radius: 6px;
            border: 1px solid #dee2e6;
        }

        .search-input {
            flex: 1;
            padding: 0.5rem;
            border: 1px solid #ddd;
            border-radius: 4px;
            transition: border-color 0.3s ease;
        }

        .search-input:focus {
            outline: none;
            border-color: #3498db;
            box-shadow: 0 0 0 0.2rem rgba(52, 152, 219, 0.25);
        }

        .filter-select {
            padding: 0.5rem;
            border: 1px solid #ddd;
            border-radius: 4px;
            background-color: white;
            transition: border-color 0.3s ease;
        }

        .filter-select:focus {
            outline: none;
            border-color: #3498db;
            box-shadow: 0 0 0 0.2rem rgba(52, 152, 219, 0.25);
        }

        .btn-action {
            padding: 6px 12px;
            border-radius: 4px;
            border: none;
            cursor: pointer;
            transition: all 0.3s;
        }

        .btn-edit {
            background-color: #3498db;
            color: white;
        }

        .btn-delete {
            background-color: #e74c3c;
            color: white;
        }

        .btn-action:hover {
            opacity: 0.9;
            transform: translateY(-1px);
        }

        .search-controls {
            display: flex;
            gap: 1rem;
            align-items: center;
            flex-wrap: wrap;
        }

        .search-group {
            display: flex;
            flex-direction: column;
            gap: 0.3rem;
        }

        .search-group label {
            font-size: 0.85rem;
            font-weight: 500;
            color: #555;
        }

        .no-results {
            text-align: center;
            padding: 2rem;
            color: #6c757d;
            font-style: italic;
        }

        .results-count {
            font-size: 0.9rem;
            color: #6c757d;
            margin-bottom: 1rem;
        }

        .user-row {
            transition: all 0.3s ease;
        }

        .user-row.hidden {
            display: none;
        }

        .highlight {
            background-color: #fff3cd;
            padding: 0 2px;
            border-radius: 2px;
        }

        @media (max-width: 768px) {
            .search-controls {
                flex-direction: column;
                align-items: stretch;
            }

            .search-group {
                width: 100%;
            }
        }
    </style>
</head>
<body>
<c:set var="active" value="users" scope="request"/>
<jsp:include page="/WEB-INF/layout/header.jsp" />
<jsp:include page="/WEB-INF/views/_admin_sidebar.jsp" />

<div class="container mt-4">
    <!-- Students Section -->
    <div class="user-section">
        <h2 class="section-title">Học Viên</h2>

        <!-- Search and Filter for Students -->
        <div class="search-filter-box">
            <div class="search-controls">
                <div class="search-group" style="flex: 2;">
                    <label for="studentSearch">Tìm kiếm</label>
                    <input type="text" id="studentSearch" class="search-input"
                           placeholder="Tên, email hoặc số điện thoại...">
                </div>
                <div class="search-group">
                    <label for="studentStatus">Trạng thái</label>
                    <select id="studentStatus" class="filter-select">
                        <option value="">Tất cả</option>
                        <option value="active">Hoạt động</option>
                        <option value="blocked">Đã bị chặn</option>
                    </select>
                </div>
                <div class="search-group">
                    <label>&nbsp;</label>
                    <button type="button" class="btn btn-outline-secondary" onclick="clearStudentFilters()">
                        <i class="fas fa-times"></i> Xóa bộ lọc
                    </button>
                </div>
            </div>
        </div>

        <div class="results-count" id="studentCount"></div>
        <div class="table-responsive">
            <table class="user-table">
                <thead>
                <tr>
                    <th>Thông Tin Người Dùng</th>
                    <th>Email</th>
                    <th>Điện Thoại</th>
                    <th>Ngày Tạo</th>
                    <th>Trạng Thái</th>
                </tr>
                </thead>
                <tbody id="studentTableBody">
                <c:forEach items="${students}" var="student">
                    <tr class="user-row"
                        data-name="${student.firstName} ${student.lastName}"
                        data-username="${student.username}"
                        data-email="${student.email}"
                        data-phone="${student.phoneNumber}"
                        data-status="${student.blocked ? 'blocked' : 'active'}">
                        <td>
                            <div class="user-info">
                                <img src="${not empty student.avatarUrl ? student.avatarUrl : '/assets/avatar/default_avatar.png'}"
                                     alt="${student.username}" class="avatar">
                                <div>
                                    <div class="user-name">${student.firstName} ${student.lastName}</div>
                                    <small class="text-muted user-username">@${student.username}</small>
                                </div>
                            </div>
                        </td>
                        <td class="user-email">${student.email}</td>
                        <td class="user-phone">${student.phoneNumber}</td>
                        <td><fmt:formatDate value="${student.createdAtDate}" pattern="MMM dd, yyyy"/></td>
                        <td>
                            <c:if test="${student.blocked}">
                                <span class="badge bg-danger">Đã bị chặn</span>
                            </c:if>
                            <c:if test="${!student.blocked}">
                                <span class="badge bg-success">Hoạt động</span>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <div id="studentNoResults" class="no-results" style="display: none;">
                <i class="fas fa-search fa-2x mb-3"></i>
                <p>Không tìm thấy học viên nào phù hợp với tiêu chí tìm kiếm.</p>
            </div>
        </div>
    </div>

    <!-- Teachers Section -->
    <div class="user-section">
        <h2 class="section-title">Giảng Viên</h2>
        <a href="${pageContext.request.contextPath}/admin/teachers/create" class="btn btn-primary mb-3">
            <i class="fas fa-plus-circle me-1"></i> Tạo Giảng Viên
        </a>

        <!-- Search and Filter for Teachers -->
        <div class="search-filter-box">
            <div class="search-controls">
                <div class="search-group" style="flex: 2;">
                    <label for="teacherSearch">Tìm kiếm</label>
                    <input type="text" id="teacherSearch" class="search-input"
                           placeholder="Tên, email hoặc số điện thoại...">
                </div>
                <div class="search-group">
                    <label for="teacherStatus">Trạng thái</label>
                    <select id="teacherStatus" class="filter-select">
                        <option value="">Tất cả</option>
                        <option value="active">Hoạt động</option>
                        <option value="blocked">Đã bị chặn</option>
                    </select>
                </div>
                <div class="search-group">
                    <label>&nbsp;</label>
                    <button type="button" class="btn btn-outline-secondary" onclick="clearTeacherFilters()">
                        <i class="fas fa-times"></i> Xóa bộ lọc
                    </button>
                </div>
            </div>
        </div>

        <div class="results-count" id="teacherCount"></div>
        <div class="table-responsive">
            <table class="user-table">
                <thead>
                <tr>
                    <th>Thông Tin Người Dùng</th>
                    <th>Email</th>
                    <th>Điện Thoại</th>
                    <th>Ngày Tạo</th>
                    <th>Trạng Thái</th>
                    <th>Thao Tác</th>
                </tr>
                </thead>
                <tbody id="teacherTableBody">
                <c:forEach items="${teachers}" var="teacher">
                    <tr class="user-row"
                        data-name="${teacher.firstName} ${teacher.lastName}"
                        data-username="${teacher.username}"
                        data-email="${teacher.email}"
                        data-phone="${teacher.phoneNumber}"
                        data-status="${teacher.blocked ? 'blocked' : 'active'}">
                        <td>
                            <div class="user-info">
                                <img src="${not empty teacher.avatarUrl ? teacher.avatarUrl : '/assets/avatar/default_avatar.png'}"
                                     alt="${teacher.username}" class="avatar">
                                <div>
                                    <div class="user-name">${teacher.firstName} ${teacher.lastName}</div>
                                    <small class="text-muted user-username">@${teacher.username}</small>
                                </div>
                            </div>
                        </td>
                        <td class="user-email">${teacher.email}</td>
                        <td class="user-phone">${teacher.phoneNumber}</td>
                        <td><fmt:formatDate value="${teacher.createdAtDate}" pattern="MMM dd, yyyy"/></td>
                        <td>
                            <c:if test="${teacher.blocked}">
                                <span class="badge bg-danger">Đã bị chặn</span>
                            </c:if>
                            <c:if test="${!teacher.blocked}">
                                <span class="badge bg-success">Hoạt động</span>
                            </c:if>
                        </td>
                        <td>
                            <c:if test="${teacher.blocked}">
                                <form method="post" action="${pageContext.request.contextPath}/admin/users/unblock" style="display:inline">
                                    <input type="hidden" name="id" value="${teacher.id}" />
                                    <button type="submit" class="btn-action btn-edit" title="Mở chặn">
                                        <i class="fas fa-unlock"></i>
                                    </button>
                                </form>
                            </c:if>
                            <c:if test="${!teacher.blocked}">
                                <form method="post" action="${pageContext.request.contextPath}/admin/users/block" style="display:inline">
                                    <input type="hidden" name="id" value="${teacher.id}" />
                                    <button type="submit" class="btn-action btn-delete" title="Chặn">
                                        <i class="fas fa-ban"></i>
                                    </button>
                                </form>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <div id="teacherNoResults" class="no-results" style="display: none;">
                <i class="fas fa-search fa-2x mb-3"></i>
                <p>Không tìm thấy giảng viên nào phù hợp với tiêu chí tìm kiếm.</p>
            </div>
        </div>
    </div>

    <!-- Course Managers Section -->
    <div class="user-section">
        <h2 class="section-title">Quản Lý Khóa Học</h2>
        <a href="${pageContext.request.contextPath}/admin/courses/new?role=COURSE_MANAGER" class="btn btn-primary mb-3">
            <i class="fas fa-plus-circle me-1"></i> Tạo Quản Lý Khóa Học
        </a>

        <!-- Search and Filter for Course Managers -->
        <div class="search-filter-box">
            <div class="search-controls">
                <div class="search-group" style="flex: 2;">
                    <label for="courseManagerSearch">Tìm kiếm</label>
                    <input type="text" id="courseManagerSearch" class="search-input"
                           placeholder="Tên, email hoặc số điện thoại...">
                </div>
                <div class="search-group">
                    <label for="courseManagerStatus">Trạng thái</label>
                    <select id="courseManagerStatus" class="filter-select">
                        <option value="">Tất cả</option>
                        <option value="active">Hoạt động</option>
                        <option value="blocked">Đã bị chặn</option>
                    </select>
                </div>
                <div class="search-group">
                    <label>&nbsp;</label>
                    <button type="button" class="btn btn-outline-secondary" onclick="clearCourseManagerFilters()">
                        <i class="fas fa-times"></i> Xóa bộ lọc
                    </button>
                </div>
            </div>
        </div>

        <div class="results-count" id="courseManagerCount"></div>
        <div class="table-responsive">
            <table class="user-table">
                <thead>
                <tr>
                    <th>Thông Tin Người Dùng</th>
                    <th>Email</th>
                    <th>Điện Thoại</th>
                    <th>Ngày Tạo</th>
                    <th>Trạng Thái</th>
                    <th>Thao Tác</th>
                </tr>
                </thead>
                <tbody id="courseManagerTableBody">
                <c:forEach items="${courseManagers}" var="manager">
                    <tr class="user-row"
                        data-name="${manager.firstName} ${manager.lastName}"
                        data-username="${manager.username}"
                        data-email="${manager.email}"
                        data-phone="${manager.phoneNumber}"
                        data-status="${manager.blocked ? 'blocked' : 'active'}">
                        <td>
                            <div class="user-info">
                                <img src="${not empty manager.avatarUrl ? manager.avatarUrl : '/assets/avatar/default_avatar.png'}"
                                     alt="${manager.username}" class="avatar">
                                <div>
                                    <div class="user-name">${manager.firstName} ${manager.lastName}</div>
                                    <small class="text-muted user-username">@${manager.username}</small>
                                </div>
                            </div>
                        </td>
                        <td class="user-email">${manager.email}</td>
                        <td class="user-phone">${manager.phoneNumber}</td>
                        <td><fmt:formatDate value="${manager.createdAtDate}" pattern="MMM dd, yyyy"/></td>
                        <td>
                            <c:if test="${manager.blocked}">
                                <span class="badge bg-danger">Đã bị chặn</span>
                            </c:if>
                            <c:if test="${!manager.blocked}">
                                <span class="badge bg-success">Hoạt động</span>
                            </c:if>
                        </td>
                        <td>
                            <c:if test="${manager.blocked}">
                                <form method="post" action="${pageContext.request.contextPath}/admin/users/unblock" style="display:inline">
                                    <input type="hidden" name="id" value="${manager.id}" />
                                    <button type="submit" class="btn-action btn-edit" title="Mở chặn">
                                        <i class="fas fa-unlock"></i>
                                    </button>
                                </form>
                            </c:if>
                            <c:if test="${!manager.blocked}">
                                <form method="post" action="${pageContext.request.contextPath}/admin/users/block" style="display:inline">
                                    <input type="hidden" name="id" value="${manager.id}" />
                                    <button type="submit" class="btn-action btn-delete" title="Chặn">
                                        <i class="fas fa-ban"></i>
                                    </button>
                                </form>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <div id="courseManagerNoResults" class="no-results" style="display: none;">
                <i class="fas fa-search fa-2x mb-3"></i>
                <p>Không tìm thấy quản lý khóa học nào phù hợp với tiêu chí tìm kiếm.</p>
            </div>
        </div>
    </div>

    <!-- User Managers Section (Only visible for Admin) -->
    <c:if test="${isAdmin}">
        <div class="user-section">
            <h2 class="section-title">Quản Lý Người Dùng</h2>
            <a href="${pageContext.request.contextPath}/admin/users/new?role=USER_MANAGER" class="btn btn-primary mb-3">
                <i class="fas fa-plus-circle me-1"></i> Tạo Quản Lý Người Dùng
            </a>

            <!-- Search and Filter for User Managers -->
            <div class="search-filter-box">
                <div class="search-controls">
                    <div class="search-group" style="flex: 2;">
                        <label for="userManagerSearch">Tìm kiếm</label>
                        <input type="text" id="userManagerSearch" class="search-input"
                               placeholder="Tên, email hoặc số điện thoại...">
                    </div>
                    <div class="search-group">
                        <label for="userManagerStatus">Trạng thái</label>
                        <select id="userManagerStatus" class="filter-select">
                            <option value="">Tất cả</option>
                            <option value="active">Hoạt động</option>
                            <option value="blocked">Đã bị chặn</option>
                        </select>
                    </div>
                    <div class="search-group">
                        <label>&nbsp;</label>
                        <button type="button" class="btn btn-outline-secondary" onclick="clearUserManagerFilters()">
                            <i class="fas fa-times"></i> Xóa bộ lọc
                        </button>
                    </div>
                </div>
            </div>

            <div class="results-count" id="userManagerCount"></div>
            <div class="table-responsive">
                <table class="user-table">
                    <thead>
                    <tr>
                        <th>Thông Tin Người Dùng</th>
                        <th>Email</th>
                        <th>Điện Thoại</th>
                        <th>Ngày Tạo</th>
                        <th>Trạng Thái</th>
                        <th>Thao Tác</th>
                    </tr>
                    </thead>
                    <tbody id="userManagerTableBody">
                    <c:forEach items="${userManagers}" var="manager">
                        <tr class="user-row"
                            data-name="${manager.firstName} ${manager.lastName}"
                            data-username="${manager.username}"
                            data-email="${manager.email}"
                            data-phone="${manager.phoneNumber}"
                            data-status="${manager.blocked ? 'blocked' : 'active'}">
                            <td>
                                <div class="user-info">
                                    <img src="${not empty manager.avatarUrl ? manager.avatarUrl : '/assets/avatar/default_avatar.png'}"
                                         alt="${manager.username}" class="avatar">
                                    <div>
                                        <div class="user-name">${manager.firstName} ${manager.lastName}</div>
                                        <small class="text-muted user-username">@${manager.username}</small>
                                    </div>
                                </div>
                            </td>
                            <td class="user-email">${manager.email}</td>
                            <td class="user-phone">${manager.phoneNumber}</td>
                            <td><fmt:formatDate value="${manager.createdAtDate}" pattern="MMM dd, yyyy"/></td>
                            <td>
                                <c:if test="${manager.blocked}">
                                    <span class="badge bg-danger">Đã bị chặn</span>
                                </c:if>
                                <c:if test="${!manager.blocked}">
                                    <span class="badge bg-success">Hoạt động</span>
                                </c:if>
                            </td>
                            <td>
                                <c:if test="${manager.blocked}">
                                    <form method="post" action="${pageContext.request.contextPath}/admin/users/unblock" style="display:inline">
                                        <input type="hidden" name="id" value="${manager.id}" />
                                        <button type="submit" class="btn-action btn-edit" title="Mở chặn">
                                            <i class="fas fa-unlock"></i>
                                        </button>
                                    </form>
                                </c:if>
                                <c:if test="${!manager.blocked}">
                                    <form method="post" action="${pageContext.request.contextPath}/admin/users/block" style="display:inline">
                                        <input type="hidden" name="id" value="${manager.id}" />
                                        <button type="submit" class="btn-action btn-delete" title="Chặn">
                                            <i class="fas fa-ban"></i>
                                        </button>
                                    </form>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                <div id="userManagerNoResults" class="no-results" style="display: none;">
                    <i class="fas fa-search fa-2x mb-3"></i>
                    <p>Không tìm thấy quản lý người dùng nào phù hợp với tiêu chí tìm kiếm.</p>
                </div>
            </div>
        </div>
    </c:if>
</div>



// JavaScript tối giản - thay thế toàn bộ phần script cuối file JSP

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function normalizeText(text) {
        return text.toLowerCase()
            .normalize('NFD')
            .replace(/[\u0300-\u036f]/g, '')
            .trim();
    }

    function highlightText(element, searchTerm) {
        if (!searchTerm) {
            element.innerHTML = element.textContent;
            return;
        }

        const text = element.textContent;
        const normalizedText = normalizeText(text);
        const normalizedSearch = normalizeText(searchTerm);

        if (normalizedText.includes(normalizedSearch)) {
            // CÁCH 1: Sử dụng string thay vì regex literal
            const regexPattern = '[.*+?^$' + '{}' + '()|[\\]\\\\]';
            const escapedTerm = searchTerm.replace(new RegExp(regexPattern, 'g'), '\\$&');
            const regex = new RegExp('(' + escapedTerm + ')', 'gi');
            element.innerHTML = text.replace(regex, '<span class="highlight">$1</span>');
        } else {
            element.innerHTML = text;
        }
    }

    function filterUsers(sectionId, searchInputId, statusSelectId, countElementId, noResultsId) {
        const searchInput = document.getElementById(searchInputId);
        const statusSelect = document.getElementById(statusSelectId);
        const tableBody = document.getElementById(sectionId + 'TableBody');
        const countElement = document.getElementById(countElementId);
        const noResults = document.getElementById(noResultsId);

        if (!searchInput || !statusSelect || !tableBody || !countElement || !noResults) {
            return;
        }

        const searchTerm = searchInput.value.trim();
        const statusFilter = statusSelect.value;
        const rows = tableBody.querySelectorAll('.user-row');
        let visibleCount = 0;
        const totalCount = rows.length;

        rows.forEach(function(row) {
            const name = row.getAttribute('data-name') || '';
            const username = row.getAttribute('data-username') || '';
            const email = row.getAttribute('data-email') || '';
            const phone = row.getAttribute('data-phone') || '';
            const status = row.getAttribute('data-status') || '';

            const searchText = name + ' ' + username + ' ' + email + ' ' + phone;
            const normalizedSearchText = normalizeText(searchText);
            const normalizedSearchTerm = normalizeText(searchTerm);

            const matchesSearch = !searchTerm || normalizedSearchText.includes(normalizedSearchTerm);
            const matchesStatus = !statusFilter || status === statusFilter;
            const shouldShow = matchesSearch && matchesStatus;

            if (shouldShow) {
                row.classList.remove('hidden');
                visibleCount++;

                if (searchTerm) {
                    const nameElement = row.querySelector('.user-name');
                    const usernameElement = row.querySelector('.user-username');
                    const emailElement = row.querySelector('.user-email');
                    const phoneElement = row.querySelector('.user-phone');

                    if (nameElement) highlightText(nameElement, searchTerm);
                    if (usernameElement) highlightText(usernameElement, searchTerm);
                    if (emailElement) highlightText(emailElement, searchTerm);
                    if (phoneElement) highlightText(phoneElement, searchTerm);
                } else {
                    const textElements = row.querySelectorAll('.user-name, .user-username, .user-email, .user-phone');
                    textElements.forEach(function(el) {
                        el.innerHTML = el.textContent;
                    });
                }
            } else {
                row.classList.add('hidden');
            }
        });

        if (searchTerm || statusFilter) {
            countElement.textContent = 'Hiển thị ' + visibleCount + ' / ' + totalCount + ' kết quả';
        } else {
            countElement.textContent = 'Tổng cộng: ' + totalCount + ' người dùng';
        }

        if (visibleCount === 0 && (searchTerm || statusFilter)) {
            noResults.style.display = 'block';
            tableBody.parentElement.style.display = 'none';
        } else {
            noResults.style.display = 'none';
            tableBody.parentElement.style.display = 'block';
        }
    }

    function clearStudentFilters() {
        document.getElementById('studentSearch').value = '';
        document.getElementById('studentStatus').value = '';
        filterUsers('student', 'studentSearch', 'studentStatus', 'studentCount', 'studentNoResults');
    }

    function clearTeacherFilters() {
        document.getElementById('teacherSearch').value = '';
        document.getElementById('teacherStatus').value = '';
        filterUsers('teacher', 'teacherSearch', 'teacherStatus', 'teacherCount', 'teacherNoResults');
    }

    function clearCourseManagerFilters() {
        document.getElementById('courseManagerSearch').value = '';
        document.getElementById('courseManagerStatus').value = '';
        filterUsers('courseManager', 'courseManagerSearch', 'courseManagerStatus', 'courseManagerCount', 'courseManagerNoResults');
    }

    function clearUserManagerFilters() {
        document.getElementById('userManagerSearch').value = '';
        document.getElementById('userManagerStatus').value = '';
        filterUsers('userManager', 'userManagerSearch', 'userManagerStatus', 'userManagerCount', 'userManagerNoResults');
    }

    document.addEventListener('DOMContentLoaded', function() {
        // Students section
        const studentSearch = document.getElementById('studentSearch');
        const studentStatus = document.getElementById('studentStatus');

        if (studentSearch) {
            studentSearch.addEventListener('input', function() {
                filterUsers('student', 'studentSearch', 'studentStatus', 'studentCount', 'studentNoResults');
            });
        }

        if (studentStatus) {
            studentStatus.addEventListener('change', function() {
                filterUsers('student', 'studentSearch', 'studentStatus', 'studentCount', 'studentNoResults');
            });
        }

        // Teachers section
        const teacherSearch = document.getElementById('teacherSearch');
        const teacherStatus = document.getElementById('teacherStatus');

        if (teacherSearch) {
            teacherSearch.addEventListener('input', function() {
                filterUsers('teacher', 'teacherSearch', 'teacherStatus', 'teacherCount', 'teacherNoResults');
            });
        }

        if (teacherStatus) {
            teacherStatus.addEventListener('change', function() {
                filterUsers('teacher', 'teacherSearch', 'teacherStatus', 'teacherCount', 'teacherNoResults');
            });
        }

        // Course Managers section
        const courseManagerSearch = document.getElementById('courseManagerSearch');
        const courseManagerStatus = document.getElementById('courseManagerStatus');

        if (courseManagerSearch) {
            courseManagerSearch.addEventListener('input', function() {
                filterUsers('courseManager', 'courseManagerSearch', 'courseManagerStatus', 'courseManagerCount', 'courseManagerNoResults');
            });
        }

        if (courseManagerStatus) {
            courseManagerStatus.addEventListener('change', function() {
                filterUsers('courseManager', 'courseManagerSearch', 'courseManagerStatus', 'courseManagerCount', 'courseManagerNoResults');
            });
        }

        // User Managers section
        const userManagerSearch = document.getElementById('userManagerSearch');
        const userManagerStatus = document.getElementById('userManagerStatus');

        if (userManagerSearch) {
            userManagerSearch.addEventListener('input', function() {
                filterUsers('userManager', 'userManagerSearch', 'userManagerStatus', 'userManagerCount', 'userManagerNoResults');
            });
        }

        if (userManagerStatus) {
            userManagerStatus.addEventListener('change', function() {
                filterUsers('userManager', 'userManagerSearch', 'userManagerStatus', 'userManagerCount', 'userManagerNoResults');
            });
        }

        // Initialize counts on page load
        filterUsers('student', 'studentSearch', 'studentStatus', 'studentCount', 'studentNoResults');
        filterUsers('teacher', 'teacherSearch', 'teacherStatus', 'teacherCount', 'teacherNoResults');
        filterUsers('courseManager', 'courseManagerSearch', 'courseManagerStatus', 'courseManagerCount', 'courseManagerNoResults');

        const userManagerSearch2 = document.getElementById('userManagerSearch');
        if (userManagerSearch2) {
            filterUsers('userManager', 'userManagerSearch', 'userManagerStatus', 'userManagerCount', 'userManagerNoResults');
        }
    });
</script>
</body>
</html>