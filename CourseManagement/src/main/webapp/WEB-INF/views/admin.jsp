<%--
  Created by IntelliJ IDEA.
  User: ducmi
  Date: 28/05/2025
  Time: 5:58 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Admin Dashboard - Course Management System</title>

  <link href="${pageContext.request.contextPath}/css/admincss.css" rel="stylesheet">
</head>
<body>
<div class="wrapper">
  <!-- Sidebar -->
  <nav id="sidebar" class="bg-dark text-white">
    <div class="sidebar-header">
      <h3>Admin Panel</h3>
    </div>

    <ul class="list-unstyled components">
      <li class="active">
        <a href="${pageContext.request.contextPath}/admin/dashboard">
          <i class="fas fa-tachometer-alt"></i> Dashboard
        </a>
      </li>
      <li>
        <a href="${pageContext.request.contextPath}/admin/users">
          <i class="fas fa-users"></i> User Management
        </a>
      </li>
      <li>
        <a href="${pageContext.request.contextPath}/admin/teachers">
          <i class="fas fa-chalkboard-teacher"></i> Teachers
        </a>
      </li>
      <li>
        <a href="${pageContext.request.contextPath}/admin/students">
          <i class="fas fa-user-graduate"></i> Students
        </a>
      </li>
      <li>
        <a href="${pageContext.request.contextPath}/admin/courses">
          <i class="fas fa-book"></i> Courses
        </a>
      </li>
      <li>
        <a href="${pageContext.request.contextPath}/admin/categories">
          <i class="fas fa-tags"></i> Categories
        </a>
      </li>
      <li>
        <a href="${pageContext.request.contextPath}/admin/reports">
          <i class="fas fa-chart-bar"></i> Reports
        </a>
      </li>
      <li>
        <a href="${pageContext.request.contextPath}/admin/settings">
          <i class="fas fa-cog"></i> Settings
        </a>
      </li>
    </ul>
  </nav>

  <!-- Page Content -->
  <div id="content">
    <!-- Top Navbar -->
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
      <div class="container-fluid">
        <a class="navbar-brand" href="#">Course Management System</a>
        <div class="ms-auto d-flex align-items-center">
          <a href="${pageContext.request.contextPath}/admin/profile" class="btn btn-link">
            <img src="${pageContext.request.contextPath}/assets/images/avatars/admin.jpg" class="rounded-circle" width="32" height="32">
            <span class="ms-2">${sessionScope.admin.name != null ? sessionScope.admin.name : 'Admin User'}</span>
          </a>
          <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-danger ms-3">
            <i class="fas fa-sign-out-alt"></i> Logout
          </a>
        </div>
      </div>
    </nav>

    <!-- Main Content -->
    <div class="container-fluid py-4">
      <!-- Dashboard Cards -->
      <div class="row">
        <div class="col-xl-3 col-md-6 mb-4">
          <div class="card border-left-primary shadow h-100 py-2">
            <div class="card-body">
              <div class="row no-gutters align-items-center">
                <div class="col mr-2">
                  <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                    Total Users</div>
                  <div class="h5 mb-0 font-weight-bold text-gray-800">
                    <fmt:formatNumber value="${dashboardStats.totalUsers}" />
                  </div>
                </div>
                <div class="col-auto">
                  <i class="fas fa-users fa-2x text-gray-300"></i>
                </div>
              </div>
            </div>
          </div>
        </div>

        <div class="col-xl-3 col-md-6 mb-4">
          <div class="card border-left-success shadow h-100 py-2">
            <div class="card-body">
              <div class="row no-gutters align-items-center">
                <div class="col mr-2">
                  <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                    Total Courses</div>
                  <div class="h5 mb-0 font-weight-bold text-gray-800">
                    <fmt:formatNumber value="${dashboardStats.totalCourses}" />
                  </div>
                </div>
                <div class="col-auto">
                  <i class="fas fa-book fa-2x text-gray-300"></i>
                </div>
              </div>
            </div>
          </div>
        </div>

        <div class="col-xl-3 col-md-6 mb-4">
          <div class="card border-left-info shadow h-100 py-2">
            <div class="card-body">
              <div class="row no-gutters align-items-center">
                <div class="col mr-2">
                  <div class="text-xs font-weight-bold text-info text-uppercase mb-1">
                    Active Enrollments</div>
                  <div class="h5 mb-0 font-weight-bold text-gray-800">
                    <fmt:formatNumber value="${dashboardStats.activeEnrollments}" />
                  </div>
                </div>
                <div class="col-auto">
                  <i class="fas fa-graduation-cap fa-2x text-gray-300"></i>
                </div>
              </div>
            </div>
          </div>
        </div>

        <div class="col-xl-3 col-md-6 mb-4">
          <div class="card border-left-warning shadow h-100 py-2">
            <div class="card-body">
              <div class="row no-gutters align-items-center">
                <div class="col mr-2">
                  <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
                    Revenue</div>
                  <div class="h5 mb-0 font-weight-bold text-gray-800">
                    $<fmt:formatNumber value="${dashboardStats.totalRevenue}" pattern="#,##0.00" />
                  </div>
                </div>
                <div class="col-auto">
                  <i class="fas fa-dollar-sign fa-2x text-gray-300"></i>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Quick Actions -->
      <div class="row mb-4">
        <div class="col-12">
          <div class="card shadow">
            <div class="card-header py-3">
              <h6 class="m-0 font-weight-bold text-primary">Quick Actions</h6>
            </div>
            <div class="card-body">
              <div class="row">
                <div class="col-md-3 mb-3">
                  <a href="${pageContext.request.contextPath}/admin/courses/new" class="btn btn-primary w-100">
                    <i class="fas fa-plus"></i> Add New Course
                  </a>
                </div>
                <div class="col-md-3 mb-3">
                  <a href="${pageContext.request.contextPath}/admin/users/new" class="btn btn-success w-100">
                    <i class="fas fa-user-plus"></i> Add New User
                  </a>
                </div>
                <div class="col-md-3 mb-3">
                  <a href="${pageContext.request.contextPath}/admin/reports/export" class="btn btn-info w-100">
                    <i class="fas fa-file-export"></i> Export Reports
                  </a>
                </div>
                <div class="col-md-3 mb-3">
                  <a href="${pageContext.request.contextPath}/admin/settings" class="btn btn-warning w-100">
                    <i class="fas fa-cog"></i> System Settings
                  </a>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Recent Activities -->
      <div class="row">
        <div class="col-12">
          <div class="card shadow mb-4">
            <div class="card-header py-3">
              <h6 class="m-0 font-weight-bold text-primary">Recent Activities</h6>
            </div>
            <div class="card-body">
              <c:choose>
                <c:when test="${not empty recentActivities}">
                  <div class="table-responsive">
                    <table class="table table-bordered">
                      <thead>
                      <tr>
                        <th>Activity</th>
                        <th>User</th>
                        <th>Time</th>
                        <th>Action</th>
                      </tr>
                      </thead>
                      <tbody>
                      <c:forEach var="activity" items="${recentActivities}">
                        <tr>
                          <td>${activity.description}</td>
                          <td>${activity.userName}</td>
                          <td>
                            <fmt:formatDate value="${activity.createdAt}" pattern="MMM dd, yyyy HH:mm" />
                          </td>
                          <td>
                            <c:if test="${not empty activity.targetId}">
                              <a href="${pageContext.request.contextPath}/admin/${activity.targetType}/${activity.targetId}"
                                 class="btn btn-sm btn-info">View</a>
                            </c:if>
                          </td>
                        </tr>
                      </c:forEach>
                      </tbody>
                    </table>
                  </div>
                </c:when>
                <c:otherwise>
                  <div class="text-center py-4">
                    <i class="fas fa-inbox fa-3x text-gray-300 mb-3"></i>
                    <p class="text-muted">No recent activities found</p>
                  </div>
                </c:otherwise>
              </c:choose>
            </div>
          </div>
        </div>
      </div>

      <!-- Additional Statistics -->
      <div class="row">
        <div class="col-lg-6">
          <div class="card shadow mb-4">
            <div class="card-header py-3">
              <h6 class="m-0 font-weight-bold text-primary">Top Courses</h6>
            </div>
            <div class="card-body">
              <c:choose>
                <c:when test="${not empty topCourses}">
                  <c:forEach var="course" items="${topCourses}">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                      <div>
                        <h6 class="mb-1">${course.title}</h6>
                        <small class="text-muted">${course.enrollmentCount} students</small>
                      </div>
                      <span class="badge badge-primary">${course.category.name}</span>
                    </div>
                  </c:forEach>
                </c:when>
                <c:otherwise>
                  <div class="text-center py-3">
                    <p class="text-muted">No courses available</p>
                  </div>
                </c:otherwise>
              </c:choose>
            </div>
          </div>
        </div>

        <div class="col-lg-6">
          <div class="card shadow mb-4">
            <div class="card-header py-3">
              <h6 class="m-0 font-weight-bold text-primary">Recent Registrations</h6>
            </div>
            <div class="card-body">
              <c:choose>
                <c:when test="${not empty recentUsers}">
                  <c:forEach var="user" items="${recentUsers}">
                    <div class="d-flex align-items-center mb-3">
                      <img src="${pageContext.request.contextPath}/assets/images/avatars/default.jpg"
                           class="rounded-circle me-3" width="40" height="40">
                      <div>
                        <h6 class="mb-1">${user.fullName}</h6>
                        <small class="text-muted">
                          <fmt:formatDate value="${user.createdAt}" pattern="MMM dd, yyyy" />
                        </small>
                      </div>
                      <span class="badge badge-${user.role == 'TEACHER' ? 'success' : 'info'} ms-auto">
                          ${user.role}
                      </span>
                    </div>
                  </c:forEach>
                </c:when>
                <c:otherwise>
                  <div class="text-center py-3">
                    <p class="text-muted">No recent registrations</p>
                  </div>
                </c:otherwise>
              </c:choose>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
</body>
</html>