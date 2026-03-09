package com.sergiocalderon.repository;

import com.sergiocalderon.modelo.Disponibilidad;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.time.LocalDate;
import java.util.List;

@Repository
public interface DisponibilidadRepository extends JpaRepository<Disponibilidad, Integer> {
    List<Disponibilidad> findAllByOrderByFechaAscHoraInicioAsc();
    List<Disponibilidad> findByFechaOrderByHoraInicioAsc(LocalDate fecha);
}