package com.sergiocalderon.dao;

import com.sergiocalderon.modelo.Cita;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CitaDAO {

    // INSERT - Crear nueva cita
    public boolean crearCita(Cita cita) throws SQLException {
        String sql = "INSERT INTO cita (fecha_cita, hora_inicio, " +
                     "hora_fin, duracion_minutos, tipo_evento, " +
                     "motivo_cita, estado, id_cliente, " +
                     "id_disponibilidad) " +
                     "VALUES (?, ?, ?, ?, ?, ?, 'PENDIENTE', ?, ?)";
        Connection conexion = null;
        try {
            conexion = ConexionDB.obtenerConexion();
            PreparedStatement ps = conexion.prepareStatement(sql);
            ps.setDate(1, Date.valueOf(cita.getFechaCita()));
            ps.setTime(2, Time.valueOf(cita.getHoraInicio()));
            ps.setTime(3, Time.valueOf(cita.getHoraFin()));
            ps.setInt(4, cita.getDuracionMinutos());
            ps.setString(5, cita.getTipoEvento());
            ps.setString(6, cita.getMotivoCita());
            ps.setInt(7, cita.getIdCliente());
            ps.setInt(8, cita.getIdDisponibilidad());
            return ps.executeUpdate() > 0;
        } finally {
            ConexionDB.cerrarConexion(conexion);
        }
    }

    // SELECT - Listar citas por cliente
    public List<Cita> listarPorCliente(int idCliente) 
            throws SQLException {
        String sql = "SELECT * FROM cita WHERE id_cliente = ? " +
                     "ORDER BY fecha_cita DESC, hora_inicio DESC";
        List<Cita> lista = new ArrayList<>();
        Connection conexion = null;
        try {
            conexion = ConexionDB.obtenerConexion();
            PreparedStatement ps = conexion.prepareStatement(sql);
            ps.setInt(1, idCliente);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                lista.add(mapearCita(rs));
            }
            return lista;
        } finally {
            ConexionDB.cerrarConexion(conexion);
        }
    }

    // SELECT - Buscar cita por ID
    public Cita buscarPorId(int idCita) throws SQLException {
        String sql = "SELECT * FROM cita WHERE id_cita = ?";
        Connection conexion = null;
        try {
            conexion = ConexionDB.obtenerConexion();
            PreparedStatement ps = conexion.prepareStatement(sql);
            ps.setInt(1, idCita);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapearCita(rs);
            return null;
        } finally {
            ConexionDB.cerrarConexion(conexion);
        }
    }

    // UPDATE - Modificar cita
    public boolean modificarCita(Cita cita) throws SQLException {
        String sql = "UPDATE cita SET fecha_cita=?, hora_inicio=?, " +
                     "hora_fin=?, tipo_evento=?, motivo_cita=?, " +
                     "id_disponibilidad=? WHERE id_cita=?";
        Connection conexion = null;
        try {
            conexion = ConexionDB.obtenerConexion();
            PreparedStatement ps = conexion.prepareStatement(sql);
            ps.setDate(1, Date.valueOf(cita.getFechaCita()));
            ps.setTime(2, Time.valueOf(cita.getHoraInicio()));
            ps.setTime(3, Time.valueOf(cita.getHoraFin()));
            ps.setString(4, cita.getTipoEvento());
            ps.setString(5, cita.getMotivoCita());
            ps.setInt(6, cita.getIdDisponibilidad());
            ps.setInt(7, cita.getIdCita());
            return ps.executeUpdate() > 0;
        } finally {
            ConexionDB.cerrarConexion(conexion);
        }
    }

    // UPDATE - Cancelar cita
    public boolean cancelarCita(int idCita, String motivo) 
            throws SQLException {
        String sql = "UPDATE cita SET estado='CANCELADA', " +
                     "motivo_cancelacion=?, " +
                     "fecha_cancelacion=NOW() " +
                     "WHERE id_cita=?";
        Connection conexion = null;
        try {
            conexion = ConexionDB.obtenerConexion();
            PreparedStatement ps = conexion.prepareStatement(sql);
            ps.setString(1, motivo);
            ps.setInt(2, idCita);
            return ps.executeUpdate() > 0;
        } finally {
            ConexionDB.cerrarConexion(conexion);
        }
    }

    // SELECT - Listar todas las citas (admin)
    public List<Cita> listarTodas() throws SQLException {
        String sql = "SELECT * FROM cita ORDER BY fecha_cita DESC";
        List<Cita> lista = new ArrayList<>();
        Connection conexion = null;
        try {
            conexion = ConexionDB.obtenerConexion();
            PreparedStatement ps = conexion.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) lista.add(mapearCita(rs));
            return lista;
        } finally {
            ConexionDB.cerrarConexion(conexion);
        }
    }

    private Cita mapearCita(ResultSet rs) throws SQLException {
        Cita cita = new Cita();
        cita.setIdCita(rs.getInt("id_cita"));
        cita.setFechaCita(rs.getDate("fecha_cita").toLocalDate());
        cita.setHoraInicio(rs.getTime("hora_inicio").toLocalTime());
        cita.setHoraFin(rs.getTime("hora_fin").toLocalTime());
        cita.setDuracionMinutos(rs.getInt("duracion_minutos"));
        cita.setTipoEvento(rs.getString("tipo_evento"));
        cita.setMotivoCita(rs.getString("motivo_cita"));
        cita.setEstado(rs.getString("estado"));
        cita.setIdCliente(rs.getInt("id_cliente"));
        cita.setIdDisponibilidad(rs.getInt("id_disponibilidad"));
        return cita;
    }
}
