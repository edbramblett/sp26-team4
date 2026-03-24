package com.csc340_team4.petpals.repository;

import com.csc340_team4.petpals.entity.IncidentReport;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface IncidentReportRepository extends JpaRepository<IncidentReport, Long> {
    List<IncidentReport> findByCaretakerUserId(Long userId);
    
    IncidentReport findByBookingBookingId(Long bookingId);
}
