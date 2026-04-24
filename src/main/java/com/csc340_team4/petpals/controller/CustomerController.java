package com.csc340_team4.petpals.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.csc340_team4.petpals.entity.Booking;
import com.csc340_team4.petpals.entity.Customer;
import com.csc340_team4.petpals.entity.LoginRequest;
import com.csc340_team4.petpals.entity.Pet;
import com.csc340_team4.petpals.entity.User;
import com.csc340_team4.petpals.repository.BookingRepository;
import com.csc340_team4.petpals.service.CaretakerService;
import com.csc340_team4.petpals.service.CustomerService;
import com.csc340_team4.petpals.service.PetService;

@Controller
@RequestMapping("/customers")
public class CustomerController {

    @Autowired
    private CustomerService customerService;

    @Autowired
private BookingRepository bookingRepository;

@Autowired
private CaretakerService caretakerService;

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

@GetMapping("/login")
public String showLoginPage(Model model) {
    model.addAttribute("loginRequest", new LoginRequest()); 
    return "login";
}


@PostMapping("/login/process")
public String processLogin(@ModelAttribute("loginRequest") LoginRequest loginRequest, Model model) {
    User user = customerService.findByEmail(loginRequest.getEmail());

    if (user != null && user.getPasswordHash().equals(loginRequest.getPassword())) {
        return "redirect:/customers/customer-home";
    } else {
        model.addAttribute("error", "Invalid email or password");
        return "login";
    }
}

@GetMapping("/customer-home")
public String showCustomerDashboard(Model model) {
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

@GetMapping("/caretaker-profile")
public String showCaretakerProfile() {
    return "customer-prototype/caretaker-profile";
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
public String requestBooking() {
    Booking booking = new Booking();
    
    booking.setCustomer(customerService.getCustomerById(1L));
    booking.setCaretaker(caretakerService.getCaretakerById(2L).orElse(null)); 
    booking.setPet(petService.getPetsByOwner(1L).get(0)); 

    bookingRepository.save(booking);
    return "redirect:/customers/bookings?requested";
}

}
