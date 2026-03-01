package com.sergiocalderon.modelo;

import java.time.LocalDate;
import java.time.LocalTime;

public class Cita {

    private int idCita;
    private LocalDate fechaCita;
    private LocalTime horaInicio;
    private LocalTime horaFin;
    private int duracionMinutos;
    private String tipoEvento;
    private String motivoCita;
    private String estado;
    private String fechaCreacion;
    private String fechaCancelacion;
    private String motivoCancelacion;
    private int idCliente;
    private int idDisponibilidad;
    private int idAdministradorAsigno;

    public Cita() {}

    public int getIdCita() { return idCita; }
    public void setIdCita(int idCita) { this.idCita = idCita; }

    public LocalDate getFechaCita() { return fechaCita; }
    public void setFechaCita(LocalDate fechaCita) { 
        this.fechaCita = fechaCita; 
    }

    public LocalTime getHoraInicio() { return horaInicio; }
    public void setHoraInicio(LocalTime horaInicio) { 
        this.horaInicio = horaInicio; 
    }

    public LocalTime getHoraFin() { return horaFin; }
    public void setHoraFin(LocalTime horaFin) { 
        this.horaFin = horaFin; 
    }

    public int getDuracionMinutos() { return duracionMinutos; }
    public void setDuracionMinutos(int duracionMinutos) { 
        this.duracionMinutos = duracionMinutos; 
    }

    public String getTipoEvento() { return tipoEvento; }
    public void setTipoEvento(String tipoEvento) { 
        this.tipoEvento = tipoEvento; 
    }

    public String getMotivoCita() { return motivoCita; }
    public void setMotivoCita(String motivoCita) { 
        this.motivoCita = motivoCita; 
    }

    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }

    public String getFechaCreacion() { return fechaCreacion; }
    public void setFechaCreacion(String fechaCreacion) { 
        this.fechaCreacion = fechaCreacion; 
    }

    public String getFechaCancelacion() { return fechaCancelacion; }
    public void setFechaCancelacion(String fechaCancelacion) { 
        this.fechaCancelacion = fechaCancelacion; 
    }

    public String getMotivoCancelacion() { return motivoCancelacion; }
    public void setMotivoCancelacion(String motivoCancelacion) { 
        this.motivoCancelacion = motivoCancelacion; 
    }

    public int getIdCliente() { return idCliente; }
    public void setIdCliente(int idCliente) { 
        this.idCliente = idCliente; 
    }

    public int getIdDisponibilidad() { return idDisponibilidad; }
    public void setIdDisponibilidad(int idDisponibilidad) { 
        this.idDisponibilidad = idDisponibilidad; 
    }

    public int getIdAdministradorAsigno() { 
        return idAdministradorAsigno; 
    }
    public void setIdAdministradorAsigno(int idAdministradorAsigno) { 
        this.idAdministradorAsigno = idAdministradorAsigno; 
    }
}