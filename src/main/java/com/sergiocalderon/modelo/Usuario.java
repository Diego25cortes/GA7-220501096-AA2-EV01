package com.sergiocalderon.modelo;

public class Usuario {
    private int idUsuario;
    private String nombre;
    private String apellido;
    private String email;
    private String contrasena;
    private String telefono;
    private String tipoUsuario;

    public Usuario() {}

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
    }

    public int getIdUsuario() { return idUsuario; }
    public void setIdUsuario(int idUsuario) { 
        this.idUsuario = idUsuario; 
    }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getApellido() { return apellido; }
    public void setApellido(String apellido) { 
        this.apellido = apellido; 
    }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getContrasena() { return contrasena; }
    public void setContrasena(String contrasena) { 
        this.contrasena = contrasena; 
    }

    public String getTelefono() { return telefono; }
    public void setTelefono(String telefono) { 
        this.telefono = telefono; 
    }

    public String getTipoUsuario() { return tipoUsuario; }
    public void setTipoUsuario(String tipoUsuario) { 
        this.tipoUsuario = tipoUsuario; 
    }

    @Override
    public String toString() {
        return "Usuario{id=" + idUsuario + ", nombre=" + nombre +
            " " + apellido + ", email=" + email +
            ", tipo=" + tipoUsuario + "}";
    }
}
