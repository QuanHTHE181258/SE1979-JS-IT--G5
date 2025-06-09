package project.demo.coursemanagement.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import java.time.Instant;

@Getter
@Setter
@Entity
@Table(name = "course_progress")
public class CourseProgress {
    @EmbeddedId
    private CourseProgressId id;

    @MapsId("userID")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "UserID", nullable = false)
    private User userID;

    @MapsId("courseID")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "CourseID", nullable = false)
    private Cours courseID;

    @ColumnDefault("0")
    @Column(name = "CompletedLessons")
    private Integer completedLessons;

    @ColumnDefault("0")
    @Column(name = "TotalLessons")
    private Integer totalLessons;

    @ColumnDefault("0")
    @Column(name = "ProgressPercent")
    private Double progressPercent;

    @ColumnDefault("getdate()")
    @Column(name = "LastAccessed")
    private Instant lastAccessed;

}