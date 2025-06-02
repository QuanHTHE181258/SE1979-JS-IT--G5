package project.demo.coursemanagement.dto;

import lombok.Data;

import java.math.BigDecimal;
import java.time.Instant;

@Data
public class CourseDTO {
    private Integer id;
    private String courseCode;
    private String title;
    private String shortDescription;
    private String teacherUsername;
    private BigDecimal price;
    private int durationHours;
    private int maxStudents;
    private Instant startDate;
    private Instant endDate;

    // Constructor
    public CourseDTO() {
    }
}