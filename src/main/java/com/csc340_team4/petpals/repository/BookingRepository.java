package com.csc340_team4.petpals.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.csc340_team4.petpals.entity.Booking;
import com.csc340_team4.petpals.entity.Caretaker;
import com.csc340_team4.petpals.entity.Customer;
import com.csc340_team4.petpals.entity.Pet;

@Repository
public interface BookingRepository extends JpaRepository<Booking, Long> {
    List<Booking> findByCaretakerUserId(Long caretakerId);

    boolean existsByCustomerAndCaretakerAndPetAndStatus(Customer c, Caretaker ck, Pet p, String status);
}