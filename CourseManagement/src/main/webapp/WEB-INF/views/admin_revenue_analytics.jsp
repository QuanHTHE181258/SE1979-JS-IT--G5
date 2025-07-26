<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Revenue Analytics - Admin</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>body { background: #f4f6fb; margin: 0; font-family: 'Segoe UI', Arial, sans-serif; }</style>
</head>
<body>
<c:set var="active" value="revenue" scope="request"/>
<%@ include file="/WEB-INF/views/layout/header.jsp" %>
<%@ include file="/WEB-INF/views/_admin_sidebar.jsp" %>
<!-- Main content -->
<div style="flex:1; display:flex; flex-direction:column;">
    <!-- Top Navbar -->
    <nav style="background:#fff; box-shadow:0 2px 8px rgba(44,44,84,0.04); padding:18px 48px; display:flex; align-items:center; justify-content:space-between;">
        <div style="font-size:1.4rem; font-weight:700; color:#2c2c54; letter-spacing:1px;">
            Revenue Analytics Dashboard
        </div>
        <div style="display:flex; align-items:center;">
            <a href="${pageContext.request.contextPath}/admin/orders" style="display:flex; align-items:center; color:#6a82fb; text-decoration:none; font-weight:600; font-size:1rem;">
                <i class="fas fa-arrow-left" style="margin-right:8px;"></i> Back to Orders
            </a>
        </div>
    </nav>
    <!-- Content -->
    <div style="flex:1; padding:48px 0; background:#f4f6fb;">
        <div style="max-width:1100px; margin:auto; padding:0 16px;">
            <c:if test="${not empty analytics}">
                <div style="display:flex; gap:24px; margin-bottom:32px; flex-wrap:wrap;">
                    <div style="flex:1; min-width:260px; background:#fff; border-radius:18px; box-shadow:0 2px 8px rgba(44,44,84,0.08); padding:32px; display:flex; flex-direction:column; align-items:flex-start;">
                        <div style="font-size:1.1rem; font-weight:700; color:#2c2c54; margin-bottom:8px;">Total Revenue</div>
                        <div style="font-size:2rem; font-weight:800; color:#6a82fb;">$<fmt:formatNumber value="${analytics.totalRevenue}" pattern="#,#00.00"/></div>
                    </div>
                    <div style="flex:1; min-width:260px; background:#fff; border-radius:18px; box-shadow:0 2px 8px rgba(44,44,84,0.08); padding:32px; display:flex; flex-direction:column; align-items:flex-start;">
                        <div style="font-size:1.1rem; font-weight:700; color:#2c2c54; margin-bottom:8px;">Average Order Value</div>
                        <div style="font-size:2rem; font-weight:800; color:#36b9cc;">$<fmt:formatNumber value="${analytics.averageOrderValue}" pattern="#,#00.00"/></div>
                    </div>
                </div>
                <div style="background:#fff; border-radius:18px; box-shadow:0 2px 8px rgba(44,44,84,0.08); padding:32px; margin-bottom:32px;">
                    <div style="font-size:1.15rem; font-weight:700; color:#2c2c54; margin-bottom:18px;">Revenue by Month</div>
                    <div style="height:320px;">
                        <canvas id="revenueByMonthChart" style="width:100%; height:100%;"></canvas>
                    </div>
                </div>
                <div style="background:#fff; border-radius:18px; box-shadow:0 2px 8px rgba(44,44,84,0.08); padding:32px; margin-bottom:32px;">
                    <div style="font-size:1.15rem; font-weight:700; color:#2c2c54; margin-bottom:18px;">Top 5 Courses by Revenue</div>
                    <div style="height:320px;">
                        <canvas id="topCoursesChart" style="width:100%; height:100%;"></canvas>
                    </div>
                </div>
                <div style="background:#fff; border-radius:18px; box-shadow:0 2px 8px rgba(44,44,84,0.08); padding:32px; margin-bottom:32px;">
                    <div style="font-size:1.15rem; font-weight:700; color:#2c2c54; margin-bottom:18px;">Revenue Details</div>
                    <div style="overflow-x:auto;">
                        <table style="width:100%; border-collapse:collapse; font-size:1rem;">
                            <thead>
                            <tr style="background:#f5f5fa; color:#2c2c54;">
                                <th style="padding:12px 8px; text-align:left; font-weight:700;">Order ID</th>
                                <th style="padding:12px 8px; text-align:left; font-weight:700;">Order Date</th>
                                <th style="padding:12px 8px; text-align:left; font-weight:700;">Status</th>
                                <th style="padding:12px 8px; text-align:left; font-weight:700;">Total Amount</th>
                                <th style="padding:12px 8px; text-align:left; font-weight:700;">Course Title</th>
                                <th style="padding:12px 8px; text-align:left; font-weight:700;">Course Price</th>
                                <th style="padding:12px 8px; text-align:left; font-weight:700;">Customer Name</th>
                                <th style="padding:12px 8px; text-align:left; font-weight:700;">Customer Email</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${revenueDetails}" var="detail">
                                <tr style="border-bottom:1px solid #e5e7eb;">
                                    <td style="padding:10px 8px;">${detail.orderId}</td>
                                    <td style="padding:10px 8px;"><fmt:formatDate value="${detail.orderDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                                    <td style="padding:10px 8px;">${detail.status}</td>
                                    <td style="padding:10px 8px;"><fmt:formatNumber value="${detail.totalAmount}" pattern="#,#00.00"/></td>
                                    <td style="padding:10px 8px;">${detail.courseTitle}</td>
                                    <td style="padding:10px 8px;"><fmt:formatNumber value="${detail.coursePrice}" pattern="#,#00.00"/></td>
                                    <td style="padding:10px 8px;">${detail.customerName}</td>
                                    <td style="padding:10px 8px;">${detail.customerEmail}</td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div style="background:#fff; border-radius:18px; box-shadow:0 2px 8px rgba(44,44,84,0.08); padding:32px; margin-bottom:32px;">
                    <div style="font-size:1.15rem; font-weight:700; color:#2c2c54; margin-bottom:18px;">Revenue by Day (Chart)</div>
                    <div style="height:320px;">
                        <canvas id="revenueByDayChart" style="width:100%; height:100%;"></canvas>
                    </div>
                </div>
                <div style="background:#fff; border-radius:18px; box-shadow:0 2px 8px rgba(44,44,84,0.08); padding:32px; margin-bottom:32px;">
                    <div style="font-size:1.15rem; font-weight:700; color:#2c2c54; margin-bottom:18px;">Revenue by Day</div>
                    <div style="overflow-x:auto;">
                        <table style="width:100%; border-collapse:collapse; font-size:1rem;">
                            <thead>
                            <tr style="background:#f5f5fa; color:#2c2c54;">
                                <th style="padding:12px 8px; text-align:left; font-weight:700;">Date</th>
                                <th style="padding:12px 8px; text-align:left; font-weight:700;">Revenue</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${revenueByDay}" var="item">
                                <tr style="border-bottom:1px solid #e5e7eb;">
                                    <td style="padding:10px 8px;">${item.date}</td>
                                    <td style="padding:10px 8px;"><fmt:formatNumber value="${item.revenue}" pattern="#,#00.00"/></td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div style="background:#fff; border-radius:18px; box-shadow:0 2px 8px rgba(44,44,84,0.08); padding:32px; margin-bottom:32px;">
                    <div style="font-size:1.15rem; font-weight:700; color:#2c2c54; margin-bottom:18px;">Revenue by Week (Chart)</div>
                    <div style="height:320px;">
                        <canvas id="revenueByWeekChart" style="width:100%; height:100%;"></canvas>
                    </div>
                </div>
                <div style="background:#fff; border-radius:18px; box-shadow:0 2px 8px rgba(44,44,84,0.08); padding:32px; margin-bottom:32px;">
                    <div style="font-size:1.15rem; font-weight:700; color:#2c2c54; margin-bottom:18px;">Revenue by Week</div>
                    <div style="overflow-x:auto;">
                        <table style="width:100%; border-collapse:collapse; font-size:1rem;">
                            <thead>
                            <tr style="background:#f5f5fa; color:#2c2c54;">
                                <th style="padding:12px 8px; text-align:left; font-weight:700;">Year</th>
                                <th style="padding:12px 8px; text-align:left; font-weight:700;">Week</th>
                                <th style="padding:12px 8px; text-align:left; font-weight:700;">Revenue</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${revenueByWeek}" var="item">
                                <tr style="border-bottom:1px solid #e5e7eb;">
                                    <td style="padding:10px 8px;">${item.year}</td>
                                    <td style="padding:10px 8px;">${item.week}</td>
                                    <td style="padding:10px 8px;"><fmt:formatNumber value="${item.revenue}" pattern="#,#00.00"/></td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div style="background:#fff; border-radius:18px; box-shadow:0 2px 8px rgba(44,44,84,0.08); padding:32px; margin-bottom:32px;">
                    <div style="font-size:1.15rem; font-weight:700; color:#2c2c54; margin-bottom:18px;">Revenue by Year (Chart)</div>
                    <div style="height:320px;">
                        <canvas id="revenueByYearChart" style="width:100%; height:100%;"></canvas>
                    </div>
                </div>
                <div style="background:#fff; border-radius:18px; box-shadow:0 2px 8px rgba(44,44,84,0.08); padding:32px; margin-bottom:32px;">
                    <div style="font-size:1.15rem; font-weight:700; color:#2c2c54; margin-bottom:18px;">Revenue by Year</div>
                    <div style="overflow-x:auto;">
                        <table style="width:100%; border-collapse:collapse; font-size:1rem;">
                            <thead>
                            <tr style="background:#f5f5fa; color:#2c2c54;">
                                <th style="padding:12px 8px; text-align:left; font-weight:700;">Year</th>
                                <th style="padding:12px 8px; text-align:left; font-weight:700;">Revenue</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${revenueByYear}" var="item">
                                <tr style="border-bottom:1px solid #e5e7eb;">
                                    <td style="padding:10px 8px;">${item.year}</td>
                                    <td style="padding:10px 8px;"><fmt:formatNumber value="${item.revenue}" pattern="#,#00.00"/></td>
                                </tr>
                            </c:forEach>
                            </tbody>
                    </div>
                </div>
            </c:if>
            <c:if test="${empty analytics}">
                <div style="background:#eaf1fb; color:#2c2c54; border-radius:10px; padding:32px 24px; margin-bottom:24px; font-size:1.2rem; text-align:center;">
                    <h4 style="margin:0 0 12px 0;">No Revenue Analytics Data Available</h4>
                    <p style="margin:0;">There are no orders in the system to generate revenue analytics.</p>
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
