<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order Management</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body { background: #f4f6fb; margin: 0; font-family: 'Segoe UI', Arial, sans-serif; }
    </style>
</head>
<body>
<div style="display:flex; min-height:100vh;">
    <%-- Sidebar và topbar giữ nguyên như đã đồng bộ --%>
    <c:set var="dashboardStyle" value="color:#fff; text-decoration:none; display:flex; align-items:center; padding:14px 32px;" />
    <c:set var="userStyle" value="color:#fff; text-decoration:none; display:flex; align-items:center; padding:14px 32px;" />
    <c:set var="coursesStyle" value="color:#fff; text-decoration:none; display:flex; align-items:center; padding:14px 32px;" />
    <c:set var="ordersStyle" value="color:#fff; text-decoration:none; display:flex; align-items:center; padding:14px 32px;" />
    <c:set var="revenueStyle" value="color:#fff; text-decoration:none; display:flex; align-items:center; padding:14px 32px;" />
    <c:set var="teacherStyle" value="color:#fff; text-decoration:none; display:flex; align-items:center; padding:14px 32px;" />
    <c:if test='${request.servletPath == "/admin"}'>
        <c:set var="dashboardStyle" value="color:#fff; text-decoration:none; display:flex; align-items:center; padding:14px 32px; border-left:5px solid #6a82fb; background:#23272b; font-weight:500;" />
    </c:if>
    <c:if test='${request.servletPath == "/admin/user-management"}'>
        <c:set var="userStyle" value="color:#fff; text-decoration:none; display:flex; align-items:center; padding:14px 32px; border-left:5px solid #6a82fb; background:#23272b; font-weight:500;" />
    </c:if>
    <c:if test='${request.servletPath == "/admin/courses"}'>
        <c:set var="coursesStyle" value="color:#fff; text-decoration:none; display:flex; align-items:center; padding:14px 32px; border-left:5px solid #6a82fb; background:#23272b; font-weight:500;" />
    </c:if>
    <c:if test='${request.servletPath == "/admin/orders"}'>
        <c:set var="ordersStyle" value="color:#fff; text-decoration:none; display:flex; align-items:center; padding:14px 32px; border-left:5px solid #6a82fb; background:#23272b; font-weight:500;" />
    </c:if>
    <c:if test='${request.servletPath == "/admin/revenue-analytics"}'>
        <c:set var="revenueStyle" value="color:#fff; text-decoration:none; display:flex; align-items:center; padding:14px 32px; border-left:5px solid #6a82fb; background:#23272b; font-weight:500;" />
    </c:if>
    <c:if test='${request.servletPath == "/teacher-performance"}'>
        <c:set var="teacherStyle" value="color:#fff; text-decoration:none; display:flex; align-items:center; padding:14px 32px; border-left:5px solid #6a82fb; background:#23272b; font-weight:500;" />
    </c:if>
    <nav style="width:250px; background:#343a40; color:#fff; min-height:100vh; display:flex; flex-direction:column;">
        <div style="padding:32px 0 24px 32px;">
            <h3 style="margin:0; font-size:1.7rem; font-weight:700; letter-spacing:1px;">Admin Panel</h3>
        </div>
        <ul style="list-style:none; padding:0; margin:0; flex:1;">
            <li><a href="${pageContext.request.contextPath}/admin" style="${dashboardStyle}"><i class="fas fa-tachometer-alt" style="margin-right:14px;"></i> Dashboard</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/user-management" style="${userStyle}"><i class="fas fa-users" style="margin-right:14px;"></i> User Management</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/courses" style="${coursesStyle}"><i class="fas fa-book" style="margin-right:14px;"></i> Courses Management</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/orders" style="${ordersStyle}"><i class="fas fa-shopping-cart" style="margin-right:14px;"></i> Order Management</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/revenue-analytics" style="${revenueStyle}"><i class="fas fa-chart-bar" style="margin-right:14px;"></i> Revenue Analytics</a></li>
            <li><a href="${pageContext.request.contextPath}/teacher-performance" style="${teacherStyle}"><i class="fas fa-chart-line" style="margin-right:14px;"></i> Teacher Performance</a></li>
            <li><a href="${pageContext.request.contextPath}/logout" style="color:#fff; text-decoration:none; display:flex; align-items:center; padding:14px 32px; font-weight:500;"><i class="fas fa-sign-out-alt" style="margin-right:14px;"></i> Logout</a></li>
        </ul>
    </nav>
    <!-- Main content -->
    <div style="flex:1; display:flex; flex-direction:column;">
        <!-- Top Navbar -->
        <nav style="background:#fff; box-shadow:0 2px 8px rgba(44,44,84,0.04); padding:18px 48px; display:flex; align-items:center; justify-content:space-between;">
            <div style="font-size:1.4rem; font-weight:700; color:#2c2c54; letter-spacing:1px;">
                Order Management
            </div>
            <div style="display:flex; align-items:center;">
                <a href="${pageContext.request.contextPath}/admin/profile" style="display:flex; align-items:center; color:#2c2c54; text-decoration:none; margin-right:24px;">
                    <c:choose>
                        <c:when test="${not empty sessionScope.user.avatar.url}">
                            <img src="${pageContext.request.contextPath}/assets/avatar/${sessionScope.user.avatar.url}" style="border-radius:50%; width:36px; height:36px; object-fit:cover;"/>
                        </c:when>
                        <c:otherwise>
                            <img src="${pageContext.request.contextPath}/assets/avatar/default_avatar.png" style="border-radius:50%; width:36px; height:36px; object-fit:cover;"/>
                        </c:otherwise>
                    </c:choose>
                    <span style="margin-left:12px; font-weight:600; font-size:1.1rem;">${sessionScope.user.username}</span>
                </a>
                <a href="${pageContext.request.contextPath}/logout" style="color:#dc3545; border:1.5px solid #dc3545; border-radius:7px; padding:7px 18px; text-decoration:none; font-weight:600; font-size:1rem;">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </a>
            </div>
        </nav>
        <!-- Content -->
        <div style="flex:1; padding:48px 0; background:#f4f6fb;">
            <div style="max-width:1100px; margin:auto; padding:0 16px;">
                <div style="background:#eaf1fb; color:#2c2c54; border-radius:10px; padding:16px 24px; margin-bottom:24px; font-size:1rem; display:flex; align-items:center;">
                    <i class="fas fa-info-circle" style="margin-right:10px;"></i>
                    Hiển thị ${orders.size()} trong tổng số ${totalOrders} bản ghi
                    <c:if test="${totalPages > 1}">
                        (Trang ${currentPage} / ${totalPages})
                    </c:if>
                </div>
                <div style="display:flex; flex-wrap:wrap; justify-content:space-between; align-items:center; margin-bottom:24px; gap:16px;">
                    <div style="flex:1; min-width:260px;">
                        <form action="${pageContext.request.contextPath}/admin/orders" method="GET" style="display:flex; gap:8px; align-items:center;">
                            <input type="text" name="search" placeholder="Search by ID, name, or email" value="${searchKeyword}" aria-label="Search" style="flex:1; padding:10px 14px; border-radius:8px; border:1px solid #d1d5db; font-size:1rem;">
                            <button type="submit" style="background:#6a82fb; color:#fff; border:none; border-radius:8px; padding:10px 20px; font-weight:600; cursor:pointer; font-size:1rem;">
                                <i class="fas fa-search"></i> Search
                            </button>
                            <c:if test="${not empty searchKeyword}">
                                <a href="${pageContext.request.contextPath}/admin/orders" style="background:#fff; color:#6a82fb; border:1.5px solid #6a82fb; border-radius:8px; padding:10px 20px; font-weight:600; text-decoration:none; margin-left:4px; font-size:1rem;"> <i class="fas fa-times"></i> Clear</a>
                            </c:if>
                        </form>
                    </div>
                    <div style="display:flex; gap:8px; align-items:center;">
                        <a href="${pageContext.request.contextPath}/admin/orders/export?format=csv" style="background:#fff; color:#6a82fb; border:1.5px solid #6a82fb; border-radius:8px; padding:10px 20px; font-weight:600; text-decoration:none; font-size:1rem;">
                            <i class="fas fa-file-csv"></i> Export to CSV
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/orders/export?format=excel" style="background:#fff; color:#6a82fb; border:1.5px solid #6a82fb; border-radius:8px; padding:10px 20px; font-weight:600; text-decoration:none; font-size:1rem;">
                            <i class="fas fa-file-excel"></i> Export to Excel
                        </a>
                    </div>
                </div>
                <div style="margin-bottom:24px;">
                    <a href="${pageContext.request.contextPath}/admin/orders" style="color:${currentStatus == null ? '#fff' : '#6a82fb'}; background:${currentStatus == null ? '#6a82fb' : '#fff'}; border:1.5px solid #6a82fb; border-radius:8px 0 0 8px; padding:8px 18px; font-weight:600; text-decoration:none; font-size:1rem;">All</a>
                    <a href="${pageContext.request.contextPath}/admin/orders?status=pending" style="color:${currentStatus == 'pending' ? '#fff' : '#f59e42'}; background:${currentStatus == 'pending' ? '#f59e42' : '#fff'}; border:1.5px solid #f59e42; border-radius:0; padding:8px 18px; font-weight:600; text-decoration:none; font-size:1rem;">Pending</a>
                    <a href="${pageContext.request.contextPath}/admin/orders?status=paid" style="color:${currentStatus == 'paid' ? '#fff' : '#22c55e'}; background:${currentStatus == 'paid' ? '#22c55e' : '#fff'}; border:1.5px solid #22c55e; border-radius:0; padding:8px 18px; font-weight:600; text-decoration:none; font-size:1rem;">Paid</a>
                    <a href="${pageContext.request.contextPath}/admin/orders?status=cancelled" style="color:${currentStatus == 'cancelled' ? '#fff' : '#ef4444'}; background:${currentStatus == 'cancelled' ? '#ef4444' : '#fff'}; border:1.5px solid #ef4444; border-radius:0 8px 8px 0; padding:8px 18px; font-weight:600; text-decoration:none; font-size:1rem;">Cancelled</a>
                </div>
                <div style="overflow-x:auto; background:#fff; border-radius:16px; box-shadow:0 2px 8px rgba(44,44,84,0.08);">
                    <table style="width:100%; border-collapse:collapse; font-size:1rem;">
                        <thead>
                        <tr style="background:#f5f5fa; color:#2c2c54;">
                            <th style="padding:14px 8px; text-align:left; font-weight:700;">Order ID</th>
                            <th style="padding:14px 8px; text-align:left; font-weight:700;">Customer</th>
                            <th style="padding:14px 8px; text-align:left; font-weight:700;">Email</th>
                            <th style="padding:14px 8px; text-align:left; font-weight:700;">Status</th>
                            <th style="padding:14px 8px; text-align:left; font-weight:700;">Payment Method</th>
                            <th style="padding:14px 8px; text-align:left; font-weight:700;">Total Amount</th>
                            <th style="padding:14px 8px; text-align:left; font-weight:700;">Created At</th>
                            <th style="padding:14px 8px; text-align:left; font-weight:700;">Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${orders}" var="order">
                            <tr style="border-bottom:1px solid #e5e7eb;">
                                <td style="padding:12px 8px;">${order.orderId}</td>
                                <td style="padding:12px 8px;">${order.customerName}</td>
                                <td style="padding:12px 8px;">${order.customerEmail}</td>
                                <td style="padding:12px 8px;">
                                    <span style="display:inline-block; padding:5px 14px; border-radius:15px; font-size:0.98em;
                                        background:${order.status == 'pending' ? '#fff3cd' : (order.status == 'paid' ? '#d4edda' : '#f8d7da')};
                                        color:${order.status == 'pending' ? '#856404' : (order.status == 'paid' ? '#155724' : '#721c24')};">
                                        ${order.status}
                                    </span>
                                </td>
                                <td style="padding:12px 8px;">${order.paymentMethod}</td>
                                <td style="padding:12px 8px;"><fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="$"/></td>
                                <td style="padding:12px 8px;"><fmt:formatDate value="${order.createdAtDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                                <td style="padding:12px 8px;">
                                    <button onclick="toggleOrderDetails(${order.orderId})" style="background:#6a82fb; color:#fff; border:none; border-radius:7px; padding:7px 14px; font-size:1rem; cursor:pointer;">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                    <c:if test="${order.status == 'pending'}">
                                        <form action="${pageContext.request.contextPath}/admin/orders/update-status" method="POST" style="display:inline;">
                                            <input type="hidden" name="orderId" value="${order.orderId}">
                                            <input type="hidden" name="status" value="paid">
                                            <button type="submit" style="background:#22c55e; color:#fff; border:none; border-radius:7px; padding:7px 14px; font-size:1rem; cursor:pointer; margin-left:4px;">
                                                <i class="fas fa-check"></i>
                                            </button>
                                        </form>
                                        <form action="${pageContext.request.contextPath}/admin/orders/update-status" method="POST" style="display:inline;">
                                            <input type="hidden" name="orderId" value="${order.orderId}">
                                            <input type="hidden" name="status" value="cancelled">
                                            <button type="submit" style="background:#ef4444; color:#fff; border:none; border-radius:7px; padding:7px 14px; font-size:1rem; cursor:pointer; margin-left:4px;">
                                                <i class="fas fa-times"></i>
                                            </button>
                                        </form>
                                    </c:if>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="8" style="padding:0; background:#f8f9fc;">
                                    <div id="order-details-${order.orderId}" style="display:none; background:#f8f9fa; padding:18px 24px; margin:0; border-radius:0 0 12px 12px;">
                                        <div style="font-weight:700; color:#2c2c54; margin-bottom:8px;">Order Details</div>
                                        <table style="width:100%; border-collapse:collapse; font-size:0.98rem;">
                                            <thead>
                                            <tr style="background:#f5f5fa; color:#2c2c54;">
                                                <th style="padding:8px 6px; text-align:left; font-weight:700;">Course</th>
                                                <th style="padding:8px 6px; text-align:left; font-weight:700;">Price</th>
                                                <th style="padding:8px 6px; text-align:left; font-weight:700;">Description</th>
                                                <th style="padding:8px 6px; text-align:left; font-weight:700;">Rating</th>
                                                <th style="padding:8px 6px; text-align:left; font-weight:700;">Status</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <c:forEach items="${order.orderDetails}" var="detail">
                                                <tr style="border-bottom:1px solid #e5e7eb;">
                                                    <td style="padding:8px 6px;">${detail.courseTitle}</td>
                                                    <td style="padding:8px 6px;"><fmt:formatNumber value="${detail.price}" type="currency" currencySymbol="$"/></td>
                                                    <td style="padding:8px 6px;">${detail.course.description}</td>
                                                    <td style="padding:8px 6px;">${detail.course.rating}</td>
                                                    <td style="padding:8px 6px;">${detail.course.status}</td>
                                                </tr>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
                <c:set var="statusParam" value="${not empty currentStatus ? '&status=' : ''}${not empty currentStatus ? currentStatus : ''}" />
                <c:set var="searchParam" value="${not empty searchKeyword ? '&search=' : ''}${not empty searchKeyword ? searchKeyword : ''}" />
                <div style="margin-top:32px; display:flex; justify-content:center; gap:8px;">
                    <c:if test="${currentPage > 1}">
                        <a href="${pageContext.request.contextPath}/admin/orders?page=${currentPage - 1}${statusParam}${searchParam}" style="background:#fff; color:#6a82fb; border:1.5px solid #6a82fb; border-radius:8px; padding:8px 18px; font-weight:600; text-decoration:none; font-size:1rem;">Previous</a>
                    </c:if>
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <a href="${pageContext.request.contextPath}/admin/orders?page=${i}${statusParam}${searchParam}" style="background:${currentPage == i ? '#6a82fb' : '#fff'}; color:${currentPage == i ? '#fff' : '#6a82fb'}; border:1.5px solid #6a82fb; border-radius:8px; padding:8px 18px; font-weight:600; text-decoration:none; font-size:1rem;">${i}</a>
                    </c:forEach>
                    <c:if test="${currentPage < totalPages}">
                        <a href="${pageContext.request.contextPath}/admin/orders?page=${currentPage + 1}${statusParam}${searchParam}" style="background:#fff; color:#6a82fb; border:1.5px solid #6a82fb; border-radius:8px; padding:8px 18px; font-weight:600; text-decoration:none; font-size:1rem;">Next</a>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    function toggleOrderDetails(orderId) {
        const detailsDiv = document.getElementById('order-details-' + orderId);
        if (detailsDiv.style.display === 'none' || detailsDiv.style.display === '') {
            detailsDiv.style.display = 'block';
        } else {
            detailsDiv.style.display = 'none';
        }
    }
</script>
</body>
</html>