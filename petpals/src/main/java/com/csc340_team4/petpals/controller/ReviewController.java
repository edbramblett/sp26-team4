package com.csc340_team4.petpals.controller;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.csc340_team4.petpals.entity.Caretaker;
import com.csc340_team4.petpals.entity.Customer;
import com.csc340_team4.petpals.entity.Review;
import com.csc340_team4.petpals.service.ReviewService;

import jakarta.servlet.http.HttpSession;

import com.csc340_team4.petpals.service.CustomerService;

@Controller
@RequestMapping("/reviews")
public class ReviewController {
    @Autowired
    private ReviewService reviewService;

    @Autowired
    private CustomerService customerService;

   @PostMapping("/reply")
public String replyToReview(@RequestParam Long reviewId, @RequestParam String reply) {
    Review review = reviewService.getReviewById(reviewId);
    if (review != null) {
        review.setCaretakerReply(reply);
        reviewService.saveReview(review);
    }
    return "redirect:/caretakers/respond-reviews";
}

@PostMapping("/submit")
public String submitReview(@RequestParam("caretakerId") Long caretakerId,
                           @RequestParam("rating") int rating,
                           @RequestParam("comment") String comment,
                            HttpSession session) {
    
    System.out.println("DEBUG: Form Submitted! Caretaker ID: " + caretakerId);
    
    Review review = new Review();
    
    Caretaker caretaker = new Caretaker();
    caretaker.setUserId(caretakerId); 
    review.setCaretaker(caretaker);

    Long customerId = (Long) session.getAttribute("userId");
    Customer customer = customerService.getCustomerById(customerId);
    
    review.setRating(rating);
    review.setComment(comment);
    review.setCustomer(customer); 
    
    
    reviewService.saveReview(review);
    System.out.println("DEBUG: Review saved to Neon!");
    
    return "redirect:/customers/caretaker-profile?caretakerId=" + caretakerId;
}
}
