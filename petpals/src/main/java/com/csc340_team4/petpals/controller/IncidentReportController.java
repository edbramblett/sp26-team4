package com.csc340_team4.petpals.controller;

import com.csc340_team4.petpals.entity.IncidentReport;
import com.csc340_team4.petpals.service.IncidentReportService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/incident-reports")
public class IncidentReportController {

    @Autowired
    private IncidentReportService incidentReportService;

    @PostMapping("/{caretaker_id}/{bookingId}")
    public ResponseEntity<IncidentReport> createIncidentReport(
            @PathVariable Long caretaker_id,
            @PathVariable Long bookingId,
            @RequestBody IncidentReport reportDetails) {

        IncidentReport created = incidentReportService.createIncidentReport(
                caretaker_id, bookingId, reportDetails);

        return new ResponseEntity<>(created, HttpStatus.CREATED);
    }

    @GetMapping
    public ResponseEntity<List<IncidentReport>> getAllReports() {
        return new ResponseEntity<>(incidentReportService.getAllReports(), HttpStatus.OK);
    }

    @GetMapping("/{id}")
    public ResponseEntity<IncidentReport> getReportById(@PathVariable Long id) {
        IncidentReport report = incidentReportService.getReportById(id);
        return new ResponseEntity<>(report, HttpStatus.OK);
    }

    @GetMapping("/caretaker/{caretaker_id}")
    public ResponseEntity<List<IncidentReport>> getReportsByCaretaker(@PathVariable Long caretaker_id) {
        return new ResponseEntity<>(incidentReportService.getReportsByCaretaker(caretaker_id), HttpStatus.OK);
    }

    @GetMapping("/booking/{bookingId}")
    public ResponseEntity<IncidentReport> getReportByBooking(@PathVariable Long bookingId) {
        IncidentReport report = incidentReportService.getReportByBooking(bookingId);
        return new ResponseEntity<>(report, HttpStatus.OK);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteReport(@PathVariable Long id) {
        incidentReportService.deleteReport(id);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }
}
