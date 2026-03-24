package com.csc340_team4.petpals.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "caretakers")
@Data
@EqualsAndHashCode(callSuper = true)
@NoArgsConstructor
@AllArgsConstructor
@PrimaryKeyJoinColumn(name = "caretaker_id")
public class Caretaker extends User{
    @Column(columnDefinition = "TEXT")
    private String servicesProvided;

    @OneToMany(mappedBy = "caretaker", cascade = CascadeType.ALL)
    @JsonIgnore
    private List<Booking> bookings;

    @OneToMany(mappedBy = "caretaker", cascade = CascadeType.ALL)
    @JsonIgnore
    private List<IncidentReport> incidentReports = new ArrayList<>();

}
