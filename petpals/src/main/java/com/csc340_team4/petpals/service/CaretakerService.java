package com.csc340_team4.petpals.serivce;

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

    public Optional<Caretaker> getCaretakerrById(Long id) {
        return caretakerRepository.findById(id);
    }

    public List<Farmer> getAllFarmers() {
        return farmerRepository.findAll();
    }

    public Farmer updateFarmer(Long id, Farmer farmerDetails) {
        return farmerRepository.findById(id).map(farmer -> {
            if (farmerDetails.getEmail() != null) {
                farmer.setEmail(farmerDetails.getEmail());
            }
            if (farmerDetails.getBio() != null) {
                farmer.setBio(farmerDetails.getBio());
            }
            if (farmerDetails.getStatus() != null) {
                farmer.setStatus(farmerDetails.getStatus());
            }
            return farmerRepository.save(farmer);
        }).orElseThrow(() -> new RuntimeException("Farmer not found"));
    }

    public void deleteFarmer(Long id) {
        farmerRepository.deleteById(id);
    }

    public Farmer getFarmerByEmail(String email) {
        return farmerRepository.findByEmail(email);
    }
}