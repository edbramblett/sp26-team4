package com.csc340_team4.petpals.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.time.LocalDateTime;

@Entity
@Table(name = "bookings")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Booking {

    public enum BookingStatus {
        PENDING,
        ACCEPTED,
        COMPLETED,
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long bookingId;

    @Column(nullable = false)
    private String serviceType;

    @Column(nullable = false)
    private LocalDateTime date;

    @ManyToOne
    @JoinColumn(name = "caretaker_id", nullable = false)  // Now required from the start
    private Caretaker caretaker;

    @ManyToOne
    @JoinColumn(name = "customer_id", nullable = false)
    private Customer customer;

    @Enumerated(EnumType.STRING)
    private BookingStatus status;
    
    @Transient
    private String petIds;
    
    @ManyToOne
    @JoinColumn(name = "pet_id")
    private Pet pet;


}


