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

        .search-box {
            margin-bottom: 1.5rem;
            display: flex;
            gap: 1rem;
        }

        .search-input {
            flex: 1;
            padding: 0.5rem;
            border: 1px solid #ddd;
            border-radius: 4px;
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
    </style>
</head>
<body>
<c:set var="active" value="users" scope="request"/>
<jsp:include page="/WEB-INF/layout/header.jsp" />
<jsp:include page="/WEB-INF/views/_admin_sidebar.jsp" />

<div class="container mt-4">
    <div class="search-box">
        <input type="text" name="keyword" class="search-input"
               placeholder="Tìm kiếm người dùng..." value="${keyword}">
    </div>

    <!-- Students Section -->
    <div class="user-section">
        <h2 class="section-title">Học Viên</h2>
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
                <tbody>
                <c:forEach items="${students}" var="student">
                    <tr>
                        <td>
                            <div class="user-info">
                                <img src="${not empty student.avatarUrl ? student.avatarUrl : '/assets/avatar/default_avatar.png'}"
                                     alt="${student.username}" class="avatar">
                                <div>
                                    <div>${student.firstName} ${student.lastName}</div>
                                    <small class="text-muted">@${student.username}</small>
                                </div>
                            </div>
                        </td>
                        <td>${student.email}</td>
                        <td>${student.phoneNumber}</td>
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
        </div>
    </div>

    <!-- Teachers Section -->
    <div class="user-section">
        <h2 class="section-title">Giảng Viên</h2>
        <a href="${pageContext.request.contextPath}/admin/teachers/create" class="btn btn-primary mb-3">
            <i class="fas fa-plus-circle me-1"></i> Tạo Giảng Viên
        </a>

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
                <tbody>
                <c:forEach items="${teachers}" var="teacher">
                    <tr>
                        <td>
                            <div class="user-info">
                                <img src="${not empty teacher.avatarUrl ? teacher.avatarUrl : '/assets/avatar/default_avatar.png'}"
                                     alt="${teacher.username}" class="avatar">
                                <div>
                                    <div>${teacher.firstName} ${teacher.lastName}</div>
                                    <small class="text-muted">@${teacher.username}</small>
                                </div>
                            </div>
                        </td>
                        <td>${teacher.email}</td>
                        <td>${teacher.phoneNumber}</td>
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
        </div>
    </div>

    <!-- Course Managers Section -->
    <div class="user-section">
        <h2 class="section-title">Quản Lý Khóa Học</h2>
        <a href="${pageContext.request.contextPath}/admin/courses/new?role=COURSE_MANAGER" class="btn btn-primary mb-3">
            <i class="fas fa-plus-circle me-1"></i> Tạo Quản Lý Khóa Học
        </a>
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
                <tbody>
                <c:forEach items="${courseManagers}" var="manager">
                    <tr>
                        <td>
                            <div class="user-info">
                                <img src="${not empty manager.avatarUrl ? manager.avatarUrl : '/assets/avatar/default_avatar.png'}"
                                     alt="${manager.username}" class="avatar">
                                <div>
                                    <div>${manager.firstName} ${manager.lastName}</div>
                                    <small class="text-muted">@${manager.username}</small>
                                </div>
                            </div>
                        </td>
                        <td>${manager.email}</td>
                        <td>${manager.phoneNumber}</td>
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
        </div>
    </div>

    <!-- User Managers Section (Only visible for Admin) -->
    <c:if test="${isAdmin}">
        <div class="user-section">
            <h2 class="section-title">Quản Lý Người Dùng</h2>
            <a href="${pageContext.request.contextPath}/admin/users/new?role=USER_MANAGER" class="btn btn-primary mb-3">
                <i class="fas fa-plus-circle me-1"></i> Tạo Quản Lý Người Dùng
            </a>

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
                    <tbody>
                    <c:forEach items="${userManagers}" var="manager">
                        <tr>
                            <td>
                                <div class="user-info">
                                    <img src="${not empty manager.avatarUrl ? manager.avatarUrl : '/assets/avatar/default_avatar.png'}"
                                         alt="${manager.username}" class="avatar">
                                    <div>
                                        <div>${manager.firstName} ${manager.lastName}</div>
                                        <small class="text-muted">@${manager.username}</small>
                                    </div>
                                </div>
                            </td>
                            <td>${manager.email}</td>
                            <td>${manager.phoneNumber}</td>
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
            </div>
        </div>
    </c:if>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>