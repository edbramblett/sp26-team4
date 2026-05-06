package com.csc340_team4.petpals.repository;

import java.util.List;
                        
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.csc340_team4.petpals.entity.Review;

@Repository
public interface ReviewRepository extends JpaRepository<Review, Long> {
    
   List<Review> findByCaretaker_UserId(Long userId);
}