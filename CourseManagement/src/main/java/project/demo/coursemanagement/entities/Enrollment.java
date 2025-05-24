package project.demo.coursemanagement.entities;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import org.hibernate.annotations.ColumnDefault;

import java.math.BigDecimal;
import java.time.Instant;

@Entity
@Table(name = "Enrollments")
public class Enrollment {
    @Id
    @Column(name = "enrollment_id", nullable = false)
    private Integer id;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "student_id", nullable = false)
    private User student;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "course_id", nullable = false)
    private Cours course;

    @ColumnDefault("getdate()")
    @Column(name = "enrollment_date")
    private Instant enrollmentDate;

    @Column(name = "completion_date")
    private Instant completionDate;

    @ColumnDefault("0")
    @Column(name = "progress_percentage", precision = 5, scale = 2)
    private BigDecimal progressPercentage;

    @Size(max = 20)
    @ColumnDefault("'ACTIVE'")
    @Column(name = "status", length = 20)
    private String status;

    @Column(name = "grade", precision = 5, scale = 2)
    private BigDecimal grade;

    @ColumnDefault("0")
    @Column(name = "certificate_issued")
    private Boolean certificateIssued;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public User getStudent() {
        return student;
    }

    public void setStudent(User student) {
        this.student = student;
    }

    public Cours getCourse() {
        return course;
    }

    public void setCourse(Cours course) {
        this.course = course;
    }

    public Instant getEnrollmentDate() {
        return enrollmentDate;
    }

    public void setEnrollmentDate(Instant enrollmentDate) {
        this.enrollmentDate = enrollmentDate;
    }

    public Instant getCompletionDate() {
        return completionDate;
    }

    public void setCompletionDate(Instant completionDate) {
        this.completionDate = completionDate;
    }

    public BigDecimal getProgressPercentage() {
        return progressPercentage;
    }

    public void setProgressPercentage(BigDecimal progressPercentage) {
        this.progressPercentage = progressPercentage;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public BigDecimal getGrade() {
        return grade;
    }

    public void setGrade(BigDecimal grade) {
        this.grade = grade;
    }

    public Boolean getCertificateIssued() {
        return certificateIssued;
    }

    public void setCertificateIssued(Boolean certificateIssued) {
        this.certificateIssued = certificateIssued;
    }

}