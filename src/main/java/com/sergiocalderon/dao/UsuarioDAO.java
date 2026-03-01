package com.sergiocalderon.dao;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.sergiocalderon.modelo.Usuario;

public class UsuarioDAO {
    // INSERT - Registrar nuevo usuario
    public boolean registrar(Usuario usuario) throws SQLException {
        String sql = "INSERT INTO usuario (nombre, apellido, email, " +
                     "contrasena, telefono, tipo_usuario) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";
        Connection conexion = null;
        try {
            conexion = ConexionDB.obtenerConexion();
            PreparedStatement ps = conexion.prepareStatement(sql);
            ps.setString(1, usuario.getNombre());
            ps.setString(2, usuario.getApellido());
            ps.setString(3, usuario.getEmail());
            ps.setString(4, usuario.getContrasena());
            ps.setString(5, usuario.getTelefono());
            ps.setString(6, usuario.getTipoUsuario());
            return ps.executeUpdate() > 0;
        } finally {
            ConexionDB.cerrarConexion(conexion);
        }
    }

    // SELECT - Buscar usuario por email (para login)
    public Usuario buscarPorEmail(String email) throws SQLException {
        String sql = "SELECT * FROM usuario WHERE email = ?";
        Connection conexion = null;
        try {
            conexion = ConexionDB.obtenerConexion();
            PreparedStatement ps = conexion.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapearUsuario(rs);
            }
            return null;
        } finally {
            ConexionDB.cerrarConexion(conexion);
        }
    }

    // SELECT - Listar todos los usuarios
    public List<Usuario> listarTodos() throws SQLException {
        String sql = "SELECT * FROM usuario";
        List<Usuario> lista = new ArrayList<>();
        Connection conexion = null;
        try {
            conexion = ConexionDB.obtenerConexion();
            PreparedStatement ps = conexion.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                lista.add(mapearUsuario(rs));
            }
            return lista;
        } finally {
            ConexionDB.cerrarConexion(conexion);
        }
    }

    // UPDATE - Actualizar datos del usuario
    public boolean actualizar(Usuario usuario) throws SQLException {
        String sql = "UPDATE usuario SET nombre=?, apellido=?, " +
                     "telefono=? WHERE id_usuario=?";
        Connection conexion = null;
        try {
            conexion = ConexionDB.obtenerConexion();
            PreparedStatement ps = conexion.prepareStatement(sql);
            ps.setString(1, usuario.getNombre());
            ps.setString(2, usuario.getApellido());
            ps.setString(3, usuario.getTelefono());
            ps.setInt(4, usuario.getIdUsuario());
            return ps.executeUpdate() > 0;
        } finally {
            ConexionDB.cerrarConexion(conexion);
        }
    }

    // DELETE - Eliminar usuario
    public boolean eliminar(int idUsuario) throws SQLException {
        String sql = "DELETE FROM usuario WHERE id_usuario = ?";
        Connection conexion = null;
        try {
            conexion = ConexionDB.obtenerConexion();
            PreparedStatement ps = conexion.prepareStatement(sql);
            ps.setInt(1, idUsuario);
            return ps.executeUpdate() > 0;
        } finally {
            ConexionDB.cerrarConexion(conexion);
        }
    }

    // Método auxiliar para mapear ResultSet a objeto Usuario
    private Usuario mapearUsuario(ResultSet rs) throws SQLException {
        return new Usuario(
            rs.getInt("id_usuario"),
            rs.getString("nombre"),
            rs.getString("apellido"),
            rs.getString("email"),
            rs.getString("contrasena"),
            rs.getString("telefono"),
            rs.getString("tipo_usuario")
        );
        }
        // INSERT - Registrar en tabla cliente
public boolean registrarCliente(int idUsuario) throws SQLException {
    String sql = "INSERT INTO cliente (id_cliente, direccion, " +
                "ciudad, numero_citas) VALUES (?, '', '', 0)";
    Connection conexion = null;
    try {
        conexion = ConexionDB.obtenerConexion();
        PreparedStatement ps = conexion.prepareStatement(sql);
        ps.setInt(1, idUsuario);
        return ps.executeUpdate() > 0;
    } finally {
        ConexionDB.cerrarConexion(conexion);
    }
}
    
}
