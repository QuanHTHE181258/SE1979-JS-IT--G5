package project.demo.coursemanagement.entities;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.Nationalized;

import java.math.BigDecimal;
import java.time.Instant;

@Getter
@Setter
@Entity
@Table(name = "cart")
public class Cart {
    @Id
    @Column(name = "CartID", nullable = false)
    private Integer id;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "UserID", nullable = false)
    private User userID;

    @Size(max = 20)
    @Nationalized
    @ColumnDefault("'active'")
    @Column(name = "Status", length = 20)
    private String status;

    @ColumnDefault("0")
    @Column(name = "TotalPrice", precision = 10, scale = 2)
    private BigDecimal totalPrice;

    @ColumnDefault("getdate()")
    @Column(name = "CreatedAt")
    private Instant createdAt;

}