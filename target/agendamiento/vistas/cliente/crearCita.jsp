<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.sergiocalderon.modelo.Usuario" %>
<%@ page import="java.util.List" %>
<%
    Usuario usuarioSesion = (Usuario) session.getAttribute(
        "usuarioSesion");
    if (usuarioSesion == null) {
        response.sendRedirect(request.getContextPath() + 
            "/vistas/auth/login.jsp");
        return;
    }
    List<String[]> horarios = (List<String[]>) 
        request.getAttribute("horarios");
    String fechaSeleccionada = (String) 
        request.getAttribute("fechaSeleccionada");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Agendar Cita - Sergio Calderón</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400;0,700&family=Lato:wght@300;400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --navbar: #D0B89E;
            --footer: #9E8C78;
            --fondo: #EBDFD4;
            --oscuro: #3E2417;
            --beige: #C9A97A;
        }
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Lato', sans-serif;
            background-color: var(--fondo);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        .navbar-sc {
            background-color: var(--navbar);
            padding: 10px 30px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .navbar-brand-sc {
            display: flex;
            align-items: center;
            gap: 12px;
            text-decoration: none;
        }
        .logo-img {
            width: 48px; height: 48px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid var(--oscuro);
            background: white;
            padding: 2px;
        }
        .brand-text .nombre {
            font-family: 'Playfair Display', serif;
            font-size: 1rem;
            font-weight: 700;
            color: var(--oscuro);
        }
        .brand-text .subtitulo {
            font-size: 0.62rem;
            letter-spacing: 2px;
            color: var(--oscuro);
            text-transform: uppercase;
        }
        .btn-volver {
            background: transparent;
            border: 1px solid var(--oscuro);
            color: var(--oscuro);
            padding: 7px 18px;
            border-radius: 2px;
            font-size: 0.82rem;
            text-decoration: none;
            letter-spacing: 1px;
            transition: all 0.3s;
        }
        .btn-volver:hover { background: var(--oscuro); color: #fff; }

        /* CONTENIDO */
        .contenido {
            flex: 1;
            max-width: 1100px;
            margin: 35px auto;
            padding: 0 20px;
            width: 100%;
        }
        .page-titulo {
            font-family: 'Playfair Display', serif;
            font-size: 1.8rem;
            color: var(--oscuro);
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 30px;
        }
        .card-sc {
            background: #fff;
            border-radius: 6px;
            padding: 30px;
            box-shadow: 0 3px 12px rgba(0,0,0,0.08);
        }
        .card-titulo {
            font-family: 'Playfair Display', serif;
            font-size: 1.1rem;
            color: var(--oscuro);
            margin-bottom: 20px;
            padding-bottom: 12px;
            border-bottom: 1px solid #D4B896;
        }
        .form-label-sc {
            display: block;
            font-size: 0.75rem;
            color: var(--oscuro);
            letter-spacing: 1.5px;
            text-transform: uppercase;
            margin-bottom: 6px;
            font-weight: 700;
        }
        .form-control-sc {
            width: 100%;
            padding: 10px 15px;
            border: 1px solid #D4B896;
            border-radius: 2px;
            font-family: 'Lato', sans-serif;
            font-size: 0.9rem;
            color: var(--oscuro);
            background: #fdfaf7;
            margin-bottom: 18px;
            outline: none;
            transition: border 0.3s;
        }
        .form-control-sc:focus {
            border-color: var(--oscuro);
        }
        .tipo-evento-grupo {
            display: flex;
            gap: 10px;
            margin-bottom: 18px;
            flex-wrap: wrap;
        }
        .tipo-btn {
            padding: 8px 18px;
            border: 1px solid #D4B896;
            border-radius: 2px;
            background: #fdfaf7;
            color: var(--oscuro);
            cursor: pointer;
            font-size: 0.85rem;
            transition: all 0.2s;
        }
        .tipo-btn.seleccionado {
            background: var(--oscuro);
            color: #fff;
            border-color: var(--oscuro);
        }

        /* HORARIOS */
        .horarios-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 10px;
            margin-bottom: 18px;
        }
        .horario-btn {
            padding: 10px;
            border: 1px solid #D4B896;
            border-radius: 2px;
            background: #fdfaf7;
            color: var(--oscuro);
            cursor: pointer;
            font-size: 0.85rem;
            text-align: center;
            transition: all 0.2s;
        }
        .horario-btn:hover {
            border-color: var(--oscuro);
            background: var(--fondo);
        }
        .horario-btn.seleccionado {
            background: var(--oscuro);
            color: #fff;
            border-color: var(--oscuro);
        }
        .horario-btn.ocupado {
            background: #f0e8df;
            color: #bbb;
            cursor: not-allowed;
            text-decoration: line-through;
        }
        .sin-horarios {
            text-align: center;
            color: #999;
            font-size: 0.85rem;
            padding: 20px;
            font-style: italic;
        }

        /* RESUMEN CITA */
        .resumen-cita {
            background: var(--fondo);
            border-radius: 4px;
            padding: 18px;
            margin-bottom: 18px;
            border: 1px solid #D4B896;
        }
        .resumen-titulo {
            font-family: 'Playfair Display', serif;
            font-size: 1rem;
            color: var(--oscuro);
            margin-bottom: 12px;
        }
        .resumen-fila {
            display: flex;
            justify-content: space-between;
            margin-bottom: 8px;
            font-size: 0.88rem;
        }
        .resumen-label { color: #999; }
        .resumen-valor {
            color: var(--oscuro);
            font-weight: 600;
        }
        .btn-agendar {
            width: 100%;
            padding: 14px;
            background: var(--oscuro);
            color: #fff;
            border: none;
            border-radius: 2px;
            font-family: 'Lato', sans-serif;
            font-size: 0.9rem;
            letter-spacing: 2px;
            text-transform: uppercase;
            cursor: pointer;
            transition: background 0.3s;
        }
        .btn-agendar:hover { background: #5C3D2E; }
        .btn-agendar:disabled {
            background: #ccc;
            cursor: not-allowed;
        }
        .alert-error {
            background: #fdecea;
            border-left: 3px solid #c0392b;
            color: #721c24;
            padding: 12px 15px;
            border-radius: 2px;
            font-size: 0.85rem;
            margin-bottom: 20px;
        }
        .alert-exito {
            background: #eafaf1;
            border-left: 3px solid #27ae60;
            color: #1e8449;
            padding: 12px 15px;
            border-radius: 2px;
            font-size: 0.85rem;
            margin-bottom: 20px;
        }

        /* FOOTER */
        .footer-sc {
            background-color: var(--footer);
            color: #fff;
            padding: 18px 30px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .footer-brand .nombre {
            font-family: 'Playfair Display', serif;
            font-size: 0.9rem;
        }
        .footer-copy { font-size: 0.72rem; opacity: 0.7; }
    </style>
</head>
<body>

<!-- NAVBAR -->
<nav class="navbar-sc">
    <a href="<%= request.getContextPath() 
             %>/vistas/cliente/dashboard.jsp"
       class="navbar-brand-sc">
        <img src="<%= request.getContextPath() %>/img/logo.png"
             alt="Logo" class="logo-img">
        <div class="brand-text">
            <div class="nombre">SERGIO CALDERÓN</div>
            <div class="subtitulo">Diseñador de Moda</div>
        </div>
    </a>
    <a href="<%= request.getContextPath() 
             %>/vistas/cliente/dashboard.jsp"
       class="btn-volver">← Volver</a>
</nav>

<!-- CONTENIDO -->
<div class="contenido">
    <h1 class="page-titulo">
    <i class="fa-regular fa-calendar-plus"></i> Agenda tu Cita
</h1>

    <% if (request.getAttribute("error") != null) { %>
        <div class="alert-error">
            <%= request.getAttribute("error") %>
        </div>
    <% } %>
    <% if (request.getAttribute("exito") != null) { %>
        <div class="alert-exito">
            <%= request.getAttribute("exito") %>
            <br><a href="<%= request.getContextPath() 
                         %>/vistas/cliente/misCitas.jsp">
                Ver mis citas 
            </a>
        </div>
    <% } %>

    <div class="form-grid">

        <!-- COLUMNA IZQUIERDA: fecha + datos cliente -->
        <div>
            <div class="card-sc" style="margin-bottom: 20px;">
                <div class="card-titulo">
                    Selecciona la fecha
                </div>
                <form method="get"
                      action="<%= request.getContextPath() 
                               %>/cliente/cita"
                      id="formFecha">
                    <label class="form-label-sc">
                        Fecha de la cita
                    </label>
                    <input type="date" name="fecha"
                           class="form-control-sc"
                           id="inputFecha"
                           min="<%= java.time.LocalDate.now()
                                    .plusDays(1) %>"
                           value="<%= fechaSeleccionada != null ? 
                                      fechaSeleccionada : "" %>"
                           onchange="this.form.submit()">
                </form>

                <!-- HORARIOS DISPONIBLES -->
                <div class="card-titulo" style="margin-top: 20px;">
                    Selecciona la hora
                </div>
                <% if (horarios != null && !horarios.isEmpty()) { %>
                    <div class="horarios-grid">
                        <% for (String[] h : horarios) { %>
                            <button type="button"
                                    class="horario-btn"
                                    onclick="seleccionarHorario(
                                        '<%= h[0] %>',
                                        '<%= h[1] %>',
                                        '<%= h[2] %>'
                                    )">
                                <%= h[1].substring(0,5) %> - 
                                <%= h[2].substring(0,5) %>
                            </button>
                        <% } %>
                    </div>
                <% } else if (fechaSeleccionada != null) { %>
                    <div class="sin-horarios">
                        No hay horarios disponibles para esta fecha.
                        <br>Por favor selecciona otra fecha.
                    </div>
                <% } else { %>
                    <div class="sin-horarios">
                        Selecciona una fecha para ver los horarios
                        disponibles.
                    </div>
                <% } %>
            </div>
        </div>

        <!-- COLUMNA DERECHA: datos y resumen -->
        <div>
            <div class="card-sc">
                <div class="card-titulo">Datos del Cliente</div>

                <label class="form-label-sc">Nombre completo</label>
                <input type="text" class="form-control-sc"
                       value="<%= usuarioSesion.getNombre() %> 
                              <%= usuarioSesion.getApellido() %>"
                       readonly>

                <label class="form-label-sc">
                    Correo electrónico
                </label>
                <input type="email" class="form-control-sc"
                       value="<%= usuarioSesion.getEmail() %>"
                       readonly>

                <label class="form-label-sc">Teléfono</label>
                <input type="text" class="form-control-sc"
                       value="<%= usuarioSesion.getTelefono() != null 
                               ? usuarioSesion.getTelefono() : "" %>"
                       readonly>

                <label class="form-label-sc">
                    Tipo de evento
                </label>
                <div class="tipo-evento-grupo">
                    <button type="button" class="tipo-btn seleccionado"
        onclick="seleccionarTipo('BODA', this)">
    Boda
</button>
<button type="button" class="tipo-btn"
        onclick="seleccionarTipo('FIESTA', this)">
    Fiesta
</button>
<button type="button" class="tipo-btn"
        onclick="seleccionarTipo('QUINCE', this)">
    Quince
</button>
<button type="button" class="tipo-btn"
        onclick="seleccionarTipo('OTRO', this)">
    Otro
</button>
                </div>

                <label class="form-label-sc">
                    Describe el motivo
                </label>
                <textarea class="form-control-sc"
                          id="motivoCita"
                          rows="3"
                          placeholder="Ej: Quiero agendar una cita para la elaboración de un vestido de novia"></textarea>

                <!-- RESUMEN -->
                <div class="resumen-cita" id="resumenCita"
                     style="display:none">
                    <div class="resumen-titulo">
                        Fecha y Hora de la Cita
                    </div>
                    <div class="resumen-fila">
                        <span class="resumen-label">Fecha:</span>
                        <span class="resumen-valor" 
                              id="resumenFecha">—</span>
                    </div>
                    <div class="resumen-fila">
                        <span class="resumen-label">Hora:</span>
                        <span class="resumen-valor" 
                              id="resumenHora">—</span>
                    </div>
                </div>

                <!-- FORMULARIO OCULTO PARA ENVIAR -->
                <form method="post"
                      action="<%= request.getContextPath() 
                               %>/cliente/cita"
                      id="formCita">
                    <input type="hidden" name="fecha"
                           id="hiddenFecha"
                           value="<%= fechaSeleccionada != null ? 
                                      fechaSeleccionada : "" %>">
                    <input type="hidden" name="idDisponibilidad"
                           id="hiddenIdDisp" value="">
                    <input type="hidden" name="horaInicio"
                           id="hiddenHoraInicio" value="">
                    <input type="hidden" name="horaFin"
                           id="hiddenHoraFin" value="">
                    <input type="hidden" name="tipoEvento"
                           id="hiddenTipo" value="BODA">
                    <input type="hidden" name="motivoCita"
                           id="hiddenMotivo" value="">

                    <button type="submit" class="btn-agendar"
        id="btnAgendar" disabled
        onclick="return prepararEnvio()">
    <i class="fa-regular fa-calendar-check"></i> Agendar Cita
</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- FOOTER -->
<footer class="footer-sc">
    <div class="footer-brand">
        <div class="nombre">SERGIO CALDERÓN</div>
    </div>
    <div class="footer-copy">
        © 2025 SERGIO CALDERÓN. Todos los derechos reservados.
    </div>
</footer>

<script>
let tipoSeleccionado = 'BODA';
let horarioSeleccionado = null;

// Seleccionar tipo de evento
function seleccionarTipo(tipo, btn) {
    tipoSeleccionado = tipo;
    document.querySelectorAll('.tipo-btn').forEach(b => {
        b.classList.remove('seleccionado');
    });
    btn.classList.add('seleccionado');
    document.getElementById('hiddenTipo').value = tipo;
    console.log('Tipo seleccionado:', tipo);
}

// Seleccionar horario
function seleccionarHorario(idDisp, horaInicio, horaFin) {
    horarioSeleccionado = { idDisp, horaInicio, horaFin };

    document.querySelectorAll('.horario-btn').forEach(b => {
        b.classList.remove('seleccionado');
    });
    event.currentTarget.classList.add('seleccionado');

    document.getElementById('hiddenIdDisp').value = idDisp;
    document.getElementById('hiddenHoraInicio').value = horaInicio;
    document.getElementById('hiddenHoraFin').value = horaFin;

    const fecha = document.getElementById('hiddenFecha').value;
    document.getElementById('resumenFecha').textContent = fecha;
    document.getElementById('resumenHora').textContent =
        horaInicio.substring(0,5) + ' - ' + horaFin.substring(0,5);
    document.getElementById('resumenCita').style.display = 'block';
    document.getElementById('btnAgendar').disabled = false;
}

// Preparar envío
function prepararEnvio() {
    // Asegurar que tipoEvento tenga valor
    const hiddenTipo = document.getElementById('hiddenTipo');
    if (!hiddenTipo.value || hiddenTipo.value === '') {
        hiddenTipo.value = 'BODA';
    }
    document.getElementById('hiddenMotivo').value =
        document.getElementById('motivoCita').value;
    
    console.log('Enviando - tipo:', hiddenTipo.value);
    console.log('Enviando - idDisp:', 
        document.getElementById('hiddenIdDisp').value);
    return true;
}

// Inicializar valor por defecto al cargar
window.onload = function() {
    document.getElementById('hiddenTipo').value = 'BODA';
};
</script>
</body>
</html>
