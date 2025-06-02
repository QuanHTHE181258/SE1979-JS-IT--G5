package project.demo.coursemanagement.dto;

import lombok.Data;
import project.demo.coursemanagement.entities.Category;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
    public class EnrolledCourse {
        private Integer id;
        private String courseCode;
        private String title;
        private Category category;
        private String imageUrl;
        private Integer durationHours;
        private LocalDateTime enrollmentStartDate;

        private BigDecimal progressPercentage;
        private BigDecimal grade;
        private String status;

    }
