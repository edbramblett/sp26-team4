package com.csc340_team4.petpals.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.csc340_team4.petpals.entity.Customer;
import com.csc340_team4.petpals.entity.User;
import com.csc340_team4.petpals.repository.CustomerRepository;
import com.csc340_team4.petpals.repository.UserRepository;

@Service
public class CustomerService {

    @Autowired
    private CustomerRepository customerRepository;

    @Autowired
    private UserRepository userRepository;

    public void saveCustomer(Customer customer) {
        customerRepository.save(customer);
    }

    public User findByEmail(String email) {
        return userRepository.findByEmail(email).orElse(null);
    }

    public List<Customer> getAllCustomers() {
        return customerRepository.findAll();
    }

    public Customer getCustomerById(Long id) {
    return customerRepository.findById(id).orElse(null);
}
}