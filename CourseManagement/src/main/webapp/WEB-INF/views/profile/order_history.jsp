<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/layout/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<fmt:setLocale value="vi_VN" />
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Lịch Sử Đơn Hàng - Hệ Thống Quản Lý Khóa Học</title>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
  <style>
    :root {
      /* Purple Gradient Theme */
      --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      --primary-500: #667eea;
      --primary-600: #5a69d4;
      --primary-50: #f3f1ff;
      --bg-primary: #ffffff;
      --bg-secondary: #f8f9fa;
      --text-primary: #2c3e50;
      --text-secondary: #6c757d;
      --text-white: #ffffff;
      --success: #28a745;
      --warning: #ffc107;
      --error: #dc3545;
      --info: #17a2b8;
      --border-light: #e9ecef;
      --shadow-light: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
      --shadow-medium: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
      --transition-medium: all 0.3s ease-in-out;
    }

    body {
      background: var(--bg-primary);
      .profile-container {
        min-height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 20px;
        background: var(--bg-secondary);
      }

      .profile-card {
        background: var(--bg-primary);
        backdrop-filter: blur(10px);
        border-radius: 20px;
        box-shadow: var(--shadow-medium);
        border: 1px solid var(--border-light);
        overflow: hidden;
        max-width: 1000px;
        width: 100%;
      }

      .profile-header {
        background: var(--primary-gradient);
        color: var(--text-white);
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
        color: var(--text-white);
        text-decoration: none;
        font-size: 18px;
        transition: var(--transition-medium);
      }

      .back-button:hover {
        color: var(--text-white);
        transform: translateX(-5px);
      }

      .profile-body {
        padding: 40px;
      }

      .order-table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
        box-shadow: var(--shadow-light);
        border-radius: 10px;
        overflow: hidden;
      }

      .order-table th {
        background: var(--primary-gradient);
        color: var(--text-white);
        padding: 15px;
        text-align: left;
        font-weight: 500;
      }

      .order-table td {
        padding: 15px;
        border-bottom: 1px solid var(--border-light);
      }

      .order-table tr:last-child td {
        border-bottom: none;
      }

      .order-table tr:hover {
        background-color: rgba(102, 126, 234, 0.05);
      }

      .order-status {
        display: inline-block;
        padding: 5px 10px;
        border-radius: 20px;
        font-size: 0.85rem;
        font-weight: 500;
      }

      .status-pending {
        background-color: rgba(255, 193, 7, 0.1);
        color: var(--warning);
        border: 1px solid rgba(255, 193, 7, 0.3);
      }

      .status-paid {
        background-color: rgba(40, 167, 69, 0.1);
        color: var(--success);
        border: 1px solid rgba(40, 167, 69, 0.3);
      }

      .status-cancelled {
        background-color: rgba(220, 53, 69, 0.1);
        color: var(--error);
        border: 1px solid rgba(220, 53, 69, 0.3);
      }

      .empty-orders {
        text-align: center;
        padding: 50px 0;
        color: var(--text-secondary);
      }

      .empty-orders i {
        font-size: 4rem;
        color: var(--border-light);
        margin-bottom: 20px;
      }

      .btn-primary {
        background: var(--primary-gradient);
        border: none;
        box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
        padding: 10px 20px;
        border-radius: 30px;
        transition: var(--transition-medium);
      }

      .btn-primary:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 20px rgba(102, 126, 234, 0.6);
      }

      .btn-info {
        background: var(--info);
        border: none;
        color: var(--text-white);
        border-radius: 20px;
        padding: 0.375rem 0.75rem;
        font-size: 0.875rem;
        transition: var(--transition-medium);
      }

      .btn-info:hover {
        background: #138496;
        transform: translateY(-1px);
        color: var(--text-white);
      }

      .order-details {
        background-color: var(--primary-50);
        padding: 15px;
        border-radius: 10px;
        margin-top: 10px;
        border: 1px solid var(--border-light);
      }

      .order-details h6 {
        margin-bottom: 10px;
        color: var(--primary-600);
        font-weight: 600;
      }

      .order-details-item {
        display: flex;
        justify-content: space-between;
        padding: 8px 0;
        border-bottom: 1px dashed var(--border-light);
      }

      .order-details-item:last-child {
        border-bottom: none;
        font-weight: 600;
        color: var(--text-primary);
      }

      .alert {
        border-radius: 12px;
        border: none;
        font-weight: 500;
        margin-bottom: 25px;
      }

      .alert-success {
        background: rgba(40, 167, 69, 0.1);
        border-left: 4px solid var(--success);
        color: var(--success);
      }

      .alert-danger {
        background: rgba(220, 53, 69, 0.1);
        border-left: 4px solid var(--error);
        color: var(--error);
      }

      .alert-info {
        background: var(--primary-50);
        border-left: 4px solid var(--primary-500);
        color: var(--primary-600);
      }

      @media (max-width: 768px) {
        .profile-card {
          margin: 1rem;
          border-radius: 16px;
        }

        .profile-body {
          padding: 2rem 1.5rem;
        }

        .order-table {
          font-size: 0.875rem;
        }

        .order-table th,
        .order-table td {
          padding: 10px 8px;
        }

        .order-details {
          padding: 12px;
        }
      }

      @media (max-width: 576px) {
        .order-table th:nth-child(2),
        .order-table td:nth-child(2) {
          display: none;
        }

        .order-details-item {
          flex-direction: column;
          align-items: flex-start;
          gap: 4px;
        }
      }

      .order-row {
        cursor: pointer;
        transition: var(--transition-medium);
      }

      .order-row:hover {
        background-color: var(--primary-50) !important;
      }

      .expandable {
        display: none;
      }

      .expandable.show {
        display: table-row;
      }

      .expand-icon {
        transition: transform 0.3s ease;
        cursor: pointer;
        color: var(--primary-500);
      }

      .expand-icon.rotated {
        transform: rotate(180deg);
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
      <h2>Lịch Sử Đơn Hàng</h2>
      <p>Xem tất cả các khóa học bạn đã mua</p>
    </div>

    <div class="profile-body">
      <c:if test="${not empty message}">
        <div class="alert alert-${messageType} alert-dismissible fade show" role="alert">
            ${message}
          <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Đóng"></button>
        </div>
      </c:if>

      <c:choose>
        <c:when test="${empty orders}">
          <div class="empty-orders">
            <i class="fas fa-shopping-cart"></i>
            <h4>Không Tìm Thấy Đơn Hàng</h4>
            <p>Bạn chưa mua khóa học nào.</p>
            <a href="${pageContext.request.contextPath}/course" class="btn btn-primary mt-3">
              <i class="fas fa-book-open me-2"></i>Duyệt Khóa Học
            </a>
          </div>
        </c:when>
        <c:otherwise>
          <table class="order-table">
            <thead>
            <tr>
              <th style="width: 5%;"></th>
              <th style="width: 15%;">Mã Đơn Hàng</th>
              <th style="width: 15%;">Ngày Đặt</th>
              <th style="width: 25%;">Khóa Học</th>
              <th style="width: 15%;">Tổng Tiền</th>
              <th style="width: 15%;">Trạng Thái</th>
              <th style="width: 10%;">Thao Tác</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="order" items="${orders}" varStatus="status">
              <tr class="order-row" onclick="toggleOrderDetails(${status.index})">
                <td>
                  <i class="fas fa-chevron-down expand-icon" id="icon-${status.index}"></i>
                </td>
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
                      <c:when test="${month == '01'}"><c:set var="monthName" value="Th1" /></c:when>
                      <c:when test="${month == '02'}"><c:set var="monthName" value="Th2" /></c:when>
                      <c:when test="${month == '03'}"><c:set var="monthName" value="Th3" /></c:when>
                      <c:when test="${month == '04'}"><c:set var="monthName" value="Th4" /></c:when>
                      <c:when test="${month == '05'}"><c:set var="monthName" value="Th5" /></c:when>
                      <c:when test="${month == '06'}"><c:set var="monthName" value="Th6" /></c:when>
                      <c:when test="${month == '07'}"><c:set var="monthName" value="Th7" /></c:when>
                      <c:when test="${month == '08'}"><c:set var="monthName" value="Th8" /></c:when>
                      <c:when test="${month == '09'}"><c:set var="monthName" value="Th9" /></c:when>
                      <c:when test="${month == '10'}"><c:set var="monthName" value="Th10" /></c:when>
                      <c:when test="${month == '11'}"><c:set var="monthName" value="Th11" /></c:when>
                      <c:when test="${month == '12'}"><c:set var="monthName" value="Th12" /></c:when>
                    </c:choose>
                    ${day} ${monthName}, ${year}
                  </c:if>
                  <c:if test="${empty createdAtInstant}">
                    Không xác định
                  </c:if>
                </td>
                <td>
                  <c:forEach var="detail" items="${order.orderDetails}" varStatus="detailStatus">
                    ${detail.courseTitle}
                    <c:if test="${!detailStatus.last}">, </c:if>
                  </c:forEach>
                </td>
                <td>
                  <strong>
                    <fmt:formatNumber value="${order.totalAmount}" type="currency" pattern="#,##0 ₫" />
                  </strong>
                </td>
                <td>
                  <c:set var="statusClass" value="" />
                  <c:set var="statusText" value="" />
                  <c:choose>
                    <c:when test="${fn:toLowerCase(order.status) == 'pending'}">
                      <c:set var="statusClass" value="status-pending" />
                      <c:set var="statusText" value="Đang chờ" />
                    </c:when>
                    <c:when test="${fn:toLowerCase(order.status) == 'paid'}">
                      <c:set var="statusClass" value="status-paid" />
                      <c:set var="statusText" value="Đã thanh toán" />
                    </c:when>
                    <c:when test="${fn:toLowerCase(order.status) == 'cancelled'}">
                      <c:set var="statusClass" value="status-cancelled" />
                      <c:set var="statusText" value="Đã hủy" />
                    </c:when>
                    <c:otherwise>
                      <c:set var="statusClass" value="status-pending" />
                      <c:set var="statusText" value="${order.status}" />
                    </c:otherwise>
                  </c:choose>
                  <span class="order-status ${statusClass}">
                      ${statusText}
                  </span>
                </td>
                <td onclick="event.stopPropagation();">
                  <a href="${pageContext.request.contextPath}/order-details?orderId=${order.orderId}"
                     class="btn btn-sm btn-info">
                    <i class="fas fa-eye"></i> Xem
                  </a>
                </td>
              </tr>
              <tr class="expandable" id="details-${status.index}">
                <td colspan="7">
                  <div class="order-details">
                    <h6><i class="fas fa-info-circle me-2"></i>Chi Tiết Đơn Hàng</h6>
                    <c:forEach var="detail" items="${order.orderDetails}">
                      <div class="order-details-item">
                        <div>
                          <strong>${detail.courseTitle}</strong>
                          <div class="text-muted small">Mã khóa học: ${detail.courseId}</div>
                        </div>
                        <div>
                          <fmt:formatNumber value="${detail.price}" type="currency" pattern="#,##0 ₫" />
                        </div>
                      </div>
                    </c:forEach>
                    <div class="order-details-item mt-2">
                      <div><strong><i class="fas fa-credit-card me-2"></i>Phương Thức Thanh Toán</strong></div>
                      <div>
                        <c:choose>
                          <c:when test="${order.paymentMethod == 'CREDIT_CARD'}">Thẻ tín dụng</c:when>
                          <c:when test="${order.paymentMethod == 'PAYPAL'}">PayPal</c:when>
                          <c:when test="${order.paymentMethod == 'BANK_TRANSFER'}">Chuyển khoản</c:when>
                          <c:otherwise>${order.paymentMethod}</c:otherwise>
                        </c:choose>
                      </div>
                    </div>
                    <div class="order-details-item">
                      <div><strong><i class="fas fa-calculator me-2"></i>Tổng Cộng</strong></div>
                      <div><strong><fmt:formatNumber value="${order.totalAmount}" type="currency" pattern="#,##0 ₫" /></strong></div>
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
<script>
  function toggleOrderDetails(index) {
    const detailsRow = document.getElementById(`details-${index}`);
    const icon = document.getElementById(`icon-${index}`);

    if (detailsRow.classList.contains('show')) {
      detailsRow.classList.remove('show');
      icon.classList.remove('rotated');
    } else {
      // Hide all other expanded rows
      document.querySelectorAll('.expandable.show').forEach(row => {
        row.classList.remove('show');
      });
      document.querySelectorAll('.expand-icon.rotated').forEach(iconEl => {
        iconEl.classList.remove('rotated');
      });

      // Show current row
      detailsRow.classList.add('show');
      icon.classList.add('rotated');
    }
  }

  // Animate table rows on load
  document.addEventListener('DOMContentLoaded', function() {
    const tableRows = document.querySelectorAll('.order-row');
    tableRows.forEach((row, index) => {
      row.style.opacity = '0';
      row.style.transform = 'translateY(20px)';

      setTimeout(() => {
        row.style.transition = 'all 0.3s ease';
        row.style.opacity = '1';
        row.style.transform = 'translateY(0)';
      }, index * 100);
    });
  });
</script>
</body>
</html>
font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

.profile-container {
min-height: 100vh;
