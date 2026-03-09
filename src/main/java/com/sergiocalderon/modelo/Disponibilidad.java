package com.sergiocalderon.modelo;

import jakarta.persistence.*;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.LocalDateTime;

@Entity
@Table(name = "disponibilidad")
public class Disponibilidad {

     @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_disponibilidad")
    private int idDisponibilidad;
    
    @Column(nullable = false)
    private LocalDate fecha;
    
    @Column(name = "hora_inicio", nullable = false)
    private LocalTime horaInicio;
    
    @Column(name = "hora_fin", nullable = false)
    private LocalTime horaFin;
    
    @Column(nullable = false)
    private boolean disponible = true;
    
    @Column(name = "cupos_totales", nullable = false)
    private int cuposTotales = 1;
    
    @Column(name = "cupos_ocupados", nullable = false)
    private int cuposOcupados = 0;
    
    @Column(name = "fecha_creacion")
    private LocalDateTime fechaCreacion;
    
    @Column(name = "fecha_modificacion")
    private LocalDateTime fechaModificacion;
    
    @Column(name = "id_administrador", nullable = false)
    private int idAdministrador;

    public Disponibilidad() {
        this.fechaCreacion = LocalDateTime.now();
        this.fechaModificacion = LocalDateTime.now();
    }
    
    // Getters y Setters
    public int getIdDisponibilidad() { return idDisponibilidad; }
    public void setIdDisponibilidad(int idDisponibilidad) { this.idDisponibilidad = idDisponibilidad; }
    
    public LocalDate getFecha() { return fecha; }
    public void setFecha(LocalDate fecha) { this.fecha = fecha; }
    
    public LocalTime getHoraInicio() { return horaInicio; }
    public void setHoraInicio(LocalTime horaInicio) { this.horaInicio = horaInicio; }
    
    public LocalTime getHoraFin() { return horaFin; }
    public void setHoraFin(LocalTime horaFin) { this.horaFin = horaFin; }
    
    public boolean isDisponible() { return disponible; }
    public void setDisponible(boolean disponible) { this.disponible = disponible; }
    
    public int getCuposTotales() { return cuposTotales; }
    public void setCuposTotales(int cuposTotales) { this.cuposTotales = cuposTotales; }
    
    public int getCuposOcupados() { return cuposOcupados; }
    public void setCuposOcupados(int cuposOcupados) { this.cuposOcupados = cuposOcupados; }
    
    public LocalDateTime getFechaCreacion() { return fechaCreacion; }
    public void setFechaCreacion(LocalDateTime fechaCreacion) { this.fechaCreacion = fechaCreacion; }
    
    public LocalDateTime getFechaModificacion() { return fechaModificacion; }
    public void setFechaModificacion(LocalDateTime fechaModificacion) { this.fechaModificacion = fechaModificacion; }
    
    public int getIdAdministrador() { return idAdministrador; }
    public void setIdAdministrador(int idAdministrador) { this.idAdministrador = idAdministrador; }
    
    @PreUpdate
    protected void onUpdate() {
        fechaModificacion = LocalDateTime.now();
    }
}