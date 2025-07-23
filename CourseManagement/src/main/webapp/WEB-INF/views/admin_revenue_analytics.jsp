<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Revenue Analytics - Admin</title>
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
            <li><a href="${pageContext.request.contextPath}/admin"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/users"><i class="fas fa-users"></i> User Management</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/courses"><i class="fas fa-book"></i> Courses Management</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/orders"><i class="fas fa-shopping-cart"></i> Order Management</a></li>
            <li class="active"><a href="${pageContext.request.contextPath}/admin/revenue-analytics"><i class="fas fa-chart-bar"></i> Revenue Analytics</a></li>
        </ul>
    </nav>
    <div id="content">
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <div class="container-fluid">
                <a class="navbar-brand" href="#">Revenue Analytics Dashboard</a>
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
                                            Total Revenue</div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800">
                                            $<fmt:formatNumber value="${analytics.totalRevenue}" pattern="#,#00.00"/>
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
                                            $<fmt:formatNumber value="${analytics.averageOrderValue}" pattern="#,#00.00"/>
                                        </div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-chart-line fa-2x text-gray-300"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Revenue by Month Chart -->
                <div class="row">
                    <div class="col-12">
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

                <!-- Top 5 Courses by Revenue Chart -->
                <div class="row">
                    <div class="col-12">
                        <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-primary">Top 5 Courses by Revenue</h6>
                            </div>
                            <div class="card-body">
                                <canvas id="topCoursesChart"></canvas>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Revenue Details Table -->
                <div class="row">
                    <div class="col-12">
                        <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-primary">Revenue Details</h6>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-bordered">
                                        <thead>
                                        <tr>
                                            <th>Order ID</th>
                                            <th>Order Date</th>
                                            <th>Status</th>
                                            <th>Total Amount</th>
                                            <th>Course Title</th>
                                            <th>Course Price</th>
                                            <th>Customer Name</th>
                                            <th>Customer Email</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${revenueDetails}" var="detail">
                                            <tr>
                                                <td>${detail.orderId}</td>
                                                <td><fmt:formatDate value="${detail.orderDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                                                <td>${detail.status}</td>
                                                <td><fmt:formatNumber value="${detail.totalAmount}" pattern="#,#00.00"/></td>
                                                <td>${detail.courseTitle}</td>
                                                <td><fmt:formatNumber value="${detail.coursePrice}" pattern="#,#00.00"/></td>
                                                <td>${detail.customerName}</td>
                                                <td>${detail.customerEmail}</td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Revenue by Day Table -->
                <div class="row">
                    <div class="col-12">
                        <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-primary">Revenue by Day</h6>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-bordered">
                                        <thead>
                                        <tr>
                                            <th>Date</th>
                                            <th>Revenue</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${revenueByDay}" var="item">
                                            <tr>
                                                <td>${item.date}</td>
                                                <td><fmt:formatNumber value="${item.revenue}" pattern="#,#00.00"/></td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Revenue by Week Table -->
                <div class="row">
                    <div class="col-12">
                        <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-primary">Revenue by Week</h6>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-bordered">
                                        <thead>
                                        <tr>
                                            <th>Year</th>
                                            <th>Week</th>
                                            <th>Revenue</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${revenueByWeek}" var="item">
                                            <tr>
                                                <td>${item.year}</td>
                                                <td>${item.week}</td>
                                                <td><fmt:formatNumber value="${item.revenue}" pattern="#,#00.00"/></td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Revenue by Year Table -->
                <div class="row">
                    <div class="col-12">
                        <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-primary">Revenue by Year</h6>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-bordered">
                                        <thead>
                                        <tr>
                                            <th>Year</th>
                                            <th>Revenue</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${revenueByYear}" var="item">
                                            <tr>
                                                <td>${item.year}</td>
                                                <td><fmt:formatNumber value="${item.revenue}" pattern="#,#00.00"/></td>
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
                    <h4>No Revenue Analytics Data Available</h4>
                    <p>There are no orders in the system to generate revenue analytics.</p>
                </div>
            </c:if>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    // Revenue by Month Chart
    const revenueByMonthCanvas = document.getElementById('revenueByMonthChart');
    if (revenueByMonthCanvas) {
        const revenueByMonthCtx = revenueByMonthCanvas.getContext('2d');
        new Chart(revenueByMonthCtx, {
            type: 'line',
            data: {
                labels: [
                    <c:forEach items="${revenueByMonth}" var="item" varStatus="loop">
                    '${item.year}-${item.month}'<c:if test="${!loop.last}">,</c:if>
                    </c:forEach>
                ],
                datasets: [{
                    label: 'Revenue ($)',
                    data: [
                        <c:forEach items="${revenueByMonth}" var="item" varStatus="loop">
                        ${item.revenue}<c:if test="${!loop.last}">,</c:if>
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
                scales: { y: { beginAtZero: true } }
            }
        });
    }

    // Revenue by Day Chart
    const revenueByDayCanvas = document.getElementById('revenueByDayChart');
    if (revenueByDayCanvas) {
        const revenueByDayCtx = revenueByDayCanvas.getContext('2d');
        new Chart(revenueByDayCtx, {
            type: 'line',
            data: {
                labels: [
                    <c:forEach items="${revenueByDay}" var="item" varStatus="loop">
                    '${item.date}'<c:if test="${!loop.last}">,</c:if>
                    </c:forEach>
                ],
                datasets: [{
                    label: 'Revenue ($)',
                    data: [
                        <c:forEach items="${revenueByDay}" var="item" varStatus="loop">
                        ${item.revenue}<c:if test="${!loop.last}">,</c:if>
                        </c:forEach>
                    ],
                    borderColor: '#28a745',
                    backgroundColor: 'rgba(40, 167, 69, 0.1)',
                    tension: 0.1
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: { y: { beginAtZero: true } }
            }
        });
    }

    // Revenue by Week Chart
    const revenueByWeekCanvas = document.getElementById('revenueByWeekChart');
    if (revenueByWeekCanvas) {
        const revenueByWeekCtx = revenueByWeekCanvas.getContext('2d');
        new Chart(revenueByWeekCtx, {
            type: 'line',
            data: {
                labels: [
                    <c:forEach items="${revenueByWeek}" var="item" varStatus="loop">
                    '${item.year}-W${item.week}'<c:if test="${!loop.last}">,</c:if>
                    </c:forEach>
                ],
                datasets: [{
                    label: 'Revenue ($)',
                    data: [
                        <c:forEach items="${revenueByWeek}" var="item" varStatus="loop">
                        ${item.revenue}<c:if test="${!loop.last}">,</c:if>
                        </c:forEach>
                    ],
                    borderColor: '#ffc107',
                    backgroundColor: 'rgba(255, 193, 7, 0.1)',
                    tension: 0.1
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: { y: { beginAtZero: true } }
            }
        });
    }

    // Revenue by Year Chart
    const revenueByYearCanvas = document.getElementById('revenueByYearChart');
    if (revenueByYearCanvas) {
        const revenueByYearCtx = revenueByYearCanvas.getContext('2d');
        new Chart(revenueByYearCtx, {
            type: 'bar',
            data: {
                labels: [
                    <c:forEach items="${revenueByYear}" var="item" varStatus="loop">
                    '${item.year}'<c:if test="${!loop.last}">,</c:if>
                    </c:forEach>
                ],
                datasets: [{
                    label: 'Revenue ($)',
                    data: [
                        <c:forEach items="${revenueByYear}" var="item" varStatus="loop">
                        ${item.revenue}<c:if test="${!loop.last}">,</c:if>
                        </c:forEach>
                    ],
                    backgroundColor: '#dc3545'
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: { y: { beginAtZero: true } }
            }
        });
    }

    // Top 5 Courses by Revenue Chart
    (function() {
        // Tính toán dữ liệu top 5 khoá học doanh thu cao nhất từ revenueDetails
        const details = [
            <c:forEach items="${revenueDetails}" var="d" varStatus="loop">
            { title: '${d.courseTitle}', revenue: ${d.coursePrice != null ? d.coursePrice : 0} }<c:if test="${!loop.last}">,</c:if>
            </c:forEach>
        ];
        // Gom nhóm theo courseTitle
        const revenueMap = {};
        details.forEach(d => {
            if (!revenueMap[d.title]) revenueMap[d.title] = 0;
            revenueMap[d.title] += d.revenue;
        });
        // Chuyển thành mảng và sort
        const sorted = Object.entries(revenueMap).map(([title, revenue]) => ({ title, revenue })).sort((a, b) => b.revenue - a.revenue);
        const top5 = sorted.slice(0, 5);
        const ctx = document.getElementById('topCoursesChart').getContext('2d');
        new Chart(ctx, {
            type: 'bar',
            data: {
                labels: top5.map(e => e.title),
                datasets: [{
                    label: 'Revenue ($)',
                    data: top5.map(e => e.revenue),
                    backgroundColor: '#36b9cc'
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: { y: { beginAtZero: true } }
            }
        });
    })();
</script>
</body>
</html> 