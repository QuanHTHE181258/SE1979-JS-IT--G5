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
public class CourseProgressId implements Serializable {
    private static final long serialVersionUID = 2295190454593479107L;
    @NotNull
    @Column(name = "UserID", nullable = false)
    private Integer userID;

    @NotNull
    @Column(name = "CourseID", nullable = false)
    private Integer courseID;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || Hibernate.getClass(this) != Hibernate.getClass(o)) return false;
        CourseProgressId entity = (CourseProgressId) o;
        return Objects.equals(this.userID, entity.userID) &&
                Objects.equals(this.courseID, entity.courseID);
    }

    @Override
    public int hashCode() {
        return Objects.hash(userID, courseID);
    }

}