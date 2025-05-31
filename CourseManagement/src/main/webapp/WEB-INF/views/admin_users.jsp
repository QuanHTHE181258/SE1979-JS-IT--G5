<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Management - Admin</title>
    <link href="${pageContext.request.contextPath}/css/admincss.css" rel="stylesheet">


</head>
<body>
<div class="wrapper">
    <nav id="sidebar" class="bg-dark text-white">
        <div class="sidebar-header">
            <h3>Admin Panel</h3>
        </div>
        <ul class="list-unstyled components">
            <li><a href="${pageContext.request.contextPath}/admin">
                <i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
            <li class="active"><a href="${pageContext.request.contextPath}/admin/users">
                <i class="fas fa-users"></i> User Management</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/teachers">
                <i class="fas fa-chalkboard-teacher"></i> Teachers</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/students">
                <i class="fas fa-user-graduate"></i> Students</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/courses">
                <i class="fas fa-book"></i> Courses</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/categories">
                <i class="fas fa-tags"></i> Categories</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/reports">
                <i class="fas fa-chart-bar"></i> Reports</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/settings">
                <i class="fas fa-cog"></i> Settings</a></li>
        </ul>
    </nav>

    <div id="content">
        <!-- Top Navbar -->
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <div class="container-fluid">
                <a class="navbar-brand" href="#">User Management</a>
                <div class="ms-auto">
                    <a href="${pageContext.request.contextPath}/admin/users/new" class="btn btn-primary">
                        <i class="fas fa-plus"></i> Add New User
                    </a>
                </div>
            </div>
        </nav>

        <div class="container-fluid py-4">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">User Management</h3>
                </div>
                <div class="card-body">
                    <% if (request.getParameter("message") != null) { %>
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <%= request.getParameter("message") %>
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                    <% } %>
                    <% if (request.getParameter("error") != null) { %>
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <%= request.getParameter("error") %>
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                    <% } %>

                    <!-- Search Form -->
                    <form action="${pageContext.request.contextPath}/admin/users" method="get" class="form-inline mb-3">
                        <div class="form-group mx-sm-3 mb-2">
                            <label for="searchTerm" class="sr-only">Search by Name</label>
                            <input type="text" class="form-control" id="searchTerm" name="searchTerm" placeholder="Search by Name" value="${searchTerm}">
                        </div>
                        <button type="submit" class="btn btn-primary mb-2"><i class="fas fa-search"></i> Search</button>
                         <c:if test="${not empty searchTerm}">
                            <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-secondary mb-2 ml-2">Clear Search</a>
                        </c:if>
                    </form>

                    <c:choose>
                        <c:when test="${not empty userList}">
                            <div class="table-responsive">
                                <table class="table table-bordered table-hover">
                                    <thead class="table-dark">
                                    <tr>
                                        <th>ID</th>
                                        <th>Avatar</th>
                                        <th>Username</th>
                                        <th>Full Name</th>
                                        <th>Email</th>
                                        <th>Phone</th>
                                        <th>Role</th>
                                        <th>Status</th>
                                        <th>Email Verified</th>
                                        <th>Last Login</th>
                                        <th>Created At</th>
                                        <th>Actions</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="user" items="${userList}">
                                        <tr>
                                            <td>${user.id}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty user.avatarUrl}">
                                                        <img src="${user.avatarUrl}" class="rounded-circle" width="40" height="40" alt="Avatar">
                                                    </c:when>
                                                    <c:when test="${not empty user.currentAvatar}">
                                                        <img src="${pageContext.request.contextPath}/images/users/${user.currentAvatar.fileName}"
                                                             class="rounded-circle" width="40" height="40" alt="Avatar">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <img src="${pageContext.request.contextPath}/assets/images/avatars/default.jpg"
                                                             class="rounded-circle" width="40" height="40" alt="Default Avatar">
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>${user.username}</td>
                                            <td>${user.firstName} ${user.lastName}</td>
                                            <td>${user.email}</td>
                                            <td>${not empty user.phone ? user.phone : 'N/A'}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty user.role.roleName}">
                                                        <span class="badge badge-info">${user.role.roleName}</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge badge-secondary">Unknown</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${user.isActive}">
                                                        <span class="badge badge-success">Active</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge badge-danger">Inactive</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${user.emailVerified}">
                                                        <span class="badge badge-success">
                                                            <i class="fas fa-check"></i> Verified
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge badge-warning">
                                                            <i class="fas fa-exclamation-triangle"></i> Unverified
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty user.lastLoginDate}">
                                                        <fmt:formatDate value="${user.lastLoginDate}" pattern="MMM dd, yyyy HH:mm" />
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-muted">Never</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty user.createdAtDate}">
                                                        <fmt:formatDate value="${user.createdAtDate}" pattern="MMM dd, yyyy" />
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-muted">N/A</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <div class="btn-group" role="group">
<%--                                                    <a href="${pageContext.request.contextPath}/admin/users/${user.id}"--%>
<%--                                                       class="btn btn-info btn-sm" title="View Details">--%>
<%--                                                        <i class="fas fa-eye"></i>--%>
<%--                                                    </a>--%>
<%--                                                    <a href="${pageContext.request.contextPath}/admin/users/${user.id}/edit"--%>
<%--                                                       class="btn btn-warning btn-sm" title="Edit User">--%>
<%--                                                        <i class="fas fa-edit"></i>--%>
<%--                                                    </a>--%>
                                                    <c:if test="${user.isActive}">
                                                        <a href="${pageContext.request.contextPath}/admin/users/${user.id}/deactivate"
                                                           class="btn btn-danger btn-sm" title="Deactivate User"
                                                           onclick="return confirm('Are you sure you want to deactivate this user?')">
                                                            <i class="fas fa-ban"></i> Deactivate
                                                        </a>
                                                    </c:if>
                                                    <c:if test="${not user.isActive}">
                                                        <a href="${pageContext.request.contextPath}/admin/users/${user.id}/activate"
                                                           class="btn btn-success btn-sm" title="Activate User">
                                                            <i class="fas fa-check"></i> Activate
                                                        </a>
                                                    </c:if>
<%--                                                    <a href="${pageContext.request.contextPath}/admin/users/${user.id}/delete"--%>
<%--                                                       class="btn btn-danger btn-sm" title="Delete User"--%>
<%--                                                       onclick="return confirm('Are you sure you want to delete this user? This action cannot be undone.')">--%>
<%--                                                        <i class="fas fa-trash"></i>--%>
<%--                                                    </a>--%>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="text-center py-5">
                                <i class="fas fa-users fa-3x text-gray-300 mb-3"></i>
                                <h5 class="text-muted">No users found</h5>
                                <p class="text-muted">There are no users in the system yet.</p>
                                <a href="${pageContext.request.contextPath}/admin/users/new" class="btn btn-primary">
                                    <i class="fas fa-plus"></i> Add First User
                                </a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>