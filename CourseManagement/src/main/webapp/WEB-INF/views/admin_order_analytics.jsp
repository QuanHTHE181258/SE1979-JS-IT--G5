<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Order Analytics - Admin</title>
    <link href="${pageContext.request.contextPath}/css/admincss.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
<div class="wrapper">
    <nav id="sidebar" class="bg-dark text-white">
        <div class="sidebar-header">
            <h3>Admin Panel</h3>
        </div>
        <ul class="list-unstyled components">
            <li <c:if test="${request.servletPath == '/admin'}">class="active"</c:if>>
                <a href="${pageContext.request.contextPath}/admin">
                    <i class="fas fa-tachometer-alt"></i> Dashboard
                </a>
            </li>
            <li <c:if test="${request.servletPath == '/admin/users' || request.servletPath == '/admin/user-management'}">class="active"</c:if>>
                <a href="${pageContext.request.contextPath}/admin/users">
                    <i class="fas fa-users"></i> User Management
                </a>
            </li>
            <li <c:if test="${request.servletPath == '/admin/courses' || request.servletPath == '/admin/course-management'}">class="active"</c:if>>
                <a href="${pageContext.request.contextPath}/admin/courses">
                    <i class="fas fa-book"></i> Courses Management
                </a>
            </li>
            <li <c:if test="${request.servletPath == '/admin/orders'}">class="active"</c:if>>
                <a href="${pageContext.request.contextPath}/admin/orders">
                    <i class="fas fa-shopping-cart"></i> Order Management
                </a>
            </li>
            <li <c:if test="${request.servletPath == '/admin/categories'}">class="active"</c:if>>
                <a href="${pageContext.request.contextPath}/admin/categories">
                    <i class="fas fa-tags"></i> Categories
                </a>
            </li>
            <li <c:if test="${request.servletPath == '/admin/enrollments'}">class="active"</c:if>>
                <a href="${pageContext.request.contextPath}/admin/enrollments">
                  <i class="fas fa-user-graduate"></i> Enrollments
                </a>
            </li>
            <li <c:if test="${request.servletPath == '/admin/feedback'}">class="active"</c:if>>
                 <a href="${pageContext.request.contextPath}/admin/feedback">
                   <i class="fas fa-comments"></i> Feedback
                 </a>
            </li>
            <li <c:if test="${request.servletPath == '/admin/reports'}">class="active"</c:if>>
                <a href="${pageContext.request.contextPath}/admin/reports">
                    <i class="fas fa-chart-bar"></i> Reports
                </a>
            </li>
            <li <c:if test="${request.servletPath == '/admin/settings'}">class="active"</c:if>>
                <a href="${pageContext.request.contextPath}/admin/settings">
                    <i class="fas fa-cog"></i> Settings
                </a>
            </li>
        </ul>
    </nav>

    <div id="content">
        <!-- Top Navbar -->
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <div class="container-fluid">
                <a class="navbar-brand" href="#">Order Analytics Dashboard</a>
                <div class="navbar-nav ml-auto">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/orders">
                        <i class="fas fa-arrow-left"></i> Back to Orders
                    </a>
                </div>
            </div>
        </nav>

        <div class="container-fluid py-4">
            <c:if test="${not empty analytics}">
                <!-- Summary Cards -->
                <div class="row mb-4">
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card border-left-primary shadow h-100 py-2">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                            Total Orders</div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800">${analytics.totalOrders}</div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-shopping-cart fa-2x text-gray-300"></i>
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
                                            Total Revenue</div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800">
                                            $<fmt:formatNumber value="${analytics.totalRevenue}" pattern="#,##0.00"/>
                                        </div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-dollar-sign fa-2x text-gray-300"></i>
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
                                            Average Order Value</div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800">
                                            $<fmt:formatNumber value="${analytics.averageOrderValue}" pattern="#,##0.00"/>
                                        </div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-chart-line fa-2x text-gray-300"></i>
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
                                            Pending Orders</div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800">${analytics.pendingOrders}</div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-clock fa-2x text-gray-300"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Charts Row -->
                <div class="row">
                    <!-- Orders by Status Chart -->
                    <div class="col-xl-6 col-lg-6">
                        <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-primary">Orders by Status</h6>
                            </div>
                            <div class="card-body">
                                <canvas id="ordersByStatusChart"></canvas>
                            </div>
                        </div>
                    </div>

                    <!-- Revenue by Month Chart -->
                    <div class="col-xl-6 col-lg-6">
                        <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-primary">Revenue by Month</h6>
                            </div>
                            <div class="card-body">
                                <canvas id="revenueByMonthChart"></canvas>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Status Breakdown Table -->
                <div class="row">
                    <div class="col-12">
                        <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-primary">Order Status Breakdown</h6>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-bordered">
                                        <thead>
                                            <tr>
                                                <th>Status</th>
                                                <th>Count</th>
                                                <th>Percentage</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${analytics.ordersByStatus}" var="statusEntry">
                                                <tr>
                                                    <td>${statusEntry.key}</td>
                                                    <td>${statusEntry.value}</td>
                                                    <td>
                                                        <fmt:formatNumber value="${statusEntry.value / analytics.totalOrders * 100}" pattern="#0.0"/>%
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>

            <c:if test="${empty analytics}">
                <div class="alert alert-info text-center">
                    <h4>No Analytics Data Available</h4>
                    <p>There are no orders in the system to generate analytics.</p>
                </div>
            </c:if>
        </div>
    </div>
</div>

<script>
// Orders by Status Chart
const ordersByStatusCtx = document.getElementById('ordersByStatusChart').getContext('2d');
const ordersByStatusChart = new Chart(ordersByStatusCtx, {
    type: 'doughnut',
    data: {
        labels: [
            <c:forEach items="${analytics.ordersByStatus}" var="statusEntry" varStatus="loop">
                '${statusEntry.key}'<c:if test="${!loop.last}">,</c:if>
            </c:forEach>
        ],
        datasets: [{
            data: [
                <c:forEach items="${analytics.ordersByStatus}" var="statusEntry" varStatus="loop">
                    ${statusEntry.value}<c:if test="${!loop.last}">,</c:if>
                </c:forEach>
            ],
            backgroundColor: [
                '#4e73df',
                '#1cc88a',
                '#36b9cc',
                '#f6c23e',
                '#e74a3b'
            ]
        }]
    },
    options: {
        responsive: true,
        maintainAspectRatio: false
    }
});

// Revenue by Month Chart
const revenueByMonthCtx = document.getElementById('revenueByMonthChart').getContext('2d');
const revenueByMonthChart = new Chart(revenueByMonthCtx, {
    type: 'line',
    data: {
        labels: [
            <c:forEach items="${analytics.revenueByMonth}" var="monthEntry" varStatus="loop">
                '${monthEntry.key}'<c:if test="${!loop.last}">,</c:if>
            </c:forEach>
        ],
        datasets: [{
            label: 'Revenue ($)',
            data: [
                <c:forEach items="${analytics.revenueByMonth}" var="monthEntry" varStatus="loop">
                    ${monthEntry.value}<c:if test="${!loop.last}">,</c:if>
                </c:forEach>
            ],
            borderColor: '#4e73df',
            backgroundColor: 'rgba(78, 115, 223, 0.1)',
            tension: 0.1
        }]
    },
    options: {
        responsive: true,
        maintainAspectRatio: false,
        scales: {
            y: {
                beginAtZero: true
            }
        }
    }
});
</script>
</body>
</html> 