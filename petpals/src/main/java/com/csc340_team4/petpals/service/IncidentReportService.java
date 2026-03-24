package com.csc340_team4.petpals.service;

import com.csc340_team4.petpals.entity.Booking;
import com.csc340_team4.petpals.entity.Caretaker;
import com.csc340_team4.petpals.entity.IncidentReport;
import com.csc340_team4.petpals.repository.BookingRepository;
import com.csc340_team4.petpals.repository.CaretakerRepository;
import com.csc340_team4.petpals.repository.IncidentReportRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class IncidentReportService {

    @Autowired
    private IncidentReportRepository incidentReportRepository;

    @Autowired
    private CaretakerRepository caretakerRepository;

    @Autowired
    private BookingRepository bookingRepository;

    public IncidentReport createIncidentReport(Long caretaker_id, Long bookingId, IncidentReport reportDetails) {

        Caretaker caretaker = caretakerRepository.findById(caretaker_id)
                .orElseThrow(() -> new RuntimeException("Caretaker not found"));

        Booking booking = bookingRepository.findById(bookingId)
                .orElseThrow(() -> new RuntimeException("Booking not found"));

        reportDetails.setCaretaker(caretaker);
        reportDetails.setBooking(booking);

        return incidentReportRepository.save(reportDetails);
    }

    public List<IncidentReport> getAllReports() {
        return incidentReportRepository.findAll();
    }

    public IncidentReport getReportById(Long id) {
        return incidentReportRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Incident report not found"));
    }

    public List<IncidentReport> getReportsByCaretaker(Long caretaker_id) {
        return incidentReportRepository.findByCaretakerUserId(caretaker_id);
    }

    public IncidentReport getReportByBooking(Long bookingId) {
        return incidentReportRepository.findByBookingBookingId(bookingId);
    }

    public void deleteReport(Long id) {
        incidentReportRepository.deleteById(id);
    }
}
