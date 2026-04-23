package com.csc340_team4.petpals.service;

import com.csc340_team4.petpals.entity.Booking;
import com.csc340_team4.petpals.entity.Booking.BookingStatus;
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

    public Booking createBooking(Booking booking) {
        if (booking.getStatus() == null) {
            booking.setStatus(BookingStatus.PENDING);
        }
        return bookingRepository.save(booking);
    }

    public Booking assignCaretaker(Long bookingId, Long caretaker_id) {
        Booking booking = bookingRepository.findById(bookingId)
                .orElseThrow(() -> new RuntimeException("Booking not found"));
    
        Caretaker caretaker = caretakerRepository.findById(caretaker_id)
                .orElseThrow(() -> new RuntimeException("Caretaker not found"));

        booking.setCaretaker(caretaker);
        booking.setStatus(BookingStatus.PENDING);
        return bookingRepository.save(booking);
    }
    
    public Booking acceptBooking(Long bookingId) {
        Booking booking = bookingRepository.findById(bookingId)
                .orElseThrow(() -> new RuntimeException("Booking not found"));
        
        booking.setStatus(BookingStatus.ACCEPTED);
        return bookingRepository.save(booking);
    }
    
    public void declineBooking(Long bookingId) {
        Booking booking = bookingRepository.findById(bookingId)
                .orElseThrow(() -> new RuntimeException("Booking not found"));
        
        // Delete the booking instead of saving as DECLINED
        bookingRepository.delete(booking);
    }
    
    public Booking updateBookingStatus(Long bookingId, String status) {
        Booking booking = bookingRepository.findById(bookingId)
                .orElseThrow(() -> new RuntimeException("Booking not found"));
        
        try {
            BookingStatus newStatus = BookingStatus.valueOf(status.toUpperCase());
            booking.setStatus(newStatus);
            return bookingRepository.save(booking);
        } catch (IllegalArgumentException e) {
            throw new RuntimeException("Invalid status: " + status);
        }
    }

    public List<Booking> getAllBookings() {
        return bookingRepository.findAll();
    }
    
    public List<Booking> getUnassignedBookings() {
        return bookingRepository.findByCaretakerIsNull();
    }
    
    public List<Booking> getPendingBookingsForCaretaker(Long caretakerId) {
        return bookingRepository.findByCaretakerUserIdAndStatus(caretakerId, BookingStatus.PENDING);
    }
    
    public List<Booking> getBookingsForCaretaker(Long caretakerId) {
        return bookingRepository.findByCaretakerUserId(caretakerId);
    }
    
    public Optional<Booking> getBookingById(Long id) {
        return bookingRepository.findById(id);
    }

    public void deleteBooking(Long id) {
        bookingRepository.deleteById(id);
    }

    public Booking completeBooking(Long bookingId) {
        Booking booking = bookingRepository.findById(bookingId)
                .orElseThrow(() -> new RuntimeException("Booking not found"));
        
        booking.setStatus(BookingStatus.COMPLETED);
        return bookingRepository.save(booking);
    }
}