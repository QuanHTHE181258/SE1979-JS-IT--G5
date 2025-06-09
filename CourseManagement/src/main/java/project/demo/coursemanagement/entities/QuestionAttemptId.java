package project.demo.coursemanagement.entities;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.Hibernate;

import java.io.Serializable;
import java.util.Objects;

@Getter
@Setter
@Embeddable
public class QuestionAttemptId implements Serializable {
    private static final long serialVersionUID = 7489298083058580236L;
    @NotNull
    @Column(name = "AttemptID", nullable = false)
    private Integer attemptID;

    @NotNull
    @Column(name = "QuestionID", nullable = false)
    private Integer questionID;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || Hibernate.getClass(this) != Hibernate.getClass(o)) return false;
        QuestionAttemptId entity = (QuestionAttemptId) o;
        return Objects.equals(this.questionID, entity.questionID) &&
                Objects.equals(this.attemptID, entity.attemptID);
    }

    @Override
    public int hashCode() {
        return Objects.hash(questionID, attemptID);
    }

}