<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="project.demo.coursemanagement.dao.impl.OrderDAOImpl" %>
<%@ page import="project.demo.coursemanagement.dto.OrderDTO" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%
    Integer orderId = (Integer) session.getAttribute("currentOrderId");
    OrderDTO order = null;
    if (orderId != null) {
        order = new OrderDAOImpl().getOrderById(orderId);
        if (order != null) {
            request.setAttribute("order", order);
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Hóa đơn thanh toán</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: #f5f6fa; }
        .invoice-card {
            max-width: 700px;
            margin: 40px auto;
            background: #fff;
            border-radius: 18px;
            box-shadow: 0 8px 32px rgba(102,126,234,0.10);
            padding: 40px 32px 32px 32px;
        }
        .invoice-title { color: #764ba2; font-weight: 600; }
        .table th { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: #fff; }
        .btn-vnpay {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: #fff;
            border: none;
            font-weight: 600;
            border-radius: 2rem;
            padding: 0.75rem 2rem;
            transition: background 0.3s;
        }
        .btn-vnpay:hover { background: #6d5cae; }
    </style>
</head>
<body>
<div class="invoice-card">
    <h2 class="invoice-title mb-4">Hóa đơn thanh toán</h2>
    <c:if test="${order != null}">
        <table class="table table-bordered align-middle">
            <thead>
            <tr>
                <th>#</th>
                <th>Tên khóa học</th>
                <th>Giá</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${order.orderDetails}" var="item" varStatus="status">
                <tr>
                    <td>${status.index + 1}</td>
                    <td>${item.courseTitle}</td>
                    <td><fmt:formatNumber value="${item.price}" type="currency" currencySymbol="₫" minFractionDigits="0" maxFractionDigits="0"/></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <div class="d-flex justify-content-between align-items-center mt-4">
            <h5 class="fw-bold">Tổng cộng: <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₫" minFractionDigits="0" maxFractionDigits="0"/></h5>
            <form action="VnpayServlet" method="post" style="display:inline-block;">
                <input type="hidden" name="orderId" value="${order.orderId}"/>
                <input type="hidden" name="amount" value="${order.totalAmount}"/>
                <button type="submit" class="btn btn-vnpay">
                    Thanh toán qua VNPAY
                </button>
            </form>
            <a href="https://sandbox.vnpayment.vn/apis/vnpay-demo/" target="_blank" class="btn btn-secondary ms-2">Link lấy tài khoản Demo VNPAY</a>
        </div>
    </c:if>
    <c:if test="${order == null}">
        <div class="alert alert-warning">Không tìm thấy hóa đơn.</div>
    </c:if>
</div>
</body>
</html>
