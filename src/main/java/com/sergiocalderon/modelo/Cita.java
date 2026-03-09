package com.sergiocalderon.modelo;

import jakarta.persistence.*;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.LocalDateTime;

@Entity
@Table(name = "cita")
public class Cita {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_cita")
    private int idCita;
    
    @Column(name = "fecha_cita", nullable = false)
    private LocalDate fechaCita;
    
    @Column(name = "hora_inicio", nullable = false)
    private LocalTime horaInicio;
    
    @Column(name = "hora_fin", nullable = false)
    private LocalTime horaFin;
    
    @Column(name = "duracion_minutos")
    private int duracionMinutos = 60;
    
    @Column(name = "tipo_evento", nullable = false, columnDefinition = "ENUM('BODA','FIESTA','QUINCE','OTRO')")
    private String tipoEvento;
    
    @Column(name = "motivo_cita")
    private String motivoCita;
    
    @Column(nullable = false, columnDefinition = "ENUM('PENDIENTE','CONFIRMADA','COMPLETADA','CANCELADA')")
    private String estado = "PENDIENTE";
    
    @Column(name = "fecha_creacion")
    private LocalDateTime fechaCreacion;
    
    @Column(name = "id_cliente", nullable = false)
    private int idCliente;
    
    @Column(name = "id_disponibilidad")
    private Integer idDisponibilidad;
    
    // Constructores
    public Cita() {
        this.fechaCreacion = LocalDateTime.now();
    }
    
    // Getters y Setters
    public int getIdCita() { return idCita; }
    public void setIdCita(int idCita) { this.idCita = idCita; }
    
    public LocalDate getFechaCita() { return fechaCita; }
    public void setFechaCita(LocalDate fechaCita) { this.fechaCita = fechaCita; }
    
    public LocalTime getHoraInicio() { return horaInicio; }
    public void setHoraInicio(LocalTime horaInicio) { this.horaInicio = horaInicio; }
    
    public LocalTime getHoraFin() { return horaFin; }
    public void setHoraFin(LocalTime horaFin) { this.horaFin = horaFin; }
    
    public int getDuracionMinutos() { return duracionMinutos; }
    public void setDuracionMinutos(int duracionMinutos) { this.duracionMinutos = duracionMinutos; }
    
    public String getTipoEvento() { return tipoEvento; }
    public void setTipoEvento(String tipoEvento) { this.tipoEvento = tipoEvento; }
    
    public String getMotivoCita() { return motivoCita; }
    public void setMotivoCita(String motivoCita) { this.motivoCita = motivoCita; }
    
    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }
    
    public LocalDateTime getFechaCreacion() { return fechaCreacion; }
    public void setFechaCreacion(LocalDateTime fechaCreacion) { this.fechaCreacion = fechaCreacion; }
    
    public int getIdCliente() { return idCliente; }
    public void setIdCliente(int idCliente) { this.idCliente = idCliente; }
    
    public Integer getIdDisponibilidad() { return idDisponibilidad; }
    public void setIdDisponibilidad(Integer idDisponibilidad) { this.idDisponibilidad = idDisponibilidad; }
}