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
                    <th>Thao Tác</th>
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
                            <a href="${pageContext.request.contextPath}/admin/users/edit?id=${student.id}"
                               class="btn-action btn-edit me-2">
                                <i class="fas fa-edit"></i>
                            </a>
                            <button class="btn-action btn-delete" onclick="deleteUser(${student.id})">
                                <i class="fas fa-trash"></i>
                            </button>
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
        <div class="table-responsive">
            <table class="user-table">
                <thead>
                <tr>
                    <th>Thông Tin Người Dùng</th>
                    <th>Email</th>
                    <th>Điện Thoại</th>
                    <th>Ngày Tạo</th>
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
                            <a href="${pageContext.request.contextPath}/admin/users/edit?id=${teacher.id}"
                               class="btn-action btn-edit me-2">
                                <i class="fas fa-edit"></i>
                            </a>
                            <button class="btn-action btn-delete" onclick="deleteUser(${teacher.id})">
                                <i class="fas fa-trash"></i>
                            </button>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
