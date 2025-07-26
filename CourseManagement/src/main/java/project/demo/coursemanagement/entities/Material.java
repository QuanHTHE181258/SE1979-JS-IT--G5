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
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "MaterialID")
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "LessonID")
    private Lesson lessonID;

    @Size(max = 255)
    @Column(name = "Title")
    private String title;

    @Size(max = 255)
    @Column(name = "FileURL")
    private String fileURL;

    public void setLessonId(int lessonId) {
        Lesson lesson = new Lesson();
        lesson.setId(lessonId);
        this.lessonID = lesson;
    }
}