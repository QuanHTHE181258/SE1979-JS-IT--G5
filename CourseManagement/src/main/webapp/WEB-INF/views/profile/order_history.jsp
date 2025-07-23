<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<fmt:setLocale value="en_US" />
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Order History - Course Management System</title>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
  <style>
    body {
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      min-height: 100vh;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    .profile-container {
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 20px;
    }

    .profile-card {
      background: rgba(255, 255, 255, 0.95);
      backdrop-filter: blur(10px);
      border-radius: 20px;
      box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
      border: 1px solid rgba(255, 255, 255, 0.2);
      overflow: hidden;
      max-width: 900px;
      width: 100%;
    }

    .profile-header {
      background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
      color: white;
      padding: 40px 30px;
      text-align: center;
      position: relative;
    }

    .profile-header h2 {
      margin: 0;
      font-weight: 300;
      font-size: 2rem;
    }

    .profile-header p {
      margin: 10px 0 0;
      opacity: 0.9;
      font-size: 0.95rem;
    }

    .back-button {
      position: absolute;
      left: 20px;
      top: 20px;
      color: white;
      text-decoration: none;
      font-size: 18px;
      transition: all 0.3s ease;
    }

    .back-button:hover {
      color: white;
      transform: translateX(-5px);
    }

    .profile-body {
      padding: 40px;
    }

    .order-table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 20px;
      box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
      border-radius: 10px;
      overflow: hidden;
    }

    .order-table th {
      background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
      color: white;
      padding: 15px;
      text-align: left;
      font-weight: 500;
    }

    .order-table td {
      padding: 15px;
      border-bottom: 1px solid #eee;
    }

    .order-table tr:last-child td {
      border-bottom: none;
    }

    .order-table tr:hover {
      background-color: rgba(79, 172, 254, 0.05);
    }

    .order-status {
      display: inline-block;
      padding: 5px 10px;
      border-radius: 20px;
      font-size: 0.85rem;
      font-weight: 500;
    }

    .status-pending {
      background-color: #ffeaa7;
      color: #d35400;
    }

    .status-paid {
      background-color: #d4f8e8;
      color: #00b894;
    }

    .status-cancelled {
      background-color: #ffebee;
      color: #e53935;
    }

    .empty-orders {
      text-align: center;
      padding: 50px 0;
      color: #666;
    }

    .empty-orders i {
      font-size: 4rem;
      color: #ddd;
      margin-bottom: 20px;
    }

    .btn-primary {
      background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
      border: none;
      box-shadow: 0 4px 15px rgba(79, 172, 254, 0.4);
      padding: 10px 20px;
      border-radius: 30px;
      transition: all 0.3s ease;
    }

    .btn-primary:hover {
      transform: translateY(-2px);
      box-shadow: 0 8px 20px rgba(79, 172, 254, 0.6);
    }

    .order-details {
      background-color: #f9f9f9;
      padding: 15px;
      border-radius: 10px;
      margin-top: 10px;
    }

    .order-details h6 {
      margin-bottom: 10px;
      color: #4facfe;
    }

    .order-details-item {
      display: flex;
      justify-content: space-between;
      padding: 8px 0;
      border-bottom: 1px dashed #eee;
    }

    .order-details-item:last-child {
      border-bottom: none;
    }
  </style>
</head>
<body>
<div class="profile-container">
  <div class="profile-card">
    <div class="profile-header">
      <a href="${pageContext.request.contextPath}/profile" class="back-button">
        <i class="fas fa-arrow-left"></i>
      </a>
      <h2>My Order History</h2>
      <p>View all your course purchases</p>
    </div>

    <div class="profile-body">
      <c:if test="${not empty message}">
        <div class="alert alert-${messageType} alert-dismissible fade show" role="alert">
            ${message}
          <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
      </c:if>

      <c:choose>
        <c:when test="${empty orders}">
          <div class="empty-orders">
            <i class="fas fa-shopping-cart"></i>
            <h4>No Orders Found</h4>
            <p>You haven't purchased any courses yet.</p>
            <a href="${pageContext.request.contextPath}/courses" class="btn btn-primary mt-3">
              <i class="fas fa-book-open me-2"></i>Browse Courses
            </a>
          </div>
        </c:when>
        <c:otherwise>
          <table class="order-table">
            <thead>
            <tr>
              <th>Order ID</th>
              <th>Date</th>
              <th>Courses</th>
              <th>Total</th>
              <th>Status</th>
              <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="order" items="${orders}">
              <tr>
                <td>#${order.orderId}</td>
                <td>
                  <c:set var="createdAtInstant" value="${order.createdAt}" />
                  <c:if test="${not empty createdAtInstant}">
                    <c:set var="dateStr" value="${createdAtInstant.toString()}" />
                    <c:set var="year" value="${fn:substring(dateStr, 0, 4)}" />
                    <c:set var="month" value="${fn:substring(dateStr, 5, 7)}" />
                    <c:set var="day" value="${fn:substring(dateStr, 8, 10)}" />
                    <c:set var="monthName" value="" />
                    <c:choose>
                      <c:when test="${month == '01'}"><c:set var="monthName" value="Jan" /></c:when>
                      <c:when test="${month == '02'}"><c:set var="monthName" value="Feb" /></c:when>
                      <c:when test="${month == '03'}"><c:set var="monthName" value="Mar" /></c:when>
                      <c:when test="${month == '04'}"><c:set var="monthName" value="Apr" /></c:when>
                      <c:when test="${month == '05'}"><c:set var="monthName" value="May" /></c:when>
                      <c:when test="${month == '06'}"><c:set var="monthName" value="Jun" /></c:when>
                      <c:when test="${month == '07'}"><c:set var="monthName" value="Jul" /></c:when>
                      <c:when test="${month == '08'}"><c:set var="monthName" value="Aug" /></c:when>
                      <c:when test="${month == '09'}"><c:set var="monthName" value="Sep" /></c:when>
                      <c:when test="${month == '10'}"><c:set var="monthName" value="Oct" /></c:when>
                      <c:when test="${month == '11'}"><c:set var="monthName" value="Nov" /></c:when>
                      <c:when test="${month == '12'}"><c:set var="monthName" value="Dec" /></c:when>
                    </c:choose>
                    ${monthName} ${day}, ${year}
                  </c:if>
                  <c:if test="${empty createdAtInstant}">
                    N/A
                  </c:if>
                </td>
                <td>
                  <c:forEach var="detail" items="${order.orderDetails}" varStatus="status">
                    ${detail.courseTitle}
                    <c:if test="${!status.last}">, </c:if>
                  </c:forEach>
                </td>
                <td><fmt:formatNumber value="${order.totalAmount}" type="currency" /></td>
                <td>
                      <span class="order-status status-${fn:toLowerCase(order.status)}">
                          ${order.status}
                      </span>
                </td>
                <td>
                  <a href="${pageContext.request.contextPath}/order-details?orderId=${order.orderId}" class="btn btn-sm btn-info">
                    <i class="fas fa-eye"></i> View Details
                </td>
              </tr>
              <tr>
                <td colspan="5">
                  <div class="order-details">
                    <h6>Order Details</h6>
                    <c:forEach var="detail" items="${order.orderDetails}">
                      <div class="order-details-item">
                        <div>
                          <strong>${detail.courseTitle}</strong>
                          <div class="text-muted small">Course ID: ${detail.courseId}</div>
                        </div>
                        <div>
                          <fmt:formatNumber value="${detail.price}" type="currency" />
                        </div>
                      </div>
                    </c:forEach>
                    <div class="order-details-item mt-2">
                      <div><strong>Payment Method</strong></div>
                      <div>${order.paymentMethod}</div>
                    </div>
                    <div class="order-details-item">
                      <div><strong>Total</strong></div>
                      <div><strong><fmt:formatNumber value="${order.totalAmount}" type="currency" /></strong></div>
                    </div>
                  </div>
                </td>
              </tr>
            </c:forEach>
            </tbody>
          </table>
        </c:otherwise>
      </c:choose>
    </div>
  </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
</body>
</html>