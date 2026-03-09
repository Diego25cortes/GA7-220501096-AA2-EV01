package com.sergiocalderon.controller;

import com.sergiocalderon.modelo.Disponibilidad;
import com.sergiocalderon.modelo.Usuario;
import com.sergiocalderon.service.DisponibilidadService;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.LinkedHashSet;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.util.Set;
import org.springframework.ui.Model;

//list

@Controller
@RequestMapping("/admin")
public class AdminController {

    @GetMapping("/test")
    @ResponseBody
    public String test() {
        return "AdminController funciona!";
    }

    // Ruta principal del dashboard SIN .jsp
    @GetMapping("/dashboard")
    public String dashboard(HttpSession session) {
        System.out.println("===== ADMIN CONTROLLER EJECUTÁNDOSE =====");

        Usuario usuario = (Usuario) session.getAttribute("usuario");

        System.out.println("Session ID: " + session.getId());
        if (usuario == null) {
            System.out.println("❌ No hay usuario en sesión - redirigiendo a login");
            return "redirect:/auth/login";
        }

        System.out.println("✅ Usuario autenticado: " + usuario.getEmail());
        System.out.println("Tipo: " + usuario.getTipoUsuario());

        if (!usuario.esAdmin()) {
            System.out.println("❌ No es admin - redirigiendo a login");
            return "redirect:/auth/login";
        }

        System.out.println("✅ Acceso permitido - mostrando dashboard");
        return "admin/dashboard";
    }

    // También aceptamos la versión con .jsp por si acaso
    @GetMapping("/dashboard.jsp")
    public String dashboardConExtension(HttpSession session) {
        return dashboard(session);
    }

    @Autowired
    private DisponibilidadService disponibilidadService;

    @GetMapping("/gestionHorarios")
    public String gestionHorarios(HttpSession session, Model model) {
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        if (usuario == null || !usuario.esAdmin()) {
            return "redirect:/auth/login";
        }

        List<Disponibilidad> lista = disponibilidadService.obtenerTodos();
        model.addAttribute("listaDisponibilidad", lista);

        return "admin/gestionHorarios";
    }

    @PostMapping("/horarios")
    public String procesarHorarios(@RequestParam("accion") String accion,
            @RequestParam(value = "id", required = false) Integer id,
            @RequestParam(value = "fecha", required = false) String fechaStr,
            @RequestParam(value = "horaInicio", required = false) String horaInicioStr,
            @RequestParam(value = "horaFin", required = false) String horaFinStr,
            @RequestParam(value = "cupos", required = false) Integer cupos,
            @RequestParam(value = "disponible", required = false) Boolean disponible,
            @RequestParam(value = "horaDesde", required = false) String horaDesdeStr,
            @RequestParam(value = "horaHasta", required = false) String horaHastaStr,
            @RequestParam(value = "intervalo", required = false) Integer intervalo,
            HttpSession session,
            Model model) {

        Usuario usuario = (Usuario) session.getAttribute("usuario");
        if (usuario == null || !usuario.esAdmin()) {
            return "redirect:/auth/login";
        }

        try {
            if ("crear".equals(accion)) {
                // Crear múltiples horarios
                LocalDate fecha = LocalDate.parse(fechaStr);
                LocalTime horaDesde = LocalTime.parse(horaDesdeStr);
                LocalTime horaHasta = LocalTime.parse(horaHastaStr);

                disponibilidadService.generarHorarios(
                        fecha, horaDesde, horaHasta, intervalo, cupos, usuario.getIdUsuario());

                model.addAttribute("exito", "Horarios generados exitosamente");

            } else if ("actualizar".equals(accion) && id != null) {
                // Actualizar horario existente
                Disponibilidad horario = disponibilidadService.obtenerPorId(id);
                if (horario != null) {
                    horario.setFecha(LocalDate.parse(fechaStr));
                    horario.setHoraInicio(LocalTime.parse(horaInicioStr));
                    horario.setHoraFin(LocalTime.parse(horaFinStr));
                    horario.setCuposTotales(cupos);
                    horario.setDisponible(disponible != null ? disponible : false);
                    disponibilidadService.actualizarHorario(horario);
                    model.addAttribute("exito", "Horario actualizado correctamente");
                }

            } else if ("eliminar".equals(accion) && id != null) {
                // Eliminar horario
                disponibilidadService.eliminarHorario(id);
                model.addAttribute("exito", "Horario eliminado correctamente");
            }

        } catch (Exception e) {
            model.addAttribute("error", "Error: " + e.getMessage());
        }

        return "redirect:/admin/gestionHorarios";
    }

    @GetMapping("/horarios")
    public String gestionHorariosConParametros(@RequestParam(required = false) String accion,
            @RequestParam(required = false) Integer id,
            HttpSession session,
            Model model) {

        Usuario usuario = (Usuario) session.getAttribute("usuario");
        if (usuario == null || !usuario.esAdmin()) {
            return "redirect:/auth/login";
        }

        List<Disponibilidad> lista = disponibilidadService.obtenerTodos();
        model.addAttribute("listaDisponibilidad", lista);

        if ("editar".equals(accion) && id != null) {
            Disponibilidad horario = disponibilidadService.obtenerPorId(id);
            model.addAttribute("disponibilidad", horario);
        }

        return "admin/gestionHorarios";
    }

}