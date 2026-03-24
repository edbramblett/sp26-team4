package com.csc340_team4.petpals.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


import org.hibernate.type.descriptor.java.LocalDateTimeJavaDescriptor;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
@Table(name = "bookings")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Booking {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long bookingId;

    @Column(nullable = false)
    private String serviceType;

    @Column(nullable = false)
    private LocalDateTimeJavaDescriptor date;

    @ManyToOne
    @JoinColumn(name = "caretaker_id", nullable = false)
    private Caretaker caretaker;
}
