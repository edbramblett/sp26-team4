package com.csc340_team4.petpals.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import java.time.LocalDateTime;

import org.hibernate.type.descriptor.java.LocalDateTimeJavaDescriptor;

import com.fasterxml.jackson.annotation.JsonIgnore;
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
    private LocalDateTime date;

    @ManyToOne
    @JoinColumn(name = "caretaker_id", nullable = true)
    private Caretaker caretaker;

    // @ManyToOne
    // @JoinColumn(name = "customer_id", nullable = false)
    // private Customer customer;

    @OneToOne(mappedBy = "booking", cascade = CascadeType.ALL)
    @JsonIgnore
    private IncidentReport incidentReport;

    // @OneToMany(mappedBy = "booking", cascade = CascadeType.ALL)
    // private List<Pet> pets = new ArrayList<>();

    @Transient
    private Long caretaker_id;

    @Transient
    private Long customer_id;
}