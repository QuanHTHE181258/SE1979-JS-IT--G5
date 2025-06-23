package project.demo.coursemanagement.entities;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

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

    @Column(name = "enrollment_date")
    private Instant enrollmentDate;

    @Column(name = "completion_date")
    private Instant completionDate;

    @Column(name = "progress_percentage")
    private Integer progressPercentage = 0;

    @Column(name = "status", length = 50)
    private String status;

    @Column(name = "grade", length = 10)
    private String grade;

    @Column(name = "certificate_issued")
    private Boolean certificateIssued = false;
}
