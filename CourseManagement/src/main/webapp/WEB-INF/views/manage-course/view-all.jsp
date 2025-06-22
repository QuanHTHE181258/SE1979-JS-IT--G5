<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Course Management</title>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">

  <style>
    :root {
      --primary-color: rgba(13, 181, 253, 0.94);
      --primary-dark: #0bc6d7;
      --secondary-color: rgba(10, 186, 202, 0.24);
      --success-color: #48bb78;
      --warning-color: #ed8936;
      --danger-color: #f56565;
      --info-color: #4299e1;
      --light-bg: #f8fafc;
      --card-shadow: 0 10px 25px rgba(0, 0, 0, 0.05);
      --card-shadow-hover: 0 20px 40px rgba(0, 0, 0, 0.1);
      --border-radius: 12px;
      --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    }

    * {
      font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
    }

    body {
      /*background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);*/
      min-height: 100vh;
      padding: 20px 0;
    }

    .main-container {
      background: rgba(255, 255, 255, 0.95);
      backdrop-filter: blur(20px);
      border-radius: var(--border-radius);
      box-shadow: var(--card-shadow);
      padding: 2rem;
      width: 100%;
      margin: 0;
      transition: var(--transition);
    }

    .page-header {
      background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
      color: white;
      padding: 2rem;
      border-radius: var(--border-radius);
      margin-bottom: 2rem;
      position: relative;
      overflow: hidden;
    }

    .page-header::before {
      content: '';
      position: absolute;
      top: 0;
      right: 0;
      width: 200px;
      height: 200px;
      background: rgba(255, 255, 255, 0.1);
      border-radius: 50%;
      transform: translate(50px, -50px);
    }

    .page-header h1 {
      font-weight: 700;
      font-size: 2.5rem;
      margin: 0;
      position: relative;
      z-index: 2;
    }

    .page-header .subtitle {
      opacity: 0.9;
      font-size: 1.1rem;
      margin-top: 0.5rem;
      position: relative;
      z-index: 2;
    }

    .create-btn {
      background: linear-gradient(135deg, var(--success-color) 0%, #38a169 100%);
      border: none;
      border-radius: 50px;
      padding: 12px 24px;
      font-weight: 600;
      transition: var(--transition);
      box-shadow: 0 4px 15px rgba(72, 187, 120, 0.3);
      position: relative;
      z-index: 2;
    }

    .create-btn:hover {
      transform: translateY(-2px);
      box-shadow: 0 8px 25px rgba(72, 187, 120, 0.4);
      background: linear-gradient(135deg, #38a169 0%, #2f855a 100%);
    }

    .fade-in {
      animation: fadeIn 0.5s ease-in-out;
    }

    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(20px); }
      to { opacity: 1; transform: translateY(0); }
    }

    .custom-table {
      border-collapse: separate;
      border-spacing: 0;
      border-radius: 12px;
      overflow: hidden;
    }

    .custom-table thead {
      background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
      color: white;
      font-weight: bold;
      border: none;
    }

    .custom-table th,
    .custom-table td {
      vertical-align: middle;
      padding: 0.85rem 1rem;
      border: none;
    }

    .custom-table tbody tr {
      background-color: #f9f9fc;
      transition: all 0.2s ease-in-out;
    }

    .custom-table tbody tr:hover {
      background-color: #eef2ff;
      transform: scale(1.01);
      box-shadow: 0 5px 15px rgba(0,0,0,0.08);
      z-index: 10;
    }

    .custom-table .badge {
      font-size: 0.95rem;
      padding: 0.5em 0.75em;
    }

    .category-item {
      padding: 8px 15px;
      border-radius: 30px;
      font-weight: 600;
      transition: all 0.2s;
      box-shadow: 0 3px 10px rgba(0,0,0,0.1);
      background: linear-gradient(135deg, var(--primary-color), var(--secondary-color)) !important;
    }

    .category-item:hover {
      transform: translateY(-2px);
      box-shadow: 0 5px 15px rgba(0,0,0,0.15);
    }

    #categoryFilter, #searchInput {
      border-radius: 50px;
      padding-left: 1.5rem;
      font-size: 1rem;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
      transition: all 0.3s;
      border: none;
      background-color: white;
    }

    #categoryFilter:focus, #searchInput:focus {
      box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
      transform: translateY(-1px);
    }

    #searchInput::placeholder {
      color: #aaa;
    }

    .btn-sm {
      transition: all 0.2s;
      margin: 0 2px;
    }

    .btn-sm:hover {
      transform: translateY(-2px);
      box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
    }

    .pagination .page-link {
      border-radius: 50%;
      margin: 0 2px;
      border: none;
      color: var(--primary-color);
      transition: all 0.3s;
    }

    .pagination .page-item.active .page-link {
      background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
      border: none;
    }

    .pagination .page-link:hover {
      background: var(--primary-color);
      color: white;
      transform: translateY(-2px);
    }

    .results-info {
      color: #6c757d;
      font-size: 0.9rem;
      margin-bottom: 1rem;
    }

    .no-results {
      text-align: center;
      padding: 3rem;
      color: #6c757d;
    }

    .no-results i {
      font-size: 3rem;
      margin-bottom: 1rem;
      opacity: 0.5;
    }

    @media (max-width: 768px) {
      .main-container {
        margin: 0 1rem;
        padding: 1rem;
      }

      .page-header {
        padding: 1.5rem;
      }

      .page-header h1 {
        font-size: 2rem;
      }

      .d-flex.gap-3 {
        flex-direction: column;
        gap: 1rem !important;
      }

      .pagination {
        justify-content: center;
        flex-wrap: wrap;
      }
    }
  </style>
</head>
<body>
<div >
  <div class="main-container fade-in">
    <!-- Page Header -->
    <div class="page-header">
      <div class="d-flex justify-content-between align-items-center">
        <div>
          <h1><i class="fas fa-graduation-cap me-3"></i>Course Management</h1>
          <p class="subtitle mb-0">Manage and organize your educational content</p>
        </div>
        <div class="d-flex gap-3">
          <button class="btn create-btn" onclick="location.href='create-course'">
            <i class="fas fa-plus me-2"></i>Create New Course
          </button>
          <button class="btn btn-outline-light" onclick="location.href='manage-categories'">
            <i class="fas fa-tags me-2"></i>Manage Categories
          </button>
        </div>
      </div>
    </div>

    <!-- Error Message -->
    <c:if test="${not empty errorMessage}">
      <div class="alert alert-danger fade-in" role="alert">
        <i class="fas fa-exclamation-triangle me-2"></i>
        <c:out value="${errorMessage}" escapeXml="true"/>
      </div>
    </c:if>

    <!-- Search and Filter Box -->
    <div class="row mb-4">
      <div class="col-md-8">
        <div class="input-group">
          <span class="input-group-text bg-transparent border-0">
            <i class="fas fa-search text-muted fs-5"></i>
          </span>
          <input type="text" id="searchInput" class="form-control form-control-lg shadow-sm"
                 placeholder="Search courses by title..." onkeyup="filterAndPaginate()">
        </div>
      </div>
      <div class="col-md-4">
        <select id="categoryFilter" class="form-select form-select-lg shadow-sm" onchange="filterAndPaginate()">
          <option value="">All Categories</option>
          <c:if test="${not empty categories}">
            <c:forEach var="category" items="${categories}">
              <option value="${fn:escapeXml(category.name)}">
                <c:out value="${category.name}" escapeXml="true"/>
              </option>
            </c:forEach>
          </c:if>
          <option value="Uncategorized">Uncategorized</option>
        </select>
      </div>
    </div>

    <!-- Results Info -->
    <div class="results-info">
      <i class="fas fa-info-circle me-2"></i>
      <span id="resultsInfo">Showing all courses</span>
    </div>

    <!-- Course Table -->
    <div class="table-responsive fade-in">
      <table id="courseTable" class="table custom-table shadow-sm rounded bg-white">
        <thead class="table-header text-center">
        <tr>
          <th>No.</th>
          <th>Image</th>
          <th>Title</th>
          <th>Category</th>
          <th>Price</th>
          <th>Statistics</th>
          <th>Actions</th>
          <th>Instructor</th>
        </tr>
        </thead>
        <tbody>
        <c:choose>
          <c:when test="${not empty courses}">
            <c:forEach var="course" items="${courses}" varStatus="status">
              <tr class="text-center align-middle">
                <td>${status.index + 1}</td>
                <td>
                  <img src="${pageContext.request.contextPath}/${course.imageURL}" alt="Course image" style="max-width: 80px; max-height: 60px; border-radius: 8px; object-fit: cover; box-shadow: 0 2px 8px rgba(0,0,0,0.07);">
                </td>
                <td class="text-start fw-semibold text-primary course-title">
                  <div><c:out value="${course.title}" escapeXml="true"/></div>
                  <small class="text-muted">
                    <c:choose>
                      <c:when test="${fn:length(course.description) > 50}">
                        <c:out value="${fn:substring(course.description, 0, 50)}..." escapeXml="true"/>
                      </c:when>
                      <c:otherwise>
                        <c:out value="${course.description}" escapeXml="true"/>
                      </c:otherwise>
                    </c:choose>
                  </small>
                </td>
                <td>
                  <c:choose>
                    <c:when test="${empty course.categoryName}">
                      <span class="badge" style="background: linear-gradient(135deg, #718096 0%, #4A5568 100%);">
                        <i class="fas fa-folder me-1"></i> Uncategorized
                      </span>
                    </c:when>
                    <c:otherwise>
                      <span class="badge category-item" style="background: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);">
                        <i class="fas fa-tag me-1"></i> <c:out value="${course.categoryName}" escapeXml="true"/>
                      </span>
                    </c:otherwise>
                  </c:choose>
                </td>
                <td><span class="badge bg-success"><c:out value="${course.price}"/>$</span></td>
                <td>
                  <div class="d-flex flex-wrap justify-content-center gap-2">
                    <span class="badge rounded-pill bg-light text-dark" title="Rating">
                      <i class="fas fa-star text-warning me-1"></i>
                      <c:out value="${course.rating != null ? course.rating : '0'}"/>
                    </span>
                    <span class="badge rounded-pill bg-light text-dark" title="Feedback count">
                      <i class="fas fa-comments text-info me-1"></i>
                      <c:out value="${course.feedbackCount != null ? course.feedbackCount : '0'}"/>
                    </span>
                    <span class="badge rounded-pill bg-light text-dark" title="Materials">
                      <i class="fas fa-book text-success me-1"></i>
                      <c:out value="${course.materialCount != null ? course.materialCount : '0'}"/>
                    </span>
                    <span class="badge rounded-pill bg-light text-dark" title="Quizzes">
                      <i class="fas fa-question-circle text-primary me-1"></i>
                      <c:out value="${course.quizCount != null ? course.quizCount : '0'}"/>
                    </span>
                    <span class="badge rounded-pill bg-light text-dark" title="Enrolled students">
                      <i class="fas fa-users text-secondary me-1"></i>
                      <c:out value="${course.enrollmentCount != null ? course.enrollmentCount : '0'}"/>
                    </span>
                  </div>
                </td>
                <td>
                  <div class="d-flex flex-column align-items-center gap-2 flex-wrap">
                    <a href="course?id=${course.id}" class="btn btn-outline-info btn-sm w-100" title="View details">
                      <i class="fas fa-eye"></i> View
                    </a>
                    <a href="course-feedback?id=${course.id}" class="btn btn-outline-warning btn-sm w-100" title="View feedback">
                      <i class="fas fa-comments"></i> Feedback
                    </a>
                    <a href="update-course?id=${course.id}" class="btn btn-outline-secondary btn-sm w-100" title="Edit course">
                      <i class="fas fa-edit"></i> Edit
                    </a>
                    <a href="course-lessons?id=${course.id}" class="btn btn-outline-primary btn-sm w-100" title="Manage lessons">
                      <i class="fas fa-list-ul"></i> Lessons
                    </a>
                  </div>
                </td>
                <td>
                  <c:out value="${course.instructorFirstName}"/> <c:out value="${course.instructorLastName}"/>
                </td>
              </tr>
            </c:forEach>
          </c:when>
          <c:otherwise>
            <tr>
              <td colspan="8" class="text-center py-4">
                <div class="no-results">
                  <i class="fas fa-graduation-cap"></i>
                  <h5>No courses available</h5>
                  <p>Start by creating your first course</p>
                </div>
              </td>
            </tr>
          </c:otherwise>
        </c:choose>
        </tbody>
      </table>

      <!-- No Results Message (for filtered results) -->
      <div id="noResults" class="no-results" style="display: none;">
        <i class="fas fa-search"></i>
        <h5>No courses found</h5>
        <p>Try adjusting your search criteria or filters</p>
      </div>
    </div>

    <!-- Pagination -->
    <nav class="mt-4">
      <ul class="pagination justify-content-center" id="pagination"></ul>
    </nav>
  </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>

<script>
  class CourseManager {
    constructor() {
      this.rowsPerPage = 5;
      this.currentPage = 1;
      this.allRows = [];
      this.filteredRows = [];

      this.init();
    }

    init() {
      // Get all table rows
      const table = document.getElementById("courseTable");
      if (table && table.querySelector("tbody")) {
        this.allRows = Array.from(table.querySelectorAll("tbody tr"));
        this.filteredRows = [...this.allRows];

        // Initialize tooltips
        this.initTooltips();

        // Initial display
        this.displayPage();
        this.setupPagination();
        this.updateResultsInfo();
      }
    }

    initTooltips() {
      const tooltipTriggerList = [].slice.call(document.querySelectorAll('[title]'));
      tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl, {
          placement: 'top',
          trigger: 'hover'
        });
      });
    }

    filterRows() {
      const searchInput = document.getElementById("searchInput");
      const categoryFilter = document.getElementById("categoryFilter");

      if (!searchInput || !categoryFilter) return;

      const titleFilter = searchInput.value.toLowerCase().trim();
      const categoryFilterValue = categoryFilter.value;

      // Filter rows based on title and category
      this.filteredRows = this.allRows.filter(row => {
        // Skip if row is invalid or is an empty state row
        if (!row.cells || row.cells.length < 3) return false;

        // --- Title filter ---
        const titleCell = row.querySelector(".course-title");
        if (!titleCell) return false;
        const titleText = (titleCell.textContent || titleCell.innerText).toLowerCase();
        const titleMatch = titleFilter === '' || titleText.includes(titleFilter);

        // --- Category filter ---
        const categoryCell = row.cells[2];
        if (!categoryCell) return false;
        const categoryText = categoryCell.textContent.trim();
        const categoryMatch =
          categoryFilterValue === "" ||
          categoryText.includes(categoryFilterValue) ||
          (categoryFilterValue === "Uncategorized" && categoryText.includes("Uncategorized"));

        // Only include rows that match both filters
        return titleMatch && categoryMatch;
      });

      // Reset to first page after filtering
      this.currentPage = 1;
    }

    displayPage() {
      const start = (this.currentPage - 1) * this.rowsPerPage;
      const end = start + this.rowsPerPage;

      // Hide all rows first
      this.allRows.forEach(row => {
        row.style.display = 'none';
      });

      // Show filtered rows for current page
      const rowsToShow = this.filteredRows.slice(start, end);
      rowsToShow.forEach(row => {
        row.style.display = '';
      });

      // Show/hide no results message
      const noResults = document.getElementById('noResults');
      const tableBody = document.querySelector('#courseTable tbody');

      if (noResults && tableBody) {
        if (this.filteredRows.length === 0 && this.allRows.length > 0) {
          noResults.style.display = 'block';
          tableBody.style.display = 'none';
        } else {
          noResults.style.display = 'none';
          tableBody.style.display = '';
        }
      }
    }

    setupPagination() {
      const pagination = document.getElementById("pagination");
      if (!pagination) return;

      const totalPages = Math.ceil(this.filteredRows.length / this.rowsPerPage);

      pagination.innerHTML = "";

      if (totalPages <= 1) return;

      // Previous button
      const prevLi = document.createElement("li");
      prevLi.className = "page-item" + (this.currentPage == 1 ? ' disabled' : '');
      const prevLink = document.createElement("a");
      prevLink.className = "page-link";
      prevLink.href = "#";
      prevLink.innerHTML = '<i class="fas fa-chevron-left"></i>';
      prevLink.onclick = (e) => {
        e.preventDefault();
        if (this.currentPage > 1) {
          this.currentPage--;
          this.displayPage();
          this.setupPagination();
          this.updateResultsInfo();
        }
      };
      prevLi.appendChild(prevLink);
      pagination.appendChild(prevLi);

      // Page numbers
      const startPage = Math.max(1, this.currentPage - 2);
      const endPage = Math.min(totalPages, this.currentPage + 2);

      if (startPage > 1) {
        this.createPageLink(1, pagination);
        if (startPage > 2) {
          const ellipsis = document.createElement("li");
          ellipsis.className = "page-item disabled";
          ellipsis.innerHTML = '<span class="page-link">...</span>';
          pagination.appendChild(ellipsis);
        }
      }

      for (let i = startPage; i <= endPage; i++) {
        this.createPageLink(i, pagination);
      }

      if (endPage < totalPages) {
        if (endPage < totalPages - 1) {
          const ellipsis = document.createElement("li");
          ellipsis.className = "page-item disabled";
          ellipsis.innerHTML = '<span class="page-link">...</span>';
          pagination.appendChild(ellipsis);
        }
        this.createPageLink(totalPages, pagination);
      }

      // Next button
      const nextLi = document.createElement("li");
      nextLi.className = "page-item" + (this.currentPage == totalPages ? ' disabled' : '');
      const nextLink = document.createElement("a");
      nextLink.className = "page-link";
      nextLink.href = "#";
      nextLink.innerHTML = '<i class="fas fa-chevron-right"></i>';
      nextLink.onclick = (e) => {
        e.preventDefault();
        if (this.currentPage < totalPages) {
          this.currentPage++;
          this.displayPage();
          this.setupPagination();
          this.updateResultsInfo();
        }
      };
      nextLi.appendChild(nextLink);
      pagination.appendChild(nextLi);
    }

    createPageLink(pageNum, pagination) {
      const li = document.createElement("li");
      li.className = "page-item" + (pageNum == this.currentPage ? " active" : "");
      const link = document.createElement("a");
      link.className = "page-link";
      link.href = "#";
      link.innerText = pageNum;
      link.onclick = (e) => {
        e.preventDefault();
        this.currentPage = pageNum;
        this.displayPage();
        this.setupPagination();
        this.updateResultsInfo();
      };
      li.appendChild(link);
      pagination.appendChild(li);
    }

    updateResultsInfo() {
      const resultsInfo = document.getElementById('resultsInfo');
      if (!resultsInfo) return;

      const totalCourses = this.allRows.length;
      const filteredCount = this.filteredRows.length;
      const start = (this.currentPage - 1) * this.rowsPerPage + 1;
      const end = Math.min(start + this.rowsPerPage - 1, filteredCount);

      if (filteredCount === 0) {
        resultsInfo.textContent = 'No courses found';
      } else if (filteredCount === totalCourses) {
        resultsInfo.textContent = `Showing ${start}-${end} of ${totalCourses} courses`;
      } else {
        resultsInfo.textContent = `Showing ${start}-${end} of ${filteredCount} filtered courses (${totalCourses} total)`;
      }
    }

    filterAndPaginate() {
      this.filterRows();
      this.displayPage();
      this.setupPagination();
      this.updateResultsInfo();
    }
  }

  // Initialize when DOM is loaded
  document.addEventListener('DOMContentLoaded', function() {
    window.courseManager = new CourseManager();
  });

  // Global function for inline event handlers
  function filterAndPaginate() {
    if (window.courseManager) {
      window.courseManager.filterAndPaginate();
    }
  }
</script>

</body>
</html>
