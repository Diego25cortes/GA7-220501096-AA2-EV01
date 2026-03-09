package com.sergiocalderon.service;

import com.sergiocalderon.modelo.Cita;
import com.sergiocalderon.modelo.Disponibilidad;
import com.sergiocalderon.repository.CitaRepository;
import com.sergiocalderon.repository.DisponibilidadRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.time.LocalTime;
import java.util.List;

@Service
public class CitaService {
    
    @Autowired
    private CitaRepository citaRepository;
    
    @Autowired
    private DisponibilidadRepository disponibilidadRepository;
    
    @Transactional
    public Cita agendarCita(int idCliente, int idDisponibilidad, 
                           String tipoEvento, String motivoCita) {
        
        // Obtener la disponibilidad
        Disponibilidad disponibilidad = disponibilidadRepository.findById(idDisponibilidad)
            .orElseThrow(() -> new RuntimeException("Horario no disponible"));
        
        // Verificar que haya cupos
        if (!disponibilidad.isDisponible() || 
            disponibilidad.getCuposOcupados() >= disponibilidad.getCuposTotales()) {
            throw new RuntimeException("No hay cupos disponibles para este horario");
        }
        
        // Crear la cita
        Cita cita = new Cita();
        cita.setIdCliente(idCliente);
        cita.setIdDisponibilidad(idDisponibilidad);
        cita.setFechaCita(disponibilidad.getFecha());
        cita.setHoraInicio(disponibilidad.getHoraInicio());
        cita.setHoraFin(disponibilidad.getHoraFin());
        cita.setTipoEvento(tipoEvento);
        cita.setMotivoCita(motivoCita);
        cita.setDuracionMinutos(
            (int) java.time.Duration.between(
                disponibilidad.getHoraInicio(), 
                disponibilidad.getHoraFin()
            ).toMinutes()
        );
        
        // Actualizar cupos ocupados
        disponibilidad.setCuposOcupados(disponibilidad.getCuposOcupados() + 1);
        if (disponibilidad.getCuposOcupados() >= disponibilidad.getCuposTotales()) {
            disponibilidad.setDisponible(false);
        }
        disponibilidadRepository.save(disponibilidad);
        
        return citaRepository.save(cita);
    }
    
    public List<Cita> obtenerCitasPorCliente(int idCliente) {
        return citaRepository.findByIdClienteOrderByFechaCitaDesc(idCliente);
    }
}