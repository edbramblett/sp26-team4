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
        List<Caretaker> caretakers = caretakerService.getAllCaretaker();
        return new ResponseEntity<>(caretakers, HttpStatus.OK);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Caretaker> getCaretakerById(@PathVariable Long id) {
        Optional<Caretaker> caretaker = caretakerService.getCaretakerById(id);
        return caretaker.map(f -> new ResponseEntity<>(f, HttpStatus.OK))
                .orElseGet(() -> new ResponseEntity<>(HttpStatus.NOT_FOUND));
    }

    @GetMapping("/email/{email}")
    public ResponseEntity<Caretaker> getCaretakerByEmail(@PathVariable String email) {
        Caretaker caretaker = caretakerService.getCaretakerByEmail(email);
        return caretaker != null ? new ResponseEntity<>(caretaker, HttpStatus.OK)
                : new ResponseEntity<>(HttpStatus.NOT_FOUND);
    }

    @GetMapping("/search")
    public ResponseEntity<List<Caretaker>> getServicesProvided(@RequestParam String service) {
        List<Caretaker> caretakers = caretakerService.getServicesProvided(service);
        if (caretakers.isEmpty()) {
         return ResponseEntity.notFound().build();
        }
    return ResponseEntity.ok(caretakers);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Caretaker> updateFarmer(@PathVariable Long id, @RequestBody Caretaker caretakerDetails) {
        try {
            Caretaker updatedCaretaker = caretakerService.updateCaretaker(id, caretakerDetails);
            return new ResponseEntity<>(updatedCaretaker, HttpStatus.OK);
        } catch (RuntimeException e) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteFarmer(@PathVariable Long id) {
        caretakerService.deleteFarmer(id);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }
}