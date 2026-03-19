package com.csc340_team4.petpals.controller;

import com.csc340_team4.petpals.entity.Caretaker;
import com.csc340_team4.petpals.service.CaretakerService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/caretakers")
public class CaretakerController {

    @Autowired
    private CaretakerService caretakerService;

    @PostMapping
    public ResponseEntity<Caretaker> createCaretaker(@RequestBody Caretaker caretaker) {
        Caretaker createdCaretaker = caretakerService.createCaretaker(caretaker);
        return new ResponseEntity<>(createdCaretaker, HttpStatus.CREATED);
    }

    @GetMapping
    public ResponseEntity<List<Caretaker>> getAllCaretakers() {
        List<Caretaker> caretakers = caretakersService.getAllCaretakers();
        return new ResponseEntity<>(caretakerss, HttpStatus.OK);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Caretaker> getCaretakerById(@PathVariable Long id) {
        Optional<Caretaker> caretaker = caretakerService.getCaretakerById(id);
        return caretaker.map(f -> new ResponseEntity<>(f, HttpStatus.OK))
                .orElseGet(() -> new ResponseEntity<>(HttpStatus.NOT_FOUND));
    }

    @GetMapping("/email/{email}")
    public ResponseEntity<Farmer> getFarmerByEmail(@PathVariable String email) {
        Farmer farmer = farmerService.getFarmerByEmail(email);
        return farmer != null ? new ResponseEntity<>(farmer, HttpStatus.OK)
                : new ResponseEntity<>(HttpStatus.NOT_FOUND);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Farmer> updateFarmer(@PathVariable Long id, @RequestBody Farmer farmerDetails) {
        try {
            Farmer updatedFarmer = farmerService.updateFarmer(id, farmerDetails);
            return new ResponseEntity<>(updatedFarmer, HttpStatus.OK);
        } catch (RuntimeException e) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteFarmer(@PathVariable Long id) {
        farmerService.deleteFarmer(id);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }
}