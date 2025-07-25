<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giỏ hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style>
        :root {
            --color-bg: #ffffff;
            --color-primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --color-primary-solid: #6d5cae;
            --color-primary-dark: #4b367c;
            --color-accent: #f5f6fa;
            --color-text: #22223b;
            --color-text-light: #ffffff;
            --color-border: #e0e0e0;
            --color-warning: #ffb347;
            --color-success: #43e97b;
            --color-danger: #ff6b6b;
            --color-disabled: #bdbdbd;
        }
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .cart-container {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        .cart-card {
            background: rgba(255, 255, 255, 0.97);
            backdrop-filter: blur(10px);
            border-radius: 32px;
            box-shadow: 0 24px 60px rgba(0, 0, 0, 0.13);
            border: 1px solid rgba(255, 255, 255, 0.2);
            overflow: hidden;
            max-width: 1200px;
            width: 100%;
        }
        .cart-header {
            background: var(--color-primary-gradient);
            color: white;
            padding: 56px 48px 32px 48px;
            text-align: center;
            position: relative;
        }
        .cart-header h1 {
            margin: 0;
            font-weight: 400;
            font-size: 2.5rem;
            letter-spacing: 1px;
        }
        .cart-header p {
            font-size: 1.15rem;
            opacity: 0.92;
            margin-top: 10px;
        }
        .cart-body {
            padding: 56px 48px 48px 48px;
        }
        .table {
            background: #fff;
            border-radius: 18px;
            overflow: hidden;
            font-size: 1.15rem;
        }
        .table thead {
            background: var(--color-primary-gradient);
            color: var(--color-text-light);
            font-size: 1.1rem;
        }
        .table tbody tr:hover {
            background: #f3f0fa;
            transition: background 0.2s;
        }
        .btn-primary, .btn-gradient {
            background: var(--color-primary-gradient);
            color: var(--color-text-light);
            border: none;
            transition: background 0.3s, box-shadow 0.3s;
        }
        .btn-primary:hover, .btn-gradient:hover, .btn-primary:focus {
            background: var(--color-primary-solid);
            color: var(--color-text-light);
            box-shadow: 0 4px 16px rgba(102, 126, 234, 0.15);
        }
        .btn-success {
            background: var(--color-success);
            color: var(--color-text-light);
            border: none;
            transition: background 0.3s, box-shadow 0.3s;
        }
        .btn-success:hover {
            background: #2ecc71;
            color: var(--color-text-light);
        }
        .btn-danger {
            background: var(--color-danger);
            color: var(--color-text-light);
            border: none;
            transition: background 0.3s;
        }
        .btn-danger:hover {
            background: #c0392b;
        }
        .btn-warning {
            background: var(--color-warning);
            color: var(--color-text);
            border: none;
            transition: background 0.3s;
        }
        .btn-warning:hover {
            background: #e1a03a;
            color: var(--color-text-light);
        }
        .empty-cart-icon {
            font-size: 5rem;
            color: var(--color-primary-solid);
            margin-bottom: 1rem;
            transition: color 0.3s;
        }
        .alert-info {
            background: var(--color-accent);
            color: var(--color-primary-dark);
            border-radius: 16px;
            border: none;
            font-weight: 500;
            margin-bottom: 30px;
            font-size: 1.1rem;
        }
        .fw-bold {
            color: var(--color-primary-dark);
        }
        .cart-total-section {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 2.5rem;
            font-size: 1.25rem;
        }
        @media (max-width: 992px) {
            .cart-card {
                max-width: 98vw;
                border-radius: 18px;
            }
            .cart-header, .cart-body {
                padding-left: 18px;
                padding-right: 18px;
            }
        }
        @media (max-width: 768px) {
            .cart-body {
                padding: 1rem;
            }
            .cart-header {
                padding: 2rem 1rem 1rem 1rem;
            }
            .cart-card {
                border-radius: 10px;
            }
            .table-responsive {
                font-size: 0.95rem;
            }
            .btn-lg {
                font-size: 1rem;
                padding: 0.5rem 1.2rem;
            }
            .cart-total-section {
                flex-direction: column;
                gap: 1rem;
                align-items: flex-start;
            }
        }
    </style>
</head>
<body>
<div class="cart-container">
    <div class="cart-card">
        <div class="cart-header">
            <h1>Giỏ hàng của bạn</h1>
            <p>Quản lý các khóa học bạn muốn đăng ký</p>
        </div>
        <div class="cart-body">
            <!-- Hiển thị thông báo nếu có -->
            <c:if test="${not empty message}">
                <div class="alert alert-warning alert-dismissible fade show" role="alert">
                        ${message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <c:choose>
                <c:when test="${not empty cartItems}">
                    <div class="table-responsive">
                        <table class="table table-bordered table-hover align-middle">
                            <thead class="text-center">
                            <tr>
                                <th>#</th>
                                <th>Tên khóa học</th>
                                <th>Giá</th>
                                <th>Hành động</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${cartItems}" var="item" varStatus="status">
                                <tr>
                                    <td class="text-center">${status.index + 1}</td>
                                    <td>${item.courseID.title}</td>
                                    <td class="text-success fw-bold">
                                        <fmt:formatNumber value="${item.price}" type="currency" currencySymbol="₫" minFractionDigits="0" maxFractionDigits="0"/>
                                    </td>
                                    <td class="text-center">
                                        <div class="d-flex justify-content-center gap-2">
                                            <!-- Nút Xóa -->
                                            <form action="CartServlet" method="post">
                                                <input type="hidden" name="action" value="remove"/>
                                                <input type="hidden" name="courseId" value="${item.courseID.id}"/>
                                                <button type="submit" class="btn btn-sm btn-danger">
                                                    <i class="bi bi-trash"></i> Xóa
                                                </button>
                                            </form>
                                            <!-- Nút chuyển sang Wishlist -->
                                            <form action="CartServlet" method="post">
                                                <input type="hidden" name="action" value="moveToWishlist"/>
                                                <input type="hidden" name="courseId" value="${item.courseID.id}"/>
                                                <button type="submit" class="btn btn-sm btn-warning">
                                                    <i class="bi bi-heart"></i> Wishlist
                                                </button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <div class="cart-total-section">
                        <h5 class="fw-bold">
                            Tổng cộng:
                            <c:choose>
                                <c:when test="${not empty sessionScope.totalPrice}">
                                    <fmt:formatNumber value="${sessionScope.totalPrice}" type="currency" currencySymbol="₫" minFractionDigits="0" maxFractionDigits="0"/>
                                </c:when>
                                <c:otherwise>
                                    0₫
                                </c:otherwise>
                            </c:choose>
                        </h5>
                        <form action="CheckoutServlet" method="post" style="margin:0;">
                            <button type="submit" class="btn btn-success btn-lg">
                                <i class="bi bi-cart-check"></i> Thanh toán
                            </button>
                        </form>
                    </div>
                </c:when>
                <c:otherwise>
                    <!-- Hiển thị khi giỏ hàng trống -->
                    <div class="alert alert-info text-center">
                        <i class="bi bi-cart-x empty-cart-icon"></i>
                        <h4 class="mt-3">Giỏ hàng trống</h4>
                        <p>Hãy thêm khóa học vào giỏ hàng!</p>
                        <a href="course" class="btn btn-primary mt-2">
                            <i class="bi bi-book"></i> Xem khóa học
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
            <!-- Nút quay lại danh sách khóa học -->
            <a href="course" class="btn btn-secondary mt-3">
                <i class="bi bi-arrow-left"></i> Quay lại danh sách khóa học
            </a>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
