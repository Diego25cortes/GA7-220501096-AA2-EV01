<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.sergiocalderon.modelo.Usuario" %>
<%@ page import="com.sergiocalderon.modelo.Cita" %>
<%@ page import="java.util.List" %>
<%
    Usuario usuarioSesion = (Usuario) session.getAttribute(
        "usuarioSesion");
    if (usuarioSesion == null) {
        response.sendRedirect(request.getContextPath() +
            "/vistas/auth/login.jsp");
        return;
    }
    List<Cita> misCitas = (List<Cita>)
        request.getAttribute("misCitas");
    Cita citaEditar = (Cita)
        request.getAttribute("citaEditar");
    List<String[]> horariosEditar = (List<String[]>)
        request.getAttribute("horariosEditar");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mis Citas - Sergio Calderón</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400;0,700&family=Lato:wght@300;400;700&display=swap" rel="stylesheet">
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
        .navbar-derecha {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        .nombre-usuario {
            font-family: 'Playfair Display', serif;
            color: var(--oscuro);
            font-size: 1rem;
        }
        .btn-menu {
            background: none;
            border: none;
            font-size: 1.4rem;
            cursor: pointer;
            color: var(--oscuro);
        }
        .dropdown-menu-sc {
            position: fixed;
            right: 20px;
            top: 70px;
            background: #fff;
            border: 1px solid #D4B896;
            border-radius: 4px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.15);
            min-width: 200px;
            z-index: 9999;
            display: none;
        }
        .dropdown-menu-sc a {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 13px 20px;
            color: var(--oscuro);
            text-decoration: none;
            font-size: 0.88rem;
            border-bottom: 1px solid #f0e8df;
            transition: background 0.2s;
        }
        .dropdown-menu-sc a:hover { background: var(--fondo); }
        .dropdown-menu-sc a:last-child {
            border-bottom: none;
            color: #c0392b;
        }

        /* CONTENIDO */
        .contenido {
            flex: 1;
            max-width: 1100px;
            margin: 35px auto;
            padding: 0 20px;
            width: 100%;
        }
        .page-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 30px;
        }
        .page-titulo {
            font-family: 'Playfair Display', serif;
            font-size: 1.8rem;
            color: var(--oscuro);
            display: flex;
            align-items: center;
            gap: 12px;
        }
        .btn-nueva-cita {
            background: var(--oscuro);
            color: #fff;
            padding: 10px 22px;
            border-radius: 2px;
            text-decoration: none;
            font-size: 0.85rem;
            letter-spacing: 1px;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: background 0.3s;
        }
        .btn-nueva-cita:hover { background: #5C3D2E; color: #fff; }

        /* FILTROS */
        .filtros {
            display: flex;
            gap: 10px;
            margin-bottom: 25px;
            flex-wrap: wrap;
        }
        .filtro-btn {
            padding: 7px 18px;
            border: 1px solid #D4B896;
            border-radius: 20px;
            background: #fff;
            color: var(--oscuro);
            cursor: pointer;
            font-size: 0.82rem;
            transition: all 0.2s;
        }
        .filtro-btn.activo {
            background: var(--oscuro);
            color: #fff;
            border-color: var(--oscuro);
        }

        /* GRID CITAS */
        .citas-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
        }
        .cita-card {
            background: #fff;
            border-radius: 6px;
            padding: 22px;
            box-shadow: 0 3px 12px rgba(0,0,0,0.07);
            border-top: 3px solid var(--navbar);
            transition: transform 0.2s;
        }
        .cita-card:hover { transform: translateY(-3px); }
        .cita-card.cancelada {
            border-top-color: #c0392b;
            opacity: 0.7;
        }
        .cita-card.confirmada {
            border-top-color: #27ae60;
        }
        .cita-fecha {
            font-family: 'Playfair Display', serif;
            font-size: 1.1rem;
            color: var(--oscuro);
            font-weight: 700;
            margin-bottom: 5px;
        }
        .cita-hora {
            font-size: 0.85rem;
            color: var(--beige);
            margin-bottom: 12px;
            display: flex;
            align-items: center;
            gap: 6px;
        }
        .cita-info {
            font-size: 0.85rem;
            color: #666;
            margin-bottom: 8px;
            display: flex;
            align-items: flex-start;
            gap: 8px;
        }
        .cita-info i { margin-top: 2px; color: var(--beige); }
        .estado-badge {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
            margin-bottom: 15px;
        }
        .estado-PENDIENTE {
            background: #fff8e1;
            color: #f39c12;
        }
        .estado-CONFIRMADA {
            background: #eafaf1;
            color: #27ae60;
        }
        .estado-CANCELADA {
            background: #fdecea;
            color: #c0392b;
        }
        .estado-COMPLETADA {
            background: #e8f4fd;
            color: #2980b9;
        }
        .cita-acciones {
            display: flex;
            gap: 8px;
            margin-top: 15px;
            padding-top: 15px;
            border-top: 1px solid #f0e8df;
        }
        .btn-accion {
            flex: 1;
            padding: 7px;
            border-radius: 2px;
            border: none;
            cursor: pointer;
            font-size: 0.8rem;
            text-decoration: none;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 5px;
            transition: opacity 0.2s;
        }
        .btn-accion:hover { opacity: 0.8; }
        .btn-editar {
            background: var(--fondo);
            color: var(--oscuro);
            border: 1px solid #D4B896;
        }
        .btn-cancelar {
            background: #fdecea;
            color: #c0392b;
            border: 1px solid #f5c6cb;
        }
        .sin-citas {
            text-align: center;
            padding: 60px 20px;
            color: #999;
            grid-column: 1/-1;
        }
        .sin-citas i { font-size: 3rem; margin-bottom: 15px; }

        /* MODAL EDITAR */
        .modal-overlay {
            position: fixed;
            inset: 0;
            background: rgba(0,0,0,0.5);
            z-index: 1000;
            display: none;
            align-items: center;
            justify-content: center;
        }
        .modal-overlay.activo { display: flex; }
        .modal-sc {
            background: #fff;
            border-radius: 6px;
            padding: 35px;
            width: 100%;
            max-width: 550px;
            max-height: 90vh;
            overflow-y: auto;
            box-shadow: 0 20px 60px rgba(0,0,0,0.2);
        }
        .modal-titulo {
            font-family: 'Playfair Display', serif;
            font-size: 1.4rem;
            color: var(--oscuro);
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .btn-cerrar-modal {
            background: none;
            border: none;
            font-size: 1.3rem;
            cursor: pointer;
            color: #999;
        }
        .form-label-sc {
            display: block;
            font-size: 0.72rem;
            color: var(--oscuro);
            letter-spacing: 1.5px;
            text-transform: uppercase;
            margin-bottom: 6px;
            font-weight: 700;
        }
        .form-control-sc {
            width: 100%;
            padding: 10px 14px;
            border: 1px solid #D4B896;
            border-radius: 2px;
            font-family: 'Lato', sans-serif;
            font-size: 0.9rem;
            color: var(--oscuro);
            background: #fdfaf7;
            margin-bottom: 16px;
            outline: none;
        }
        .form-control-sc:focus { border-color: var(--oscuro); }
        .fila-dos {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 12px;
        }
        .horarios-modal {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 8px;
            margin-bottom: 16px;
        }
        .horario-opt {
            padding: 8px;
            border: 1px solid #D4B896;
            border-radius: 2px;
            background: #fdfaf7;
            color: var(--oscuro);
            cursor: pointer;
            font-size: 0.8rem;
            text-align: center;
            transition: all 0.2s;
        }
        .horario-opt.seleccionado {
            background: var(--oscuro);
            color: #fff;
        }
        .tipo-grupo {
            display: flex;
            gap: 8px;
            margin-bottom: 16px;
            flex-wrap: wrap;
        }
        .tipo-opt {
            padding: 7px 14px;
            border: 1px solid #D4B896;
            border-radius: 2px;
            background: #fdfaf7;
            color: var(--oscuro);
            cursor: pointer;
            font-size: 0.82rem;
            transition: all 0.2s;
        }
        .tipo-opt.seleccionado {
            background: var(--oscuro);
            color: #fff;
        }
        .btn-guardar-modal {
            width: 100%;
            padding: 13px;
            background: var(--oscuro);
            color: #fff;
            border: none;
            border-radius: 2px;
            font-size: 0.88rem;
            letter-spacing: 2px;
            text-transform: uppercase;
            cursor: pointer;
            transition: background 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }
        .btn-guardar-modal:hover { background: #5C3D2E; }

        /* ALERTAS */
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
            margin-top: 20px;
        }
        .footer-brand .nombre {
            font-family: 'Playfair Display', serif;
            font-size: 0.9rem;
        }
        .footer-copy { font-size: 0.72rem; opacity: 0.7; }

        @media (max-width: 768px) {
            .citas-grid { grid-template-columns: 1fr; }
        }
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
    <div class="navbar-derecha">
        <span class="nombre-usuario">
            <%= usuarioSesion.getNombre() %>
            <%= usuarioSesion.getApellido() %>
        </span>
        <button class="btn-menu" onclick="toggleMenu()">
            <i class="fa-solid fa-bars"></i>
        </button>
    </div>
</nav>

<!-- DROPDOWN -->
<div class="dropdown-menu-sc" id="dropdownMenu">
    <a href="<%= request.getContextPath() 
             %>/vistas/cliente/dashboard.jsp">
        <i class="fa-regular fa-user"></i> Perfil
    </a>
    <a href="<%= request.getContextPath() 
             %>/cliente/miscitas">
        <i class="fa-regular fa-calendar"></i> Mis Citas
    </a>
    <a href="<%= request.getContextPath() 
             %>/cliente/cita">
        <i class="fa-solid fa-calendar-check"></i> Agendar Cita
    </a>
    <a href="<%= request.getContextPath() %>/logout">
        <i class="fa-solid fa-right-from-bracket"></i>
        Cerrar Sesión
    </a>
</div>

<!-- CONTENIDO -->
<div class="contenido">
    <div class="page-header">
        <h1 class="page-titulo">
            <i class="fa-regular fa-calendar"></i> Mis Citas
        </h1>
        <a href="<%= request.getContextPath() %>/cliente/cita"
           class="btn-nueva-cita">
            <i class="fa-regular fa-calendar-plus"></i>
            Nueva Cita
        </a>
    </div>

    <% if (request.getAttribute("error") != null) { %>
        <div class="alert-error">
            <i class="fa-solid fa-circle-exclamation"></i>
            <%= request.getAttribute("error") %>
        </div>
    <% } %>
    <% if (request.getAttribute("exito") != null) { %>
        <div class="alert-exito">
            <i class="fa-solid fa-circle-check"></i>
            <%= request.getAttribute("exito") %>
        </div>
    <% } %>

    <!-- FILTROS -->
    <div class="filtros">
        <button class="filtro-btn activo"
                onclick="filtrar('todas', this)">
            Todas
        </button>
        <button class="filtro-btn"
                onclick="filtrar('PENDIENTE', this)">
            Pendientes
        </button>
        <button class="filtro-btn"
                onclick="filtrar('CONFIRMADA', this)">
            Confirmadas
        </button>
        <button class="filtro-btn"
                onclick="filtrar('COMPLETADA', this)">
            Completadas
        </button>
        <button class="filtro-btn"
                onclick="filtrar('CANCELADA', this)">
            Canceladas
        </button>
    </div>

    <!-- GRID DE CITAS -->
    <div class="citas-grid" id="citasGrid">
        <% if (misCitas != null && !misCitas.isEmpty()) { %>
            <% for (Cita c : misCitas) { %>
            <div class="cita-card <%= c.getEstado()
                                       .toLowerCase() %>"
                 data-estado="<%= c.getEstado() %>">

                <div class="cita-fecha">
                    <i class="fa-regular fa-calendar"></i>
                    <%= c.getFechaCita() %>
                </div>
                <div class="cita-hora">
                    <i class="fa-regular fa-clock"></i>
                    <%= c.getHoraInicio().toString()
                         .substring(0,5) %> —
                    <%= c.getHoraFin().toString()
                         .substring(0,5) %>
                </div>

                <span class="estado-badge estado-<%= c.getEstado() %>">
                    <%= c.getEstado() %>
                </span>

                <div class="cita-info">
                    <i class="fa-solid fa-tag"></i>
                    <span><%= c.getTipoEvento() %></span>
                </div>
                <% if (c.getMotivoCita() != null && 
                       !c.getMotivoCita().isEmpty()) { %>
                <div class="cita-info">
                    <i class="fa-regular fa-comment"></i>
                    <span><%= c.getMotivoCita().length() > 60 ?
                        c.getMotivoCita().substring(0,60) + "..." :
                        c.getMotivoCita() %></span>
                </div>
                <% } %>

                <!-- Acciones solo si está PENDIENTE -->
                <% if ("PENDIENTE".equals(c.getEstado())) { %>
                <div class="cita-acciones">
                    <button class="btn-accion btn-editar"
                            onclick="abrirModal(
                                '<%= c.getIdCita() %>',
                                '<%= c.getFechaCita() %>',
                                '<%= c.getHoraInicio()
                                      .toString()
                                      .substring(0,5) %>',
                                '<%= c.getTipoEvento() %>',
                                '<%= c.getMotivoCita() != null ?
                                     c.getMotivoCita()
                                      .replace("'", "\\'") : "" %>'
                            )">
                        <i class="fa-solid fa-pen"></i> Modificar
                    </button>
                    <a href="<%= request.getContextPath() 
                             %>/cliente/miscitas?accion=cancelar&id=<%= c.getIdCita() %>"
                       class="btn-accion btn-cancelar"
                       onclick="return confirm(
                           '¿Seguro que deseas cancelar esta cita?')">
                        <i class="fa-solid fa-xmark"></i> Cancelar
                    </a>
                </div>
                <% } %>
            </div>
            <% } %>
        <% } else { %>
            <div class="sin-citas">
                <i class="fa-regular fa-calendar-xmark"></i>
                <p>No tienes citas registradas aún.</p>
                <a href="<%= request.getContextPath() 
                         %>/cliente/cita"
                   class="btn-nueva-cita"
                   style="display:inline-flex; margin-top:15px">
                    <i class="fa-regular fa-calendar-plus"></i>
                    Agendar mi primera cita
                </a>
            </div>
        <% } %>
    </div>
</div>

<!-- MODAL EDITAR CITA -->
<div class="modal-overlay" id="modalEditar">
    <div class="modal-sc">
        <div class="modal-titulo">
            <span>
                <i class="fa-solid fa-pen"></i> Modificar Cita
            </span>
            <button class="btn-cerrar-modal"
                    onclick="cerrarModal()">
                <i class="fa-solid fa-xmark"></i>
            </button>
        </div>

        <form method="post"
              action="<%= request.getContextPath() 
                       %>/cliente/miscitas">
            <input type="hidden" name="accion" value="modificar">
            <input type="hidden" name="idCita" id="modalIdCita">
            <input type="hidden" name="idDisponibilidad"
                   id="modalIdDisp">
            <input type="hidden" name="horaInicio"
                   id="modalHoraInicio">
            <input type="hidden" name="horaFin"
                   id="modalHoraFin">
            <input type="hidden" name="tipoEvento"
                   id="modalTipoEvento" value="BODA">

            <label class="form-label-sc">Nueva fecha</label>
            <input type="date" name="fecha" id="modalFecha"
                   class="form-control-sc"
                   min="<%= java.time.LocalDate.now()
                            .plusDays(1) %>"
                   onchange="cargarHorariosModal(this.value)">

            <label class="form-label-sc">
                Horarios disponibles
            </label>
            <div class="horarios-modal" id="horariosModal">
                <div style="color:#999; font-size:0.82rem;
                            grid-column:1/-1; text-align:center;
                            padding:10px;">
                    Selecciona una fecha primero
                </div>
            </div>

            <label class="form-label-sc">Tipo de evento</label>
            <div class="tipo-grupo">
                <button type="button" class="tipo-opt seleccionado"
                        onclick="seleccionarTipoModal('BODA',this)">
                    Boda
                </button>
                <button type="button" class="tipo-opt"
                        onclick="seleccionarTipoModal('FIESTA',this)">
                    Fiesta
                </button>
                <button type="button" class="tipo-opt"
                        onclick="seleccionarTipoModal('QUINCE',this)">
                    Quince
                </button>
                <button type="button" class="tipo-opt"
                        onclick="seleccionarTipoModal('OTRO',this)">
                    Otro
                </button>
            </div>

            <label class="form-label-sc">Motivo</label>
            <textarea name="motivoCita" id="modalMotivo"
                      class="form-control-sc" rows="3"></textarea>

            <button type="submit" class="btn-guardar-modal">
                <i class="fa-solid fa-floppy-disk"></i>
                Guardar Cambios
            </button>
        </form>
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
// DROPDOWN MENÚ
function toggleMenu() {
    const menu = document.getElementById('dropdownMenu');
    menu.style.display =
        menu.style.display === 'block' ? 'none' : 'block';
}
document.addEventListener('click', function(e) {
    const menu = document.getElementById('dropdownMenu');
    const btn = document.querySelector('.btn-menu');
    if (menu && btn &&
        !menu.contains(e.target) &&
        !btn.contains(e.target)) {
        menu.style.display = 'none';
    }
});

// FILTRAR CITAS
function filtrar(estado, btn) {
    document.querySelectorAll('.filtro-btn').forEach(b =>
        b.classList.remove('activo'));
    btn.classList.add('activo');

    document.querySelectorAll('.cita-card').forEach(card => {
        if (estado === 'todas' ||
            card.dataset.estado === estado) {
            card.style.display = 'block';
        } else {
            card.style.display = 'none';
        }
    });
}

// MODAL
function abrirModal(idCita, fecha, hora, tipo, motivo) {
    document.getElementById('modalIdCita').value = idCita;
    document.getElementById('modalFecha').value = fecha;
    document.getElementById('modalMotivo').value = motivo;
    document.getElementById('modalTipoEvento').value = tipo;

    // Marcar tipo activo
    document.querySelectorAll('.tipo-opt').forEach(b => {
        b.classList.remove('seleccionado');
        if (b.textContent.trim().toUpperCase() === tipo ||
            b.onclick.toString().includes("'" + tipo + "'")) {
            b.classList.add('seleccionado');
        }
    });

    document.getElementById('modalEditar')
            .classList.add('activo');
    cargarHorariosModal(fecha);
}

function cerrarModal() {
    document.getElementById('modalEditar')
            .classList.remove('activo');
}

function seleccionarTipoModal(tipo, btn) {
    document.querySelectorAll('.tipo-opt').forEach(b =>
        b.classList.remove('seleccionado'));
    btn.classList.add('seleccionado');
    document.getElementById('modalTipoEvento').value = tipo;
}

function cargarHorariosModal(fecha) {
    if (!fecha) return;
    const contenedor = document.getElementById('horariosModal');
    contenedor.innerHTML = '<div style="color:#999;font-size:0.82rem;grid-column:1/-1;text-align:center;padding:10px;">Cargando...</div>';

    fetch('<%= request.getContextPath() %>/cliente/cita?fecha=' + fecha)
        .then(res => res.text())
        .then(html => {
            // Extraer horarios del HTML retornado
            const parser = new DOMParser();
            const doc = parser.parseFromString(html, 'text/html');
            const botones = doc.querySelectorAll('.horario-btn');

            if (botones.length === 0) {
                contenedor.innerHTML = '<div style="color:#999;font-size:0.82rem;grid-column:1/-1;text-align:center;padding:10px;">No hay horarios disponibles</div>';
                return;
            }

            contenedor.innerHTML = '';
            botones.forEach(btn => {
                const onclick = btn.getAttribute('onclick');
                const match = onclick.match(
                    /seleccionarHorario\('(.+?)','(.+?)','(.+?)'\)/);
                if (match) {
                    const [_, idDisp, hIni, hFin] = match;
                    const opt = document.createElement('button');
                    opt.type = 'button';
                    opt.className = 'horario-opt';
                    opt.textContent =
                        hIni.substring(0,5) + ' - ' +
                        hFin.substring(0,5);
                    opt.onclick = function() {
                        document.querySelectorAll('.horario-opt')
                            .forEach(b =>
                                b.classList.remove('seleccionado'));
                        this.classList.add('seleccionado');
                        document.getElementById(
                            'modalIdDisp').value = idDisp;
                        document.getElementById(
                            'modalHoraInicio').value = hIni;
                        document.getElementById(
                            'modalHoraFin').value = hFin;
                    };
                    contenedor.appendChild(opt);
                }
            });
        })
        .catch(() => {
            contenedor.innerHTML = '<div style="color:#c0392b;font-size:0.82rem;grid-column:1/-1;text-align:center;padding:10px;">Error cargando horarios</div>';
        });
}

// Cerrar modal al hacer clic fuera
document.getElementById('modalEditar')
    .addEventListener('click', function(e) {
        if (e.target === this) cerrarModal();
    });
</script>
</body>
</html>