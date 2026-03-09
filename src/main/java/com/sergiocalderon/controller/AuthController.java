package com.sergiocalderon.controller;

import com.sergiocalderon.modelo.Disponibilidad;
import com.sergiocalderon.modelo.Usuario;
import com.sergiocalderon.service.AuthService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import jakarta.servlet.http.HttpSession;

import java.util.ArrayList;
import java.util.Optional;
import java.util.List;

@Controller
@RequestMapping("/auth")
public class AuthController {

    @Autowired
    private AuthService authService;

    @GetMapping("/")
    public String home() {
        return "redirect:/auth/login";
    }

    @GetMapping("/login")
    public String mostrarLogin() {
        return "auth/login";
    }

    @PostMapping("/login")
    public String procesarLogin(@RequestParam("email") String email,
            @RequestParam("contrasena") String contrasena,
            HttpSession session,
            Model model) {
        try {
            Optional<Usuario> usuarioOpt = authService.login(email, contrasena);
            if (usuarioOpt.isPresent()) {
                Usuario usuario = usuarioOpt.get();
                session.setAttribute("usuario", usuario);

                System.out.println("===== LOGIN EXITOSO =====");
                System.out.println("Usuario ID: " + usuario.getIdUsuario());
                System.out.println("Usuario email: " + usuario.getEmail());
                System.out.println("Usuario tipo: " + usuario.getTipoUsuario());
                System.out.println("Session ID: " + session.getId());

                if (usuario.esAdmin()) {
                    return "redirect:/admin/dashboard";
                } else {
                    return "redirect:/cliente/dashboard"; 
                }
            } else {
                model.addAttribute("error", "Email o contraseña incorrectos");
                return "auth/login";
            }
        } catch (Exception e) {
            model.addAttribute("error", "Error en el servidor: " + e.getMessage());
            return "auth/login";
        }
    }

    @GetMapping("/registro")
    public String mostrarRegistro() {
        return "auth/registro";
    }

    @PostMapping("/registro")
    public String procesarRegistro(@RequestParam String nombre,
            @RequestParam String apellido,
            @RequestParam String email,
            @RequestParam String contrasena,
            @RequestParam(required = false) String telefono,
            Model model) {
        try {
            Usuario nuevoUsuario = authService.registrarCliente(
                    nombre, apellido, email, contrasena, telefono);
            model.addAttribute("mensaje", "Registro exitoso. Por favor inicia sesión.");
            return "auth/login"; // Solo el nombre de la vista
        } catch (RuntimeException e) {
            model.addAttribute("error", e.getMessage());
            return "auth/registro"; // Solo el nombre de la vista
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/auth/login";
    }

    @GetMapping("/test")
    @ResponseBody
    public String test() {
        return "El controlador funciona!";
    }
}
