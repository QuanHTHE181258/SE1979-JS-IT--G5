package project.demo.coursemanagement.entities;

import jakarta.persistence.Embeddable;
import lombok.*;

import java.io.Serializable;
import java.util.Objects;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Embeddable
public class QuestionAttemptId implements Serializable {
    private int attemptID;
    private int questionID;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        QuestionAttemptId that = (QuestionAttemptId) o;
        return attemptID == that.attemptID && questionID == that.questionID;
    }

    @Override
    public int hashCode() {
        return Objects.hash(attemptID, questionID);
    }
}
