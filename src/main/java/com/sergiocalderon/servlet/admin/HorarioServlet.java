package com.sergiocalderon.servlet.admin;

import com.sergiocalderon.dao.DisponibilidadDAO;
import com.sergiocalderon.modelo.Disponibilidad;
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

public class HorarioServlet extends HttpServlet {

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

        String accion = request.getParameter("accion");

        try {
            if ("eliminar".equals(accion)) {
                int id = Integer.parseInt(
                    request.getParameter("id"));
                disponibilidadDAO.eliminar(id);
                response.sendRedirect(
                    request.getContextPath() +
                    "/admin/horarios?exito=eliminado");
                return;
            }

            if ("editar".equals(accion)) {
                int id = Integer.parseInt(
                    request.getParameter("id"));
                Disponibilidad d =
                    disponibilidadDAO.buscarPorId(id);
                request.setAttribute("disponibilidad", d);
            }

            List<Disponibilidad> lista =
                disponibilidadDAO.listarTodas();
            request.setAttribute("listaDisponibilidad", lista);

        } catch (SQLException e) {
            request.setAttribute("error",
                "Error: " + e.getMessage());
        }

        request.getRequestDispatcher(
            "/vistas/admin/gestionHorarios.jsp")
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
            if ("crear".equals(accion)) {
                // Crear horarios en rango
                String fecha      = request.getParameter("fecha");
                String horaDesde  = request.getParameter("horaDesde");
                String horaHasta  = request.getParameter("horaHasta");
                int intervalo     = Integer.parseInt(
                    request.getParameter("intervalo"));
                int cupos         = Integer.parseInt(
                    request.getParameter("cupos"));

                LocalTime inicio = LocalTime.parse(horaDesde);
                LocalTime fin    = LocalTime.parse(horaHasta);
                int creados = 0;

                while (inicio.plusMinutes(intervalo)
                             .compareTo(fin) <= 0) {
                    Disponibilidad d = new Disponibilidad();
                    d.setFecha(LocalDate.parse(fecha));
                    d.setHoraInicio(inicio);
                    d.setHoraFin(inicio.plusMinutes(intervalo));
                    d.setCuposTotales(cupos);
                    d.setIdAdministrador(usuario.getIdUsuario());
                    disponibilidadDAO.crear(d);
                    inicio = inicio.plusMinutes(intervalo);
                    creados++;
                }

                request.setAttribute("exito",
                    creados + " horarios creados exitosamente");

            } else if ("actualizar".equals(accion)) {
                int id = Integer.parseInt(
                    request.getParameter("id"));
                Disponibilidad d =
                    disponibilidadDAO.buscarPorId(id);
                d.setFecha(LocalDate.parse(
                    request.getParameter("fecha")));
                d.setHoraInicio(LocalTime.parse(
                    request.getParameter("horaInicio")));
                d.setHoraFin(LocalTime.parse(
                    request.getParameter("horaFin")));
                d.setCuposTotales(Integer.parseInt(
                    request.getParameter("cupos")));
                d.setDisponible(
                    "on".equals(
                        request.getParameter("disponible")));
                disponibilidadDAO.actualizar(d);
                request.setAttribute("exito",
                    "Horario actualizado correctamente");
            }

            List<Disponibilidad> lista =
                disponibilidadDAO.listarTodas();
            request.setAttribute("listaDisponibilidad", lista);

        } catch (SQLException e) {
            request.setAttribute("error",
                "Error: " + e.getMessage());
        }

        request.getRequestDispatcher(
            "/vistas/admin/gestionHorarios.jsp")
            .forward(request, response);
    }
}