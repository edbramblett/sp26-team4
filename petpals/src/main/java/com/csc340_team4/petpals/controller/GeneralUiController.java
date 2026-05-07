package com.csc340_team4.petpals.controller;

import com.csc340_team4.petpals.entity.Caretaker;
import com.csc340_team4.petpals.entity.Customer;
import com.csc340_team4.petpals.entity.User;
import com.csc340_team4.petpals.service.CaretakerService;
import com.csc340_team4.petpals.service.CustomerService;

import jakarta.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/")
public class GeneralUiController {

    @Autowired
    private CaretakerService caretakerService;

    @Autowired
    private CustomerService customerService;

    public GeneralUiController(CaretakerService caretakerService) {
        this.caretakerService = caretakerService;
    }

    @GetMapping({"", "/", "/home", "/index"})
    public String home(Model model) {
        model.addAttribute("title", "Welcome to PetPals");
        return "index";
    }

    @GetMapping("/login")
    public String showLoginForm(Model model) {
        model.addAttribute("title", "Login");
        return "login";
    }

    @PostMapping("/login")
    public String login(@RequestParam String email, 
                       @RequestParam String password,
                       HttpSession session,
                       RedirectAttributes redirectAttributes) {
        
        Caretaker caretaker = caretakerService.getCaretakerByEmail(email);
        
        if (caretaker != null && caretaker.getPasswordHash().equals(password)) {
            session.setAttribute("userId", caretaker.getUserId());
            session.setAttribute("userRole", caretaker.getRole().toString());
            session.setAttribute("userName", caretaker.getFirstName() + " " + caretaker.getLastName());
            session.setAttribute("userEmail", caretaker.getEmail());
            
            if (caretaker.getRole() == User.UserRole.CARETAKER) {
                return "redirect:/caretaker/home";
            }
        }

        Customer customer = customerService.getCustomerByEmail(email);
        if (customer != null && customer.getPasswordHash().equals(password)) {
            session.setAttribute("userId", customer.getUserId());
            session.setAttribute("userRole", "CUSTOMER");
            session.setAttribute("userName", customer.getFirstName() + " " + customer.getLastName());
            session.setAttribute("userEmail", customer.getEmail());;
            session.setAttribute("customerId", customer.getUserId());
            
            return "redirect:/customers/customer-home";
        }
        
        
        redirectAttributes.addFlashAttribute("error", "Invalid email or password");
        return "redirect:/login";
    }

    @GetMapping("/signup")
    public String showSignupForm(Model model) {
        model.addAttribute("userType", "CARETAKER");
        model.addAttribute("title", "Sign Up");
        return "signup";
    }

    @PostMapping("/signup")
    public String signup(@RequestParam String firstName,
                        @RequestParam String lastName,
                        @RequestParam String phoneNumber,
                        @RequestParam String email,
                        @RequestParam String password,
                        @RequestParam String userType,
                        RedirectAttributes redirectAttributes) {
        
        if (caretakerService.getCaretakerByEmail(email) != null) {
            redirectAttributes.addFlashAttribute("error", "Email already registered");
            return "redirect:/signup";
        }
        
        if (userType.equals("CARETAKER")) {
            Caretaker newCaretaker = new Caretaker();
            newCaretaker.setFirstName(firstName);
            newCaretaker.setLastName(lastName);
            newCaretaker.setPhoneNumber(phoneNumber);
            newCaretaker.setEmail(email);
            newCaretaker.setPasswordHash(password);
            newCaretaker.setRole(User.UserRole.CARETAKER);
            caretakerService.createCaretaker(newCaretaker);
            return "redirect:/login";
        } else if (userType.equals("CUSTOMER")) {
            Customer newCustomer = new Customer();
            newCustomer.setFirstName(firstName);
            newCustomer.setLastName(lastName);
            newCustomer.setPhoneNumber(phoneNumber);
            newCustomer.setEmail(email);
            newCustomer.setPasswordHash(password);
            newCustomer.setRole(User.UserRole.CUSTOMER);
            newCustomer.setPreferredPetType("");
            
            customerService.createCustomer(newCustomer);
            return "redirect:/login";
        }
        
        redirectAttributes.addFlashAttribute("error", "Invalid user type");
        return "redirect:/signup";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }

    @GetMapping("/about")
    public String about(Model model) {
        model.addAttribute("title", "About Us");
        return "about";
    }
}