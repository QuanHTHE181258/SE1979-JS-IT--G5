package project.demo.coursemanagement.entities;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.*;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.Nationalized;

import java.time.Instant;
import java.time.LocalDate;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "users")
public class User {
    @Id
    @Column(name = "UserID", nullable = false)
    private Integer id;

    @Size(max = 50)
    @NotNull
    @Nationalized
    @Column(name = "Username", nullable = false, length = 50)
    private String username;

    @Size(max = 100)
    @NotNull
    @Nationalized
    @Column(name = "Email", nullable = false, length = 100)
    private String email;

    @Size(max = 255)
    @NotNull
    @Nationalized
    @Column(name = "PasswordHash", nullable = false)
    private String passwordHash;

    @Size(max = 20)
    @Nationalized
    @Column(name = "FirstName", length = 20)
    private String firstName;

    @Size(max = 20)
    @Nationalized
    @Column(name = "LastName", length = 20)
    private String lastName;

    @Size(max = 255)
    @Nationalized
    @Column(name = "AvatarUrl")
    private String avatarUrl;

    @Size(max = 20)
    @Nationalized
    @Column(name = "PhoneNumber", length = 20)
    private String phoneNumber;

    @Column(name = "DateOfBirth")
    private LocalDate dateOfBirth;

    @Column(name = "LastLogin")
    private Instant lastLogin;

    @ColumnDefault("getdate()")
    @Column(name = "CreatedAt")
    private Instant createdAt;

}