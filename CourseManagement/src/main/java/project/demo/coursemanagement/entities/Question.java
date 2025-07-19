package project.demo.coursemanagement.entities;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.Nationalized;

@Getter
@Setter
@Entity
@Table(name = "questions")
public class Question {
    @Id
    @Column(name = "QuestionID", nullable = false)
    private Integer id;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "QuizID", nullable = false)
    private Quiz quiz;

    @Nationalized
    @Column(name = "QuestionText")
    private String questionText;
}
