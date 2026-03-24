package com.csc340_team4.petpals.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

import com.csc340_team4.petpals.entity.Booking;

@Repository
public interface BookingRepository extends JpaRepository<Booking, Long> {
    List<Booking> findByCaretakerUserId(Long caretakerId);
    List<Booking> findByCustomerUserId(Long customerId);
}
