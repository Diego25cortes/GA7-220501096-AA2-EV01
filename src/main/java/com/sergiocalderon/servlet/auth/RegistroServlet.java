package com.sergiocalderon.servlet.auth;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

import com.sergiocalderon.dao.UsuarioDAO;
import com.sergiocalderon.modelo.Usuario;

public class RegistroServlet extends HttpServlet {

    private UsuarioDAO usuarioDAO = new UsuarioDAO();

    // GET - Mostrar formulario de registro
    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher(
            "/vistas/auth/registro.jsp")
            .forward(request, response);
    }

    // POST - Procesar registro
    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String nombre     = request.getParameter("nombre");
        String apellido   = request.getParameter("apellido");
        String email      = request.getParameter("email");
        String contrasena = request.getParameter("contrasena");
        String confirmar  = request.getParameter("confirmar");
        String telefono   = request.getParameter("telefono");

        // Validar que las contraseñas coincidan
        if (!contrasena.equals(confirmar)) {
            request.setAttribute("error",
                "Las contraseñas no coinciden");
            request.getRequestDispatcher(
                "/vistas/auth/registro.jsp")
                .forward(request, response);
            return;
        }

        // Validar longitud contraseña
        if (contrasena.length() < 6) {
            request.setAttribute("error",
                "La contraseña debe tener mínimo 6 caracteres");
            request.getRequestDispatcher(
                "/vistas/auth/registro.jsp")
                .forward(request, response);
            return;
        }

        try {
            // Verificar si el email ya existe
            Usuario existente = usuarioDAO.buscarPorEmail(email);
            if (existente != null) {
                request.setAttribute("error",
                    "Ya existe una cuenta con ese correo electrónico");
                request.getRequestDispatcher(
                    "/vistas/auth/registro.jsp")
                    .forward(request, response);
                return;
            }

            // Crear nuevo usuario como CLIENTE
            Usuario nuevoUsuario = new Usuario();
            nuevoUsuario.setNombre(nombre);
            nuevoUsuario.setApellido(apellido);
            nuevoUsuario.setEmail(email);
            nuevoUsuario.setContrasena(contrasena);
            nuevoUsuario.setTelefono(telefono);
            nuevoUsuario.setTipoUsuario("CLIENTE");

            boolean registrado = usuarioDAO.registrar(nuevoUsuario);

            if (registrado) {
                // Registrar también en tabla cliente
                Usuario usuarioCreado = 
                    usuarioDAO.buscarPorEmail(email);
                usuarioDAO.registrarCliente(
                    usuarioCreado.getIdUsuario());

                request.setAttribute("exito",
                    "¡Cuenta creada exitosamente! Ya puedes iniciar sesión.");
                request.getRequestDispatcher(
                    "/vistas/auth/registro.jsp")
                    .forward(request, response);
            } else {
                request.setAttribute("error",
                    "Error al crear la cuenta, intente de nuevo");
                request.getRequestDispatcher(
                    "/vistas/auth/registro.jsp")
                    .forward(request, response);
            }

        } catch (SQLException e) {
            request.setAttribute("error",
                "Error del servidor: " + e.getMessage());
            request.getRequestDispatcher(
                "/vistas/auth/registro.jsp")
                .forward(request, response);
        }
    }
}
