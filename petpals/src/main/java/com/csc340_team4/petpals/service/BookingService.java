package com.csc340_team4.petpals.service;

import com.csc340_team4.petpals.entity.Booking;
import com.csc340_team4.petpals.entity.Caretaker;
import com.csc340_team4.petpals.repository.BookingRepository;
import com.csc340_team4.petpals.repository.CaretakerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;


@Service
public class BookingService {

    @Autowired
    private BookingRepository bookingRepository;

    @Autowired
    private CaretakerRepository caretakerRepository;


    public Booking createBooking(Long caretakerId, Booking bookingDetails) {

        Caretaker caretaker = caretakerRepository.findById(caretakerId)
                .orElseThrow(() -> new RuntimeException("Caretaker not found"));

        bookingDetails.setCaretaker(caretaker);

        return bookingRepository.save(bookingDetails);
    }

    public List<Booking> getAllBookings() {
        return bookingRepository.findAll();
    }

    public Optional<Booking> getBookingById(Long id) {
        return bookingRepository.findById(id);
    }

    public void deleteBooking(Long id) {
        bookingRepository.deleteById(id);
    }
}
