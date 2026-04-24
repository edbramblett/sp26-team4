package com.csc340_team4.petpals.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.csc340_team4.petpals.entity.Caretaker;
import com.csc340_team4.petpals.service.CaretakerService;

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

   @PutMapping("/{id}")
    public ResponseEntity<Caretaker> updateCaretaker(@PathVariable Long id, @RequestBody Caretaker caretakerDetails) {
        try {
            Caretaker updatedCaretaker = caretakerService.updateCaretaker(id, caretakerDetails);
            return new ResponseEntity<>(updatedCaretaker, HttpStatus.OK);
        } catch (RuntimeException e) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteCaretaker(@PathVariable Long id) {
        caretakerService.deleteCaretaker(id);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }
}