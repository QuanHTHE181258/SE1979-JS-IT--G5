package project.demo.coursemanagement.dto;

import java.math.BigDecimal;
import java.time.Instant;
import java.util.List;
import java.util.Date;



public class OrderDTO {
    private Integer orderId;
    private String username;
    private String status;
    private String paymentMethod;
    private BigDecimal totalAmount;
    private Instant createdAt;
    private List<OrderDetailDTO> orderDetails;
    private String customerName;
    private String customerEmail;
    private Integer userId;

    // Calculate total amount based on order details
    public void calculateTotalAmount() {
        if (orderDetails != null && !orderDetails.isEmpty()) {
            BigDecimal calculatedTotal = BigDecimal.ZERO;
            for (OrderDetailDTO detail : orderDetails) {
                if (detail.getPrice() != null) {
                    calculatedTotal = calculatedTotal.add(detail.getPrice());
                }
            }
            this.totalAmount = calculatedTotal;
        }
    }

    // Getters and Setters
    public Integer getOrderId() {
        return orderId;
    }



    public void setOrderId(Integer orderId) {
        this.orderId = orderId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public Instant getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Instant createdAt) {
        this.createdAt = createdAt;
    }

    public List<OrderDetailDTO> getOrderDetails() {
        return orderDetails;
    }

    public void setOrderDetails(List<OrderDetailDTO> orderDetails) {
        this.orderDetails = orderDetails;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getCustomerEmail() {
        return customerEmail;
    }

    public void setCustomerEmail(String customerEmail) {
        this.customerEmail = customerEmail;
    }
    public Date getCreatedAtDate() {
        return createdAt == null ? null : Date.from(createdAt); }
    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }
}
