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
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --success-gradient: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
            --danger-gradient: linear-gradient(135deg, #fc466b 0%, #3f5efb 100%);
            --warning-gradient: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            --card-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
            --border-radius: 16px;
        }

        * {
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            padding: 0;
            margin: 0;
        }

        .main-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem 1rem;
        }

        .page-header {
            text-align: center;
            margin-bottom: 3rem;
            position: relative;
        }

        .page-title {
            font-size: 3rem;
            font-weight: 700;
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 0.5rem;
            text-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }

        .page-subtitle {
            color: #64748b;
            font-size: 1.1rem;
            font-weight: 400;
        }

        .alert-modern {
            border: none;
            border-radius: var(--border-radius);
            box-shadow: var(--card-shadow);
            backdrop-filter: blur(10px);
            animation: slideInDown 0.5s ease-out;
        }

        @keyframes slideInDown {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .cart-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: var(--border-radius);
            box-shadow: var(--card-shadow);
            overflow: hidden;
            animation: fadeInUp 0.6s ease-out;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .table-modern {
            margin: 0;
            background: transparent;
        }

        .table-modern thead th {
            background: var(--primary-gradient);
            color: white;
            border: none;
            padding: 1.5rem 1rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-size: 0.9rem;
        }

        .table-modern tbody tr {
            border: none;
            transition: all 0.3s ease;
        }

        .table-modern tbody tr:hover {
            background: rgba(102, 126, 234, 0.05);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        .table-modern td {
            padding: 1.5rem 1rem;
            border: none;
            border-bottom: 1px solid rgba(0,0,0,0.05);
            vertical-align: middle;
        }

        .course-title {
            font-weight: 600;
            color: #1e293b;
            font-size: 1.1rem;
        }

        .price-tag {
            font-size: 1.25rem;
            font-weight: 700;
            background: var(--success-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .btn-modern {
            border: none;
            border-radius: 12px;
            padding: 0.75rem 1.5rem;
            font-weight: 600;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            position: relative;
            overflow: hidden;
            transition: all 0.3s ease;
        }

        .btn-modern::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: left 0.5s;
        }

        .btn-modern:hover::before {
            left: 100%;
        }

        .btn-danger-modern {
            background: var(--danger-gradient);
            color: white;
        }

        .btn-danger-modern:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(252, 70, 107, 0.3);
            color: white;
        }

        .btn-warning-modern {
            background: var(--warning-gradient);
            color: white;
        }

        .btn-warning-modern:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(240, 147, 251, 0.3);
            color: white;
        }

        .btn-success-modern {
            background: var(--success-gradient);
            color: white;
            padding: 1rem 2rem;
            font-size: 1.1rem;
        }

        .btn-success-modern:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 30px rgba(17, 153, 142, 0.4);
            color: white;
        }

        .btn-secondary-modern {
            background: linear-gradient(135deg, #74b9ff 0%, #0984e3 100%);
            color: white;
            border: none;
        }

        .btn-secondary-modern:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(116, 185, 255, 0.3);
            color: white;
        }

        .summary-card {
            background: var(--primary-gradient);
            color: white;
            border-radius: var(--border-radius);
            padding: 2rem;
            box-shadow: var(--card-shadow);
            position: sticky;
            top: 2rem;
        }

        .total-amount {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 1rem;
        }

        .empty-cart {
            text-align: center;
            padding: 4rem 2rem;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: var(--border-radius);
            box-shadow: var(--card-shadow);
            animation: fadeInScale 0.8s ease-out;
        }

        @keyframes fadeInScale {
            from {
                opacity: 0;
                transform: scale(0.9);
            }
            to {
                opacity: 1;
                transform: scale(1);
            }
        }

        .empty-cart-icon {
            font-size: 6rem;
            background: linear-gradient(135deg, #a8edea 0%, #fed6e3 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 2rem;
            animation: bounce 2s infinite;
        }

        @keyframes bounce {
            0%, 20%, 50%, 80%, 100% {
                transform: translateY(0);
            }
            40% {
                transform: translateY(-10px);
            }
            60% {
                transform: translateY(-5px);
            }
        }

        .action-buttons {
            display: flex;
            gap: 0.75rem;
            justify-content: center;
            flex-wrap: wrap;
        }

        .cart-item {
            animation: slideInLeft 0.5s ease-out;
            animation-fill-mode: both;
        }

        .cart-item:nth-child(1) { animation-delay: 0.1s; }
        .cart-item:nth-child(2) { animation-delay: 0.2s; }
        .cart-item:nth-child(3) { animation-delay: 0.3s; }
        .cart-item:nth-child(4) { animation-delay: 0.4s; }
        .cart-item:nth-child(5) { animation-delay: 0.5s; }

        @keyframes slideInLeft {
            from {
                opacity: 0;
                transform: translateX(-50px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        .floating-checkout {
            position: fixed;
            bottom: 2rem;
            right: 2rem;
            z-index: 1000;
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0% {
                box-shadow: 0 0 0 0 rgba(17, 153, 142, 0.7);
            }
            70% {
                box-shadow: 0 0 0 10px rgba(17, 153, 142, 0);
            }
            100% {
                box-shadow: 0 0 0 0 rgba(17, 153, 142, 0);
            }
        }

        @media (max-width: 768px) {
            .page-title {
                font-size: 2rem;
            }

            .table-responsive {
                border-radius: var(--border-radius);
            }

            .action-buttons {
                flex-direction: column;
            }

            .btn-modern {
                width: 100%;
                margin-bottom: 0.5rem;
            }

            .floating-checkout {
                position: static;
                margin-top: 2rem;
                width: 100%;
            }
        }

        .loading-spinner {
            display: none;
            width: 20px;
            height: 20px;
            border: 2px solid #ffffff;
            border-top: 2px solid transparent;
            border-radius: 50%;
            animation: spin 1s linear infinite;
            margin-right: 0.5rem;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
    </style>
</head>
<body>

<div class="main-container">
    <!-- Header -->
    <div class="page-header">
        <h1 class="page-title">Giỏ hàng của bạn</h1>
        <p class="page-subtitle">Xem lại và thanh toán các khóa học đã chọn</p>
    </div>

    <!-- Thông báo -->
    <c:if test="${not empty message}">
        <div class="alert alert-warning alert-modern alert-dismissible fade show" role="alert">
            <i class="bi bi-exclamation-triangle me-2"></i>
                ${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <c:choose>
        <c:when test="${not empty cartItems}">
            <div class="row">
                <div class="col-lg-8">
                    <!-- Bảng giỏ hàng -->
                    <div class="cart-card">
                        <div class="table-responsive">
                            <table class="table table-modern">
                                <thead>
                                <tr>
                                    <th style="width: 5%">#</th>
                                    <th style="width: 45%">Khóa học</th>
                                    <th style="width: 20%">Giá</th>
                                    <th style="width: 30%">Hành động</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${cartItems}" var="item" varStatus="status">
                                    <tr class="cart-item">
                                        <td class="text-center fw-bold">${status.index + 1}</td>
                                        <td>
                                            <div class="course-title">${item.courseID.title}</div>
                                        </td>
                                        <td>
                                            <span class="price-tag">$${item.price}</span>
                                        </td>
                                        <td>
                                            <div class="action-buttons">
                                                <!-- Nút Xóa -->
                                                <form action="CartServlet" method="post" style="display: inline;">
                                                    <input type="hidden" name="action" value="remove"/>
                                                    <input type="hidden" name="courseId" value="${item.courseID.id}"/>
                                                    <button type="submit" class="btn btn-modern btn-danger-modern btn-sm" onclick="showLoading(this)">
                                                        <span class="loading-spinner"></span>
                                                        <i class="bi bi-trash"></i> Xóa
                                                    </button>
                                                </form>
                                                <!-- Nút Wishlist -->
                                                <form action="CartServlet" method="post" style="display: inline;">
                                                    <input type="hidden" name="action" value="moveToWishlist"/>
                                                    <input type="hidden" name="courseId" value="${item.courseID.id}"/>
                                                    <button type="submit" class="btn btn-modern btn-warning-modern btn-sm" onclick="showLoading(this)">
                                                        <span class="loading-spinner"></span>
                                                        <i class="bi bi-heart"></i> Yêu thích
                                                    </button>
                                                </form>
                                            </div>
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
                        <h4 class="mb-3">
                            <i class="bi bi-calculator me-2"></i>
                            Tổng kết đơn hàng
                        </h4>
                        <div class="d-flex justify-content-between mb-3">
                            <span>Số khóa học:</span>
                            <span class="fw-bold">${cartItems.size()}</span>
                        </div>
                        <hr style="border-color: rgba(255,255,255,0.3);">
                        <div class="total-amount">
                            Tổng cộng:
                            <c:choose>
                                <c:when test="${not empty sessionScope.totalPrice}">
                                    $${sessionScope.totalPrice}
                                </c:when>
                                <c:otherwise>
                                    $0.00
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <form action="CheckoutServlet" method="post">
                            <button type="submit" class="btn btn-success-modern w-100">
                                <i class="bi bi-credit-card me-2"></i>
                                Thanh toán ngay
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
                <h3 class="mb-3" style="color: #1e293b; font-weight: 600;">Giỏ hàng trống</h3>
                <p style="color: #64748b; font-size: 1.1rem; margin-bottom: 2rem;">
                    Hãy khám phá các khóa học tuyệt vời và thêm vào giỏ hàng của bạn!
                </p>
                <a href="course" class="btn btn-modern btn-success-modern">
                    <i class="bi bi-book me-2"></i>
                    Khám phá khóa học
                </a>
            </div>
        </c:otherwise>
    </c:choose>

    <!-- Nút quay lại -->
    <div class="text-center mt-4">
        <a href="course" class="btn btn-modern btn-secondary-modern">
            <i class="bi bi-arrow-left me-2"></i>
            Tiếp tục mua sắm
        </a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function showLoading(button) {
        const spinner = button.querySelector('.loading-spinner');
        if (spinner) {
            spinner.style.display = 'inline-block';
            button.disabled = true;
        }
    }

    // Smooth scroll animation for page load
    document.addEventListener('DOMContentLoaded', function() {
        document.body.style.opacity = '0';
        document.body.style.transform = 'translateY(20px)';

        setTimeout(() => {
            document.body.style.transition = 'all 0.6s ease-out';
            document.body.style.opacity = '1';
            document.body.style.transform = 'translateY(0)';
        }, 100);
    });

    // Add hover effects to table rows
    document.querySelectorAll('.table-modern tbody tr').forEach(row => {
        row.addEventListener('mouseenter', function() {
            this.style.transform = 'translateY(-2px)';
        });

        row.addEventListener('mouseleave', function() {
            this.style.transform = 'translateY(0)';
        });
    });
</script>
</body>
</html>