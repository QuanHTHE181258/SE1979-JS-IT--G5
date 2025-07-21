<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Chi tiết đơn hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .main-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.05);
            overflow: hidden;
            margin: 40px auto;
        }

        .order-header {
            background: linear-gradient(135deg, #f1f3f4 0%, #e8eaed 100%);
            color: #495057;
            padding: 30px;
            position: relative;
            overflow: hidden;
        }

        .order-header::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -50%;
            width: 100%;
            height: 200%;
            background: rgba(255,255,255,0.3);
            transform: rotate(45deg);
        }

        .order-header h2 {
            font-weight: 700;
            font-size: 2.2rem;
            margin-bottom: 10px;
            position: relative;
            z-index: 1;
        }

        .order-date {
            font-size: 1.1rem;
            opacity: 0.9;
            position: relative;
            z-index: 1;
        }

        .status-badge {
            font-size: 0.9rem;
            padding: 12px 20px;
            border-radius: 25px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            position: relative;
            z-index: 1;
            border: 2px solid rgba(108,117,125,0.2);
        }

        .status-pending {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            color: #6c757d;
        }
        .status-paid {
            background: linear-gradient(135deg, #f1f3f4 0%, #e8eaed 100%);
            color: #495057;
        }
        .status-cancelled {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            color: #6c757d;
        }

        .content-section {
            padding: 40px;
        }

        .info-card {
            background: #fafafa;
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 30px;
            border: 1px solid #f0f0f0;
            box-shadow: 0 5px 15px rgba(0,0,0,0.02);
        }

        .info-card h5 {
            color: #495057;
            font-weight: 600;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
        }

        .info-card h5 i {
            margin-right: 10px;
            color: #868e96;
        }

        .info-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 0;
            border-bottom: 1px solid #f0f0f0;
        }

        .info-item:last-child {
            border-bottom: none;
        }

        .info-label {
            font-weight: 500;
            color: #6c757d;
        }

        .info-value {
            font-weight: 600;
            color: #495057;
        }

        .courses-table {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0,0,0,0.02);
        }

        .table {
            margin-bottom: 0;
        }

        .table thead {
            background: linear-gradient(135deg, #f1f3f4 0%, #e8eaed 100%);
            color: #495057;
        }

        .table thead th {
            border: none;
            padding: 20px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .table tbody tr {
            border-bottom: 1px solid #f0f0f0;
            transition: all 0.3s ease;
        }

        .table tbody tr:hover {
            background-color: #fafafa;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        }

        .table tbody td {
            padding: 20px;
            vertical-align: middle;
        }

        .course-name {
            font-weight: 600;
            color: #495057;
        }

        .price {
            font-size: 1.1rem;
            font-weight: 700;
            color: #495057;
        }

        .total-section {
            background: linear-gradient(135deg, #f1f3f4 0%, #e8eaed 100%);
            color: #495057;
            padding: 30px;
            margin-top: 30px;
            border-radius: 15px;
            position: relative;
            overflow: hidden;
        }

        .total-section::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 100%;
            height: 200%;
            background: rgba(255,255,255,0.3);
            transform: rotate(-45deg);
        }

        .total-amount {
            font-size: 2.5rem;
            font-weight: 700;
            text-align: center;
            position: relative;
            z-index: 1;
        }

        .total-label {
            text-align: center;
            font-size: 1.1rem;
            opacity: 0.9;
            text-transform: uppercase;
            letter-spacing: 2px;
            position: relative;
            z-index: 1;
        }

        .back-btn {
            background: linear-gradient(135deg, #f1f3f4 0%, #e8eaed 100%);
            border: 1px solid #dee2e6;
            color: #495057;
            padding: 12px 30px;
            border-radius: 25px;
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            transition: all 0.3s ease;
            margin-bottom: 20px;
        }

        .back-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
            color: #495057;
        }

        .back-btn i {
            margin-right: 8px;
        }

        @media (max-width: 768px) {
            .main-container {
                margin: 20px;
            }

            .content-section {
                padding: 20px;
            }

            .order-header {
                padding: 20px;
            }

            .order-header h2 {
                font-size: 1.8rem;
            }

            .total-amount {
                font-size: 2rem;
            }
        }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/layout/header.jsp"/>

<div class="container">
    <a href="javascript:history.back()" class="back-btn">
        <i class="fas fa-arrow-left"></i>
        Quay lại
    </a>

    <div class="main-container">
        <div class="order-header">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h2><i class="fas fa-receipt"></i> Đơn hàng #${orderDetails.orderId}</h2>
                    <div class="order-date">
                        <i class="fas fa-calendar-alt"></i>
                        <fmt:formatDate value="${orderDetails.createdAt}" pattern="dd/MM/yyyy 'lúc' HH:mm"/>
                    </div>
                </div>
                <div class="col-md-4 text-end">
                        <span class="status-badge status-${orderDetails.status.toLowerCase()}">
                            <c:choose>
                                <c:when test="${orderDetails.status == 'PAID'}">
                                    <i class="fas fa-check-circle"></i> Đã thanh toán
                                </c:when>
                                <c:when test="${orderDetails.status == 'PENDING'}">
                                    <i class="fas fa-clock"></i> Chờ thanh toán
                                </c:when>
                                <c:otherwise>
                                    <i class="fas fa-times-circle"></i> ${orderDetails.status}
                                </c:otherwise>
                            </c:choose>
                        </span>
                </div>
            </div>
        </div>

        <div class="content-section">
            <div class="info-card">
                <h5><i class="fas fa-info-circle"></i> Thông tin đơn hàng</h5>
                <div class="info-item">
                    <span class="info-label"><i class="fas fa-calendar-alt"></i> Ngày đặt hàng:</span>
                    <span class="info-value">
                            <fmt:formatDate value="${orderDetails.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                        </span>
                </div>
                <div class="info-item">
                    <span class="info-label"><i class="fas fa-credit-card"></i> Phương thức thanh toán:</span>
                    <span class="info-value">${orderDetails.paymentMethod}</span>
                </div>
                <div class="info-item">
                    <span class="info-label"><i class="fas fa-info-circle"></i> Trạng thái:</span>
                    <span class="info-value">
                            <c:choose>
                                <c:when test="${orderDetails.status == 'PAID'}">Đã thanh toán</c:when>
                                <c:when test="${orderDetails.status == 'PENDING'}">Chờ thanh toán</c:when>
                                <c:otherwise>${orderDetails.status}</c:otherwise>
                            </c:choose>
                        </span>
                </div>
            </div>

            <div class="info-card">
                <h5><i class="fas fa-graduation-cap"></i> Khóa học đã mua</h5>
                <div class="courses-table">
                    <table class="table">
                        <thead>
                        <tr>
                            <th><i class="fas fa-book"></i> Tên khóa học</th>
                            <th class="text-end"><i class="fas fa-tag"></i> Giá</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${orderDetails.courseDetails}" var="course">
                            <tr>
                                <td class="course-name">${course.courseName}</td>
                                <td class="text-end price">
                                    $<fmt:formatNumber value="${course.price}" pattern="#,##0.00"/>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="total-section">
                <div class="total-label">Tổng cộng</div>
                <div class="total-amount">
                    $<fmt:formatNumber value="${orderDetails.totalAmount}" pattern="#,##0.00"/>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/layout/footer.jsp"/>
</body>
</html>