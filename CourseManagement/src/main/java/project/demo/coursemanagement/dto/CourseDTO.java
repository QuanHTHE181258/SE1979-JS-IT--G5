package project.demo.coursemanagement.dto;

import java.math.BigDecimal;
import java.time.Instant;
import java.util.Date;

public class CourseDTO {
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

    // Getters and Setters

    public String getCourseCode() {
        return courseCode;
    }

    public void setCourseCode(String courseCode) {
        this.courseCode = courseCode;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getShortDescription() {
        return shortDescription;
    }

    public void setShortDescription(String shortDescription) {
        this.shortDescription = shortDescription;
    }

    public String getTeacherUsername() {
        return teacherUsername;
    }

    public void setTeacherUsername(String teacherUsername) {
        this.teacherUsername = teacherUsername;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public int getDurationHours() {
        return durationHours;
    }

    public void setDurationHours(int durationHours) {
        this.durationHours = durationHours;
    }

    public int getMaxStudents() {
        return maxStudents;
    }

    public void setMaxStudents(int maxStudents) {
        this.maxStudents = maxStudents;
    }

    public Instant getStartDate() {
        return startDate;
    }

    public void setStartDate(Instant startDate) {
        this.startDate = startDate;
    }

    public Instant getEndDate() {
        return endDate;
    }

    public void setEndDate(Instant endDate) {
        this.endDate = endDate;
    }

    public Date getStartDateAsDate() {
        return startDate != null ? Date.from(startDate) : null;
    }

    public Date getEndDateAsDate() {
        return endDate != null ? Date.from(endDate) : null;
    }
}