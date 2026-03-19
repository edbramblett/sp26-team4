package csc340_team4.repository;

import com.csc340_team4.backendapi.entity.Caretaker;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CaretakerRepository extends JpaRepository<Caretaker, Long> {
    Caretaker findByEmail(String email);
}

