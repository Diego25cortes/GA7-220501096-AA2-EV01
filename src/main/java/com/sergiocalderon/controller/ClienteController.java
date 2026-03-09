package com.sergiocalderon.controller;

import com.sergiocalderon.modelo.Usuario;
import com.sergiocalderon.modelo.Cita;
import com.sergiocalderon.modelo.Disponibilidad;
import com.sergiocalderon.service.CitaService;
import com.sergiocalderon.service.DisponibilidadService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;
import java.util.List;

@Controller
@RequestMapping("/cliente")
public class ClienteController {

    @Autowired
    private DisponibilidadService disponibilidadService;

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session) {
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        if (usuario == null) {
            return "redirect:/auth/login";
        }
        return "cliente/dashboard";
    }

    @GetMapping("/cita")
    public String crearCita(@RequestParam(value = "fecha", required = false) String fecha,
            HttpSession session,
            Model model) {
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        if (usuario == null) {
            return "redirect:/auth/login";
        }

        // Si se seleccionó una fecha, cargar horarios disponibles
        if (fecha != null && !fecha.isEmpty()) {
            LocalDate fechaSeleccionada = LocalDate.parse(fecha);
            List<Disponibilidad> horarios = disponibilidadService.buscarPorFecha(fechaSeleccionada);

            // Convertir a formato para el JSP (array de strings)
            List<String[]> horariosFormateados = new java.util.ArrayList<>();
            for (Disponibilidad d : horarios) {
                if (d.isDisponible() && d.getCuposOcupados() < d.getCuposTotales()) {
                    horariosFormateados.add(new String[] {
                            String.valueOf(d.getIdDisponibilidad()),
                            d.getHoraInicio().toString(),
                            d.getHoraFin().toString()
                    });
                }
            }

            model.addAttribute("horarios", horariosFormateados);
            model.addAttribute("fechaSeleccionada", fecha);
        }

        return "cliente/crearCita";
    }

    @Autowired
    private CitaService citaService;

    @PostMapping("/cita")
    public String guardarCita(@RequestParam("fecha") String fecha,
            @RequestParam("idDisponibilidad") int idDisponibilidad,
            @RequestParam("tipoEvento") String tipoEvento,
            @RequestParam(value = "motivoCita", required = false) String motivoCita,
            HttpSession session,
            Model model) {

        Usuario usuario = (Usuario) session.getAttribute("usuario");
        if (usuario == null) {
            return "redirect:/auth/login";
        }

        try {
            citaService.agendarCita(usuario.getIdUsuario(), idDisponibilidad,
                    tipoEvento, motivoCita);
            model.addAttribute("exito", "Cita agendada exitosamente");
        } catch (Exception e) {
            model.addAttribute("error", "Error al agendar cita: " + e.getMessage());
            return "redirect:/cliente/cita?fecha=" + fecha;
        }

        return "redirect:/cliente/miscitas";
    }

    @GetMapping("/miscitas")
    public String misCitas(HttpSession session, Model model) {
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        if (usuario == null) {
            return "redirect:/auth/login";
        }

        List<Cita> citas = citaService.obtenerCitasPorCliente(usuario.getIdUsuario());
        model.addAttribute("citas", citas);

        return "cliente/misCitas";
    }
}