package project.demo.coursemanagement.entities;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.Nationalized;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import java.math.BigDecimal;
import java.time.Instant;

@Entity
@Table(name = "Assignments")
public class Assignment {
    @Id
    @Column(name = "assignment_id", nullable = false)
    private Integer id;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "course_id", nullable = false)
    private Cours course;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "lesson_id")
    private Lesson lesson;

    @Size(max = 255)
    @NotNull
    @Nationalized
    @Column(name = "title", nullable = false)
    private String title;

    @Nationalized
    @Lob
    @Column(name = "description")
    private String description;

    @Nationalized
    @Lob
    @Column(name = "instructions")
    private String instructions;

    @ColumnDefault("100")
    @Column(name = "max_score", precision = 5, scale = 2)
    private BigDecimal maxScore;

    @ColumnDefault("1")
    @Column(name = "weight", precision = 5, scale = 2)
    private BigDecimal weight;

    @Column(name = "due_date")
    private Instant dueDate;

    @ColumnDefault("0")
    @Column(name = "allow_late_submission")
    private Boolean allowLateSubmission;

    @ColumnDefault("0")
    @Column(name = "late_penalty_percent", precision = 5, scale = 2)
    private BigDecimal latePenaltyPercent;

    @ColumnDefault("1")
    @Column(name = "max_attempts")
    private Integer maxAttempts;

    @ColumnDefault("0")
    @Column(name = "is_published")
    private Boolean isPublished;

    @ColumnDefault("getdate()")
    @Column(name = "created_at")
    private Instant createdAt;

    @ColumnDefault("getdate()")
    @Column(name = "updated_at")
    private Instant updatedAt;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Cours getCourse() {
        return course;
    }

    public void setCourse(Cours course) {
        this.course = course;
    }

    public Lesson getLesson() {
        return lesson;
    }

    public void setLesson(Lesson lesson) {
        this.lesson = lesson;
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

    public String getInstructions() {
        return instructions;
    }

    public void setInstructions(String instructions) {
        this.instructions = instructions;
    }

    public BigDecimal getMaxScore() {
        return maxScore;
    }

    public void setMaxScore(BigDecimal maxScore) {
        this.maxScore = maxScore;
    }

    public BigDecimal getWeight() {
        return weight;
    }

    public void setWeight(BigDecimal weight) {
        this.weight = weight;
    }

    public Instant getDueDate() {
        return dueDate;
    }

    public void setDueDate(Instant dueDate) {
        this.dueDate = dueDate;
    }

    public Boolean getAllowLateSubmission() {
        return allowLateSubmission;
    }

    public void setAllowLateSubmission(Boolean allowLateSubmission) {
        this.allowLateSubmission = allowLateSubmission;
    }

    public BigDecimal getLatePenaltyPercent() {
        return latePenaltyPercent;
    }

    public void setLatePenaltyPercent(BigDecimal latePenaltyPercent) {
        this.latePenaltyPercent = latePenaltyPercent;
    }

    public Integer getMaxAttempts() {
        return maxAttempts;
    }

    public void setMaxAttempts(Integer maxAttempts) {
        this.maxAttempts = maxAttempts;
    }

    public Boolean getIsPublished() {
        return isPublished;
    }

    public void setIsPublished(Boolean isPublished) {
        this.isPublished = isPublished;
    }

    public Instant getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Instant createdAt) {
        this.createdAt = createdAt;
    }

    public Instant getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Instant updatedAt) {
        this.updatedAt = updatedAt;
    }

}