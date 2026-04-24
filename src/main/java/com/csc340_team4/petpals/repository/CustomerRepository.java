package com.csc340_team4.petpals.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.csc340_team4.petpals.entity.Customer;

@Repository
public interface CustomerRepository extends JpaRepository<Customer, Long> {
    // You can add custom searches here later if needed
}