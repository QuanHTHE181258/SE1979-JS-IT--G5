<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ include file="/WEB-INF/layout/header.jsp" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Quản Lý Khóa Học</title>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">

  <style>
    :root {
      --primary: #2563eb;
      --primary-light: #3b82f6;
      --success: #10b981;
      --warning: #f59e0b;
      --danger: #ef4444;
      --gray-50: #f9fafb;
      --gray-100: #f3f4f6;
      --gray-200: #e5e7eb;
      --gray-300: #d1d5db;
      --gray-400: #9ca3af;
      --gray-500: #6b7280;
      --gray-600: #4b5563;
      --gray-700: #374151;
      --gray-800: #1f2937;
      --gray-900: #111827;
      --shadow-sm: 0 1px 2px 0 rgb(0 0 0 / 0.05);
      --shadow: 0 1px 3px 0 rgb(0 0 0 / 0.1), 0 1px 2px -1px rgb(0 0 0 / 0.1);
      --shadow-md: 0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1);
      --border-radius: 8px;
      --transition: all 0.15s ease;
    }

    * {
      font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
    }

    body {
      background-color: var(--gray-50);
      color: var(--gray-900);
      line-height: 1.6;
    }

    .main-container {
      padding: 24px;
    }

    /* Header */
    .page-header {
      background: white;
      border-radius: var(--border-radius);
      box-shadow: var(--shadow-sm);
      padding: 32px;
      margin-bottom: 24px;
      border: 1px solid var(--gray-200);
    }

    .page-header h2 {
      font-weight: 600;
      font-size: 28px;
      color: var(--gray-900);
      margin: 0;
    }

    .btn {
      font-weight: 500;
      border-radius: var(--border-radius);
      transition: var(--transition);
      border: none;
      font-size: 14px;
      padding: 10px 16px;
    }

    .btn-primary {
      background-color: var(--primary);
      color: white;
    }

    .btn-primary:hover {
      background-color: var(--primary-light);
      transform: translateY(-1px);
      box-shadow: var(--shadow);
    }

    .btn-outline-secondary {
      background-color: transparent;
      border: 1px solid var(--gray-300);
      color: var(--gray-700);
    }

    .btn-outline-secondary:hover {
      background-color: var(--gray-100);
      border-color: var(--gray-400);
    }

    /* Search Section */
    .search-section {
      background: white;
      border-radius: var(--border-radius);
      box-shadow: var(--shadow-sm);
      padding: 24px;
      margin-bottom: 24px;
      border: 1px solid var(--gray-200);
    }

    .form-control,
    .form-select {
      border: 1px solid var(--gray-300);
      border-radius: var(--border-radius);
      padding: 12px 16px;
      background: white;
      transition: var(--transition);
      font-size: 14px;
    }

    .form-control:focus,
    .form-select:focus {
      border-color: var(--primary);
      box-shadow: 0 0 0 3px rgb(37 99 235 / 0.1);
      outline: none;
    }

    /* Table */
    .table-container {
      background: white;
      border-radius: var(--border-radius);
      box-shadow: var(--shadow-sm);
      overflow: hidden;
      border: 1px solid var(--gray-200);
    }

    .table {
      margin: 0;
    }

    .table thead th {
      background-color: var(--gray-50);
      color: var(--gray-700);
      font-weight: 600;
      font-size: 12px;
      text-transform: uppercase;
      letter-spacing: 0.5px;
      padding: 16px;
      border-bottom: 1px solid var(--gray-200);
      border-top: none;
    }

    .table tbody tr {
      border-bottom: 1px solid var(--gray-100);
      transition: var(--transition);
    }

    .table tbody tr:hover {
      background-color: var(--gray-50);
    }

    .table tbody td {
      padding: 16px;
      vertical-align: middle;
      color: var(--gray-800);
      border-top: none;
    }

    /* Course Elements */
    .course-image {
      width: 56px;
      height: 40px;
      object-fit: cover;
      border-radius: 6px;
      border: 1px solid var(--gray-200);
    }

    .course-title {
      font-weight: 600;
      color: var(--gray-900);
      font-size: 14px;
    }

    .course-description {
      color: var(--gray-500);
      font-size: 13px;
      margin-top: 4px;
      line-height: 1.4;
    }

    /* Badges */
    .badge {
      padding: 4px 10px;
      border-radius: 20px;
      font-size: 11px;
      font-weight: 500;
      text-transform: uppercase;
      letter-spacing: 0.3px;
    }

    .badge-success {
      background-color: var(--success);
      color: white;
    }

    .badge-warning {
      background-color: var(--warning);
      color: white;
    }

    .badge-secondary {
      background-color: var(--gray-400);
      color: white;
    }

    .badge-gray {
      background-color: var(--gray-100);
      color: var(--gray-700);
      border: 1px solid var(--gray-200);
    }

    /* Status Section */
    .status-section {
      display: flex;
      flex-direction: column;
      gap: 8px;
    }

    .status-section .btn {
      font-size: 12px;
      padding: 6px 12px;
    }

    /* Price */
    .price-display {
      font-weight: 600;
      color: var(--success);
      font-size: 14px;
    }

    /* Stats - Remove unused styles */
    .stats-section,
    .stat-item,
    .stat-label,
    .stat-value {
      /* Removed - no longer needed */
    }

    /* Action Buttons */
    .action-buttons {
      display: flex;
      flex-direction: column;
      gap: 6px;
    }

    .action-buttons .btn {
      font-size: 12px;
      padding: 6px 12px;
    }

    /* Instructor */
    .instructor-name {
      font-weight: 500;
      color: var(--gray-700);
      font-size: 13px;
    }

    /* Pagination */
    .pagination .page-link {
      border: 1px solid var(--gray-300);
      color: var(--gray-600);
      font-weight: 500;
      border-radius: var(--border-radius);
      margin: 0 2px;
      transition: var(--transition);
      padding: 8px 12px;
    }

    .pagination .page-item.active .page-link {
      background-color: var(--primary);
      border-color: var(--primary);
      color: white;
    }

    .pagination .page-link:hover {
      background-color: var(--gray-100);
      border-color: var(--gray-400);
      color: var(--gray-700);
    }

    /* Alerts */
    .alert {
      border: none;
      border-radius: var(--border-radius);
      box-shadow: var(--shadow-sm);
      border-left: 4px solid;
      font-size: 14px;
    }

    .alert-success {
      background-color: rgb(16 185 129 / 0.1);
      border-left-color: var(--success);
      color: var(--success);
    }

    .alert-danger {
      background-color: rgb(239 68 68 / 0.1);
      border-left-color: var(--danger);
      color: var(--danger);
    }

    /* Empty State */
    .empty-state {
      padding: 48px 24px;
      text-align: center;
      color: var(--gray-500);
    }

    .empty-state i {
      font-size: 48px;
      color: var(--gray-300);
      margin-bottom: 16px;
    }

    .empty-state h5 {
      color: var(--gray-600);
      font-weight: 500;
      margin-bottom: 8px;
    }

    /* Results Info */
    .results-info {
      color: var(--gray-600);
      font-size: 14px;
      font-weight: 500;
    }

    /* Responsive */
    @media (max-width: 768px) {
      .main-container {
        padding: 12px;
      }

      .page-header {
        padding: 20px;
      }

      .search-section {
        padding: 16px;
      }

      .table tbody td {
        padding: 12px 8px;
        font-size: 13px;
      }

      .course-image {
        width: 48px;
        height: 32px;
      }

      .action-buttons {
        flex-direction: row;
        flex-wrap: wrap;
      }
    }

    /* Loading Animation */
    @keyframes fadeIn {
      from {
        opacity: 0;
        transform: translateY(10px);
      }
      to {
        opacity: 1;
        transform: translateY(0);
      }
    }

    .fade-in {
      animation: fadeIn 0.3s ease-out;
    }
  </style>
</head>
<body>
<div class="main-container fade-in">
  <!-- Page Header -->
  <div class="page-header">
    <div class="d-flex justify-content-between align-items-center flex-wrap gap-3">
      <div class="d-flex align-items-center gap-3">
        <i class="fas fa-graduation-cap text-primary fs-4"></i>
        <h2>Quản Lý Khóa Học</h2>
      </div>
      <div class="d-flex gap-2">
        <a href="create-course" class="btn btn-primary">
          <i class="fas fa-plus me-2"></i>Tạo Khóa Học
        </a>
      </div>
    </div>
  </div>

  <!-- Success Message -->
  <c:if test="${not empty successMessage}">
    <div class="alert alert-success alert-dismissible fade show" role="alert">
      <i class="fas fa-check-circle me-2"></i>
      <c:out value="${successMessage}" escapeXml="true"/>
      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
  </c:if>

  <!-- Error Message -->
  <c:if test="${not empty errorMessage}">
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
      <i class="fas fa-exclamation-circle me-2"></i>
      <c:out value="${errorMessage}" escapeXml="true"/>
      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
  </c:if>

  <!-- Search and Filter -->
  <div class="search-section">
    <div class="row g-3">
      <div class="col-md-8">
        <div class="position-relative">
          <i class="fas fa-search position-absolute" style="left: 16px; top: 50%; transform: translateY(-50%); color: var(--gray-400);"></i>
          <input type="text" id="searchInput" class="form-control ps-5"
                 placeholder="Tìm kiếm khóa học..." onkeyup="filterAndPaginate()">
        </div>
      </div>
      <div class="col-md-4">
        <select id="categoryFilter" class="form-select" onchange="filterAndPaginate()">
          <option value="">Tất Cả Danh Mục</option>
          <c:if test="${not empty categories}">
            <c:forEach var="category" items="${categories}">
              <option value="${fn:escapeXml(category.name)}">
                <c:out value="${category.name}" escapeXml="true"/>
              </option>
            </c:forEach>
          </c:if>
          <option value="Uncategorized">Chưa Phân Loại</option>
        </select>
      </div>
    </div>

    <!-- Results Info -->
    <div class="mt-3">
        <span id="resultsInfo" class="results-info">
          <i class="fas fa-info-circle me-1"></i>Hiển thị tất cả khóa học
        </span>
    </div>
  </div>

  <!-- Course Table -->
  <div class="table-container">
    <div class="table-responsive">
      <table id="courseTable" class="table">
        <thead>
        <tr>
          <th style="width: 60px;">STT</th>
          <th style="width: 80px;">Hình Ảnh</th>
          <th>Tiêu Đề</th>
          <th style="width: 120px;">Danh Mục</th>
          <th style="width: 140px;">Trạng Thái</th>
          <th style="width: 100px;">Giá</th>
          <th style="width: 100px;">Đánh Giá TB</th>
          <th style="width: 100px;">Số Người Học</th>
          <th style="width: 120px;">Thao Tác</th>
          <th style="width: 140px;">Giảng Viên</th>
        </tr>
        </thead>
        <tbody>
        <c:choose>
          <c:when test="${not empty courses}">
            <c:forEach var="course" items="${courses}" varStatus="status">
              <tr>
                <td>
                  <span class="text-muted fw-medium">${status.index + 1}</span>
                </td>
                <td>
                  <img src="${pageContext.request.contextPath}/${course.imageURL}"
                       alt="Course image" class="course-image">
                </td>
                <td>
                  <div class="course-title"><c:out value="${course.title}" escapeXml="true"/></div>
                  <div class="course-description">
                    <c:choose>
                      <c:when test="${fn:length(course.description) > 60}">
                        <c:out value="${fn:substring(course.description, 0, 60)}..." escapeXml="true"/>
                      </c:when>
                      <c:otherwise>
                        <c:out value="${course.description}" escapeXml="true"/>
                      </c:otherwise>
                    </c:choose>
                  </div>
                </td>
                <td>
                  <c:choose>
                    <c:when test="${empty course.categoryName}">
                      <span class="badge badge-secondary">Chưa Phân Loại</span>
                    </c:when>
                    <c:otherwise>
                          <span class="badge badge-gray">
                            <c:out value="${course.categoryName}" escapeXml="true"/>
                          </span>
                    </c:otherwise>
                  </c:choose>
                </td>
                <td>
                  <div class="status-section">
                    <!-- Status Display -->
                    <span class="badge text-dark">
                          <c:choose>
                            <c:when test="${course.status == 'active'}">
                              <i class="fas fa-check me-1"></i>Hoạt Động
                            </c:when>
                            <c:when test="${course.status == 'draft'}">
                              <i class="fas fa-edit me-1"></i>Nháp
                            </c:when>
                            <c:otherwise>
                              Không xác định
                            </c:otherwise>
                          </c:choose>
                        </span>

                    <!-- Change Status Form -->
                    <form method="post" action="change-status" style="display: inline;">
                      <input type="hidden" name="courseId" value="${course.id}">
                      <c:choose>
                        <c:when test="${course.status == 'active'}">
                          <input type="hidden" name="status" value="draft">
                          <button type="submit" class="btn btn-outline-danger btn-sm">
                            <i class="fas fa-pause me-1"></i>Tạm Dừng
                          </button>
                        </c:when>
                        <c:when test="${course.status == 'draft'}">
                          <input type="hidden" name="status" value="active">
                          <button type="submit" class="btn btn-outline-primary btn-sm">
                            <i class="fas fa-play me-1"></i>Kích Hoạt
                          </button>
                        </c:when>
                        <c:otherwise>
                          <input type="hidden" name="status" value="active">
                          <button type="submit" class="btn btn-outline-secondary btn-sm">
                            <i class="fas fa-sync me-1"></i>Cập Nhật
                          </button>
                        </c:otherwise>
                      </c:choose>
                    </form>
                  </div>
                </td>
                <td>
                  <span class="price-display"><c:out value="${course.price}"/> VNĐ</span>
                </td>
                <td>
                  <div class="text-center">
                        <span class="fw-semibold">
                          <c:out value="${course.rating != null ? course.rating : '0.0'}"/>/5.0
                        </span>
                  </div>
                </td>
                <td>
                  <div class="text-center">
                        <span class="fw-semibold">
                          <c:out value="${course.enrollmentCount != null ? course.enrollmentCount : '0'}"/> người
                        </span>
                  </div>
                </td>
                <td>
                  <div class="action-buttons">
                    <a href="update-course?id=${course.id}" class="btn btn-outline-secondary btn-sm">
                      <i class="fas fa-edit me-1"></i>Sửa
                    </a>
                    <a href="course-lessons?id=${course.id}" class="btn btn-outline-primary btn-sm">
                      <i class="fas fa-book-open me-1"></i>Bài học
                    </a>
                  </div>
                </td>
                <td>
                  <div class="instructor-name">
                    <c:out value="${course.instructorFirstName}"/> <c:out value="${course.instructorLastName}"/>
                  </div>
                </td>
              </tr>
            </c:forEach>
          </c:when>
          <c:otherwise>
            <tr>
              <td colspan="9" class="text-center">
                <div class="empty-state">
                  <i class="fas fa-graduation-cap"></i>
                  <h5>Không có khóa học nào</h5>
                  <p class="mb-0">Bắt đầu bằng cách tạo khóa học đầu tiên</p>
                </div>
              </td>
            </tr>
          </c:otherwise>
        </c:choose>
        </tbody>
      </table>

      <!-- No Results Message -->
      <div id="noResults" class="empty-state" style="display: none;">
        <i class="fas fa-search"></i>
        <h5>Không tìm thấy khóa học nào</h5>
        <p class="mb-0">Thử điều chỉnh từ khóa tìm kiếm</p>
      </div>
    </div>
  </div>

  <!-- Pagination -->
  <nav class="mt-4">
    <ul class="pagination justify-content-center" id="pagination"></ul>
  </nav>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
  // Course management class
  class CourseManager {
    constructor() {
      this.rowsPerPage = 10;
      this.currentPage = 1;
      this.allRows = [];
      this.filteredRows = [];
      this.init();
    }

    init() {
      const table = document.getElementById("courseTable");
      if (table && table.querySelector("tbody")) {
        this.allRows = Array.from(table.querySelectorAll("tbody tr"));
        this.filteredRows = [...this.allRows];
        this.displayPage();
        this.setupPagination();
        this.updateResultsInfo();
      }
    }

    filterRows() {
      const searchInput = document.getElementById("searchInput");
      const categoryFilter = document.getElementById("categoryFilter");

      if (!searchInput || !categoryFilter) return;

      const titleFilter = searchInput.value.toLowerCase().trim();
      const categoryFilterValue = categoryFilter.value;

      this.filteredRows = this.allRows.filter(row => {
        if (!row.cells || row.cells.length < 3) return false;

        const titleCell = row.querySelector(".course-title");
        if (!titleCell) return false;
        const titleText = (titleCell.textContent || titleCell.innerText).toLowerCase();
        const titleMatch = titleFilter == '' || titleText.includes(titleFilter);

        const categoryCell = row.cells[3];
        if (!categoryCell) return false;
        const categoryText = categoryCell.textContent.trim();
        const categoryMatch = categoryFilterValue == "" ||
                categoryText.includes(categoryFilterValue) ||
                (categoryFilterValue == "Uncategorized" && categoryText.includes("Uncategorized"));

        return titleMatch && categoryMatch;
      });

      this.currentPage = 1;
    }

    displayPage() {
      const start = (this.currentPage - 1) * this.rowsPerPage;
      const end = start + this.rowsPerPage;

      this.allRows.forEach(row => row.style.display = 'none');

      const rowsToShow = this.filteredRows.slice(start, end);
      rowsToShow.forEach(row => row.style.display = '');

      const noResults = document.getElementById('noResults');
      const tableBody = document.querySelector('#courseTable tbody');

      if (this.filteredRows.length == 0 && this.allRows.length > 0) {
        noResults.style.display = 'block';
        tableBody.style.display = 'none';
      } else {
        noResults.style.display = 'none';
        tableBody.style.display = '';
      }
    }

    setupPagination() {
      const pagination = document.getElementById("pagination");
      if (!pagination) return;

      const totalPages = Math.ceil(this.filteredRows.length / this.rowsPerPage);
      pagination.innerHTML = "";

      if (totalPages <= 1) return;

      // Previous
      if (this.currentPage > 1) {
        const prevLi = document.createElement("li");
        prevLi.className = "page-item";
        const prevLink = document.createElement("a");
        prevLink.className = "page-link";
        prevLink.href = "#";
        prevLink.innerHTML = '<i class="fas fa-chevron-left"></i>';
        prevLink.onclick = (e) => {
          e.preventDefault();
          this.goToPage(this.currentPage - 1);
        };
        prevLi.appendChild(prevLink);
        pagination.appendChild(prevLi);
      }

      // Pages
      const startPage = Math.max(1, this.currentPage - 2);
      const endPage = Math.min(totalPages, this.currentPage + 2);

      for (let i = startPage; i <= endPage; i++) {
        const li = document.createElement("li");
        li.className = "page-item";
        if (i == this.currentPage) {
          li.classList.add("active");
        }
        const link = document.createElement("a");
        link.className = "page-link";
        link.href = "#";
        link.textContent = i;
        link.onclick = (e) => {
          e.preventDefault();
          this.goToPage(i);
        };
        li.appendChild(link);
        pagination.appendChild(li);
      }

      // Next
      if (this.currentPage < totalPages) {
        const nextLi = document.createElement("li");
        nextLi.className = "page-item";
        const nextLink = document.createElement("a");
        nextLink.className = "page-link";
        nextLink.href = "#";
        nextLink.innerHTML = '<i class="fas fa-chevron-right"></i>';
        nextLink.onclick = (e) => {
          e.preventDefault();
          this.goToPage(this.currentPage + 1);
        };
        nextLi.appendChild(nextLink);
        pagination.appendChild(nextLi);
      }
    }

    goToPage(page) {
      this.currentPage = page;
      this.displayPage();
      this.setupPagination();
      this.updateResultsInfo();
    }

    updateResultsInfo() {
      const resultsInfo = document.getElementById('resultsInfo');
      if (!resultsInfo) return;

      const totalCourses = this.allRows.length;
      const filteredCount = this.filteredRows.length;
      const start = (this.currentPage - 1) * this.rowsPerPage + 1;
      const end = Math.min(start + this.rowsPerPage - 1, filteredCount);

      if (filteredCount == 0) {
        resultsInfo.innerHTML = '<i class="fas fa-info-circle me-1"></i>Không tìm thấy khóa học nào';
      } else {
        resultsInfo.innerHTML = `<i class="fas fa-info-circle me-1"></i>Hiển thị ${start}-${end} của ${filteredCount} khóa học`;
      }
    }

    filterAndPaginate() {
      this.filterRows();
      this.displayPage();
      this.setupPagination();
      this.updateResultsInfo();
    }
  }

  // Initialize
  let courseManager;
  document.addEventListener('DOMContentLoaded', function() {
    courseManager = new CourseManager();

    // Auto-hide alerts after 5 seconds
    const alerts = document.querySelectorAll('.alert');
    alerts.forEach(alert => {
      setTimeout(() => {
        if (alert.parentNode) {
          alert.classList.remove('show');
          setTimeout(() => {
            if (alert.parentNode) {
              alert.remove();
            }
          }, 150);
        }
      }, 5000);
    });
  });

  function filterAndPaginate() {
    if (courseManager) {
      courseManager.filterAndPaginate();
    }
  }

  // Smooth scrolling
  document.addEventListener('DOMContentLoaded', function() {
    document.documentElement.style.scrollBehavior = 'smooth';
  });
</script>

</body>
</html>