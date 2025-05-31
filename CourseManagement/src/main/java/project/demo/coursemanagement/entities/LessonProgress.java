package project.demo.coursemanagement.entities;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import java.time.LocalDateTime;

@Entity
public class LessonProgress {
    @Id
    @Column(name = "progress_id", nullable = false)
    private Integer id;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "lesson_id", nullable = false)
    private Lesson lesson;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "student_id", nullable = false)
    private User student;

    @ColumnDefault("0")
    @Column(name = "is_completed")
    private Boolean isCompleted;

    @Column(name = "completion_date")
    private LocalDateTime completionDate;

    @ColumnDefault("0")
    @Column(name = "watch_time_minutes")
    private Integer watchTimeMinutes;

    @ColumnDefault("0")
    @Column(name = "last_watched_position")
    private Integer lastWatchedPosition;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Lesson getLesson() {
        return lesson;
    }

    public void setLesson(Lesson lesson) {
        this.lesson = lesson;
    }

    public User getStudent() {
        return student;
    }

    public void setStudent(User student) {
        this.student = student;
    }

    public Boolean getIsCompleted() {
        return isCompleted;
    }

    public void setIsCompleted(Boolean isCompleted) {
        this.isCompleted = isCompleted;
    }

    public LocalDateTime getCompletionDate() {
        return completionDate;
    }

    public void setCompletionDate(LocalDateTime completionDate) {
        this.completionDate = completionDate;
    }

    public Integer getWatchTimeMinutes() {
        return watchTimeMinutes;
    }

    public void setWatchTimeMinutes(Integer watchTimeMinutes) {
        this.watchTimeMinutes = watchTimeMinutes;
    }

    public Integer getLastWatchedPosition() {
        return lastWatchedPosition;
    }

    public void setLastWatchedPosition(Integer lastWatchedPosition) {
        this.lastWatchedPosition = lastWatchedPosition;
    }

}