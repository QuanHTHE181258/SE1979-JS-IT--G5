package project.demo.coursemanagement.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import project.demo.coursemanagement.entities.Category;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class EnrolledCourse {
    // Thông tin khóa học
    private Integer id;                    // Course ID
    private String courseCode;
    private String title;
    private Category category;
    private String imageUrl;
    private Integer durationHours;

    // Thông tin liên quan đến việc enroll
    private LocalDateTime enrollmentDate;
    private LocalDateTime completionDate;

    private BigDecimal progressPercentage;
    private BigDecimal grade;
    private String status;

    private Boolean certificateIssued;
}
