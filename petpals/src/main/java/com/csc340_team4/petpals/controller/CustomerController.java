package com.csc340_team4.petpals.controller;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;
import java.util.Optional;
import java.util.stream.Collectors;

import com.csc340_team4.petpals.entity.Booking;
import com.csc340_team4.petpals.entity.Caretaker;
import com.csc340_team4.petpals.entity.Customer;
import com.csc340_team4.petpals.entity.Pet;
import com.csc340_team4.petpals.entity.Review;
import com.csc340_team4.petpals.entity.User;
import com.csc340_team4.petpals.repository.BookingRepository;
import com.csc340_team4.petpals.service.CaretakerService;
import com.csc340_team4.petpals.service.CustomerService;
import com.csc340_team4.petpals.service.PetService;
import com.csc340_team4.petpals.service.ReviewService;

@Controller
@RequestMapping("/customers")
public class CustomerController {

    @Autowired
    private CustomerService customerService;

    @Autowired
    private BookingRepository bookingRepository;

    @Autowired
    private CaretakerService caretakerService;

    @Autowired
    private ReviewService reviewService;

    // Use-case 1: Show the registration form
    @GetMapping("/register")
    public String showRegistrationForm(Model model) {
        model.addAttribute("customer", new Customer());
        return "signup";
    }

    // Use-case 2: Save the data and redirect to home with success message
@PostMapping("/save")
public String registerCustomer(@ModelAttribute("customer") Customer customer) {
    customer.setRole(User.UserRole.CUSTOMER);
    customerService.saveCustomer(customer);
    return "redirect:/customers/home?success";
}

    @GetMapping("/home")
    public String showHomePage() {
        return "index";
    }


@GetMapping("/customer-home")
public String showCustomerDashboard(HttpSession session, Model model) {
    Long customerId = (Long) session.getAttribute("userId");
    if (customerId != null) {
        Customer customer = customerService.getCustomerById(customerId);
        model.addAttribute("customer", customer);
    }
    return "customer-templates/customer-home";
}

@GetMapping("/pets")
public String showPetsPage(Model model, HttpSession session) {
    Long customerId = (Long) session.getAttribute("userId");
    
    if (customerId != null) {
        List<Pet> userPets = petService.getPetsByOwner(customerId);
        model.addAttribute("pets", userPets);
        System.out.println("Found " + userPets.size() + " pets for customer ID: " + customerId);
    } else {
        System.out.println("Customer ID is null in session");
        model.addAttribute("pets", new ArrayList<>());
    }
    
    model.addAttribute("pet", new Pet()); 
    return "customer-templates/pets-page";
}

@GetMapping("/bookings")
public String showBookingsPage(Model model, HttpSession session) {
    Long customerId = (Long) session.getAttribute("userId");
    
    if (customerId != null) {
        List<Booking> allBookings = bookingRepository.findByCustomerUserId(customerId);
        
        List<Booking> pendingBookings = allBookings.stream()
            .filter(b -> b.getStatus() == Booking.BookingStatus.PENDING)
            .collect(Collectors.toList());
            
        List<Booking> acceptedBookings = allBookings.stream()
            .filter(b -> b.getStatus() == Booking.BookingStatus.ACCEPTED)
            .collect(Collectors.toList());
            
        List<Booking> completedBookings = allBookings.stream()
            .filter(b -> b.getStatus() == Booking.BookingStatus.COMPLETED)
            .collect(Collectors.toList());
        
        model.addAttribute("pendingBookings", pendingBookings);
        model.addAttribute("acceptedBookings", acceptedBookings);
        model.addAttribute("completedBookings", completedBookings);

        
    } else {
        model.addAttribute("pendingBookings", new ArrayList<>());
        model.addAttribute("acceptedBookings", new ArrayList<>());
        model.addAttribute("completedBookings", new ArrayList<>());
    }
    
    return "customer-templates/bookings";
}

@GetMapping("/caretaker-profile")
public String showCaretakerProfile(@RequestParam Long caretakerId, 
                                   Model model,
                                   HttpSession session) {
    Optional<Caretaker> caretakerOpt = caretakerService.getCaretakerById(caretakerId);
    if (caretakerOpt.isEmpty()) {
        return "redirect:/customers/search-caretakers?error=Caretaker not found";
    }
    
    Caretaker caretaker = caretakerOpt.get();
    model.addAttribute("caretaker", caretaker);
    
    List<Review> reviews = reviewService.getReviewsForCaretaker(caretakerId);
    model.addAttribute("reviews", reviews);
    
    Long customerId = (Long) session.getAttribute("userId");
    model.addAttribute("customerId", customerId);
    
    return "customer-templates/caretaker-profile";
}

@Autowired
private PetService petService;

@PostMapping("/pets/add")
public String addPet(@ModelAttribute("pet") Pet pet) {
    
    Customer currentCustomer = customerService.getCustomerById(1L); 
    pet.setOwner(currentCustomer);
    
    petService.savePet(pet);
    return "redirect:/customers/pets?success";
}

@PostMapping("/bookings/request")
public String requestBooking(HttpSession session, 
                             @RequestParam Long caretakerId,
                             @RequestParam String serviceType,
                             @RequestParam String dateTime,
                             @RequestParam(required = false) Long petId,  // Single pet ID
                             @RequestParam(required = false) String petInfo,
                             RedirectAttributes redirectAttributes) {
    
    Long customerId = (Long) session.getAttribute("userId");
    if (customerId == null) {
        redirectAttributes.addFlashAttribute("error", "Please login first");
        return "redirect:/login";
    }
    
    try {
        Customer customer = customerService.getCustomerById(customerId);
        Caretaker caretaker = caretakerService.getCaretakerById(caretakerId)
            .orElseThrow(() -> new RuntimeException("Caretaker not found"));
        
        Booking booking = new Booking();
        booking.setCustomer(customer);
        booking.setCaretaker(caretaker);
        booking.setServiceType(serviceType);
        booking.setDate(LocalDateTime.parse(dateTime));
        booking.setStatus(Booking.BookingStatus.PENDING);
        
        if (petId != null) {
            Pet pet = petService.getPetById(petId);
            booking.setPet(pet);
        }
        
        bookingRepository.save(booking);
        redirectAttributes.addFlashAttribute("success", "Booking requested successfully!");
        return "redirect:/customers/bookings";
        
    } catch (Exception e) {
        redirectAttributes.addFlashAttribute("error", "Failed to create booking: " + e.getMessage());
        return "redirect:/customers/search-caretakers";
    }
}

    @GetMapping("/search-caretakers")
    public String searchCaretakers(@RequestParam(required = false) String service, 
                                   Model model,
                                   HttpSession session) {
        List<Caretaker> caretakers;
        
        if (service != null && !service.trim().isEmpty()) {
            // Filter by service provided
            caretakers = caretakerService.getServicesProvided(service);
            model.addAttribute("searchService", service);
        } else {
            // Get all caretakers
            caretakers = caretakerService.getAllCaretaker();
        }
        
        model.addAttribute("caretakers", caretakers);
        return "customer-templates/search-results";
    }

@GetMapping("/bookings/new")
public String showBookingForm(@RequestParam Long caretakerId, 
                              Model model,
                              HttpSession session) {
    Long customerId = (Long) session.getAttribute("userId");
    if (customerId == null) {
        return "redirect:/login";
    }
    
    Optional<Caretaker> caretakerOpt = caretakerService.getCaretakerById(caretakerId);
    if (caretakerOpt.isEmpty()) {
        return "redirect:/customers/search-caretakers?error=Caretaker not found";
    }
    
    model.addAttribute("caretaker", caretakerOpt.get());

    List<Pet> userPets = petService.getPetsByOwner(customerId);
    model.addAttribute("caretaker", caretakerOpt.get());
    model.addAttribute("pets", userPets);
    return "customer-templates/make-booking";
}

@GetMapping("/reviews")
public String showReviewsPage(Model model, HttpSession session) {
    Long customerId = (Long) session.getAttribute("userId");
    
    if (customerId == null) {
        return "redirect:/login";
    }
    
    List<Review> customerReviews = reviewService.getReviewsByCustomer(customerId);
    model.addAttribute("reviews", customerReviews);
    
    return "customer-templates/reviews";
}


}
