package com.sergiocalderon.service;

import com.sergiocalderon.modelo.Disponibilidad;
import com.sergiocalderon.repository.DisponibilidadRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

@Service
public class DisponibilidadService {
    
    @Autowired
    private DisponibilidadRepository disponibilidadRepository;
    
    public List<Disponibilidad> obtenerTodos() {
        return disponibilidadRepository.findAllByOrderByFechaAscHoraInicioAsc();
    }

    public List<Disponibilidad> buscarPorFecha(LocalDate fecha) {
    return disponibilidadRepository.findByFechaOrderByHoraInicioAsc(fecha);
}
    
    public void generarHorarios(LocalDate fecha, LocalTime horaDesde, LocalTime horaHasta, 
                                int intervaloMinutos, int cupos, int idAdministrador) {
        
        List<Disponibilidad> horarios = new ArrayList<>();
        LocalTime horaActual = horaDesde;
        
        while (horaActual.isBefore(horaHasta)) {
            LocalTime horaFin = horaActual.plusMinutes(intervaloMinutos);
            if (horaFin.isAfter(horaHasta)) {
                horaFin = horaHasta;
            }
            
            Disponibilidad d = new Disponibilidad();
            d.setFecha(fecha);
            d.setHoraInicio(horaActual);
            d.setHoraFin(horaFin);
            d.setCuposTotales(cupos);
            d.setCuposOcupados(0);
            d.setDisponible(true);
            d.setIdAdministrador(idAdministrador);
            
            horarios.add(d);
            
            horaActual = horaFin;
        }
        
        disponibilidadRepository.saveAll(horarios);
    }
    
    public Disponibilidad obtenerPorId(int id) {
        return disponibilidadRepository.findById(id).orElse(null);
    }
    
    public void actualizarHorario(Disponibilidad horario) {
        disponibilidadRepository.save(horario);
    }
    
    public void eliminarHorario(int id) {
        disponibilidadRepository.deleteById(id);
    }
}