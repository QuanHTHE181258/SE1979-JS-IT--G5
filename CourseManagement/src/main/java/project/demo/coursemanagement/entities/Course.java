package project.demo.coursemanagement.entities;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.Nationalized;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Getter
@Setter
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
}