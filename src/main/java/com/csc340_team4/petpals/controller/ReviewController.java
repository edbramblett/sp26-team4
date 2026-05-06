package com.csc340_team4.petpals.controller;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.csc340_team4.petpals.entity.Caretaker;
import com.csc340_team4.petpals.entity.Review;
import com.csc340_team4.petpals.service.ReviewService;

@Controller
@RequestMapping("/reviews")
public class ReviewController {
    @Autowired
    private ReviewService reviewService;

   @PostMapping("/reply")
public String replyToReview(@RequestParam Long reviewId, @RequestParam String reply) {
    Review review = reviewService.getReviewById(reviewId);
    if (review != null) {
        review.setCaretakerReply(reply);
        reviewService.saveReview(review);
    }
    return "redirect:/caretakers/my-reviews";
}

@PostMapping("/submit")
public String submitReview(@RequestParam("caretakerId") Long caretakerId,
                           @RequestParam("rating") int rating,
                           @RequestParam("comment") String comment) {
    
    System.out.println("DEBUG: Form Submitted! Caretaker ID: " + caretakerId);
    
    Review review = new Review();
    
    Caretaker caretaker = new Caretaker();
    caretaker.setUserId(caretakerId); 
    review.setCaretaker(caretaker);
    
    review.setRating(rating);
    review.setComment(comment);
    
    
    reviewService.saveReview(review);
    System.out.println("DEBUG: Review saved to Neon!");
    
    return "redirect:/customers/bookings";
}
}
