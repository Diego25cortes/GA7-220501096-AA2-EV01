<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.sergiocalderon.modelo.Usuario" %>
<%@ page import="com.sergiocalderon.modelo.Disponibilidad" %>
<%@ page import="java.util.List" %>
<%
    Usuario usuarioSesion = (Usuario) session.getAttribute("usuario");
    if (usuarioSesion == null ||
        !usuarioSesion.getTipoUsuario().equals("ADMIN")) {
        response.sendRedirect(request.getContextPath() + "/auth/login");
        return;
    }
    List<Disponibilidad> lista = (List<Disponibilidad>)
        request.getAttribute("listaDisponibilidad");
    Disponibilidad editar = (Disponibilidad)
        request.getAttribute("disponibilidad");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Horarios - Sergio Calderón</title>
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
            position: relative;
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
        .badge-admin {
            background: var(--oscuro);
            color: #fff;
            padding: 3px 10px;
            border-radius: 20px;
            font-size: 0.72rem;
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
            min-width: 210px;
            z-index: 9999;
            display: none;
        }
        .dropdown-menu-sc a {
            display: block;
            padding: 13px 20px;
            color: var(--oscuro);
            text-decoration: none;
            font-size: 0.88rem;
            border-bottom: 1px solid #f0e8df;
            transition: background 0.2s;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .dropdown-menu-sc a:hover { background: var(--fondo); }
        .dropdown-menu-sc a:last-child {
            border-bottom: none;
            color: #c0392b;
        }

        /* LAYOUT */
        .layout { display: flex; flex: 1; }
        .sidebar {
            width: 240px;
            background: #fff;
            box-shadow: 2px 0 10px rgba(0,0,0,0.05);
            padding: 25px 0;
            min-height: calc(100vh - 68px);
        }
        .sidebar-titulo {
            font-size: 0.7rem;
            letter-spacing: 2px;
            text-transform: uppercase;
            color: var(--beige);
            padding: 0 20px 10px;
            border-bottom: 1px solid #f0e8df;
            margin-bottom: 10px;
        }
        .sidebar a {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px 20px;
            color: var(--oscuro);
            text-decoration: none;
            font-size: 0.88rem;
            transition: background 0.2s;
            border-left: 3px solid transparent;
        }
        .sidebar a:hover { background: var(--fondo); }
        .sidebar a.activo {
            background: var(--fondo);
            border-left-color: var(--oscuro);
            font-weight: 700;
        }

        /* CONTENIDO */
        .main-content { flex: 1; padding: 30px; }
        .page-titulo {
            font-family: 'Playfair Display', serif;
            font-size: 1.7rem;
            color: var(--oscuro);
            margin-bottom: 5px;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        .page-subtitulo {
            color: #999;
            font-size: 0.85rem;
            margin-bottom: 30px;
        }

        /* GRID DOS COLUMNAS */
        .content-grid {
            display: grid;
            grid-template-columns: 380px 1fr;
            gap: 25px;
        }
        .card-sc {
            background: #fff;
            border-radius: 6px;
            padding: 25px;
            box-shadow: 0 3px 12px rgba(0,0,0,0.07);
            height: fit-content;
        }
        .card-titulo {
            font-family: 'Playfair Display', serif;
            font-size: 1.1rem;
            color: var(--oscuro);
            margin-bottom: 20px;
            padding-bottom: 12px;
            border-bottom: 1px solid #D4B896;
            display: flex;
            align-items: center;
            gap: 10px;
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
            transition: border 0.3s;
        }
        .form-control-sc:focus { border-color: var(--oscuro); }
        .fila-dos {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 12px;
        }
        .btn-guardar {
            width: 100%;
            padding: 12px;
            background: var(--oscuro);
            color: #fff;
            border: none;
            border-radius: 2px;
            font-family: 'Lato', sans-serif;
            font-size: 0.85rem;
            letter-spacing: 2px;
            text-transform: uppercase;
            cursor: pointer;
            transition: background 0.3s;
            margin-top: 5px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }
        .btn-guardar:hover { background: #5C3D2E; }

        /* CARRUSEL POR DÍA - VERSIÓN SIMPLIFICADA */
        .fechas-nav {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 8px;
            background: var(--fondo);
            padding: 10px 15px;
            border-radius: 4px;
        }
        .btn-nav {
            background: #fff;
            border: 1px solid #D4B896;
            color: var(--oscuro);
            width: 35px; height: 35px;
            border-radius: 50%;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.2s;
            font-size: 0.9rem;
        }
        .btn-nav:hover {
            background: var(--oscuro);
            color: #fff;
            border-color: var(--oscuro);
        }
        .btn-nav:disabled {
            opacity: 0.3;
            cursor: not-allowed;
        }
        .fecha-actual {
            font-family: 'Playfair Display', serif;
            font-size: 1.1rem;
            color: var(--oscuro);
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .dia-contador {
            text-align: center;
            font-size: 0.75rem;
            color: #999;
            margin-bottom: 15px;
            letter-spacing: 1px;
        }
        .horarios-dia-grid {
            display: flex;
            flex-direction: column;
            gap: 10px;
            max-height: 400px;
            overflow-y: auto;
            padding-right: 5px;
        }
        .horario-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 12px 15px;
            background: #fdfaf7;
            border: 1px solid #D4B896;
            border-radius: 4px;
            transition: background 0.2s;
            flex-wrap: wrap;
            gap: 10px;
        }
        .horario-item:hover { background: var(--fondo); }
        .horario-tiempo {
            font-weight: 700;
            color: var(--oscuro);
            font-size: 0.95rem;
            display: flex;
            align-items: center;
            gap: 8px;
            min-width: 150px;
        }
        .horario-cupos {
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .horario-acciones {
            display: flex;
            gap: 6px;
        }

        /* TABLA */
        .tabla-sc {
            width: 100%;
            border-collapse: collapse;
        }
        .tabla-sc th {
            background: var(--fondo);
            color: var(--oscuro);
            padding: 12px 15px;
            text-align: left;
            font-size: 0.75rem;
            letter-spacing: 1px;
            text-transform: uppercase;
            border-bottom: 2px solid #D4B896;
        }
        .tabla-sc td {
            padding: 12px 15px;
            border-bottom: 1px solid #f0e8df;
            font-size: 0.88rem;
            color: var(--oscuro);
            vertical-align: middle;
        }
        .tabla-sc tr:hover td { background: #fdfaf7; }
        .badge-disponible {
            background: #eafaf1;
            color: #1e8449;
            padding: 3px 10px;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
        }
        .badge-nodisponible {
            background: #fdecea;
            color: #c0392b;
            padding: 3px 10px;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
        }
        .badge-cupos {
            background: var(--fondo);
            color: var(--oscuro);
            padding: 3px 10px;
            border-radius: 20px;
            font-size: 0.75rem;
        }
        .btn-accion {
            padding: 5px 12px;
            border-radius: 2px;
            border: none;
            cursor: pointer;
            font-size: 0.8rem;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 5px;
            transition: opacity 0.2s;
        }
        .btn-accion:hover { opacity: 0.8; }
        .btn-editar {
            background: var(--fondo);
            color: var(--oscuro);
            border: 1px solid #D4B896;
        }
        .btn-eliminar {
            background: #fdecea;
            color: #c0392b;
            border: 1px solid #f5c6cb;
        }

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
        .sin-datos {
            text-align: center;
            padding: 40px;
            color: #999;
            font-style: italic;
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
    <a href="<%= request.getContextPath() %>/admin/dashboard" class="navbar-brand-sc">
        <img src="<%= request.getContextPath() %>/img/logo.png" alt="Logo" class="logo-img">
        <div class="brand-text">
            <div class="nombre">SERGIO CALDERÓN</div>
            <div class="subtitulo">Diseñador de Moda</div>
        </div>
    </a>
    <div class="navbar-derecha">
        <span class="badge-admin">Administración</span>
        <span class="nombre-usuario"><%= usuarioSesion.getNombre() %></span>
        <button class="btn-menu" onclick="toggleMenu()"><i class="fa-solid fa-bars"></i></button>
    </div>
</nav>

<!-- DROPDOWN -->
<div class="dropdown-menu-sc" id="dropdownMenu">
    <a href="<%= request.getContextPath() %>/admin/dashboard"><i class="fa-solid fa-house"></i> Inicio</a>
    <a href="<%= request.getContextPath() %>/admin/gestionCitas"><i class="fa-regular fa-calendar"></i> Gestión de Citas</a>
    <a href="<%= request.getContextPath() %>/admin/gestionUsuarios"><i class="fa-solid fa-users"></i> Administrar Usuarios</a>
    <a href="<%= request.getContextPath() %>/admin/horarios" class="activo"><i class="fa-regular fa-clock"></i> Administrar Horas</a>
    <a href="<%= request.getContextPath() %>/admin/gestionCatalogo"><i class="fa-solid fa-shirt"></i> Administrar Catálogo</a>
    <a href="<%= request.getContextPath() %>/auth/logout"><i class="fa-solid fa-right-from-bracket"></i> Cerrar Sesión</a>
</div>

<!-- LAYOUT -->
<div class="layout">

    <!-- SIDEBAR -->
    <div class="sidebar">
        <div class="sidebar-titulo">Panel Admin</div>
        <a href="<%= request.getContextPath() %>/admin/dashboard"><i class="fa-solid fa-house"></i> Inicio</a>
        <a href="<%= request.getContextPath() %>/admin/gestionCitas"><i class="fa-regular fa-calendar"></i> Gestión de Citas</a>
        <a href="<%= request.getContextPath() %>/admin/gestionUsuarios"><i class="fa-solid fa-users"></i> Administrar Usuarios</a>
        <a href="<%= request.getContextPath() %>/admin/horarios" class="activo"><i class="fa-regular fa-clock"></i> Administrar Horas</a>
        <a href="<%= request.getContextPath() %>/admin/gestionCatalogo"><i class="fa-solid fa-shirt"></i> Administrar Catálogo</a>
        <a href="<%= request.getContextPath() %>/auth/logout"><i class="fa-solid fa-right-from-bracket"></i> Cerrar Sesión</a>
    </div>

    <!-- CONTENIDO -->
    <div class="main-content">
        <h1 class="page-titulo">
            <i class="fa-regular fa-clock"></i> Gestión de Horarios
        </h1>
        <p class="page-subtitulo">Configura los horarios disponibles para citas</p>

        <% if (request.getAttribute("error") != null) { %>
            <div class="alert-error"><i class="fa-solid fa-circle-exclamation"></i> <%= request.getAttribute("error") %></div>
        <% } %>
        <% if (request.getAttribute("exito") != null) { %>
            <div class="alert-exito"><i class="fa-solid fa-circle-check"></i> <%= request.getAttribute("exito") %></div>
        <% } %>

        <div class="content-grid">

            <!-- FORMULARIO -->
            <div>
                <div class="card-sc">
                    <div class="card-titulo">
                        <i class="fa-regular fa-calendar-plus"></i>
                        <%= editar != null ? "Editar Horario" : "Crear Horarios" %>
                    </div>

                    <% if (editar != null) { %>
                    <!-- FORMULARIO EDITAR -->
                    <form method="post" action="<%= request.getContextPath() %>/admin/horarios">
                        <input type="hidden" name="accion" value="actualizar">
                        <input type="hidden" name="id" value="<%= editar.getIdDisponibilidad() %>">

                        <label class="form-label-sc">Fecha</label>
                        <input type="date" name="fecha" class="form-control-sc" value="<%= editar.getFecha() %>" required>

                        <div class="fila-dos">
                            <div>
                                <label class="form-label-sc">Hora inicio</label>
                                <input type="time" name="horaInicio" class="form-control-sc" value="<%= editar.getHoraInicio() %>" required>
                            </div>
                            <div>
                                <label class="form-label-sc">Hora fin</label>
                                <input type="time" name="horaFin" class="form-control-sc" value="<%= editar.getHoraFin() %>" required>
                            </div>
                        </div>

                        <label class="form-label-sc">Cupos totales</label>
                        <input type="number" name="cupos" class="form-control-sc" value="<%= editar.getCuposTotales() %>" min="1" required>

                        <label class="form-label-sc">
                            <input type="checkbox" name="disponible" <%= editar.isDisponible() ? "checked" : "" %>> &nbsp;Disponible
                        </label>
                        <br><br>

                        <button type="submit" class="btn-guardar"><i class="fa-solid fa-floppy-disk"></i> Guardar Cambios</button>
                    </form>
                    <% } else { %>
                    <!-- FORMULARIO CREAR -->
                    <form method="post" action="<%= request.getContextPath() %>/admin/horarios">
                        <input type="hidden" name="accion" value="crear">

                        <label class="form-label-sc">Fecha</label>
                        <input type="date" name="fecha" class="form-control-sc" min="<%= java.time.LocalDate.now() %>" required>

                        <div class="fila-dos">
                            <div>
                                <label class="form-label-sc">Hora desde</label>
                                <input type="time" name="horaDesde" class="form-control-sc" value="07:00" required>
                            </div>
                            <div>
                                <label class="form-label-sc">Hora hasta</label>
                                <input type="time" name="horaHasta" class="form-control-sc" value="17:00" required>
                            </div>
                        </div>

                        <label class="form-label-sc">Intervalo (minutos)</label>
                        <select name="intervalo" class="form-control-sc">
                            <option value="30">30 minutos</option>
                            <option value="60" selected>60 minutos</option>
                            <option value="90">90 minutos</option>
                            <option value="120">120 minutos</option>
                        </select>

                        <label class="form-label-sc">Cupos por horario</label>
                        <input type="number" name="cupos" class="form-control-sc" value="1" min="1" max="10">

                        <button type="submit" class="btn-guardar"><i class="fa-regular fa-calendar-plus"></i> Generar Horarios</button>
                    </form>
                    <% } %>
                </div>
            </div>

            <!-- HORARIOS POR DÍA - VERSIÓN SIMPLIFICADA -->
            <div class="card-sc">
                <div class="card-titulo"><i class="fa-solid fa-list"></i> Horarios Registrados</div>

                <% if (lista != null && !lista.isEmpty()) { 
                    // Agrupar por fecha
                    java.util.Map<String, java.util.List<Disponibilidad>> porFecha = new java.util.LinkedHashMap<>();
                    for (Disponibilidad d : lista) {
                        String fechaKey = d.getFecha().toString();
                        if (!porFecha.containsKey(fechaKey)) {
                            porFecha.put(fechaKey, new java.util.ArrayList<>());
                        }
                        porFecha.get(fechaKey).add(d);
                    }
                    java.util.List<String> fechas = new java.util.ArrayList<>(porFecha.keySet());
                %>

                <!-- NAVEGACIÓN FECHAS -->
                <div class="fechas-nav">
                    <button class="btn-nav" onclick="anteriorDia()" id="btnAnterior"><i class="fa-solid fa-chevron-left"></i></button>
                    <div class="fecha-actual" id="fechaActual">
                        <i class="fa-regular fa-calendar"></i>
                        <span id="textoFecha"></span>
                    </div>
                    <button class="btn-nav" onclick="siguienteDia()" id="btnSiguiente"><i class="fa-solid fa-chevron-right"></i></button>
                </div>

                <div class="dia-contador" id="diaContador"></div>

                <!-- SLIDES POR DÍA -->
                <div class="slides-container">
                    <% int diaIndex = 0; for (String fecha : fechas) { %>
                    <div class="slide-dia" id="dia_<%= diaIndex %>" style="display: <%= diaIndex == 0 ? "block" : "none" %>;">
                        <div class="horarios-dia-grid">
                            <% for (Disponibilidad d : porFecha.get(fecha)) { %>
                            <div class="horario-item">
                                <div class="horario-tiempo">
                                    <i class="fa-regular fa-clock"></i>
                                    <%= d.getHoraInicio().toString().substring(0,5) %> — <%= d.getHoraFin().toString().substring(0,5) %>
                                </div>
                                <div class="horario-cupos">
                                    <span class="badge-cupos"><i class="fa-solid fa-user"></i> <%= d.getCuposOcupados() %>/<%= d.getCuposTotales() %></span>
                                    <% if (d.isDisponible()) { %>
                                        <span class="badge-disponible">Disponible</span>
                                    <% } else { %>
                                        <span class="badge-nodisponible">No disponible</span>
                                    <% } %>
                                </div>
                                <div class="horario-acciones">
                                    <a href="<%= request.getContextPath() %>/admin/horarios?accion=editar&id=<%= d.getIdDisponibilidad() %>" class="btn-accion btn-editar"><i class="fa-solid fa-pen"></i></a>
                                    <a href="<%= request.getContextPath() %>/admin/horarios?accion=eliminar&id=<%= d.getIdDisponibilidad() %>" class="btn-accion btn-eliminar" onclick="return confirm('¿Eliminar este horario?')"><i class="fa-solid fa-trash"></i></a>
                                </div>
                            </div>
                            <% } %>
                        </div>
                    </div>
                    <% diaIndex++; } %>
                </div>

                <!-- SCRIPT SIMPLIFICADO -->
                <script>
                   <%
    // Generar array de fechas como string JSON
    String fechasArrayStr = "[";
    if (fechas != null && !fechas.isEmpty()) {
        for (int i = 0; i < fechas.size(); i++) {
            if (i > 0) fechasArrayStr += ",";
            fechasArrayStr += "'" + fechas.get(i) + "'";
        }
    }
    fechasArrayStr += "]";
%>
const fechas = <%= fechasArrayStr %>;
let diaActual = 0;

                    function mostrarDia(index) {
                        // Ocultar todos
                        document.querySelectorAll('.slide-dia').forEach(s => s.style.display = 'none');
                        
                        // Mostrar actual
                        const slide = document.getElementById('dia_' + index);
                        if (slide) slide.style.display = 'block';

                        // Actualizar texto fecha
                        if (fechas[index]) {
                            const fecha = new Date(fechas[index] + 'T00:00:00');
                            const opciones = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
                            document.getElementById('textoFecha').textContent = fecha.toLocaleDateString('es-CO', opciones);
                        }

                        // Contador
                        document.getElementById('diaContador').textContent = 'Día ' + (index + 1) + ' de ' + fechas.length;

                        // Botones
                        document.getElementById('btnAnterior').disabled = index === 0;
                        document.getElementById('btnSiguiente').disabled = index === fechas.length - 1;
                    }

                    function anteriorDia() { if (diaActual > 0) { diaActual--; mostrarDia(diaActual); } }
                    function siguienteDia() { if (diaActual < fechas.length - 1) { diaActual++; mostrarDia(diaActual); } }

                    function toggleMenu() {
                        const menu = document.getElementById('dropdownMenu');
                        menu.style.display = menu.style.display === 'block' ? 'none' : 'block';
                    }

                    document.addEventListener('click', function(e) {
                        const menu = document.getElementById('dropdownMenu');
                        const btn = document.querySelector('.btn-menu');
                        if (menu && btn && !menu.contains(e.target) && !btn.contains(e.target)) {
                            menu.style.display = 'none';
                        }
                    });

                    if (fechas.length > 0) mostrarDia(0);
                </script>

                <% } else { %>
                    <div class="sin-datos">
                        <i class="fa-regular fa-calendar-xmark fa-2x"></i>
                        <br><br>No hay horarios registrados aún.
                    </div>
                <% } %>
            </div>
        </div>
    </div>
</div>

<!-- FOOTER -->
<footer class="footer-sc">
    <div class="footer-brand"><div class="nombre">SERGIO CALDERÓN</div></div>
    <div class="footer-copy">© 2025 SERGIO CALDERÓN. Todos los derechos reservados.</div>
</footer>

</body>
</html>