package com.csc340_team4.petpals.entity;

import java.util.List;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.OneToMany;
import jakarta.persistence.PrimaryKeyJoinColumn;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "caretakers")
@Data
@EqualsAndHashCode(callSuper = true)
@NoArgsConstructor
@AllArgsConstructor
@PrimaryKeyJoinColumn(name = "caretake_id")
public class Caretaker extends User{
    @OneToMany(mappedBy = "caretaker") 
    private List<Review> reviews;
    @Column(columnDefinition = "TEXT")
    private String servicesProvided;
}
