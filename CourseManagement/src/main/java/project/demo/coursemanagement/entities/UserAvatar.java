package project.demo.coursemanagement.entities;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.Nationalized;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import java.time.Instant;

@Getter
@Setter
@Entity
@Table(name = "user_avatars")
public class UserAvatar {
    @Id
    @Column(name = "AvatarID", nullable = false)
    private Integer id;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "UserID", nullable = false)
    private User userID;

    @Size(max = 255)
    @Nationalized
    @Column(name = "ImageURL")
    private String imageURL;

    @ColumnDefault("0")
    @Column(name = "IsDefault")
    private Boolean isDefault;

    @ColumnDefault("getdate()")
    @Column(name = "UploadedAt")
    private Instant uploadedAt;

}