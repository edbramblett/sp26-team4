package com.csc340_team4.petpals.service;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.csc340_team4.petpals.entity.Review;
import com.csc340_team4.petpals.repository.ReviewRepository;

@Service
@Transactional
public class ReviewService {
    @Autowired
    private ReviewRepository reviewRepository;

    public void saveReview(Review review) {
        reviewRepository.save(review);
    }

    public List<Review> getReviewsForCaretaker(Long caretakerId) {
        return reviewRepository.findByCaretaker_UserId(caretakerId);
    }

    public Review getReviewById(Long id) { 
        return reviewRepository.findById(id).orElse(null);
    }

    public List<Review> getReviewsByCustomer(Long customerId) {
        return reviewRepository.findByCustomer_UserId(customerId);
    }
}
