package com.csc340_team4.petpals.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.csc340_team4.petpals.entity.Caretaker;

@Repository
public interface CaretakerRepository extends JpaRepository<Caretaker, Long> {
    Caretaker findByEmail(String email);
}

