<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Management</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #3498db;
            --danger-color: #e74c3c;
            --success-color: #2ecc71;
            --warning-color: #f1c40f;
            --dark-color: #2c3e50;
            --light-color: #ecf0f1;
            --sidebar-width: 280px;
        }

        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background: #f4f6fb;
        }

        .wrapper {
            display: flex;
            min-height: 100vh;
        }

        .main-content {
            flex: 1;
            margin-left: var(--sidebar-width);
            padding: 2rem;
        }

        .main-content.no-sidebar {
            margin-left: 0;
        }

        .content-header {
            margin-bottom: 2rem;
            padding: 1rem;
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
            border: none;
        }

        .card-header {
            background: var(--dark-color);
            color: white;
            padding: 1rem;
            border-radius: 10px 10px 0 0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .search-box {
            background: white;
            border-radius: 5px;
            padding: 1rem;
            margin-bottom: 1.5rem;
            display: flex;
            gap: 1rem;
            align-items: center;
        }

        .search-input {
            flex: 1;
            border: 1px solid #e1e1e1;
            border-radius: 5px;
            padding: 0.75rem 1rem;
            font-size: 0.9rem;
        }

        .search-input:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(52, 152, 219, 0.25);
            outline: none;
        }

        .filter-dropdown {
            border: 1px solid #e1e1e1;
            border-radius: 5px;
            padding: 0.75rem 1rem;
            background: white;
            min-width: 150px;
        }

        .user-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            margin-top: 1rem;
        }

        .user-table th,
        .user-table td {
            padding: 1rem;
            border-bottom: 1px solid #eee;
        }

        .user-table th {
            background: #f8f9fa;
            font-weight: 600;
            color: var(--dark-color);
        }

        .user-table tr:hover {
            background: #f8f9fa;
        }

        .status-badge {
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 500;
        }

        .status-active {
            background: var(--success-color);
            color: white;
        }

        .status-inactive {
            background: var(--warning-color);
            color: white;
        }

        .btn-action {
            padding: 0.5rem 1rem;
            border-radius: 5px;
            border: none;
            cursor: pointer;
            transition: all 0.3s ease;
            font-size: 0.9rem;
            text-decoration: none;
            margin-right: 0.5rem;
        }

        .btn-edit {
            background: var(--primary-color);
            color: white;
        }

        .btn-delete {
            background: var(--danger-color);
            color: white;
        }

        .btn-activate {
            background: var(--success-color);
            color: white;
        }

        .btn-deactivate {
            background: var(--warning-color);
            color: white;
        }

        .btn-create {
            background: var(--success-color);
            color: white;
            padding: 0.75rem 1.5rem;
            font-weight: 500;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-create:hover,
        .btn-edit:hover,
        .btn-delete:hover,
        .btn-activate:hover,
        .btn-deactivate:hover {
            transform: translateY(-2px);
            color: white;
        }

        .alert {
            margin-bottom: 1.5rem;
        }

        .no-users {
            text-align: center;
            padding: 3rem;
            color: #6c757d;
        }

        @media (max-width: 768px) {
            .main-content {
                margin-left: 0;
                padding: 1rem;
            }
        }
    </style>
</head>
<body>
<c:set var="active" value="users" scope="request"/>
<%@ include file="/WEB-INF/layout/header.jsp" %>
<%@ include file="_admin_sidebar.jsp" %>

<div class="wrapper">
    <div class="main-content ${sessionScope.user.role.roleName == 'USER_MANAGER' ? 'no-sidebar' : ''}">
        <div class="content-header">
            <h1 class="h3 mb-0">User Management</h1>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin">Dashboard</a></li>
                    <li class="breadcrumb-item active">User Management</li>
                </ol>
            </nav>
        </div>

        <!-- Display success/error messages -->
        <c:if test="${not empty param.message}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle me-2"></i>${param.message}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <c:if test="${not empty param.error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-circle me-2"></i>${param.error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <div class="card">
            <div class="card-header">
                <h5 class="mb-0">User List</h5>
                <a href="${pageContext.request.contextPath}/admin/users/new?role=USER_MANAGER" class="btn-action btn-create">
                    <i class="fas fa-user-plus"></i>
                    Create User Manager
                </a>
            </div>
            <div class="card-body">
                <form class="search-box" method="GET" action="${pageContext.request.contextPath}/admin/user-management">
                    <input type="text" name="search" class="search-input"
                           placeholder="Search users..." value="${param.search}">
                    <select name="role" class="filter-dropdown" onchange="this.form.submit()">
                        <option value="">All Roles</option>
                        <option value="USER" ${param.role == 'USER' ? 'selected' : ''}>User</option>
                        <option value="ADMIN" ${param.role == 'ADMIN' ? 'selected' : ''}>Admin</option>
                        <option value="USER_MANAGER" ${param.role == 'USER_MANAGER' ? 'selected' : ''}>User Manager</option>
                        <option value="COURSE_MANAGER" ${param.role == 'COURSE_MANAGER' ? 'selected' : ''}>Course Manager</option>
                    </select>
                </form>

                <!-- User table - use userList attribute -->
                <c:if test="${not empty userList}">
                    <div class="table-responsive">
                        <table class="user-table">
                            <thead>
                            <tr>
                                <th>User</th>
                                <th>Email</th>
                                <th>Role</th>
                                <th>Status</th>
                                <th>Created Date</th>
                                <th>Last Login</th>
                                <th>Actions</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${userList}" var="user">
                                <tr>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <img src="${not empty user.avatar ? user.avatar : '/assets/avatar/default_avatar.png'}"
                                                 alt="${user.username}" class="rounded-circle" width="40" height="40">
                                            <div class="ms-3">
                                                <h6 class="mb-0">${user.firstName} ${user.lastName}</h6>
                                                <small class="text-muted">@${user.username}</small>
                                            </div>
                                        </div>
                                    </td>
                                    <td>${user.email}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${user.role.roleName == 'ADMIN'}">
                                                <span class="badge bg-danger">Admin</span>
                                            </c:when>
                                            <c:when test="${user.role.roleName == 'USER_MANAGER'}">
                                                <span class="badge bg-warning">User Manager</span>
                                            </c:when>
                                            <c:when test="${user.role.roleName == 'COURSE_MANAGER'}">
                                                <span class="badge bg-info">Course Manager</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-secondary">${user.role.roleName}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                            <span class="status-badge ${user.active ? 'status-active' : 'status-inactive'}">
                                                    ${user.active ? 'ACTIVE' : 'INACTIVE'}
                                            </span>
                                    </td>
                                    <td>
                                        <c:if test="${not empty user.createdAtDate}">
                                            <fmt:formatDate value="${user.createdAtDate}" pattern="MMM dd, yyyy"/>
                                        </c:if>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty user.lastLoginDate}">
                                                <fmt:formatDate value="${user.lastLoginDate}" pattern="MMM dd, yyyy HH:mm"/>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-muted">Never</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/admin/users/edit/${user.id}"
                                           class="btn-action btn-edit">
                                            <i class="fas fa-edit"></i>
                                        </a>

                                        <c:choose>
                                            <c:when test="${user.active}">
                                                <button onclick="toggleUserStatus(${user.id}, 'deactivate')"
                                                        class="btn-action btn-deactivate">
                                                    <i class="fas fa-user-slash"></i>
                                                </button>
                                            </c:when>
                                            <c:otherwise>
                                                <button onclick="toggleUserStatus(${user.id}, 'activate')"
                                                        class="btn-action btn-activate">
                                                    <i class="fas fa-user-check"></i>
                                                </button>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:if>

                <!-- No users found message -->
                <c:if test="${empty userList}">
                    <div class="no-users">
                        <i class="fas fa-users fa-3x mb-3"></i>
                        <h5>No users found</h5>
                        <c:choose>
                            <c:when test="${not empty searchTerm}">
                                <p>No users match your search criteria: "<strong>${searchTerm}</strong>"</p>
                                <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-primary">
                                    View All Users
                                </a>
                            </c:when>
                            <c:otherwise>
                                <p>There are no users in the system.</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </c:if>

                <!-- Pagination -->
                <c:if test="${totalPages > 1}">
                    <div class="pagination">
                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <a href="${pageContext.request.contextPath}/admin/user-management?page=${i}${not empty param.search ? '&search='.concat(param.search) : ''}${not empty param.role ? '&role='.concat(param.role) : ''}"
                               class="page-link ${currentPage == i ? 'active' : ''}">
                                    ${i}
                            </a>
                        </c:forEach>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function toggleUserStatus(userId, action) {
        const message = action === 'activate' ? 'activate' : 'deactivate';
        if (confirm(`Are you sure you want to ${message} this user?`)) {
            // Create a form and submit it
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = '${pageContext.request.contextPath}/admin/users/' + userId + '/' + action;
            document.body.appendChild(form);
            form.submit();
        }
    }
</script>
</body>
</html>
