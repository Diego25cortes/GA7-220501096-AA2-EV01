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

public class CitaClienteServlet extends HttpServlet {

    private CitaDAO citaDAO = new CitaDAO();
    private DisponibilidadDAO disponibilidadDAO = 
        new DisponibilidadDAO();

    // GET - Mostrar formulario o cargar horarios por fecha
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

        String fecha = request.getParameter("fecha");
        if (fecha != null && !fecha.isEmpty()) {
            try {
                List<String[]> horarios = 
                    disponibilidadDAO.listarPorFecha(fecha);
                request.setAttribute("horarios", horarios);
                request.setAttribute("fechaSeleccionada", fecha);
            } catch (SQLException e) {
                request.setAttribute("error", 
                    "Error cargando horarios: " + e.getMessage());
            }
        }

        request.getRequestDispatcher(
            "/vistas/cliente/crearCita.jsp")
            .forward(request, response);
    }

    // POST - Guardar nueva cita
    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession sesion = request.getSession(false);
        Usuario usuario = (Usuario) sesion.getAttribute(
            "usuarioSesion");

        String fecha           = request.getParameter("fecha");
        String idDisp          = request.getParameter(
            "idDisponibilidad");
        String horaInicio      = request.getParameter("horaInicio");
        String horaFin         = request.getParameter("horaFin");
        String tipoEvento      = request.getParameter("tipoEvento");
        String motivoCita      = request.getParameter("motivoCita");

        try {
            Cita cita = new Cita();
            cita.setFechaCita(LocalDate.parse(fecha));
            cita.setHoraInicio(LocalTime.parse(horaInicio));
            cita.setHoraFin(LocalTime.parse(horaFin));
            cita.setDuracionMinutos(60);
            cita.setTipoEvento(tipoEvento);
            cita.setMotivoCita(motivoCita);
            cita.setIdCliente(usuario.getIdUsuario());
            cita.setIdDisponibilidad(Integer.parseInt(idDisp));

            boolean creada = citaDAO.crearCita(cita);

            if (creada) {
                disponibilidadDAO.ocuparCupo(
                    Integer.parseInt(idDisp));
                request.setAttribute("exito",
                    "¡Tu cita ha sido agendada exitosamente!");
            } else {
                request.setAttribute("error",
                    "No se pudo agendar la cita, intenta de nuevo");
            }

        } catch (SQLException e) {
            request.setAttribute("error",
                "Error del servidor: " + e.getMessage());
        }

        request.getRequestDispatcher(
            "/vistas/cliente/crearCita.jsp")
            .forward(request, response);
    }
}