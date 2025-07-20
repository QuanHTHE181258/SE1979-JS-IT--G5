package project.demo.coursemanagement.entities;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.*;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "question_attempts")
public class QuestionAttempt {
    @EmbeddedId
    private QuestionAttemptId id;

    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("attemptID")
    @JoinColumn(name = "AttemptID", nullable = false)
    private QuizAttempt attemptID;

    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("questionID")
    @JoinColumn(name = "QuestionID", nullable = false)
    private Question questionID;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "SelectedAnswerID", nullable = false)
    private Answer answer;

    @Column(name = "IsCorrect")
    private Boolean isCorrect;
}
