package project.demo.coursemanagement.entities;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Data;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.Nationalized;

import java.sql.Timestamp;
import java.time.LocalDate;

@Entity
@Data
@Table(name = "Users")
public class User {
    @Id
    @Column(name = "user_id", nullable = false)
    private Integer id;

    @Size(max = 50)
    @NotNull
    @Column(name = "username", nullable = false, length = 50)
    private String username;

    @Size(max = 100)
    @NotNull
    @Column(name = "email", nullable = false, length = 100)
    private String email;

    @Size(max = 255)
    @NotNull
    @Column(name = "password_hash", nullable = false)
    private String passwordHash;

    @Size(max = 50)
    @NotNull
    @Nationalized
    @Column(name = "first_name", nullable = false, length = 50)
    private String firstName;

    @Size(max = 50)
    @NotNull
    @Nationalized
    @Column(name = "last_name", nullable = false, length = 50)
    private String lastName;

    @Size(max = 20)
    @Column(name = "phone", length = 20)
    private String phone;

    @Column(name = "date_of_birth")
    private LocalDate dateOfBirth;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @ColumnDefault("2")
    @JoinColumn(name = "role_id", nullable = false)
    private Role role;

    @Size(max = 255)
    @ColumnDefault("NULL")
    @Column(name = "avatar_url")
    private String avatarUrl;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "current_avatar_id")
    private UserImage currentAvatar;

    @ColumnDefault("1")
    @Column(name = "is_active")
    private Boolean isActive;

    @ColumnDefault("0")
    @Column(name = "email_verified")
    private Boolean emailVerified;

    @Column(name = "last_login")
    private Timestamp lastLogin;

    @ColumnDefault("getdate()")
    @Column(name = "created_at")
    private Timestamp createdAt;

    @ColumnDefault("getdate()")
    @Column(name = "updated_at")
    private Timestamp updatedAt;
}