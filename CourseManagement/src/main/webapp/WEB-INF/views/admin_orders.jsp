<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order Management</title>
    <link href="${pageContext.request.contextPath}/css/admincss.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-blue: #6a5acd; /* A shade of blue/purple inspired by the image */
            --light-blue: #8a7de8;
            --dark-blue: #4a3a9a;
            --text-light: #f8f9fa;
            --light-gray-background: #e9ecef; /* Changed background color */
        }

        body {
            background-color: var(--light-gray-background); /* Applied new background color */
        }

        .order-status {
            padding: 5px 10px;
            border-radius: 15px;
            font-size: 0.9em;
        }
        .status-pending {
            background-color: #fff3cd;
            color: #856404;
        }
        .status-paid {
            background-color: #d4edda;
            color: #155724;
        }
        .status-cancelled {
            background-color: #f8d7da;
            color: #721c24;
        }
        .order-details {
            display: none;
            background-color: #f8f9fa;
            padding: 15px;
            margin-top: 10px;
            border-radius: 5px;
        }

        /* Custom styles for the new look */
        .sidebar {
            background: linear-gradient(180deg, var(--primary-blue) 0%, var(--dark-blue) 100%);
            transition: all 0.3s ease-in-out;
            transform: translateX(0);
            position: fixed; /* Keep sidebar fixed */
            top: 0;
            left: 0;
            height: 100vh;
            z-index: 1000; /* Ensure sidebar is above other content */
        }

        .sidebar.collapsed {
            transform: translateX(-100%);
        }

        .sidebar .nav-link {
            color: var(--text-light) !important;
            padding: 15px 20px;
            transition: background-color 0.2s ease-in-out;
        }

        .sidebar .nav-link:hover,
        .sidebar .nav-link.active {
            background-color: var(--light-blue);
            border-radius: 5px;
            color: white !important;
        }

        .sidebar .nav-link.active {
            font-weight: bold;
        }

        .sidebar .nav-item {
            margin-bottom: 5px;
        }

        .main-content-wrapper {
            margin-left: 16.66666667%; /* Equivalent to col-md-2 */
            transition: all 0.3s ease-in-out;
        }

        .main-content-wrapper.collapsed {
            margin-left: 0;
            width: 100%; /* Take full width when sidebar is collapsed */
        }

        .navbar-toggler-custom {
            position: fixed;
            top: 15px;
            left: 15px;
            z-index: 1001;
            background-color: var(--primary-blue);
            border: none;
            padding: 8px 12px;
            border-radius: 5px;
            color: white;
            transition: left 0.3s ease-in-out;
        }

        .navbar-toggler-custom.shifted {
            left: calc(16.66666667% + 15px); /* Position when sidebar is open */
        }

        /* Adjustments for main content when sidebar is collapsed */
        @media (max-width: 767.98px) {
            .sidebar {
                transform: translateX(-100%);
            }
            .sidebar.show {
                transform: translateX(0);
            }
            .main-content-wrapper {
                margin-left: 0;
            }
            .navbar-toggler-custom {
                left: 15px;
            }
            .navbar-toggler-custom.shifted {
                left: calc(16.66666667% + 15px);
            }
        }

        /* Styles for the new sliding filter buttons */
        .filter-buttons-wrapper {
            display: flex;
            overflow: hidden; /* Hide overflow for slide effect */
            white-space: nowrap; /* Prevent wrapping */
        }

        .filter-button-item {
            transform: translateX(-100%); /* Start off-screen to the left */
            opacity: 0;
            transition: transform 0.5s ease-out, opacity 0.5s ease-out;
            margin-left: -1px; /* To prevent double borders when sliding in */
            border-top-left-radius: 0; /* Adjust border radius for slide effect */
            border-bottom-left-radius: 0;
        }

        .filter-button-item.show-filter {
            transform: translateX(0);
            opacity: 1;
            /* Adjust individual transition delays for staggered effect */
        }
        .filter-button-item:nth-child(1).show-filter { transition-delay: 0.1s; }
        .filter-button-item:nth-child(2).show-filter { transition-delay: 0.2s; }
        .filter-button-item:nth-child(3).show-filter { transition-delay: 0.3s; }

        /* Ensure the 'All' button looks right and triggers the toggle */
        #allFilterButton {
            border-top-right-radius: 0;
            border-bottom-right-radius: 0;
        }

        /* Specific styling for the 'All' button to remain active/distinct when expanded */
        #allFilterButton.active-toggle {
            background-color: #0d6efd; /* Bootstrap primary blue */
            color: white;
            border-color: #0d6efd;
        }

    </style>
</head>
<body>
<div class="wrapper">
    <nav id="sidebar" class="sidebar">
      <div class="sidebar-header">
        <h3>Admin Panel</h3>
      </div>
      <ul class="nav flex-column">
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/admin"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/admin/user-management"><i class="fas fa-users"></i> User Management</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/admin/courses"><i class="fas fa-book"></i> Courses Management</a>
        </li>
        <li class="nav-item">
          <a class="nav-link active" href="${pageContext.request.contextPath}/admin/orders"><i class="fas fa-shopping-cart"></i> Order Management</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/admin/revenue-analytics"><i class="fas fa-chart-bar"></i> Revenue Analytics</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/teacher-performance"><i class="fas fa-chart-line"></i> Teacher Performance</a>
        </li>
      </ul>
    </nav>
    <div id="content">
        <nav class="navbar navbar-expand-lg">
            <div class="container-fluid">
                <a class="navbar-brand" href="#">Order Management</a>
            </div>
        </nav>
        <div class="container-fluid py-4">
            <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                <h1 class="h2">Order Management</h1>
                <div class="btn-group" role="group">
                    <div class="btn-group" role="group">
                        <button type="button" class="btn btn-success dropdown-toggle" data-bs-toggle="dropdown">
                            <i class="fas fa-download"></i> Export
                        </button>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/orders/export?format=csv">
                                <i class="fas fa-file-csv"></i> Export to CSV
                            </a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/orders/export?format=excel">
                                <i class="fas fa-file-excel"></i> Export to Excel
                            </a></li>
                        </ul>
                    </div>
                </div>
            </div>

            <!-- Thêm thông tin tổng số bản ghi -->
            <div class="row mb-3">
                <div class="col-md-6">
                    <div class="alert alert-info">
                        <i class="fas fa-info-circle"></i>
                        Hiển thị ${orders.size()} trong tổng số ${totalOrders} bản ghi
                        <c:if test="${totalPages > 1}">
                            (Trang ${currentPage} / ${totalPages})
                        </c:if>
                    </div>
                </div>
            </div>

            <div class="row mb-4">
                <div class="col-md-6 mb-3">
                    <form action="${pageContext.request.contextPath}/admin/orders" method="GET" class="d-flex">
                        <input type="text" name="search" class="form-control me-2" placeholder="Search by ID, name, or email"
                               value="${searchKeyword}" aria-label="Search">
                        <button class="btn btn-outline-primary" type="submit">
                            <i class="fas fa-search"></i> Search
                        </button>
                        <c:if test="${not empty searchKeyword}">
                            <a href="${pageContext.request.contextPath}/admin/orders" class="btn btn-outline-secondary ms-2">
                                <i class="fas fa-times"></i> Clear
                            </a>
                        </c:if>
                    </form>
                </div>

                <div class="col-md-6">
                    <div class="btn-group" role="group">
                        <a href="${pageContext.request.contextPath}/admin/orders"
                           class="btn btn-primary ${currentStatus == null ? 'active-toggle' : ''}" id="allFilterButton">All</a>

                        <div class="filter-buttons-wrapper" id="statusFilterButtons">
                            <a href="${pageContext.request.contextPath}/admin/orders?status=pending"
                               class="btn btn-outline-warning filter-button-item ${currentStatus == 'pending' ? 'active' : ''}">Pending</a>
                            <a href="${pageContext.request.contextPath}/admin/orders?status=paid"
                               class="btn btn-outline-success filter-button-item ${currentStatus == 'paid' ? 'active' : ''}">Paid</a>
                            <a href="${pageContext.request.contextPath}/admin/orders?status=cancelled"
                               class="btn btn-outline-danger filter-button-item ${currentStatus == 'cancelled' ? 'active' : ''}">Cancelled</a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Customer</th>
                        <th>Email</th>
                        <th>Status</th>
                        <th>Payment Method</th>
                        <th>Total Amount</th>
                        <th>Created At</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${orders}" var="order">
                        <tr>
                            <td>${order.orderId}</td>
                            <td>${order.customerName}</td>
                            <td>${order.customerEmail}</td>
                            <td>
                                        <span class="order-status status-${order.status.toLowerCase()}">
                                                ${order.status}
                                        </span>
                            </td>
                            <td>${order.paymentMethod}</td>
                            <td>
                                <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="$"/>
                            </td>
                            <td>
                                <fmt:formatDate value="${order.createdAtDate}" pattern="yyyy-MM-dd HH:mm"/>
                            </td>
                            <td>
                                <button class="btn btn-sm btn-info" onclick="toggleOrderDetails(${order.orderId})">
                                    <i class="fas fa-eye"></i>
                                </button>
                                <c:if test="${order.status == 'pending'}">
                                    <form action="${pageContext.request.contextPath}/admin/orders/update-status"
                                          method="POST" style="display: inline;">
                                        <input type="hidden" name="orderId" value="${order.orderId}">
                                        <input type="hidden" name="status" value="paid">
                                        <button type="submit" class="btn btn-sm btn-success">
                                            <i class="fas fa-check"></i>
                                        </button>
                                    </form>
                                    <form action="${pageContext.request.contextPath}/admin/orders/update-status"
                                          method="POST" style="display: inline;">
                                        <input type="hidden" name="orderId" value="${order.orderId}">
                                        <input type="hidden" name="status" value="cancelled">
                                        <button type="submit" class="btn btn-sm btn-danger">
                                            <i class="fas fa-times"></i>
                                        </button>
                                    </form>
                                </c:if>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="8">
                                <div id="order-details-${order.orderId}" class="order-details">
                                    <h6>Order Details</h6>
                                    <table class="table table-sm">
                                        <thead>
                                        <tr>
                                            <th>Course</th>
                                            <th>Price</th>
                                            <th>Description</th>
                                            <th>Rating</th>
                                            <th>Status</th>
<%--                                            <th>Image</th>--%>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${order.orderDetails}" var="detail">
                                            <tr>
                                                <td>${detail.courseTitle}</td>
                                                <td>
                                                    <fmt:formatNumber value="${detail.price}"
                                                                      type="currency"
                                                                      currencySymbol="$"/>
                                                </td>
                                                <td>${detail.course.description}</td>
                                                <td>${detail.course.rating}</td>
                                                <td>${detail.course.status}</td>
                                                <td>
                                                    <c:if test="${not empty detail.course.imageUrl}">
                                                        <img src="${detail.course.imageUrl}" alt="Course Image" style="max-width:60px;max-height:40px;"/>
                                                    </c:if>
                                                </td>
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
            <nav aria-label="Page navigation" class="mt-4">
                <ul class="pagination justify-content-center">
                    <c:if test="${currentPage > 1}">
                        <li class="page-item">
                            <a class="page-link"
                               href="${pageContext.request.contextPath}/admin/orders?page=${currentPage - 1}${statusParam}${searchParam}">
                                Previous
                            </a>
                        </li>
                    </c:if>

                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                            <a class="page-link"
                               href="${pageContext.request.contextPath}/admin/orders?page=${i}${statusParam}${searchParam}">
                                    ${i}
                            </a>
                        </li>
                    </c:forEach>

                    <c:if test="${currentPage < totalPages}">
                        <li class="page-item">
                            <a class="page-link"
                               href="${pageContext.request.contextPath}/admin/orders?page=${currentPage + 1}${statusParam}${searchParam}">
                                Next
                            </a>
                        </li>
                    </c:if>
                </ul>
            </nav>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function toggleOrderDetails(orderId) {
        const detailsDiv = document.getElementById('order-details-' + orderId);
        if (detailsDiv.style.display === 'none' || detailsDiv.style.display === '') {
            detailsDiv.style.display = 'block';
        } else {
            detailsDiv.style.display = 'none';
        }
    }

    document.addEventListener('DOMContentLoaded', function() {
        const sidebar = document.getElementById('sidebar');
        const mainContentWrapper = document.getElementById('mainContentWrapper');
        const sidebarToggle = document.getElementById('sidebarToggle');

        // Initial state for larger screens: sidebar always visible
        if (window.innerWidth >= 768) {
            sidebar.classList.remove('collapsed');
            mainContentWrapper.classList.remove('collapsed');
        } else {
            // For smaller screens, sidebar starts collapsed
            sidebar.classList.add('collapsed');
            mainContentWrapper.classList.add('collapsed');
            sidebarToggle.classList.remove('shifted');
        }

        // Toggle sidebar for smaller screens
        sidebarToggle.addEventListener('click', function() {
            sidebar.classList.toggle('collapsed');
            // For smaller screens, main content doesn't shift, only sidebar appears
            if (window.innerWidth < 768) {
                sidebar.classList.toggle('show'); // Use 'show' class for mobile visibility
            } else {
                mainContentWrapper.classList.toggle('collapsed');
            }
            sidebarToggle.classList.toggle('shifted');
        });

        // Ensure proper state on window resize
        window.addEventListener('resize', function() {
            if (window.innerWidth >= 768) {
                sidebar.classList.remove('collapsed');
                sidebar.classList.remove('show'); // Remove mobile show class
                mainContentWrapper.classList.remove('collapsed');
                sidebarToggle.classList.remove('shifted');
            } else {
                // If resized to small screen, ensure sidebar is collapsed by default
                if (!sidebar.classList.contains('show')) { // Only collapse if not explicitly shown by toggle
                    sidebar.classList.add('collapsed');
                    mainContentWrapper.classList.add('collapsed');
                }
                sidebarToggle.classList.remove('shifted'); // Always reset toggle position for mobile
            }
        });

        // New functionality for status filter slide out
        const allFilterButton = document.getElementById('allFilterButton');
        const statusFilterButtons = document.querySelectorAll('#statusFilterButtons .filter-button-item');
        const currentStatus = '${currentStatus}'; // Get current status from JSP variable

        // Function to toggle filter buttons visibility
        function toggleStatusFilters(show) {
            statusFilterButtons.forEach((button, index) => {
                if (show) {
                    button.classList.add('show-filter');
                } else {
                    button.classList.remove('show-filter');
                }
            });
        }

        // Initial state: if a specific status is active, show the filters
        if (currentStatus && currentStatus !== 'null' && currentStatus !== '') {
            toggleStatusFilters(true);
            allFilterButton.classList.add('active-toggle'); // Keep 'All' button styled as active when others are shown
        } else {
            // Otherwise, hide them initially and set 'All' as active
            toggleStatusFilters(false);
            allFilterButton.classList.add('active-toggle');
        }

        allFilterButton.addEventListener('click', function(event) {
            // Prevent default navigation if not already active to toggle visibility
            if (!this.classList.contains('active-toggle')) {
                event.preventDefault(); // Only prevent default if we're just toggling view
            }

            const isShowing = statusFilterButtons[0].classList.contains('show-filter');
            toggleStatusFilters(!isShowing);
            this.classList.toggle('active-toggle', !isShowing); // Toggle the active styling

            // If we are showing filters and 'All' was not the current filter, then clicking 'All' should navigate to 'All'
            if (!isShowing && currentStatus !== null && currentStatus !== '') {
                window.location.href = this.href; // Navigate to All orders
            }
            // If filters are shown and 'All' is clicked again, we remain on 'All' view but hide filters
        });

        // If any of the specific status buttons are clicked, ensure the other buttons remain visible
        statusFilterButtons.forEach(button => {
            button.addEventListener('click', function() {
                toggleStatusFilters(true); // Keep filters visible when a specific status is selected
                allFilterButton.classList.add('active-toggle'); // Keep 'All' button styled as active
            });
        });

    });
</script>
</body>
</html>