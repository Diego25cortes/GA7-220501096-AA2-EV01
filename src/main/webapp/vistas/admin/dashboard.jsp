<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.sergiocalderon.modelo.Usuario" %>
<%
    Usuario usuarioSesion = (Usuario) session.getAttribute("usuarioSesion");
    if (usuarioSesion == null || 
        !usuarioSesion.getTipoUsuario().equals("ADMIN")) {
        response.sendRedirect(request.getContextPath() + 
            "/vistas/auth/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Administración - Sergio Calderón</title>
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
            letter-spacing: 1px;
        }
        .nombre-usuario {
            font-family: 'Playfair Display', serif;
            color: var(--oscuro);
            font-size: 1rem;
        }
        .btn-menu {
            background: none;
            border: none;
            font-size: 1.5rem;
            cursor: pointer;
            color: var(--oscuro);
        }
        .dropdown-menu-sc {
    position: fixed;
    right: 20px;
    top: 75px;
    background: #fff;
    border: 1px solid #D4B896;
    border-radius: 4px;
    box-shadow: 0 5px 20px rgba(0,0,0,0.15);
    min-width: 200px;
    z-index: 9999;
    display: none;
}
        .dropdown-menu-sc.activo { display: block; }
        .dropdown-menu-sc a {
            display: block;
            padding: 12px 20px;
            color: var(--oscuro);
            text-decoration: none;
            font-size: 0.88rem;
            border-bottom: 1px solid #f0e8df;
            transition: background 0.2s;
        }
        .dropdown-menu-sc a:hover { background: var(--fondo); }
        .dropdown-menu-sc a:last-child { border-bottom: none; color: #c0392b; }

        /* LAYOUT */
        .layout {
            display: flex;
            flex: 1;
        }
        .sidebar {
            width: 240px;
            background: #fff;
            box-shadow: 2px 0 10px rgba(0,0,0,0.05);
            padding: 30px 0;
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
        .sidebar a:hover {
            background: var(--fondo);
            border-left-color: var(--navbar);
        }
        .sidebar a.activo {
            background: var(--fondo);
            border-left-color: var(--oscuro);
            font-weight: 700;
        }
        .main-content {
            flex: 1;
            padding: 35px 30px;
        }
        .page-titulo {
            font-family: 'Playfair Display', serif;
            font-size: 1.8rem;
            color: var(--oscuro);
            margin-bottom: 8px;
        }
        .page-subtitulo {
            color: #999;
            font-size: 0.85rem;
            margin-bottom: 35px;
        }

        /* TARJETAS ESTADÍSTICAS */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            margin-bottom: 35px;
        }
        .stat-card {
            background: #fff;
            border-radius: 6px;
            padding: 22px 20px;
            box-shadow: 0 3px 12px rgba(0,0,0,0.07);
            border-top: 3px solid var(--navbar);
        }
        .stat-numero {
            font-family: 'Playfair Display', serif;
            font-size: 2rem;
            color: var(--oscuro);
            font-weight: 700;
        }
        .stat-label {
            font-size: 0.78rem;
            color: #999;
            letter-spacing: 1px;
            text-transform: uppercase;
            margin-top: 5px;
        }

        /* ACCESOS RÁPIDOS */
        .accesos-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }
        .acceso-card {
            background: #fff;
            border-radius: 6px;
            padding: 25px;
            box-shadow: 0 3px 12px rgba(0,0,0,0.07);
            text-decoration: none;
            transition: transform 0.3s;
            display: flex;
            align-items: center;
            gap: 20px;
        }
        .acceso-card:hover { transform: translateY(-3px); }
        .acceso-icono {
            font-size: 2rem;
            width: 55px; height: 55px;
            background: var(--fondo);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }
        .acceso-titulo {
            font-family: 'Playfair Display', serif;
            font-size: 1rem;
            color: var(--oscuro);
            font-weight: 700;
            margin-bottom: 4px;
        }
        .acceso-desc {
            font-size: 0.8rem;
            color: #999;
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
    <a href="<%= request.getContextPath() %>/vistas/admin/dashboard.jsp"
       class="navbar-brand-sc">
        <img src="<%= request.getContextPath() %>/img/logo.png"
             alt="Logo" class="logo-img">
        <div class="brand-text">
            <div class="nombre">SERGIO CALDERÓN</div>
            <div class="subtitulo">Diseñador de Moda</div>
        </div>
    </a>
    <div class="navbar-derecha">
        <span class="badge-admin">Administración</span>
        <span class="nombre-usuario">
            <%= usuarioSesion.getNombre() %>
        </span>
        <button class="btn-menu" onclick="toggleMenu()">
    <i class="fa-solid fa-bars"></i>
</button>
    </div>
</nav>

<!-- DROPDOWN -->
<div class="dropdown-menu-sc" id="dropdownMenu">
    <a href="<%= request.getContextPath() %>/vistas/admin/gestionCitas.jsp"><i class="fa-regular fa-calendar"></i> Gestión de Citas</a>
    <a href="<%= request.getContextPath() %>/vistas/admin/gestionUsuarios.jsp">
        <i class="fa-solid fa-users"></i> Administrar Usuarios</a>
    <a href="<%= request.getContextPath() %>/vistas/admin/gestionHorarios.jsp">
        <i class="fa-regular fa-clock"></i> Administrar Horas</a>
    <a href="<%= request.getContextPath() %>/vistas/admin/gestionCatalogo.jsp">
        <i class="fa-solid fa-shirt"></i> Administrar Catálogo</a>
    <a href="<%= request.getContextPath() %>/logout">
        <i class="fa-solid fa-right-from-bracket"></i> Cerrar Sesión</a>
</div>

<!-- LAYOUT -->
<div class="layout">

    <!-- SIDEBAR -->
    <div class="sidebar">
        <div class="sidebar-titulo">Panel Admin</div>
        <a href="<%= request.getContextPath() 
                 %>/vistas/admin/dashboard.jsp" class="activo">
            <i class="fa-solid fa-house"></i> Inicio
        </a>
        <a href="<%= request.getContextPath() 
                 %>/vistas/admin/gestionCitas.jsp">
            <i class="fa-regular fa-calendar"></i> Gestión de Citas
        </a>
        <a href="<%= request.getContextPath() 
                 %>/vistas/admin/gestionUsuarios.jsp">
            <i class="fa-solid fa-users"></i> Administrar Usuarios
        </a>
        <a href="<%= request.getContextPath() 
                 %>/vistas/admin/gestionHorarios.jsp">
            <i class="fa-regular fa-clock"></i> Administrar Horas
        </a>
        <a href="<%= request.getContextPath() 
                 %>/vistas/admin/gestionCatalogo.jsp">
            <i class="fa-solid fa-shirt"></i> Administrar Catálogo
        </a>
        <a href="<%= request.getContextPath() %>/logout">
            <i class="fa-solid fa-right-from-bracket"></i> Cerrar Sesión
        </a>
    </div>

    <!-- CONTENIDO PRINCIPAL -->
    <div class="main-content">
        <h1 class="page-titulo">
            Bienvenido, <%= usuarioSesion.getNombre() %>
        </h1>
        <p class="page-subtitulo">
            Panel de administración — Sergio Calderón Atelier
        </p>

        <!-- ESTADÍSTICAS -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-numero">0</div>
                <div class="stat-label">Citas hoy</div>
            </div>
            <div class="stat-card">
                <div class="stat-numero">0</div>
                <div class="stat-label">Citas pendientes</div>
            </div>
            <div class="stat-card">
                <div class="stat-numero">0</div>
                <div class="stat-label">Clientes registrados</div>
            </div>
            <div class="stat-card">
                <div class="stat-numero">17</div>
                <div class="stat-label">Vestidos en catálogo</div>
            </div>
        </div>

        <!-- ACCESOS RÁPIDOS -->
        <div class="accesos-grid">
            <a href="<%= request.getContextPath() 
                     %>/vistas/admin/gestionCitas.jsp"
               class="acceso-card">
                <div class="acceso-icono">
    <i class="fa-regular fa-calendar fa-xl"></i>
</div>
                <div>
                    <div class="acceso-titulo">Gestión de Citas</div>
                    <div class="acceso-desc">
                        Ver, modificar y cancelar citas agendadas
                    </div>
                </div>
            </a>
            <a href="<%= request.getContextPath() 
                     %>/vistas/admin/gestionUsuarios.jsp"
               class="acceso-card">
                <div class="acceso-icono">
    <i class="fa-solid fa-users fa-xl"></i>
</div>
                <div>
                    <div class="acceso-titulo">Administrar Usuarios</div>
                    <div class="acceso-desc">
                        Gestionar clientes y personal del atelier
                    </div>
                </div>
            </a>
            <a href="<%= request.getContextPath() 
                     %>/vistas/admin/gestionHorarios.jsp"
               class="acceso-card">
                <div class="acceso-icono">
    <i class="fa-regular fa-clock fa-xl"></i>
                </div>
                <div>
                    <div class="acceso-titulo">Administrar Horas</div>
                    <div class="acceso-desc">
                        Configurar disponibilidad y horarios
                    </div>
                </div>
            </a>
            <a href="<%= request.getContextPath() 
                     %>/vistas/admin/gestionCatalogo.jsp"
               class="acceso-card">
                <div class="acceso-icono">
    <i class="fa-solid fa-shirt fa-xl"></i>
</div>
                <div>
                    <div class="acceso-titulo">Administrar Catálogo</div>
                    <div class="acceso-desc">
                        Agregar y editar vestidos del catálogo
                    </div>
                </div>
            </a>
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
function toggleMenu() {
    const menu = document.getElementById('dropdownMenu');
    if (menu.style.display === 'block') {
        menu.style.display = 'none';
    } else {
        menu.style.display = 'block';
    }
}

// Cerrar al hacer clic fuera
document.addEventListener('click', function(e) {
    const menu = document.getElementById('dropdownMenu');
    const btn = document.querySelector('.btn-menu');
    if (menu && btn && 
        !menu.contains(e.target) && 
        !btn.contains(e.target)) {
        menu.style.display = 'none';
    }
});
</script>
</body>
</html>
