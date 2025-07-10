package project.demo.coursemanagement.dto;

import lombok.Data;
import java.math.BigDecimal;
import java.time.Instant;
import java.util.Date;

@Data
public class CourseDTO {
    private String courseCode;
    private String title;
    private String description;
    private String shortDescription;
    private int teacherId;
    private int categoryId;
    private String imageUrl;
    private BigDecimal price;
    private int durationHours;
    private String teacherUsername;
    private String level;
    private boolean isPublished;
    private boolean isActive;
    private int maxStudents;
    private Instant enrollmentStartDate;
    private Instant enrollmentEndDate;
    private Instant startDate;
    private Instant endDate;
    private int lessonCount;
    private Instant createdAt;
    private java.util.Date createdAtDate;
    private int enrollmentCount;
    private BigDecimal rating;
    private String status;

    private int courseID;
    private String courseTitle;
    private String courseDescription;
    private Double rating;
    private String teacherName;
    private String categories;
    private String courseStatus;

    public CourseDTO() {
    }

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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getShortDescription() {
        return shortDescription;
    }

    public void setShortDescription(String shortDescription) {
        this.shortDescription = shortDescription;
    }

    public int getTeacherId() {
        return teacherId;
    }

    public void setTeacherId(int teacherId) {
        this.teacherId = teacherId;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
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

    public String getTeacherUsername() {
        return teacherUsername;
    }

    public void setTeacherUsername(String teacherUsername) {
        this.teacherUsername = teacherUsername;
    }

    public String getLevel() {
        return level;
    }

    public void setLevel(String level) {
        this.level = level;
    }

    public boolean isPublished() {
        return isPublished;
    }

    public void setPublished(boolean published) {
        isPublished = published;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }

    public int getMaxStudents() {
        return maxStudents;
    }

    public void setMaxStudents(int maxStudents) {
        this.maxStudents = maxStudents;
    }

    public Instant getEnrollmentStartDate() {
        return enrollmentStartDate;
    }

    public void setEnrollmentStartDate(Instant enrollmentStartDate) {
        this.enrollmentStartDate = enrollmentStartDate;
    }

    public Instant getEnrollmentEndDate() {
        return enrollmentEndDate;
    }

    public void setEnrollmentEndDate(Instant enrollmentEndDate) {
        this.enrollmentEndDate = enrollmentEndDate;
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

    public int getLessonCount() {
        return lessonCount;
    }

    public void setLessonCount(int lessonCount) {
        this.lessonCount = lessonCount;
    }

    public Instant getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Instant createdAt) {
        this.createdAt = createdAt;
    }

    public java.util.Date getCreatedAtDate() {
        return createdAtDate;
    }

    public void setCreatedAtDate(java.util.Date createdAtDate) {
        this.createdAtDate = createdAtDate;
    }

    public int getEnrollmentCount() {
        return enrollmentCount;
    }

    public void setEnrollmentCount(int enrollmentCount) {
        this.enrollmentCount = enrollmentCount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
    public int getCourseID() {
        return courseID;
    }

    public void setCourseID(int courseID) {
        this.courseID = courseID;
    }

    public String getCourseTitle() {
        return courseTitle;
    }

    public void setCourseTitle(String courseTitle) {
        this.courseTitle = courseTitle;
    }

    public String getCourseDescription() {
        return courseDescription;
    }

    public void setCourseDescription(String courseDescription) {
        this.courseDescription = courseDescription;
    }

    public Double getRating() {
        return rating;
    }

    public void setRating(Double rating) {
        this.rating = rating;
    }

    public String getTeacherName() {
        return teacherName;
    }

    public void setTeacherName(String teacherName) {
        this.teacherName = teacherName;
    }

    public String getCategories() {
        return categories;
    }

    public void setCategories(String categories) {
        this.categories = categories;
    }

    public String getCourseStatus() {
        return courseStatus;
    }

    public void setCourseStatus(String courseStatus) {
        this.courseStatus = courseStatus;
    }

    public Date getStartDateAsDate() {
        return startDate != null ? Date.from(startDate) : null;
    }

    public Date getEndDateAsDate() {
        return endDate != null ? Date.from(endDate) : null;
    }
}