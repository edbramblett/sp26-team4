package com.csc340_team4.petpals.entity;

import java.time.LocalDateTime;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.PrePersist;
import jakarta.persistence.Table;

@Entity
@Table(name = "bookings")
public class Booking {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long bookingId;
    private LocalDateTime date;

    @ManyToOne
    @JoinColumn(name = "customer_id")
    private Customer customer;

    @ManyToOne
    @JoinColumn(name = "caretaker_id")
    private Caretaker caretaker;

    @ManyToOne
    @JoinColumn(name = "pet_id")
    private Pet pet;

    private String status = "PENDING"; 

    public Long getBookingId() { return bookingId; }
    public void setBookingId(Long bookingId) { this.bookingId = bookingId; }

    public Customer getCustomer() { return customer; }
    public void setCustomer(Customer customer) { this.customer = customer; }

    public Caretaker getCaretaker() { return caretaker; }
    public void setCaretaker(Caretaker caretaker) { this.caretaker = caretaker; }

    public Pet getPet() { return pet; }
    public void setPet(Pet pet) { this.pet = pet; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    @PrePersist
protected void onCreate() {
    this.date = LocalDateTime.now();
}

public LocalDateTime getDate() { return date; }
public void setDate(LocalDateTime date) { this.date = date; }

private String serviceType = "Pet Sitting"; 

public String getServiceType() { return serviceType; }
public void setServiceType(String serviceType) { this.serviceType = serviceType; }

}