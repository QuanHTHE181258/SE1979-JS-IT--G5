package project.demo.coursemanagement.entities;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.Nationalized;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "Courses")
public class Course {
    @Id
    @Column(name = "course_id", nullable = false)
    private Integer id;

    @Size(max = 20)
    @NotNull
    @Column(name = "course_code", nullable = false, length = 20)
    private String courseCode;

    @Size(max = 255)
    @NotNull
    @Nationalized
    @Column(name = "title", nullable = false)
    private String title;

    @Nationalized
    @Lob
    @Column(name = "description")
    private String description;

    @Size(max = 500)
    @Nationalized
    @Column(name = "short_description", length = 500)
    private String shortDescription;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "teacher_id", nullable = false)
    private User teacher;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "category_id", nullable = false)
    private Category category;

    @Size(max = 255)
    @ColumnDefault("'assets/images/default-course.jpg'")
    @Column(name = "image_url")
    private String imageUrl;

    @ColumnDefault("0")
    @Column(name = "price", precision = 10, scale = 2)
    private BigDecimal price;

    @ColumnDefault("0")
    @Column(name = "duration_hours")
    private Integer durationHours;

    @Size(max = 20)
    @ColumnDefault("'Beginner'")
    @Column(name = "\"level\"", length = 20)
    private String level;

    @ColumnDefault("0")
    @Column(name = "is_published")
    private Boolean isPublished;

    @ColumnDefault("1")
    @Column(name = "is_active")
    private Boolean isActive;

    @ColumnDefault("0")
    @Column(name = "max_students")
    private Integer maxStudents;

    @Column(name = "enrollment_start_date")
    private LocalDateTime enrollmentStartDate;

    @Column(name = "enrollment_end_date")
    private LocalDateTime enrollmentEndDate;

    @Column(name = "start_date")
    private LocalDateTime startDate;

    @Column(name = "end_date")
    private LocalDateTime endDate;

    @ColumnDefault("getdate()")
    @Column(name = "created_at")
    private LocalDateTime createdAt;

    @ColumnDefault("getdate()")
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
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

    public User getTeacher() {
        return teacher;
    }

    public void setTeacher(User teacher) {
        this.teacher = teacher;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
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

    public Integer getDurationHours() {
        return durationHours;
    }

    public void setDurationHours(Integer durationHours) {
        this.durationHours = durationHours;
    }

    public String getLevel() {
        return level;
    }

    public void setLevel(String level) {
        this.level = level;
    }

    public Boolean getIsPublished() {
        return isPublished;
    }

    public void setIsPublished(Boolean isPublished) {
        this.isPublished = isPublished;
    }

    public Boolean getIsActive() {
        return isActive;
    }

    public void setIsActive(Boolean isActive) {
        this.isActive = isActive;
    }

    public Integer getMaxStudents() {
        return maxStudents;
    }

    public void setMaxStudents(Integer maxStudents) {
        this.maxStudents = maxStudents;
    }

    public LocalDateTime getEnrollmentStartDate() {
        return enrollmentStartDate;
    }

    public void setEnrollmentStartDate(LocalDateTime enrollmentStartDate) {
        this.enrollmentStartDate = enrollmentStartDate;
    }

    public LocalDateTime getEnrollmentEndDate() {
        return enrollmentEndDate;
    }

    public void setEnrollmentEndDate(LocalDateTime enrollmentEndDate) {
        this.enrollmentEndDate = enrollmentEndDate;
    }

    public LocalDateTime getStartDate() {
        return startDate;
    }

    public void setStartDate(LocalDateTime startDate) {
        this.startDate = startDate;
    }

    public LocalDateTime getEndDate() {
        return endDate;
    }

    public void setEndDate(LocalDateTime endDate) {
        this.endDate = endDate;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

}