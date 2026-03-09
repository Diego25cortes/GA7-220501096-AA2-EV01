package com.sergiocalderon.modelo;

import jakarta.persistence.*;

@Entity
@Table(name = "cliente")
public class Cliente {
    
    @Id
    @Column(name = "id_cliente")
    private int idCliente;
    
    private String direccion = "";
    
    private String ciudad = "";
    
    @Column(name = "numero_citas")
    private int numeroCitas = 0;
    
    // Constructores
    public Cliente() {}
    
    // Getters y Setters
    public int getIdCliente() { return idCliente; }
    public void setIdCliente(int idCliente) { this.idCliente = idCliente; }
    
    public String getDireccion() { return direccion; }
    public void setDireccion(String direccion) { this.direccion = direccion; }
    
    public String getCiudad() { return ciudad; }
    public void setCiudad(String ciudad) { this.ciudad = ciudad; }
    
    public int getNumeroCitas() { return numeroCitas; }
    public void setNumeroCitas(int numeroCitas) { this.numeroCitas = numeroCitas; }
}