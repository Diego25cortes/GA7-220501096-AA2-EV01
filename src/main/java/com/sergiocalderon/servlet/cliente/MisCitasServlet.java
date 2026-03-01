package com.sergiocalderon.servlet.cliente;

import com.sergiocalderon.dao.CitaDAO;
import com.sergiocalderon.dao.DisponibilidadDAO;
import com.sergiocalderon.modelo.Cita;
import com.sergiocalderon.modelo.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

public class MisCitasServlet extends HttpServlet {

    private CitaDAO citaDAO = new CitaDAO();
    private DisponibilidadDAO disponibilidadDAO =
        new DisponibilidadDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession sesion = request.getSession(false);
        if (sesion == null ||
            sesion.getAttribute("usuarioSesion") == null) {
            response.sendRedirect(
                request.getContextPath() +
                "/vistas/auth/login.jsp");
            return;
        }

        Usuario usuario = (Usuario) sesion.getAttribute(
            "usuarioSesion");
        String accion = request.getParameter("accion");

        try {
            if ("editar".equals(accion)) {
                int idCita = Integer.parseInt(
                    request.getParameter("id"));
                Cita cita = citaDAO.buscarPorId(idCita);
                // Verificar que la cita pertenece al cliente
                if (cita != null && 
                    cita.getIdCliente() == 
                    usuario.getIdUsuario()) {
                    request.setAttribute("citaEditar", cita);
                    // Cargar horarios de esa fecha
                    List<String[]> horarios =
                        disponibilidadDAO.listarPorFecha(
                            cita.getFechaCita().toString());
                    request.setAttribute("horariosEditar",
                        horarios);
                }
            } else if ("cancelar".equals(accion)) {
                int idCita = Integer.parseInt(
                    request.getParameter("id"));
                Cita cita = citaDAO.buscarPorId(idCita);
                if (cita != null &&
                    cita.getIdCliente() ==
                    usuario.getIdUsuario()) {
                    citaDAO.cancelarCita(idCita,
                        "Cancelada por el cliente");
                    request.setAttribute("exito",
                        "Cita cancelada exitosamente");
                }
            }

            // Cargar todas las citas del cliente
            List<Cita> citas = citaDAO.listarPorCliente(
                usuario.getIdUsuario());
            request.setAttribute("misCitas", citas);

        } catch (SQLException e) {
            request.setAttribute("error",
                "Error: " + e.getMessage());
        }

        request.getRequestDispatcher(
            "/vistas/cliente/misCitas.jsp")
            .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession sesion = request.getSession(false);
        Usuario usuario = (Usuario) sesion.getAttribute(
            "usuarioSesion");

        String accion = request.getParameter("accion");

        try {
            if ("modificar".equals(accion)) {
                int idCita = Integer.parseInt(
                    request.getParameter("idCita"));
                Cita cita = citaDAO.buscarPorId(idCita);

                if (cita != null &&
                    cita.getIdCliente() ==
                    usuario.getIdUsuario() &&
                    "PENDIENTE".equals(cita.getEstado())) {

                    cita.setFechaCita(LocalDate.parse(
                        request.getParameter("fecha")));
                    cita.setHoraInicio(LocalTime.parse(
                        request.getParameter("horaInicio")));
                    cita.setHoraFin(LocalTime.parse(
                        request.getParameter("horaFin")));
                    cita.setTipoEvento(
                        request.getParameter("tipoEvento"));
                    cita.setMotivoCita(
                        request.getParameter("motivoCita"));
                    cita.setIdDisponibilidad(
                        Integer.parseInt(request.getParameter(
                            "idDisponibilidad")));

                    citaDAO.modificarCita(cita);
                    request.setAttribute("exito",
                        "Cita modificada exitosamente");
                }
            }

            List<Cita> citas = citaDAO.listarPorCliente(
                usuario.getIdUsuario());
            request.setAttribute("misCitas", citas);

        } catch (SQLException e) {
            request.setAttribute("error",
                "Error: " + e.getMessage());
        }

        request.getRequestDispatcher(
            "/vistas/cliente/misCitas.jsp")
            .forward(request, response);
    }
}