<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/layout/header.jsp" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Giỏ Hàng - Hệ Thống Học Trực Tuyến</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
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
        .cart-empty {
            text-align: center;
            padding: 3rem;
        }
        .cart-empty i {
            font-size: 4rem;
            color: #6c757d;
            margin-bottom: 1rem;
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
<div class="container py-5">
    <div class="row">
        <!-- Main Content -->
        <div class="col-lg-8">
            <div class="card shadow-sm mb-4">
                <div class="card-header bg-primary text-white">
                    <h4 class="mb-0"><i class="bi bi-cart me-2"></i>Giỏ Hàng</h4>
                </div>
                <div class="card-body">
                    <!-- Hiển thị thông báo nếu có -->
                    <c:if test="${not empty message}">
                        <div class="alert alert-warning alert-dismissible fade show" role="alert">
                                ${message}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>

                    <c:choose>
                        <c:when test="${not empty cartItems}">
                            <c:forEach var="item" items="${cartItems}">
                                <div class="card mb-3" id="cart-item-${item.id}">
                                    <div class="card-body">
                                        <div class="d-flex align-items-center">
                                            <img src="${item.courseID.imageURL}" alt="${item.courseID.title}"
                                                 class="img-fluid rounded me-3" style="width: 100px;">
                                            <div class="flex-grow-1">
                                                <h5 class="card-title mb-1">${item.courseID.title}</h5>
                                                <p class="text-muted mb-0">
                                                    <i class="bi bi-tag me-1"></i>Giá:
                                                    <fmt:formatNumber value="${item.price}" type="currency" currencySymbol="₫"
                                                                      minFractionDigits="0" maxFractionDigits="0"/>
                                                </p>
                                            </div>
                                            <div class="ms-3">
                                                <button class="btn btn-outline-danger btn-sm"
                                                        onclick="removeFromCart(${item.id})">
                                                    <i class="bi bi-trash"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <!-- Hiển thị khi giỏ hàng trống -->
                            <div class="cart-empty">
                                <i class="bi bi-cart-x"></i>
                                <h4>Giỏ hàng trống</h4>
                                <p class="text-muted">Bạn chưa có khóa học nào trong giỏ hàng</p>
                                <a href="${pageContext.request.contextPath}/course" class="btn btn-primary">
                                    <i class="bi bi-search me-2"></i>Khám Phá Khóa Học
                                </a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <!-- Order Summary -->
        <div class="col-lg-4">
            <div class="card shadow-sm">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0"><i class="bi bi-receipt me-2"></i>Tổng Thanh Toán</h5>
                </div>
                <div class="card-body">
                    <div class="d-flex justify-content-between mb-3">
                        <span>Tổng tiền:</span>
                        <strong>
                            <c:choose>
                                <c:when test="${not empty sessionScope.totalPrice}">
                                    <fmt:formatNumber value="${sessionScope.totalPrice}" type="currency" currencySymbol="₫"
                                                      minFractionDigits="0" maxFractionDigits="0"/>
                                </c:when>
                                <c:otherwise>
                                    0₫
                                </c:otherwise>
                            </c:choose>
                        </strong>
                    </div>
                    <hr>
                    <div class="d-grid gap-2">
                        <form action="CheckoutServlet" method="post" style="margin:0;">
                            <button type="submit" class="btn btn-primary">
                                <i class="bi bi-credit-card me-2"></i>Thanh Toán
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function removeFromCart(itemId) {
        if (confirm('Bạn có chắc chắn muốn xóa khóa học này khỏi giỏ hàng?')) {
            fetch('CartServlet?action=remove&courseId=' + itemId, {
                method: 'POST'
            }).then(response => {
                if (response.ok) {
                    document.getElementById('cart-item-' + itemId).remove();
                    // Kiểm tra nếu giỏ hàng trống
                    if (document.querySelectorAll('.card.mb-3').length === 0) {
                        location.reload();
                    }
                } else {
                    alert('Có lỗi xảy ra khi xóa khóa học khỏi giỏ hàng');
                }
            });
        }
    }

    function checkout() {
        if (${empty cartItems}) {
            alert('Giỏ hàng của bạn đang trống!');
            return;
        }
        window.location.href = '${pageContext.request.contextPath}/checkout';
    }
</script>
</body>
</html>
