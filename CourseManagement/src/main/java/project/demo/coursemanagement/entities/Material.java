package project.demo.coursemanagement.entities;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.Nationalized;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

@Getter
@Setter
@Entity
@Table(name = "materials")
public class Material {
    @Id
    @Column(name = "MaterialID", nullable = false)
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

    @Size(max = 255)
    @Nationalized
    @Column(name = "FileURL")
    private String fileURL;

    public void setLessonId(int lessonId) {
        Lesson lesson = new Lesson();
        lesson.setId(lessonId);
        this.lessonID = lesson;
    }
}