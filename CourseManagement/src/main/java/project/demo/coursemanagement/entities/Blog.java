package project.demo.coursemanagement.entities;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import jakarta.servlet.http.Part;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.Nationalized;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import java.time.Instant;
import java.util.Date;

@Getter
@Setter
@Entity
@Table(name = "blogs")
public class Blog {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "BlogID", nullable = false)
    private Integer id;

    @Size(max = 255)
    @NotNull
    @Nationalized
    @Column(name = "Title", nullable = false)
    private String title;

    @NotNull
    @Nationalized
    @Lob
    @Column(name = "Content", nullable = false)
    private String content;

    @Size(max = 255)
    @Nationalized
    @Column(name = "ImageURL")
    private String imageURL;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "AuthorID", nullable = false)
    private User authorID;

    @ColumnDefault("getdate()")
    @Column(name = "CreatedAt")
    private Instant createdAt;

    @Column(name = "UpdatedAt")
    private Instant updatedAt;

    @Size(max = 20)
    @Nationalized
    @ColumnDefault("'published'")
    @Column(name = "Status", length = 20)
    private String status;

    @Transient
    private Part imageFile;

    @Transient
    private Date createdAtDate;

    public Date getCreatedAtDate() {
        return createdAtDate;
    }

    public void setCreatedAtDate(Date createdAtDate) {
        this.createdAtDate = createdAtDate;
    }
}
