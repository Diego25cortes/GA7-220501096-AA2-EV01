package com.sergiocalderon.servlet.auth;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

import com.sergiocalderon.dao.UsuarioDAO;
import com.sergiocalderon.modelo.Usuario;

public class LoginServlet extends HttpServlet {

    private UsuarioDAO usuarioDAO = new UsuarioDAO();

    // GET - Mostrar formulario de login
    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher(
                "/vistas/auth/login.jsp").forward(request, response);
    }

    // POST - Procesar login
    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String contrasena = request.getParameter("contrasena");

        try {
            Usuario usuario = usuarioDAO.buscarPorEmail(email);

            if (usuario != null &&
                    usuario.getContrasena().equals(contrasena)) {

                // Crear sesión
                HttpSession sesion = request.getSession();
                sesion.setAttribute("usuarioSesion", usuario);
                sesion.setAttribute("tipoUsuario",
                        usuario.getTipoUsuario());

                // Redirigir según rol
                if (usuario.getTipoUsuario().equals("ADMIN")) {
                    response.sendRedirect(
                            request.getContextPath() +
                                    "/vistas/admin/dashboard.jsp");
                } else {
                    response.sendRedirect(
                            request.getContextPath() +
                                    "/vistas/cliente/dashboard.jsp");
                }

            } else {
                request.setAttribute("error",
                        "Email o contraseña incorrectos");
                request.getRequestDispatcher(
                        "/vistas/auth/login.jsp")
                        .forward(request, response);
            }

        } catch (SQLException e) {
            request.setAttribute("error",
                    "Error del servidor, intente más tarde");
            request.getRequestDispatcher(
                    "/vistas/auth/login.jsp")
                    .forward(request, response);
        }
    }
}