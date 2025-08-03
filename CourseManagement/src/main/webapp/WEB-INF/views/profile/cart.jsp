<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/layout/header.jsp" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giỏ hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .cart-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 2rem 0;
            margin-bottom: 2rem;
        }

        .cart-card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            overflow: hidden;
        }

        .table th {
            background-color: #f8f9fa;
            border-bottom: 2px solid #dee2e6;
            font-weight: 600;
            color: #495057;
        }

        .course-title {
            font-weight: 600;
            color: #2c3e50;
        }

        .price {
            font-size: 1.1rem;
            font-weight: 600;
            color: #27ae60;
        }

        .btn-remove {
            background-color: #e74c3c;
            border: none;
            color: white;
            padding: 0.375rem 1rem;
            border-radius: 5px;
            transition: background-color 0.3s;
        }

        .btn-remove:hover {
            background-color: #c0392b;
            color: white;
        }

        .summary-card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            padding: 1.5rem;
            position: sticky;
            top: 20px;
        }

        .total-price {
            font-size: 1.5rem;
            font-weight: 700;
            color: #2c3e50;
        }

        .btn-checkout {
            background: linear-gradient(135deg, #27ae60 0%, #2ecc71 100%);
            border: none;
            color: white;
            padding: 12px 24px;
            font-weight: 600;
            border-radius: 8px;
            width: 100%;
            transition: transform 0.2s;
        }

        .btn-checkout:hover {
            transform: translateY(-2px);
            color: white;
        }

        .empty-cart {
            text-align: center;
            padding: 3rem;
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .empty-cart-icon {
            font-size: 4rem;
            color: #bdc3c7;
            margin-bottom: 1rem;
        }

        .btn-continue {
            background-color: #3498db;
            border: none;
            color: white;
            padding: 0.5rem 1.5rem;
            border-radius: 5px;
            text-decoration: none;
            display: inline-block;
            transition: background-color 0.3s;
        }

        .btn-continue:hover {
            background-color: #2980b9;
            color: white;
            text-decoration: none;
        }

        .debug-info {
            background-color: #fff3cd;
            border: 1px solid #ffeaa7;
            border-radius: 5px;
            padding: 10px;
            margin-bottom: 20px;
            font-size: 0.9rem;
        }

        /* Enhanced message styles */
        .alert-success {
            background-color: #d1edff;
            border-color: #bee5eb;
            color: #0c5460;
            border-left: 4px solid #17a2b8;
        }

        .alert-warning {
            background-color: #fff3cd;
            border-color: #ffeaa7;
            color: #856404;
            border-left: 4px solid #ffc107;
        }

        .alert-info {
            background-color: #e2f3ff;
            border-color: #b3e5fc;
            color: #0c5460;
            border-left: 4px solid #2196f3;
        }

        .alert-danger {
            background-color: #f8d7da;
            border-color: #f5c6cb;
            color: #721c24;
            border-left: 4px solid #dc3545;
        }

        .alert {
            border-radius: 8px;
            padding: 1rem 1.25rem;
            margin-bottom: 1.5rem;
            border: 1px solid transparent;
            animation: slideInDown 0.5s ease-out;
        }

        @keyframes slideInDown {
            from {
                transform: translate3d(0, -100%, 0);
                visibility: visible;
            }
            to {
                transform: translate3d(0, 0, 0);
            }
        }

        .alert-dismissible .btn-close {
            padding: 0.75rem 1.25rem;
        }

        @media (max-width: 768px) {
            .cart-header h1 {
                font-size: 1.8rem;
            }

            .table-responsive {
                font-size: 0.9rem;
            }

            .btn-remove {
                padding: 0.25rem 0.75rem;
                font-size: 0.875rem;
            }
        }
    </style>

    <script>
        // Auto dismiss alerts after 5 seconds
        document.addEventListener('DOMContentLoaded', function() {
            const alerts = document.querySelectorAll('.alert:not(.alert-permanent)');
            alerts.forEach(function(alert) {
                setTimeout(function() {
                    const bsAlert = new bootstrap.Alert(alert);
                    bsAlert.close();
                }, 5000);
            });
        });
    </script>
</head>
<body>

<!-- Header -->
<div class="cart-header">
    <div class="container">
        <div class="text-center">
            <h1><i class="bi bi-cart3 me-2"></i>Giỏ hàng của bạn</h1>
            <p class="mb-0">Xem lại và thanh toán các khóa học đã chọn</p>
        </div>
    </div>
</div>

<div class="container">

    <!-- Enhanced Messages -->
    <c:if test="${not empty sessionScope.message}">
        <c:choose>
            <c:when test="${sessionScope.messageType eq 'success'}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="bi bi-check-circle me-2"></i>
                        ${sessionScope.message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:when>
            <c:when test="${sessionScope.messageType eq 'warning'}">
                <div class="alert alert-warning alert-dismissible fade show" role="alert">
                    <i class="bi bi-exclamation-triangle me-2"></i>
                        ${sessionScope.message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:when>
            <c:when test="${sessionScope.messageType eq 'info'}">
                <div class="alert alert-info alert-dismissible fade show" role="alert">
                    <i class="bi bi-info-circle me-2"></i>
                        ${sessionScope.message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:when>
            <c:when test="${sessionScope.messageType eq 'error'}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="bi bi-exclamation-octagon me-2"></i>
                        ${sessionScope.message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:when>
            <c:otherwise>
                <div class="alert alert-info alert-dismissible fade show" role="alert">
                    <i class="bi bi-info-circle me-2"></i>
                        ${sessionScope.message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:otherwise>
        </c:choose>
        <!-- Clear message after displaying -->
        <c:remove var="message" scope="session"/>
        <c:remove var="messageType" scope="session"/>
    </c:if>

    <!-- Legacy message support -->
    <c:if test="${not empty message and empty sessionScope.message}">
        <div class="alert alert-warning alert-dismissible fade show" role="alert">
            <i class="bi bi-exclamation-triangle me-2"></i>
                ${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <c:choose>
        <c:when test="${not empty cartItems}">
            <div class="row">
                <div class="col-lg-8">
                    <!-- Bảng giỏ hàng -->
                    <div class="cart-card">
                        <div class="table-responsive">
                            <table class="table table-hover mb-0">
                                <thead>
                                <tr>
                                    <th width="5%">#</th>
                                    <th width="50%">Khóa học</th>
                                    <th width="20%">Giá</th>
                                    <th width="25%">Hành động</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${cartItems}" var="item" varStatus="status">
                                    <tr>
                                        <td class="align-middle text-center">
                                            <strong>${status.index + 1}</strong>
                                        </td>
                                        <td class="align-middle">
                                            <div class="course-title">${item.courseID.title}</div>
                                            <small class="text-muted">Course ID: ${item.courseID.id}</small>
                                        </td>
                                        <td class="align-middle">
                                            <span class="price">${item.price}</span>
                                        </td>
                                        <td class="align-middle">
                                            <form action="CartServlet" method="post" style="display: inline;"
                                                  onsubmit="return confirm('Bạn có chắc muốn xóa khóa học này?')">
                                                <input type="hidden" name="action" value="remove">
                                                <input type="hidden" name="courseId" value="${item.courseID.id}">
                                                <button type="submit" class="btn btn-remove btn-sm">
                                                    <i class="bi bi-trash me-1"></i>Xóa
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4">
                    <!-- Thẻ tổng kết -->
                    <div class="summary-card">
                        <h5 class="mb-3">
                            <i class="bi bi-calculator me-2"></i>Tổng kết đơn hàng
                        </h5>

                        <div class="d-flex justify-content-between mb-2">
                            <span>Số khóa học:</span>
                            <strong>${cartItems.size()}</strong>
                        </div>

                        <hr>

                        <div class="d-flex justify-content-between mb-3">
                            <span class="total-price">Tổng cộng:</span>
                            <span class="total-price">
                                    <c:choose>
                                        <c:when test="${not empty sessionScope.totalPrice}">
                                            ${sessionScope.totalPrice}
                                        </c:when>
                                        <c:otherwise>
                                            $0.00
                                        </c:otherwise>
                                    </c:choose>
                                </span>
                        </div>

                        <form action="CheckoutServlet" method="post">
                            <button type="submit" class="btn btn-checkout">
                                <i class="bi bi-credit-card me-2"></i>Thanh toán ngay
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </c:when>

        <c:otherwise>
            <!-- Giỏ hàng trống -->
            <div class="empty-cart">
                <i class="bi bi-cart-x empty-cart-icon"></i>
                <h3 class="mb-3">Giỏ hàng trống</h3>
                <p class="text-muted mb-4">
                    Hãy khám phá các khóa học tuyệt vời và thêm vào giỏ hàng của bạn!
                </p>
                <a href="course" class="btn btn-continue">
                    <i class="bi bi-book me-2"></i>Khám phá khóa học
                </a>
            </div>
        </c:otherwise>
    </c:choose>

    <!-- Nút quay lại -->
    <div class="text-center mt-4 mb-4">
        <a href="course" class="btn btn-continue">
            <i class="bi bi-arrow-left me-2"></i>Tiếp tục mua sắm
        </a>
    </div>
</div>

<!-- Chỉ Bootstrap JS cho modal và alert -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>