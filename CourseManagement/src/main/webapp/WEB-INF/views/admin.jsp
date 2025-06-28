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
  <nav class="col-md-2 d-md-block sidebar min-vh-100" id="sidebar">
    <div class="position-sticky pt-3">
      <h3 class="text-white text-center mb-4">Admin Panel</h3>
      <ul class="nav flex-column">
        <li class="nav-item">
          <a class="nav-link active" href="${pageContext.request.contextPath}/admin/dashboard">
            <i class="fas fa-home"></i> Dashboard
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/admin/courses">
            <i class="fas fa-book"></i> Courses
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/admin/orders">
            <i class="fas fa-shopping-cart"></i> Orders
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/admin/users">
            <i class="fas fa-users"></i> Users
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/admin/revenue-analytics">
            <i class="fas fa-chart-bar"></i> Revenue Analytics
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/teacher-performance">
            <i class="fas fa-chart-line"></i> Teacher Performance
          </a>
        </li>
      </ul>
    </div>
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

<%--      <!-- Quick Actions -->--%>
<%--      <div class="row mb-4">--%>
<%--        <div class="col-12">--%>
<%--          <div class="card shadow">--%>
<%--            <div class="card-header py-3">--%>
<%--              <h6 class="m-0 font-weight-bold text-primary">Quick Actions</h6>--%>
<%--            </div>--%>
<%--            <div class="card-body">--%>
<%--              <div class="row">--%>
<%--                <div class="col-md-3 mb-3">--%>
<%--                  <a href="${pageContext.request.contextPath}/admin/users/new?role=USER_MANAGER" class="btn btn-primary w-100">--%>
<%--                    <i class="fas fa-user-shield"></i> Add User Manager--%>
<%--                  </a>--%>
<%--                </div>--%>
<%--                <div class="col-md-3 mb-3">--%>
<%--                  <a href="${pageContext.request.contextPath}/admin/users/new?role=COURSE_MANAGER" class="btn btn-success w-100">--%>
<%--                    <i class="fas fa-book-reader"></i> Add Course Manager--%>
<%--                  </a>--%>
<%--                </div>--%>
<%--                <div class="col-md-3 mb-3">--%>
<%--                  <a href="${pageContext.request.contextPath}/admin/courses/new" class="btn btn-info w-100">--%>
<%--                    <i class="fas fa-plus"></i> Add New Course--%>
<%--                  </a>--%>
<%--                </div>--%>
<%--                <div class="col-md-3 mb-3">--%>
<%--                  <a href="${pageContext.request.contextPath}/admin/reports/export" class="btn btn-warning w-100">--%>
<%--                    <i class="fas fa-file-export"></i> Export Reports--%>
<%--                  </a>--%>
<%--                </div>--%>
<%--              </div>--%>
<%--            </div>--%>
<%--          </div>--%>
<%--        </div>--%>
<%--      </div>--%>

      <!-- Recent Activities -->
      <div class="row">
        <div class="col-12">
          <div class="card shadow mb-4">
            <div class="card-header py-3 d-flex justify-content-between align-items-center">
              <h6 class="m-0 font-weight-bold text-primary">Recent Activities</h6>
              <div class="d-flex gap-2">
                <!-- Search Form -->
                <form action="${pageContext.request.contextPath}/admin" method="GET" class="d-flex gap-2">
                  <input type="hidden" name="courseSearch" value="${param.courseSearch}">
                  <input type="hidden" name="courseLimit" value="${param.courseLimit}">
                  <input type="hidden" name="activityLimit" value="${param.activityLimit}">
                  <input type="hidden" name="activityRole" value="${param.activityRole}">
                  
                  <input type="text" name="activitySearch" class="form-control form-control-sm" 
                         placeholder="Search users..." value="${param.activitySearch}" style="width: 200px;">
                  <button type="submit" class="btn btn-sm btn-primary">
                    <i class="fas fa-search"></i>
                  </button>
                  <c:if test="${not empty param.activitySearch}">
                    <a href="${pageContext.request.contextPath}/admin?courseSearch=${param.courseSearch}&courseLimit=${param.courseLimit}&activityLimit=${param.activityLimit}&activityRole=${param.activityRole}" 
                       class="btn btn-sm btn-outline-secondary">
                      <i class="fas fa-times"></i>
                    </a>
                  </c:if>
                </form>
                
                <!-- Role Filter -->
                <div class="btn-group btn-group-sm" role="group">
                  <a href="${pageContext.request.contextPath}/admin?activitySearch=${param.activitySearch}&courseSearch=${param.courseSearch}&courseLimit=${param.courseLimit}&activityLimit=${param.activityLimit}&activityRole=student" 
                     class="btn btn-outline-primary ${param.activityRole == 'student' || empty param.activityRole ? 'active' : ''}">Student</a>
                  <a href="${pageContext.request.contextPath}/admin?activitySearch=${param.activitySearch}&courseSearch=${param.courseSearch}&courseLimit=${param.courseLimit}&activityLimit=${param.activityLimit}&activityRole=teacher" 
                     class="btn btn-outline-primary ${param.activityRole == 'teacher' ? 'active' : ''}">Teacher</a>
                </div>
                
                <!-- Limit Toggle -->
                <div class="btn-group btn-group-sm" role="group">
                  <a href="${pageContext.request.contextPath}/admin?activitySearch=${param.activitySearch}&courseSearch=${param.courseSearch}&courseLimit=${param.courseLimit}&activityLimit=5&activityRole=${param.activityRole}" 
                     class="btn btn-outline-info ${param.activityLimit == 5 || empty param.activityLimit ? 'active' : ''}">5</a>
                  <a href="${pageContext.request.contextPath}/admin?activitySearch=${param.activitySearch}&courseSearch=${param.courseSearch}&courseLimit=${param.courseLimit}&activityLimit=10&activityRole=${param.activityRole}" 
                     class="btn btn-outline-info ${param.activityLimit == 10 ? 'active' : ''}">10</a>
                </div>
              </div>
            </div>
            <div class="card-body">
              <c:choose>
                <c:when test="${not empty recentActivities}">
                  <div class="table-responsive">
                    <table class="table table-bordered">
                      <thead>
                      <tr>
                        <th>User</th>
                        <th>Last Login Time</th>
                        <th>Registration Time</th>
                        <th>Role</th>
                      </tr>
                      </thead>
                      <tbody>
                      <c:forEach var="user" items="${recentActivities}">
                        <tr>
                          <td>${user.firstName} ${user.lastName}</td>
                          <td>
                            <c:choose>
                              <c:when test="${not empty user.lastLoginDate}">
                                <fmt:formatDate value="${user.lastLoginDate}" pattern="MMM dd, yyyy HH:mm" />
                              </c:when>
                              <c:otherwise>
                                N/A
                              </c:otherwise>
                            </c:choose>
                          </td>
                          <td>
                            <fmt:formatDate value="${user.createdAtDate}" pattern="MMM dd, yyyy HH:mm" />
                          </td>
                          <td>${user.role.roleName}</td>
                        </tr>
                      </c:forEach>
                      </tbody>
                    </table>
                  </div>
                </c:when>
                <c:otherwise>
                  <div class="text-center py-4">
                    <i class="fas fa-inbox fa-3x text-gray-300 mb-3"></i>
                    <p class="text-muted">
                      <c:choose>
                        <c:when test="${not empty param.activitySearch}">
                          No recent activities found for "${param.activitySearch}"
                        </c:when>
                        <c:otherwise>
                          No recent activities found
                        </c:otherwise>
                      </c:choose>
                    </p>
                  </div>
                </c:otherwise>
              </c:choose>
            </div>
          </div>
        </div>
      </div>

      <!-- Recent Created Courses -->
      <div class="row">
        <div class="col-12">
          <div class="card shadow mb-4">
            <div class="card-header py-3 d-flex justify-content-between align-items-center">
              <h6 class="m-0 font-weight-bold text-primary">Recent Created Courses</h6>
              <div class="d-flex gap-2">
                <!-- Search Form -->
                <form action="${pageContext.request.contextPath}/admin" method="GET" class="d-flex gap-2">
                  <input type="hidden" name="activitySearch" value="${param.activitySearch}">
                  <input type="hidden" name="activityLimit" value="${param.activityLimit}">
                  <input type="hidden" name="activityRole" value="${param.activityRole}">
                  <input type="hidden" name="courseLimit" value="${param.courseLimit}">
                  
                  <input type="text" name="courseSearch" class="form-control form-control-sm" 
                         placeholder="Search courses..." value="${param.courseSearch}" style="width: 200px;">
                  <button type="submit" class="btn btn-sm btn-primary">
                    <i class="fas fa-search"></i>
                  </button>
                  <c:if test="${not empty param.courseSearch}">
                    <a href="${pageContext.request.contextPath}/admin?activitySearch=${param.activitySearch}&activityLimit=${param.activityLimit}&activityRole=${param.activityRole}&courseLimit=${param.courseLimit}" 
                       class="btn btn-sm btn-outline-secondary">
                      <i class="fas fa-times"></i>
                    </a>
                  </c:if>
                </form>
                
                <!-- Limit Toggle -->
                <div class="btn-group btn-group-sm" role="group">
                  <a href="${pageContext.request.contextPath}/admin?activitySearch=${param.activitySearch}&courseSearch=${param.courseSearch}&activityLimit=${param.activityLimit}&activityRole=${param.activityRole}&courseLimit=5" 
                     class="btn btn-outline-info ${param.courseLimit == 5 || empty param.courseLimit ? 'active' : ''}">5</a>
                  <a href="${pageContext.request.contextPath}/admin?activitySearch=${param.activitySearch}&courseSearch=${param.courseSearch}&activityLimit=${param.activityLimit}&activityRole=${param.activityRole}&courseLimit=10" 
                     class="btn btn-outline-info ${param.courseLimit == 10 ? 'active' : ''}">10</a>
                </div>
              </div>
            </div>
            <div class="card-body">
              <c:choose>
                <c:when test="${not empty recentCourses}">
                  <div class="table-responsive">
                    <table class="table table-bordered">
                      <thead>
                      <tr>
                        <th>Course Code</th>
                        <th>Title</th>
                        <th>Teacher</th>
                        <th>Created At</th>
                      </tr>
                      </thead>
                      <tbody>
                      <c:forEach var="course" items="${recentCourses}">
                        <tr>
                          <td>${course.courseCode}</td>
                          <td>${course.title}</td>
                          <td>${course.teacherUsername}</td>
                          <td>
                              <c:choose>
                                  <c:when test="${not empty course.createdAtDate}">
                                      <fmt:formatDate value="${course.createdAtDate}" pattern="MMM dd, yyyy HH:mm" />
                                  </c:when>
                                  <c:otherwise>
                                      N/A
                                  </c:otherwise>
                              </c:choose>
                          </td>
                        </tr>
                      </c:forEach>
                      </tbody>
                    </table>
                  </div>
                </c:when>
                <c:otherwise>
                  <div class="text-center py-4">
                    <i class="fas fa-book fa-3x text-gray-300 mb-3"></i>
                    <p class="text-muted">
                      <c:choose>
                        <c:when test="${not empty param.courseSearch}">
                          No recent courses found for "${param.courseSearch}"
                        </c:when>
                        <c:otherwise>
                          No recent courses created
                        </c:otherwise>
                      </c:choose>
                    </p>
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
                      <span class="badge badge-primary">Category ${course.categoryId}</span>
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
                        <h6 class="mb-1">${user.firstName} ${user.lastName}</h6>
                        <small class="text-muted">
                          <fmt:formatDate value="${user.createdAtDate}" pattern="MMM dd, yyyy HH:mm" />
                        </small>
                      </div>
                      <span class="badge badge-info ms-auto">User</span>
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