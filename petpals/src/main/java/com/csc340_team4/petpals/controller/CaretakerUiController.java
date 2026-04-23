package com.csc340_team4.petpals.controller;

import com.csc340_team4.petpals.entity.Booking;
import com.csc340_team4.petpals.entity.Caretaker;
import com.csc340_team4.petpals.entity.IncidentReport;
import com.csc340_team4.petpals.service.BookingService;
import com.csc340_team4.petpals.service.CaretakerService;
import com.csc340_team4.petpals.service.IncidentReportService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/caretaker")
public class CaretakerUiController {

    private CaretakerService caretakerService;
    private BookingService bookingService;
    private IncidentReportService incidentReportService;

    public CaretakerUiController(CaretakerService caretakerService, BookingService bookingService, IncidentReportService incidentReportService) {
        this.caretakerService = caretakerService;
        this.bookingService = bookingService;
        this.incidentReportService = incidentReportService;
    }

    @GetMapping({"/home", "/", "/index", "/dashboard"})
    public String home(HttpSession session, Model model) {
        // Check if user is logged in and is a caretaker
        if (session.getAttribute("userRole") == null || 
            !session.getAttribute("userRole").equals("CARETAKER")) {
            return "redirect:/login";
        }
        
        Long userId = (Long) session.getAttribute("userId");
        Caretaker caretaker = caretakerService.getCaretakerById(userId).orElse(null);
        
        if (caretaker != null) {
            model.addAttribute("caretaker", caretaker);
            model.addAttribute("title", "Provider Dashboard");
        } else {
            model.addAttribute("errorMessage", "Caretaker not found");
            model.addAttribute("title", "Error");
            return "error";
        }
        
        return "provider-templates/caretaker-home";
    }

    @GetMapping("/account")
    public String showEditAccountForm(HttpSession session, Model model) {
        if (session.getAttribute("userRole") == null || 
            !session.getAttribute("userRole").equals("CARETAKER")) {
            return "redirect:/login";
        }
        
        Long userId = (Long) session.getAttribute("userId");
        Caretaker caretaker = caretakerService.getCaretakerById(userId).orElse(null);
        
        if (caretaker != null) {
            model.addAttribute("caretaker", caretaker);
            model.addAttribute("title", "Edit Account");
            return "account";
        } else {
            model.addAttribute("errorMessage", "Caretaker not found");
            model.addAttribute("title", "Error");
            return "error";
        }
    }

    @PostMapping("/account/update")
    public String updateAccount(@RequestParam String firstName, @RequestParam String lastName, @RequestParam String phoneNumber, @RequestParam String email, @RequestParam(required = false) String servicesProvided, HttpSession session, RedirectAttributes redirectAttributes) {
        if (session.getAttribute("userRole") == null || 
            !session.getAttribute("userRole").equals("CARETAKER")) {
            return "redirect:/login";
        }
        
        Long userId = (Long) session.getAttribute("userId");

        Caretaker existingCaretaker = caretakerService.getCaretakerById(userId).orElse(null);
        
        if (existingCaretaker != null) {
            existingCaretaker.setFirstName(firstName);
            existingCaretaker.setLastName(lastName);
            existingCaretaker.setPhoneNumber(phoneNumber);
            existingCaretaker.setEmail(email);
            
            if (servicesProvided != null) {
                existingCaretaker.setServicesProvided(servicesProvided);
            }
            
            Caretaker updatedCaretaker = caretakerService.updateCaretaker(existingCaretaker.getUserId(), existingCaretaker);
            
            if (updatedCaretaker != null) {
                // Update session with new name
                session.setAttribute("userName", updatedCaretaker.getFirstName() + " " + updatedCaretaker.getLastName());
                session.setAttribute("userEmail", updatedCaretaker.getEmail());
                redirectAttributes.addFlashAttribute("success", "Account updated successfully!");
            } else {
                redirectAttributes.addFlashAttribute("error", "Failed to update account");
            }
        } else {
            redirectAttributes.addFlashAttribute("error", "Caretaker not found");
        }
        
        return "redirect:/caretaker/account";  // FIXED: Added redirect:
    }

    @GetMapping("/profile/{userId}")
    public String viewPublicProfile(@PathVariable Long userId, Model model) {
        Caretaker caretaker = caretakerService.getCaretakerById(userId).orElse(null);
        
        if (caretaker != null) {
            model.addAttribute("caretaker", caretaker);
            model.addAttribute("title", "Caretaker Profile");
            return "public-profile";
        } else {
            model.addAttribute("errorMessage", "Caretaker not found");
            model.addAttribute("title", "Error");
            return "error";
        }
    }

    @GetMapping("/bookings")
    public String allBookings(HttpSession session, Model model) {
        if (session.getAttribute("userRole") == null || 
            !session.getAttribute("userRole").equals("CARETAKER")) {
            return "redirect:/login";
        }
        
        Long caretakerId = (Long) session.getAttribute("userId");
        
        List<Booking> allBookings = bookingService.getBookingsForCaretaker(caretakerId);
        
        List<Booking> pendingBookings = allBookings.stream()
            .filter(b -> b.getStatus() == Booking.BookingStatus.PENDING)
            .collect(Collectors.toList());
        
        List<Booking> acceptedBookings = allBookings.stream()
            .filter(b -> b.getStatus() == Booking.BookingStatus.ACCEPTED)
            .collect(Collectors.toList());
        
        List<Booking> completedBookings = allBookings.stream()
            .filter(b -> b.getStatus() == Booking.BookingStatus.COMPLETED)
            .collect(Collectors.toList());
        
        model.addAttribute("title", "My Bookings");
        model.addAttribute("pendingBookings", pendingBookings);
        model.addAttribute("acceptedBookings", acceptedBookings);
        model.addAttribute("completedBookings", completedBookings);
        
        return "provider-templates/bookings";
    }

    @PostMapping("/bookings/accept/{bookingId}")
    public String acceptBooking(@PathVariable Long bookingId, HttpSession session, RedirectAttributes redirectAttributes) {
        if (session.getAttribute("userRole") == null || 
            !session.getAttribute("userRole").equals("CARETAKER")) {
            return "redirect:/login";
        }
        
        Long caretakerId = (Long) session.getAttribute("userId");
        
        try {
            Booking booking = bookingService.getBookingById(bookingId).orElse(null);
            if (booking != null && booking.getCaretaker() != null && 
                booking.getCaretaker().getUserId().equals(caretakerId)) {
                
                Booking acceptedBooking = bookingService.acceptBooking(bookingId);
                if (acceptedBooking != null) {
                    redirectAttributes.addFlashAttribute("success", "Booking accepted successfully!");
                } else {
                    redirectAttributes.addFlashAttribute("error", "Failed to accept booking");
                }
            } else {
                redirectAttributes.addFlashAttribute("error", "Booking not found or doesn't belong to you");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error accepting booking: " + e.getMessage());
        }
        
        return "redirect:/caretaker/bookings";  // FIXED: Changed to redirect
    }

    @PostMapping("/bookings/decline/{bookingId}")
    public String declineBooking(@PathVariable Long bookingId, HttpSession session, RedirectAttributes redirectAttributes) {
        if (session.getAttribute("userRole") == null || 
            !session.getAttribute("userRole").equals("CARETAKER")) {
            return "redirect:/login";
        }
        
        Long caretakerId = (Long) session.getAttribute("userId");
        
        try {
            Booking booking = bookingService.getBookingById(bookingId).orElse(null);
            if (booking != null && booking.getCaretaker() != null && 
                booking.getCaretaker().getUserId().equals(caretakerId)) {
                
                bookingService.declineBooking(bookingId);  // This now deletes the booking
                redirectAttributes.addFlashAttribute("success", "Booking declined and removed successfully!");
            } else {
                redirectAttributes.addFlashAttribute("error", "Booking not found or doesn't belong to you");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error declining booking: " + e.getMessage());
        }
        
        return "redirect:/caretaker/bookings";
    }

    @PostMapping("/bookings/complete/{bookingId}")
    public String completeBooking(@PathVariable Long bookingId, HttpSession session, RedirectAttributes redirectAttributes) {
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

    @GetMapping("/incident-reports")
    public String incidentReports(HttpSession session, Model model) {
        if (session.getAttribute("userRole") == null || 
            !session.getAttribute("userRole").equals("CARETAKER")) {
            return "redirect:/login";
        }
        
        Long caretakerId = (Long) session.getAttribute("userId");
        
        List<Booking> caretakerBookings = bookingService.getBookingsForCaretaker(caretakerId);
        
        List<Booking> eligibleBookings = caretakerBookings.stream()
            .filter(b -> b.getStatus() == Booking.BookingStatus.ACCEPTED || 
                        b.getStatus() == Booking.BookingStatus.COMPLETED)
            .collect(Collectors.toList());
        
        List<IncidentReport> existingReports = incidentReportService.getReportsByCaretaker(caretakerId);
        
        model.addAttribute("title", "Incident Reports");
        model.addAttribute("bookings", eligibleBookings);
        model.addAttribute("existingReports", existingReports);
        
        return "provider-templates/incident-reports";
    }

    @PostMapping("/incident-reports/create")
    public String createIncidentReport(@RequestParam Long bookingId, @RequestParam String description, @RequestParam String petType, HttpSession session, RedirectAttributes redirectAttributes) {
        if (session.getAttribute("userRole") == null || 
            !session.getAttribute("userRole").equals("CARETAKER")) {
            return "redirect:/login";
        }
        
        Long caretakerId = (Long) session.getAttribute("userId");
        
        try {
            Booking booking = bookingService.getBookingById(bookingId).orElse(null);
            if (booking == null || !booking.getCaretaker().getUserId().equals(caretakerId)) {
                redirectAttributes.addFlashAttribute("error", "Invalid booking selection");
                return "redirect:/caretaker/incident-reports";
            }
            
            IncidentReport existingReport = incidentReportService.getReportByBooking(bookingId);
            if (existingReport != null) {
                redirectAttributes.addFlashAttribute("error", "An incident report already exists for this booking");
                return "redirect:/caretaker/incident-reports";
            }
            
            IncidentReport report = new IncidentReport();
            report.setDescription(description);
            report.setPetType(petType);
            
            incidentReportService.createIncidentReport(caretakerId, bookingId, report);
            
            redirectAttributes.addFlashAttribute("success", "Incident report submitted successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error creating report: " + e.getMessage());
        }
        
        return "redirect:/caretaker/incident-reports";
    }

    @PostMapping("/incident-reports/delete/{reportId}")
    public String deleteIncidentReport(@PathVariable Long reportId, HttpSession session, RedirectAttributes redirectAttributes) {
        if (session.getAttribute("userRole") == null || 
            !session.getAttribute("userRole").equals("CARETAKER")) {
            return "redirect:/login";
        }
        
        Long caretakerId = (Long) session.getAttribute("userId");
        
        try {
            IncidentReport report = incidentReportService.getReportById(reportId);
            if (report == null || !report.getCaretaker().getUserId().equals(caretakerId)) {
                redirectAttributes.addFlashAttribute("error", "Report not found or doesn't belong to you");
                return "redirect:/caretaker/incident-reports";
            }
            
            incidentReportService.deleteReportById(reportId);
            redirectAttributes.addFlashAttribute("success", "Incident report deleted successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error deleting report: " + e.getMessage());
        }
        
        return "redirect:/caretaker/incident-reports";
    }


    @GetMapping("/reviews")
    public String respondToReviews(HttpSession session, Model model) {
        if (session.getAttribute("userRole") == null || 
            !session.getAttribute("userRole").equals("CARETAKER")) {
            return "redirect:/login";
        }
        
        model.addAttribute("title", "Respond to Reviews");
        return "provider-templates/respond-reviews";
    }
}