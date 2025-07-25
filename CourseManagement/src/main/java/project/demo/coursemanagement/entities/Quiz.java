package project.demo.coursemanagement.entities;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.*;
import org.hibernate.annotations.Nationalized;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import java.util.List;

@Getter
@Setter
@Builder
@Entity
@AllArgsConstructor
@Table(name = "quizzes")
public class Quiz {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "QuizID", nullable = false)
    private Integer id;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "LessonID", nullable = false)
    private Lesson lessonID;

    @Size(max = 255)
    @Nationalized
    @Column(name = "Title")
    private String title;

    private int durationMinutes;

    @Transient
    private List<Question> questions;

    public Quiz() {}
    
    // Compatibility methods for existing code
    public void setLessonID(Lesson lesson) {
        this.lessonID = lesson;
    }
    
    public Lesson getLessonID() {
        return this.lessonID;
    }

    public Quiz(Integer id, Lesson lessonID, String title, int durationMinutes) {
        this.id = id;
        this.lessonID = lessonID;
        this.title = title;
        this.durationMinutes = durationMinutes;
    }

    public void setLessonId(int lessonId) {
        Lesson lesson = new Lesson();
        lesson.setId(lessonId);
        this.lessonID = lesson;
    }

    public void setQuestions(List<Question> questions) {
        this.questions = questions;
    }
}