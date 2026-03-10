<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sergio Calderón - Registro</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400;0,700;1,400&family=Lato:wght@300;400;700&display=swap" rel="stylesheet">
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
        /* NAVBAR */
        .navbar-sc {
            background-color: var(--navbar);
            padding: 10px 30px;
            display: flex;
            align-items: center;
            justify-content: space-between;
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
            padding: 6px 18px;
            border-radius: 2px;
            font-size: 0.82rem;
            text-decoration: none;
            letter-spacing: 1px;
            transition: all 0.3s;
        }
        .btn-volver:hover { background: var(--oscuro); color: #fff; }

        /* CONTENIDO */
        .registro-wrapper {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px 20px;
        }
        .registro-container {
            display: flex;
            width: 100%;
            max-width: 900px;
            min-height: 550px;
            border-radius: 6px;
            overflow: hidden;
            box-shadow: 0 15px 40px rgba(0,0,0,0.15);
        }
        .registro-imagen {
            flex: 0.8;
            background: url('<%= request.getContextPath() %>/img/vestido1.jpeg')
                        center/cover no-repeat;
            position: relative;
        }
        .registro-imagen::after {
            content: '';
            position: absolute; inset: 0;
            background: rgba(30, 15, 5, 0.35);
        }
        .registro-form-lado {
            flex: 1.2;
            background: #fff;
            padding: 45px 45px;
            overflow-y: auto;
        }
        .registro-titulo {
            font-family: 'Playfair Display', serif;
            color: var(--oscuro);
            font-size: 1.8rem;
            margin-bottom: 5px;
        }
        .registro-subtitulo {
            color: var(--beige);
            font-size: 0.75rem;
            margin-bottom: 30px;
            letter-spacing: 3px;
            text-transform: uppercase;
        }
        .fila-dos {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
        }
        .form-grupo { margin-bottom: 18px; }
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
            outline: none;
            transition: border 0.3s;
        }
        .form-control-sc:focus {
            border-color: var(--oscuro);
            background: #fff;
        }
        .btn-registro-sc {
            width: 100%;
            padding: 13px;
            background: var(--oscuro);
            color: #fff;
            border: none;
            border-radius: 2px;
            font-family: 'Lato', sans-serif;
            font-size: 0.85rem;
            letter-spacing: 3px;
            text-transform: uppercase;
            cursor: pointer;
            transition: background 0.3s;
            margin-top: 5px;
        }
        .btn-registro-sc:hover { background: #5C3D2E; }
        .link-login {
            text-align: center;
            margin-top: 18px;
            font-size: 0.83rem;
            color: #999;
        }
        .link-login a {
            color: var(--oscuro);
            text-decoration: none;
            font-weight: 700;
        }
        .link-login a:hover { text-decoration: underline; }
        .alert-error {
            background: #fdecea;
            border-left: 3px solid #c0392b;
            color: #721c24;
            padding: 10px 15px;
            border-radius: 2px;
            font-size: 0.83rem;
            margin-bottom: 20px;
        }
        .alert-exito {
            background: #eafaf1;
            border-left: 3px solid #27ae60;
            color: #1e8449;
            padding: 10px 15px;
            border-radius: 2px;
            font-size: 0.83rem;
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
        .footer-brand .subtitulo {
            font-size: 0.6rem;
            letter-spacing: 2px;
            text-transform: uppercase;
            opacity: 0.7;
        }
        .footer-copy { font-size: 0.72rem; opacity: 0.7; }
        .footer-social { display: flex; gap: 15px; }
        .footer-social a { color: #fff; text-decoration: none; }
    </style>
</head>
<body>

<!-- NAVBAR -->
<nav class="navbar-sc">
    <a href="<%= request.getContextPath() %>/" class="navbar-brand-sc">
        <img src="<%= request.getContextPath() %>/img/logo.png"
             alt="Logo" class="logo-img">
        <div class="brand-text">
            <div class="nombre">SERGIO CALDERÓN</div>
            <div class="subtitulo">Diseñador de Moda</div>
        </div>
    </a>
    <a href="<%= request.getContextPath() %>/auth/login"
       class="btn-volver">← Iniciar Sesión</a>
</nav>

<!-- REGISTRO -->
<div class="registro-wrapper">
    <div class="registro-container">
        <div class="registro-imagen"></div>
        <div class="registro-form-lado">

            <h2 class="registro-titulo">Crear Cuenta</h2>
            <p class="registro-subtitulo">Sergio Calderón Atelier</p>

            <% if (request.getAttribute("error") != null) { %>
                <div class="alert-error">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>
            <% if (request.getAttribute("exito") != null) { %>
                <div class="alert-exito">
                    <%= request.getAttribute("exito") %>
                    <br><a href="<%= request.getContextPath() 
                    %>/auth/login">
                        Ir al login →
                    </a>
                </div>
            <% } %>

            <form action="<%= request.getContextPath() %>/auth/registro"
                  method="post">

                <div class="fila-dos">
                    <div class="form-grupo">
                        <label class="form-label-sc">Nombre</label>
                        <input type="text" name="nombre"
                               class="form-control-sc"
                               placeholder="Tu nombre" required>
                    </div>
                    <div class="form-grupo">
                        <label class="form-label-sc">Apellido</label>
                        <input type="text" name="apellido"
                               class="form-control-sc"
                               placeholder="Tu apellido" required>
                    </div>
                </div>

                <div class="form-grupo">
                    <label class="form-label-sc">
                        Correo electrónico
                    </label>
                    <input type="email" name="email"
                           class="form-control-sc"
                           placeholder="correo@ejemplo.com" required>
                </div>

                <div class="form-grupo">
                    <label class="form-label-sc">Teléfono</label>
                    <input type="tel" name="telefono"
                           class="form-control-sc"
                           placeholder="3001234567">
                </div>

                <div class="fila-dos">
                    <div class="form-grupo">
                        <label class="form-label-sc">Contraseña</label>
                        <input type="password" name="contrasena"
                               class="form-control-sc"
                               placeholder="Mínimo 6 caracteres"
                               required>
                    </div>
                    <div class="form-grupo">
                        <label class="form-label-sc">
                            Confirmar contraseña
                        </label>
                        <input type="password" name="confirmar"
                               class="form-control-sc"
                               placeholder="Repite tu contraseña"
                               required>
                    </div>
                </div>

                <button type="submit" class="btn-registro-sc">
                    Crear Cuenta
                </button>
            </form>

            <div class="link-login">
                ¿Ya tienes cuenta?
                <a href="<%= request.getContextPath() 
                          %>/auth/login">
                    Inicia sesión aquí
                </a>
            </div>
        </div>
    </div>
</div>

<!-- FOOTER -->
<footer class="footer-sc">
    <div class="footer-brand">
        <div class="nombre">SERGIO CALDERÓN</div>
        <div class="subtitulo">Diseñador de Moda</div>
    </div>
    <div class="footer-copy">
        © 2025 SERGIO CALDERÓN. Todos los derechos reservados.
    </div>
    <div class="footer-social">
        <a href="#">Ig</a>
        <a href="#">f</a>
    </div>
</footer>

</body>
</html>