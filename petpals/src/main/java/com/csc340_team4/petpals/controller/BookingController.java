package com.csc340_team4.petpals.controller;

import com.csc340_team4.petpals.entity.Booking;
import com.csc340_team4.petpals.entity.Booking.BookingStatus;
import com.csc340_team4.petpals.entity.Caretaker;
import com.csc340_team4.petpals.entity.Customer;
import com.csc340_team4.petpals.service.BookingService;
import com.csc340_team4.petpals.service.CaretakerService;
import com.csc340_team4.petpals.service.CustomerService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.apache.tomcat.util.net.openssl.ciphers.Authentication;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/api/bookings")
public class BookingController {

    @Autowired
    private BookingService bookingService;
    
    @Autowired
    private CaretakerService caretakerService;

    @Autowired
    private CustomerService customerService;

    @PostMapping
    public ResponseEntity<?> createBooking(@RequestBody Map<String, Object> request) {
        try {
            String serviceType = (String) request.get("serviceType");
            String dateStr = (String) request.get("date");
            Integer customerId = (Integer) request.get("customer_id");
            Integer caretakerId = (Integer) request.get("caretaker_id");  // Caretaker ID from the start;
            
            // Validate required fields
            if (serviceType == null || dateStr == null || customerId == null || caretakerId == null) {
                Map<String, String> error = new HashMap<>();
                error.put("error", "Missing required fields: serviceType, date, customer_id, caretaker_id");
                return new ResponseEntity<>(error, HttpStatus.BAD_REQUEST);
            }
            
            // Parse date
            LocalDateTime date = LocalDateTime.parse(dateStr);
            
            // Get the caretaker
            Optional<Caretaker> caretakerOpt = caretakerService.getCaretakerById(Long.valueOf(caretakerId));
            if (caretakerOpt.isEmpty()) {
                Map<String, String> error = new HashMap<>();
                error.put("error", "Caretaker not found with id: " + caretakerId);
                return new ResponseEntity<>(error, HttpStatus.NOT_FOUND);
            }
            
            // Create new booking
            Booking booking = new Booking();
            booking.setServiceType(serviceType);
            booking.setDate(date);
            booking.setCaretaker(caretakerOpt.get());
            Customer customer = customerService.getCustomerById(Long.valueOf(customerId));
            booking.setCustomer(customer);
            booking.setStatus(BookingStatus.PENDING);
            
            
            Booking savedBooking = bookingService.createBooking(booking);
            return new ResponseEntity<>(savedBooking, HttpStatus.CREATED);
            
        } catch (Exception e) {
            Map<String, String> error = new HashMap<>();
            error.put("error", "Failed to create booking: " + e.getMessage());
            return new ResponseEntity<>(error, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @GetMapping
    public ResponseEntity<List<Booking>> getAllBookings() {
        return new ResponseEntity<>(bookingService.getAllBookings(), HttpStatus.OK);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Booking> getBookingById(@PathVariable Long id) {
        return bookingService.getBookingById(id)
                .map(b -> new ResponseEntity<>(b, HttpStatus.OK))
                .orElse(new ResponseEntity<>(HttpStatus.NOT_FOUND));
    }

    @GetMapping("/caretaker/{caretakerId}")
    public ResponseEntity<List<Booking>> getBookingsByCaretaker(@PathVariable Long caretakerId) {
        List<Booking> bookings = bookingService.getBookingsForCaretaker(caretakerId);
        return new ResponseEntity<>(bookings, HttpStatus.OK);
    }

    @PostMapping("/bookings/complete/{bookingId}")
        public String completeBooking(@PathVariable Long bookingId,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {
            if (session.getAttribute("userRole") == null || 
                !session.getAttribute("userRole").equals("CARETAKER")) {
                return "redirect:/login";
            }
            
            Long caretakerId = (Long) session.getAttribute("userId");
            
            try {
                Booking booking = bookingService.getBookingById(bookingId).orElse(null);
                if (booking != null && booking.getCaretaker() != null && 
                    booking.getCaretaker().getUserId().equals(caretakerId)) {
                    
                    bookingService.completeBooking(bookingId);
                    redirectAttributes.addFlashAttribute("success", "Booking marked as complete!");
                } else {
                    redirectAttributes.addFlashAttribute("error", "Booking not found or doesn't belong to you");
                }
            } catch (Exception e) {
                redirectAttributes.addFlashAttribute("error", "Error completing booking: " + e.getMessage());
            }
        
        return "redirect:/caretaker/bookings";
    }


    @PutMapping("/{bookingId}/status")
    public ResponseEntity<Booking> updateBookingStatus(@PathVariable Long bookingId, 
                                                        @RequestParam String status) {
        try {
            Booking updated = bookingService.updateBookingStatus(bookingId, status);
            return ResponseEntity.ok(updated);
        } catch (RuntimeException e) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @DeleteMapping("/{bookingId}/decline")
    public ResponseEntity<?> declineBooking(@PathVariable Long bookingId) {
        try {
            Booking booking = bookingService.getBookingById(bookingId).orElse(null);
            if (booking == null) {
                return new ResponseEntity<>("Booking not found", HttpStatus.NOT_FOUND);
            }
            
            bookingService.declineBooking(bookingId);  // This now deletes the booking
            Map<String, String> response = new HashMap<>();
            response.put("message", "Booking declined and removed successfully");
            return new ResponseEntity<>(response, HttpStatus.OK);
            
        } catch (Exception e) {
            Map<String, String> error = new HashMap<>();
            error.put("error", "Failed to decline booking: " + e.getMessage());
            return new ResponseEntity<>(error, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

 }
