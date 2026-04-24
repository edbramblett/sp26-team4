package com.csc340_team4.petpals.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.csc340_team4.petpals.entity.Pet;
import com.csc340_team4.petpals.repository.PetRepository;

@Service
public class PetService {
    @Autowired
    private PetRepository petRepository;

    public void savePet(Pet pet) {
        petRepository.save(pet);
    }

    public List<Pet> getPetsByOwner(Long customerId) {
        return petRepository.findByOwnerUserId(customerId);
    }
}
