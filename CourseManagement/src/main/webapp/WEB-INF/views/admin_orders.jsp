<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order Management</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        /* Admin Sidebar Styles */
        .admin-sidebar {
            width: 280px;
            height: 100vh;
            position: fixed;
            left: 0;
            top: 0;
            padding: 20px;
            background: #2c3e50;
            color: white;
            transition: all 0.3s ease;
            z-index: 1000;
        }

        .sidebar-brand {
            padding: 15px 0;
            font-size: 1.4rem;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .nav-list {
            list-style: none;
            padding: 0;
            margin: 20px 0;
        }

        .nav-item {
            margin: 5px 0;
        }

        .nav-link {
            display: flex;
            align-items: center;
            padding: 12px 15px;
            color: #ecf0f1;
            text-decoration: none;
            border-radius: 5px;
            transition: all 0.3s ease;
            gap: 10px;
        }

        .nav-link:hover, .nav-link.active {
            background: #34495e;
            color: #fff;
        }

        .nav-section {
            margin: 20px 0 10px;
            padding: 0 15px;
            font-size: 0.8rem;
            text-transform: uppercase;
            color: #95a5a6;
        }

        /* Header Styles */
        .header {
            position: fixed;
            top: 0;
            right: 0;
            left: 280px;
            height: 70px;
            background: white;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            z-index: 100;
            padding: 0 20px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .navbar {
            background: white !important;
            padding: 15px 0;
        }

        .navbar-brand {
            font-size: 1.4rem;
            font-weight: 600;
            color: #2c3e50;
        }

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

        .btn-success {
            background: #28a745;
            color: white;
        }

        .btn-danger {
            background: #dc3545;
            color: white;
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

        .order-details {
            background: #f8f9fa;
            padding: 20px;
            margin-top: 10px;
            border-radius: 5px;
        }

        .order-details table {
            width: 100%;
            margin-top: 10px;
        }

        .order-details th,
        .order-details td {
            padding: 8px;
            text-align: left;
            border-bottom: 1px solid #ddd;
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
<c:set var="active" value="orders" scope="request"/>
<%@ include file="/WEB-INF/layout/header.jsp" %>
<%@ include file="_admin_sidebar.jsp" %>

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
<%--                <div class="stat-card">--%>
<%--                    <i class="fas fa-clock stat-icon" style="color: #f1c40f;"></i>--%>
<%--                    <div class="stat-value">${orderStats.pendingOrders}</div>--%>
<%--                    <div class="stat-label">Pending Orders</div>--%>
<%--                </div>--%>
                <div class="stat-card">
                    <i class="fas fa-dollar-sign stat-icon" style="color: #9b59b6;"></i>
                    <div class="stat-value">$<fmt:formatNumber value="${orderStats.totalRevenue}" pattern="#,##0.00"/></div>
                    <div class="stat-label">Total Revenue</div>
                </div>
            </div>

            <!-- Search and Filter -->
            <form method="GET" action="${pageContext.request.contextPath}/admin/orders" class="search-box">
                <input type="text" name="search" class="search-input" placeholder="Search orders..." value="${searchKeyword}">

            </form>

            <!-- Orders Table -->
            <div style="overflow-x: auto;">
                <table class="order-table">
                    <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Customer</th>
                        <th>Amount</th>
                        <th>Date</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${orders}" var="order">
                        <tr>
                            <td>#${order.orderId}</td>
                            <td>
                                <div>${order.customerName}</div>
                                <small style="color: #666;">${order.customerEmail}</small>
                            </td>
                            <td><fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="$"/></td>
                            <td><fmt:formatDate value="${order.createdAtDate}" pattern="MMM dd, yyyy"/></td>
                            <td>
                                    <span class="status-badge ${
                                        (order.status == 'paid' ? 'status-completed' : 'status-cancelled')}">
                                            ${order.status}
                                    </span>
                            </td>
                            <td>
                                <button onclick="toggleOrderDetails(${order.orderId})" class="action-btn btn-view">
                                    <i class="fas fa-eye"></i> View
                                </button>
                                <c:if test="${order.status == 'pending'}">
                                    <form action="${pageContext.request.contextPath}/admin/orders/update-status"
                                          method="POST" style="display:inline;">
                                        <input type="hidden" name="orderId" value="${order.orderId}">
                                        <input type="hidden" name="status" value="paid">
                                        <button type="submit" class="action-btn btn-success">
                                            <i class="fas fa-check"></i>
                                        </button>
                                    </form>
                                    <form action="${pageContext.request.contextPath}/admin/orders/update-status"
                                          method="POST" style="display:inline;">
                                        <input type="hidden" name="orderId" value="${order.orderId}">
                                        <input type="hidden" name="status" value="cancelled">
                                        <button type="submit" class="action-btn btn-danger">
                                            <i class="fas fa-times"></i>
                                        </button>
                                    </form>
                                </c:if>
                            </td>
                        </tr>
                        <!-- Order Details Row -->
                        <tr class="order-details-row" id="order-details-${order.orderId}" style="display: none;">
                            <td colspan="6">
                                <div class="order-details">
                                    <h4>Order Details</h4>
                                    <table>
                                        <thead>
                                        <tr>
                                            <th>Course</th>
                                            <th>Price</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${order.orderDetails}" var="detail">
                                            <tr>
                                                <td>${detail.courseTitle}</td>
                                                <td><fmt:formatNumber value="${detail.price}" type="currency" currencySymbol="$"/></td>
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

            <!-- Pagination -->
            <c:if test="${totalPages > 1}">
                <div style="margin-top: 20px; text-align: center;">
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <a href="${pageContext.request.contextPath}/admin/orders?page=${i}${not empty currentStatus ? '&status='.concat(currentStatus) : ''}${not empty searchKeyword ? '&search='.concat(searchKeyword) : ''}"
                           class="action-btn ${currentPage == i ? 'btn-view' : ''}" style="margin: 0 5px;">
                                ${i}
                        </a>
                    </c:forEach>
                </div>
            </c:if>
        </div>
    </div>
</div>

<script>
    function toggleOrderDetails(orderId) {
        const detailsRow = document.getElementById('order-details-' + orderId);
        const allDetailsRows = document.querySelectorAll('.order-details-row');

        // Hide all other detail rows
        allDetailsRows.forEach(row => {
            if (row.id !== 'order-details-' + orderId) {
                row.style.display = 'none';
            }
        });

        // Toggle current detail row
        if (detailsRow.style.display === 'none') {
            detailsRow.style.display = 'table-row';
        } else {
            detailsRow.style.display = 'none';
        }
    }

    // Handle filter dropdown change
    document.querySelector('select[name="status"]').addEventListener('change', function() {
        this.form.submit();
    });
</script>
</body>
</html>
