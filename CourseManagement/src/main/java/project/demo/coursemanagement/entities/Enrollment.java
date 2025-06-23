package project.demo.coursemanagement.entities;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.ColumnDefault;

import java.math.BigDecimal;
import java.time.Instant;

@Getter
@Setter
@Entity
@Table(name = "enrollments")
public class Enrollment {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
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

}