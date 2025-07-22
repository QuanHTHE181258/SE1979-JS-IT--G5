package project.demo.coursemanagement.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class OrderDetailsViewDTO {
    private int orderId;
    private String status;
    private String paymentMethod;
    private BigDecimal totalAmount;
    private Date createdAt;
    private List<OrderCourseDetailDTO> courseDetails;
}
