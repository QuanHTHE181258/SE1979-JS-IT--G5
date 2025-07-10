<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Your Teaching Courses</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: #f8fafc; }
        .container { max-width: 1000px; margin: 40px auto; background: #fff; border-radius: 16px; box-shadow: 0 8px 32px 0 rgba(31,38,135,0.10); padding: 2.5rem 2rem; }
        .table thead { background: linear-gradient(135deg, #43cea2 0%, #185a9d 100%); color: #fff; }
        .table tbody tr:hover { background: #e0eafc; }
        .title { font-size: 2rem; font-weight: 700; color: #185a9d; margin-bottom: 2rem; text-align: center; }
    </style>
</head>
<body>
<div class="container">
    <div class="title"><i class="fas fa-chalkboard-teacher me-2"></i>Your Teaching Courses</div>
    <!-- Filter & Search Controls -->
    <div class="row mb-3">
        <div class="col-md-4 mb-2">
            <input type="text" id="searchInput" class="form-control" placeholder="Search by title or description...">
        </div>
        <div class="col-md-3 mb-2">
            <select id="statusFilter" class="form-select">
                <option value="">All Statuses</option>
                <option value="active">Active</option>
                <option value="inactive">Inactive</option>
                <option value="draft">draft</option>
            </select>
        </div>
    </div>
    <c:choose>
        <c:when test="${not empty courses}">
            <div class="table-responsive">
                <table class="table table-bordered align-middle">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Title</th>
                            <th>Description</th>
                            <th>Price</th>
                            <th>Rating</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody id="coursesTableBody">
                        <c:forEach var="course" items="${courses}" varStatus="status">
                            <tr data-title="${course.title}" data-description="${course.description}" data-status="${course.status}">
                                <td>${status.index + 1}</td>
                                <td class="fw-semibold text-primary">${course.title}</td>
                                <td><c:out value="${course.description}"/></td>
                                <td><span class="badge bg-success">${course.price}$</span></td>
                                <td><span class="badge bg-info text-dark">${course.rating}</span></td>
                                <td><span class="badge bg-secondary">${course.status}</span></td>
                                <td>
                                    <a href="course-lessons?id=${course.id}" class="btn btn-outline-info btn-sm mb-1"><i class="fas fa-eye me-1"></i>View Details</a>
                                    <a href="course-feedback?id=${course.id}" class="btn btn-outline-warning btn-sm mb-1"><i class="fas fa-comments me-1"></i>Feedback</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <!-- Pagination Controls -->
                <nav>
                  <ul class="pagination justify-content-center" id="pagination"></ul>
                </nav>
            </div>
        </c:when>
        <c:otherwise>
            <div class="alert alert-info text-center">You are not teaching any courses yet.</div>
        </c:otherwise>
    </c:choose>
</div>
<!-- FontAwesome for icon -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
<!-- Client-side Filter, Search, Pagination Script -->
<script>
const rowsPerPage = 5;
let currentPage = 1;

function filterAndPaginate() {
    const search = document.getElementById('searchInput').value.toLowerCase();
    const status = document.getElementById('statusFilter').value;
    const rows = Array.from(document.querySelectorAll('#coursesTableBody tr'));
    let filtered = rows.filter(row => {
        const title = row.getAttribute('data-title').toLowerCase();
        const desc = row.getAttribute('data-description').toLowerCase();
        const stat = row.getAttribute('data-status');
        const matchSearch = title.includes(search) || desc.includes(search);
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
        a.onclick = (e) => { e.preventDefault(); currentPage = i; filterAndPaginate(); };
        li.appendChild(a);
        pag.appendChild(li);
    }
}

document.getElementById('searchInput').addEventListener('input', () => { currentPage = 1; filterAndPaginate(); });
document.getElementById('statusFilter').addEventListener('change', () => { currentPage = 1; filterAndPaginate(); });
window.onload = filterAndPaginate;
</script>
</body>
</html>
