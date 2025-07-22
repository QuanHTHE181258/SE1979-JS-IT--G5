package project.demo.coursemanagement.entities;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.*;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.Nationalized;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

@Getter
@Setter
@Builder(builderMethodName = "internalBuilder")
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "answers")
public class Answer {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "AnswerID", nullable = false)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "QuestionID", nullable = false)
    private Question question;

    @Column(name = "AnswerText")
    private String answerText;

    @Column(name = "IsCorrect")
    private Boolean isCorrect;
    
    // Custom builder with questionID method
    public static AnswerBuilder builder() {
        return new CustomAnswerBuilder();
    }
    
    public static class CustomAnswerBuilder extends AnswerBuilder {
        public CustomAnswerBuilder questionID(Question question) {
            super.question(question);
            return this;
        }
    }
    
    // Compatibility methods for existing code
    public Answer questionID(Question question) {
        this.question = question;
        return this;
    }
    
    public Question getQuestionID() {
        return this.question;
    }
}