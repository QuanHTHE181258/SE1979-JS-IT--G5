package project.demo.coursemanagement.entities;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.*;
import org.hibernate.annotations.Nationalized;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import java.util.List;

@Getter
@Setter
@Builder(builderMethodName = "internalBuilder")
@AllArgsConstructor
@Entity
@Table(name = "questions")
public class Question {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "QuestionID", nullable = false)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "QuizID", nullable = false)
    private Quiz quiz;

    @Column(name = "QuestionText")
    private String questionText;

    @Transient
    private List<Answer> answers;

    public Question() {
    }
    
    // Custom builder with quizID method
    public static QuestionBuilder builder() {
        return new CustomQuestionBuilder();
    }
    
    public static class CustomQuestionBuilder extends QuestionBuilder {
        public CustomQuestionBuilder quizID(Quiz quiz) {
            super.quiz(quiz);
            return this;
        }
    }
    
    // Compatibility method for existing code
    public Question quizID(Quiz quiz) {
        this.quiz = quiz;
        return this;
    }

    public Question(Integer id, Quiz quiz, String questionText) {
        this.id = id;
        this.quiz = quiz;
        this.questionText = questionText;
    }

    public List<Answer> getAnswers() {
        return answers;
    }

    public void setAnswers(List<Answer> answers) {
        this.answers = answers;
    }
    
    // Compatibility method for existing code
    public Quiz getQuizID() {
        return this.quiz;
    }
}