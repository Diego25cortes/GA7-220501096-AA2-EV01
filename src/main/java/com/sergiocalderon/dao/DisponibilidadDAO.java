package com.sergiocalderon.dao;

import com.sergiocalderon.modelo.Disponibilidad;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DisponibilidadDAO {

    // INSERT - Crear disponibilidad
    public boolean crear(Disponibilidad d) throws SQLException {
        String sql = "INSERT INTO disponibilidad (fecha, hora_inicio," +
                     " hora_fin, disponible, cupos_totales, " +
                     "cupos_ocupados, id_administrador) " +
                     "VALUES (?, ?, ?, 1, ?, 0, ?)";
        Connection conexion = null;
        try {
            conexion = ConexionDB.obtenerConexion();
            PreparedStatement ps = conexion.prepareStatement(sql);
            ps.setDate(1, Date.valueOf(d.getFecha()));
            ps.setTime(2, Time.valueOf(d.getHoraInicio()));
            ps.setTime(3, Time.valueOf(d.getHoraFin()));
            ps.setInt(4, d.getCuposTotales());
            ps.setInt(5, d.getIdAdministrador());
            return ps.executeUpdate() > 0;
        } finally {
            ConexionDB.cerrarConexion(conexion);
        }
    }

    // SELECT - Listar todas
    public List<Disponibilidad> listarTodas() throws SQLException {
        String sql = "SELECT * FROM disponibilidad " +
                     "ORDER BY fecha DESC, hora_inicio ASC";
        List<Disponibilidad> lista = new ArrayList<>();
        Connection conexion = null;
        try {
            conexion = ConexionDB.obtenerConexion();
            PreparedStatement ps = conexion.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) lista.add(mapear(rs));
            return lista;
        } finally {
            ConexionDB.cerrarConexion(conexion);
        }
    }

    // SELECT - Listar por fecha
    public List<String[]> listarPorFecha(String fecha)
            throws SQLException {
        String sql = "SELECT id_disponibilidad, hora_inicio, " +
                     "hora_fin, cupos_totales, cupos_ocupados " +
                     "FROM disponibilidad " +
                     "WHERE fecha = ? AND disponible = 1 " +
                     "AND cupos_ocupados < cupos_totales " +
                     "ORDER BY hora_inicio";
        List<String[]> lista = new ArrayList<>();
        Connection conexion = null;
        try {
            conexion = ConexionDB.obtenerConexion();
            PreparedStatement ps = conexion.prepareStatement(sql);
            ps.setString(1, fecha);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                lista.add(new String[]{
                    rs.getString("id_disponibilidad"),
                    rs.getString("hora_inicio"),
                    rs.getString("hora_fin"),
                    rs.getString("cupos_totales"),
                    rs.getString("cupos_ocupados")
                });
            }
            return lista;
        } finally {
            ConexionDB.cerrarConexion(conexion);
        }
    }

    // SELECT - Buscar por ID
    public Disponibilidad buscarPorId(int id) throws SQLException {
        String sql = "SELECT * FROM disponibilidad " +
                     "WHERE id_disponibilidad = ?";
        Connection conexion = null;
        try {
            conexion = ConexionDB.obtenerConexion();
            PreparedStatement ps = conexion.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapear(rs);
            return null;
        } finally {
            ConexionDB.cerrarConexion(conexion);
        }
    }

    // UPDATE - Actualizar disponibilidad
    public boolean actualizar(Disponibilidad d) throws SQLException {
        String sql = "UPDATE disponibilidad SET fecha=?, " +
                     "hora_inicio=?, hora_fin=?, " +
                     "cupos_totales=?, disponible=? " +
                     "WHERE id_disponibilidad=?";
        Connection conexion = null;
        try {
            conexion = ConexionDB.obtenerConexion();
            PreparedStatement ps = conexion.prepareStatement(sql);
            ps.setDate(1, Date.valueOf(d.getFecha()));
            ps.setTime(2, Time.valueOf(d.getHoraInicio()));
            ps.setTime(3, Time.valueOf(d.getHoraFin()));
            ps.setInt(4, d.getCuposTotales());
            ps.setBoolean(5, d.isDisponible());
            ps.setInt(6, d.getIdDisponibilidad());
            return ps.executeUpdate() > 0;
        } finally {
            ConexionDB.cerrarConexion(conexion);
        }
    }

    // DELETE - Eliminar disponibilidad
    public boolean eliminar(int id) throws SQLException {
        String sql = "DELETE FROM disponibilidad " +
                     "WHERE id_disponibilidad = ?";
        Connection conexion = null;
        try {
            conexion = ConexionDB.obtenerConexion();
            PreparedStatement ps = conexion.prepareStatement(sql);
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } finally {
            ConexionDB.cerrarConexion(conexion);
        }
    }

    // UPDATE - Ocupar cupo
    public boolean ocuparCupo(int id) throws SQLException {
        String sql = "UPDATE disponibilidad " +
                     "SET cupos_ocupados = cupos_ocupados + 1 " +
                     "WHERE id_disponibilidad = ?";
        Connection conexion = null;
        try {
            conexion = ConexionDB.obtenerConexion();
            PreparedStatement ps = conexion.prepareStatement(sql);
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } finally {
            ConexionDB.cerrarConexion(conexion);
        }
    }

    private Disponibilidad mapear(ResultSet rs) throws SQLException {
        Disponibilidad d = new Disponibilidad();
        d.setIdDisponibilidad(rs.getInt("id_disponibilidad"));
        d.setFecha(rs.getDate("fecha").toLocalDate());
        d.setHoraInicio(rs.getTime("hora_inicio").toLocalTime());
        d.setHoraFin(rs.getTime("hora_fin").toLocalTime());
        d.setDisponible(rs.getBoolean("disponible"));
        d.setCuposTotales(rs.getInt("cupos_totales"));
        d.setCuposOcupados(rs.getInt("cupos_ocupados"));
        d.setIdAdministrador(rs.getInt("id_administrador"));
        return d;
    }
}