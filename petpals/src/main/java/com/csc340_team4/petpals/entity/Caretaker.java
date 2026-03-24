package com.csc340_team4.petpals.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import java.util.List;

@Entity
@Table(name = "caretakers")
@Data
@EqualsAndHashCode(callSuper = true)
@NoArgsConstructor
@AllArgsConstructor
@PrimaryKeyJoinColumn(name = "caretake_id")
public class Caretaker extends User{
    @Column(columnDefinition = "TEXT")
    private String servicesProvided;

    @OneToMany(mappedBy = "caretaker", cascade = CascadeType.ALL)
    private List<Booking> bookings;
}
