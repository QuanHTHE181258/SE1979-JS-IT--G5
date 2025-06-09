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

/**
 * Adapter class to provide backward compatibility with the old UserImage entity.
 * This class extends UserAvatar and provides the same interface as the old UserImage class.
 */
@Getter
@Setter
@Entity
@Table(name = "user_avatars")
public class UserImage {
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

    // Additional fields for backward compatibility
    @Transient
    private User user;

    @Transient
    private String imageName;

    @Transient
    private String imagePath;

    @Transient
    private Long imageSize;

    @Transient
    private String imageType;

    @Transient
    private Instant uploadDate;

    public UserImage() {
        // Default constructor
    }

    // Getters and setters for backward compatibility

    public User getUser() {
        return user != null ? user : userID;
    }

    public void setUser(User user) {
        this.user = user;
        this.userID = user;
    }

    public String getImageName() {
        return imageName;
    }

    public void setImageName(String imageName) {
        this.imageName = imageName;
    }

    public String getImagePath() {
        return imagePath != null ? imagePath : imageURL;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
        this.imageURL = imagePath;
    }

    public Long getImageSize() {
        return imageSize;
    }

    public void setImageSize(Long imageSize) {
        this.imageSize = imageSize;
    }

    public String getImageType() {
        return imageType;
    }

    public void setImageType(String imageType) {
        this.imageType = imageType;
    }

    public Boolean getIsDefault() {
        return isDefault;
    }

    public void setIsDefault(Boolean isDefault) {
        this.isDefault = isDefault;
    }

    public Instant getUploadDate() {
        return uploadDate != null ? uploadDate : uploadedAt;
    }

    public void setUploadDate(Instant uploadDate) {
        this.uploadDate = uploadDate;
        this.uploadedAt = uploadDate;
    }
}
