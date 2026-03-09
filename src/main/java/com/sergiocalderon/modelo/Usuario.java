package com.sergiocalderon.modelo;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "usuario")
public class Usuario {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_usuario")
    private int idUsuario;

    @Column(nullable = false, length = 100)
    private String nombre;

    @Column(nullable = false, length = 100)
    private String apellido;

    @Column(nullable = false, unique = true, length = 150)
    private String email;

    @Column(nullable = false, length = 255)
    private String contrasena;

    @Column(length = 20)
    private String telefono;

    // Campo privado - usamos String internamente para compatibilidad
    @Column(name = "tipo_usuario", nullable = false, columnDefinition = "ENUM('ADMIN','CLIENTE')")
    private String tipoUsuario;

    @Column(name = "fecha_registro")
    private LocalDateTime fechaRegistro;

    // Constructor vacío
    public Usuario() {
    }

    // Constructor completo para Servlets
    public Usuario(int idUsuario, String nombre, String apellido,
            String email, String contrasena,
            String telefono, String tipoUsuario) {
        this.idUsuario = idUsuario;
        this.nombre = nombre;
        this.apellido = apellido;
        this.email = email;
        this.contrasena = contrasena;
        this.telefono = telefono;
        this.tipoUsuario = tipoUsuario;
        this.fechaRegistro = LocalDateTime.now();
    }

    // Getters y Setters (TODO con String para compatibilidad)
    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellido() {
        return apellido;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getContrasena() {
        return contrasena;
    }

    public void setContrasena(String contrasena) {
        this.contrasena = contrasena;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getTipoUsuario() {
        return tipoUsuario;
    }

    public void setTipoUsuario(String tipoUsuario) {
        this.tipoUsuario = tipoUsuario;
    }

    public LocalDateTime getFechaRegistro() {
        return fechaRegistro;
    }

    public void setFechaRegistro(LocalDateTime fechaRegistro) {
        this.fechaRegistro = fechaRegistro;
    }

    @PrePersist
    protected void onCreate() {
        if (fechaRegistro == null) {
            fechaRegistro = LocalDateTime.now();
        }
    }

    // Métodos helper (basados en String)
    public boolean esAdmin() {
        return "ADMIN".equalsIgnoreCase(this.tipoUsuario);
    }

    public boolean esCliente() {
        return "CLIENTE".equalsIgnoreCase(this.tipoUsuario);
    }

    @Override
    public String toString() {
        return "Usuario{" +
                "id=" + idUsuario +
                ", nombre='" + nombre + " " + apellido + '\'' +
                ", email='" + email + '\'' +
                ", tipo='" + tipoUsuario + '\'' +
                '}';
    }
}