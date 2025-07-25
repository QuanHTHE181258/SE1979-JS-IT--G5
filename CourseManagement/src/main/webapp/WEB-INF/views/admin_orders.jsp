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
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
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
            margin-left: 280px;
            padding: 2rem;
        }

        .content-box {
            background: #fff;
            border-radius: 12px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
        }

        .stats-row {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: white;
            padding: 1.5rem;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-5px);
        }

        .stat-icon {
            font-size: 2rem;
            margin-bottom: 1rem;
            color: #4a90e2;
        }

        .stat-value {
            font-size: 1.5rem;
            font-weight: bold;
            color: #2c3e50;
        }

        .stat-label {
            color: #666;
            font-size: 0.9rem;
            margin-top: 0.5rem;
        }

        .order-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1rem;
        }

        .order-table th,
        .order-table td {
            padding: 1rem;
            text-align: left;
            border-bottom: 1px solid #e5e7eb;
        }

        .order-table th {
            background: #f8f9fa;
            font-weight: 600;
            color: #2c3e50;
        }

        .order-table tr:hover {
            background: #f8f9fa;
            transition: background 0.3s ease;
        }

        .status-badge {
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 500;
        }

        .status-pending {
            background: #fff3cd;
            color: #856404;
        }

        .status-completed {
            background: #d4edda;
            color: #155724;
        }

        .status-cancelled {
            background: #f8d7da;
            color: #721c24;
        }

        .action-btn {
            padding: 0.5rem 1rem;
            border-radius: 5px;
            border: none;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
            font-size: 0.9rem;
        }

        .btn-view {
            background: #4a90e2;
            color: white;
        }

        .btn-view:hover {
            background: #357abd;
            transform: translateY(-2px);
        }

        .search-box {
            margin-bottom: 2rem;
            display: flex;
            gap: 1rem;
            align-items: center;
        }

        .search-input {
            flex: 1;
            padding: 0.75rem 1rem;
            border: 1px solid #e5e7eb;
            border-radius: 5px;
            font-size: 0.9rem;
        }

        .search-input:focus {
            outline: none;
            border-color: #4a90e2;
            box-shadow: 0 0 0 2px rgba(74, 144, 226, 0.2);
        }

        .filter-dropdown {
            padding: 0.75rem 1rem;
            border: 1px solid #e5e7eb;
            border-radius: 5px;
            background: white;
            cursor: pointer;
        }

        @media (max-width: 768px) {
            .main-content {
                margin-left: 0;
                padding: 1rem;
            }

            .stats-row {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <!-- Include admin sidebar -->
    <jsp:include page="_admin_sidebar.jsp" />

    <div class="wrapper">
        <div class="main-content">
            <div class="content-box">
                <h2 style="margin-bottom: 2rem">Order Management</h2>

                <!-- Stats Row -->
                <div class="stats-row">
                    <div class="stat-card">
                        <i class="fas fa-shopping-cart stat-icon"></i>
                        <div class="stat-value">${orderStats.totalOrders}</div>
                        <div class="stat-label">Total Orders</div>
                    </div>
                    <div class="stat-card">
                        <i class="fas fa-check-circle stat-icon" style="color: #2ecc71;"></i>
                        <div class="stat-value">${orderStats.completedOrders}</div>
                        <div class="stat-label">Completed Orders</div>
                    </div>
                    <div class="stat-card">
                        <i class="fas fa-clock stat-icon" style="color: #f1c40f;"></i>
                        <div class="stat-value">${orderStats.pendingOrders}</div>
                        <div class="stat-label">Pending Orders</div>
                    </div>
                    <div class="stat-card">
                        <i class="fas fa-dollar-sign stat-icon" style="color: #9b59b6;"></i>
                        <div class="stat-value">$${orderStats.totalRevenue}</div>
                        <div class="stat-label">Total Revenue</div>
                    </div>
                </div>

                <!-- Search and Filter -->
                <div class="search-box">
                    <input type="text" class="search-input" placeholder="Search orders...">
                    <select class="filter-dropdown">
                        <option value="all">All Status</option>
                        <option value="pending">Pending</option>
                        <option value="completed">Completed</option>
                        <option value="cancelled">Cancelled</option>
                    </select>
                </div>

                <!-- Orders Table -->
                <div style="overflow-x: auto;">
                    <table class="order-table">
                        <thead>
                            <tr>
                                <th>Order ID</th>
                                <th>Customer</th>
                                <th>Course</th>
                                <th>Date</th>
                                <th>Amount</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
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