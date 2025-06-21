package project.demo.coursemanagement.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

@Getter
@Setter
@Entity
@Table(name = "question_attempts")
public class QuestionAttempt {
    @EmbeddedId
    private QuestionAttemptId id;

    @MapsId("attemptID")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "AttemptID", nullable = false)
    private QuizAttempt attemptID;

    @MapsId("questionID")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "QuestionID", nullable = false)
    private Question questionID;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "SelectedAnswerID")
    private Answer selectedAnswerID;

    @Column(name = "IsCorrect")
    private Boolean isCorrect;

}