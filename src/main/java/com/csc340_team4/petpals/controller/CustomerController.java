package com.csc340_team4.petpals.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.csc340_team4.petpals.entity.Booking;
import com.csc340_team4.petpals.entity.Caretaker;
import com.csc340_team4.petpals.entity.Customer;
import com.csc340_team4.petpals.entity.LoginRequest;
import com.csc340_team4.petpals.entity.Pet;
import com.csc340_team4.petpals.entity.User;
import com.csc340_team4.petpals.repository.BookingRepository;
import com.csc340_team4.petpals.service.CaretakerService;
import com.csc340_team4.petpals.service.CustomerService;
import com.csc340_team4.petpals.service.PetService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/customers")
public class CustomerController {

    @Autowired
    private CustomerService customerService;

    @Autowired
private BookingRepository bookingRepository;

@Autowired
private CaretakerService caretakerService;

    @GetMapping("/register")
    public String showRegistrationForm(Model model) {
        model.addAttribute("customer", new Customer());
        return "signup";
    }

@PostMapping("/save")
public String registerCustomer(@ModelAttribute("customer") Customer customer) {
    
    customerService.saveCustomer(customer);
    
    return "redirect:/customers/login?success";
}

    @GetMapping("/home")
    public String showHomePage() {
        return "index";
    }

@GetMapping("/login")
public String showLoginPage(Model model) {
    model.addAttribute("loginRequest", new LoginRequest()); 
    return "login";
}


@PostMapping("/login/process")
public String processLogin(@ModelAttribute("loginRequest") LoginRequest loginRequest, HttpSession session) {
    User user = customerService.findByEmail(loginRequest.getEmail());
    
    if (user != null && user.getPasswordHash().equals(loginRequest.getPassword())) {
        session.setAttribute("userName", user.getFirstName());
        session.setAttribute("userId", user.getUserId());
        session.setAttribute("userRole", user.getRole().toString());

        // Redirect based on role
        if ("CARETAKER".equals(user.getRole().toString())) {
            return "redirect:/caretakers/dashboard";
        } else {
            return "redirect:/customers/customer-home";
        }
    }
    return "redirect:/customers/login?error";
}

@GetMapping("/customer-home")
public String showCustomerDashboard(Model model, HttpSession session) {
    String name = (String) session.getAttribute("userName");
    model.addAttribute("name", (name != null) ? name : "Guest");
    
    model.addAttribute("results", caretakerService.getAllCaretaker());
    return "customer-prototype/customer-home"; 
}

@GetMapping("/search")
public String searchCaretakers(@RequestParam("query") String query, Model model, HttpSession session) {
    String name = (String) session.getAttribute("userName");
    model.addAttribute("name", (name != null) ? name : "Guest");
    
    List<Caretaker> results = caretakerService.searchByService(query);
    model.addAttribute("results", results);
    model.addAttribute("searchQuery", query);
    return "customer-prototype/customer-home";
}

@GetMapping("/pets")
public String showPetsPage(Model model) {
    model.addAttribute("pet", new Pet()); 
    return "customer-prototype/pets-page";
}

@GetMapping("/bookings")
public String showBookingsPage(Model model) {
    List<Booking> userBookings = bookingRepository.findAll();
    model.addAttribute("bookings", userBookings);
    return "customer-prototype/bookings";
}

@GetMapping("/caretaker-profile/{id}")
public String showDynamicCaretakerProfile(@PathVariable("id") Long id, Model model, HttpSession session) {
    String name = (String) session.getAttribute("userName");
    model.addAttribute("name", (name != null) ? name : "Guest");

    Caretaker caretaker = caretakerService.getCaretakerById(id).orElse(null);
    
    if (caretaker != null) {
        model.addAttribute("caretaker", caretaker);
        return "customer-prototype/caretaker-profile";
    } else {
        return "redirect:/customers/customer-home?error=CaretakerNotFound";
    }
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
public String requestBooking(@RequestParam("caretakerId") Long caretakerId, HttpSession session) {
    Long customerId = (Long) session.getAttribute("userId"); // Use session instead of hardcoded 1L
    
    Customer customer = customerService.getCustomerById(customerId);
    Caretaker caretaker = caretakerService.getCaretakerById(caretakerId).orElse(null);
    Pet pet = petService.getPetsByOwner(customerId).get(0); 

    boolean alreadyExists = bookingRepository.existsByCustomerAndCaretakerAndPetAndStatus(
        customer, caretaker, pet, "PENDING"
    );

    if (!alreadyExists) {
        Booking booking = new Booking();
        booking.setCustomer(customer);
        booking.setCaretaker(caretaker);
        booking.setPet(pet);
        booking.setStatus("PENDING");
        bookingRepository.save(booking);
        return "redirect:/customers/bookings?requested";
    } else {
        return "redirect:/customers/bookings?alreadyPending";
    }
}

}
