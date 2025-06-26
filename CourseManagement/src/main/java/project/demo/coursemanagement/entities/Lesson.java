package project.demo.coursemanagement.entities;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.*;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.Nationalized;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import java.time.Instant;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "lessons")
public class Lesson {
    @Id
    @Column(name = "LessonID", nullable = false)
    private Integer id;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "CourseID", nullable = false)
    private Cours courseID;

    @Size(max = 255)
    @Nationalized
    @Column(name = "Title")
    private String title;

    @Nationalized
    @Lob
    @Column(name = "Content")
    private String content;

    @Size(max = 20)
    @Nationalized
    @Column(name = "Status", length = 20)
    private String status;

    @ColumnDefault("0")
    @Column(name = "IsFreePreview")
    private Boolean isFreePreview;

    @ColumnDefault("getdate()")
    @Column(name = "CreatedAt")
    private Instant createdAt;

}