package com.csc340_team4.petpals.service;

import com.csc340_team4.petpals.entity.Caretaker;
import com.csc340_team4.petpals.repository.CaretakerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class CaretakerService {

    @Autowired
    private CaretakerRepository caretakerRepository;

    public Caretaker createCaretaker(Caretaker caretaker) {
        return caretakerRepository.save(caretaker);
    }

    public Optional<Caretaker> getCaretakerById(Long id) {
        return caretakerRepository.findById(id);
    }

    public List<Caretaker> getAllCaretaker() {
        return caretakerRepository.findAll();
    }

    public void deleteFarmer(Long id) {
        caretakerRepository.deleteById(id);
    }

    public Caretaker getCaretakerByEmail(String email) {
        return caretakerRepository.findByEmail(email);
    }
    
    public List<Caretaker> getServicesProvided(String service) {
        return caretakerRepository.findAll().stream()
                .filter(c -> c.getServicesProvided() != null && c.getServicesProvided().toLowerCase().contains(service.toLowerCase()))
                .toList();
    }
    
    public Caretaker updateCaretaker(Long id, Caretaker caretakerDetails) {
        return caretakerRepository.findById(id).map(caretaker -> {
            if (caretakerDetails.getEmail() != null) {
                caretaker.setEmail(caretakerDetails.getEmail());
            }
            if (caretakerDetails.getServicesProvided() != null) {
                caretaker.setServicesProvided(caretakerDetails.getServicesProvided());
            }
            return caretakerRepository.save(caretaker);
        }).orElseThrow(() -> new RuntimeException("Caretaker not found"));
    }

}