package project.demo.coursemanagement.dto;

import java.math.BigDecimal;
import java.time.Instant;

/**
 * Data Transfer Object for course statistics
 */
public class CourseStatsDTO {
    private Long id;
    private String title;
    private String description;
    private BigDecimal price;
    private Double rating;
    private Instant createdAt;
    private String imageURL;
    private String status; // Added status field

    private Long feedbackCount;
    private Long materialCount;
    private Long quizCount;
    private Long enrollmentCount;
    private Long categoryId;
    private String categoryName;

    private Long instructorId;
    private String instructorFirstName;
    private String instructorLastName;

    // Updated Constructor to include status
    public CourseStatsDTO(Long id, String title, String description, BigDecimal price,
                          Double rating, Instant createdAt, String imageURL, String status,
                          Long feedbackCount, Long materialCount, Long quizCount, Long enrollmentCount,
                          Long categoryId, String categoryName,
                          Long instructorId, String instructorFirstName, String instructorLastName) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.price = price;
        this.rating = rating;
        this.createdAt = createdAt;
        this.imageURL = imageURL;
        this.status = status;
        this.feedbackCount = feedbackCount;
        this.materialCount = materialCount;
        this.quizCount = quizCount;
        this.enrollmentCount = enrollmentCount;
        this.categoryId = categoryId;
        this.categoryName = categoryName;
        this.instructorId = instructorId;
        this.instructorFirstName = instructorFirstName;
        this.instructorLastName = instructorLastName;
    }

    // Getter and setter for status
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    // Existing getters and setters
    public Long getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Long categoryId) {
        this.categoryId = categoryId;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public Double getRating() {
        return rating;
    }

    public void setRating(Double rating) {
        this.rating = rating;
    }

    public Instant getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Instant createdAt) {
        this.createdAt = createdAt;
    }

    public String getImageURL() {
        return imageURL;
    }

    public void setImageURL(String imageURL) {
        this.imageURL = imageURL;
    }

    public Long getFeedbackCount() {
        return feedbackCount;
    }

    public void setFeedbackCount(Long feedbackCount) {
        this.feedbackCount = feedbackCount;
    }

    public Long getMaterialCount() {
        return materialCount;
    }

    public void setMaterialCount(Long materialCount) {
        this.materialCount = materialCount;
    }

    public Long getQuizCount() {
        return quizCount;
    }

    public void setQuizCount(Long quizCount) {
        this.quizCount = quizCount;
    }

    public Long getEnrollmentCount() {
        return enrollmentCount;
    }

    public void setEnrollmentCount(Long enrollmentCount) {
        this.enrollmentCount = enrollmentCount;
    }

    public Long getInstructorId() {
        return instructorId;
    }

    public void setInstructorId(Long instructorId) {
        this.instructorId = instructorId;
    }

    public String getInstructorFirstName() {
        return instructorFirstName;
    }

    public void setInstructorFirstName(String instructorFirstName) {
        this.instructorFirstName = instructorFirstName;
    }

    public String getInstructorLastName() {
        return instructorLastName;
    }

    public void setInstructorLastName(String instructorLastName) {
        this.instructorLastName = instructorLastName;
    }
}