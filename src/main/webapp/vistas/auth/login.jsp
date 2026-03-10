<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="es">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sergio Calderón - Iniciar Sesión</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link
            href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400;0,700;1,400&family=Lato:wght@300;400;700&display=swap"
            rel="stylesheet">
        <style>
            :root {
                --color-primario: #D0B89E;
                --color-beige: #4b3b29;
                --color-fondo: #EBDFD4;
                --color-oscuro: #3E2417;
                --color-texto: #3E2723;
                --color-navbar: #D0B89E;
                --color-footer: #9E8C78;
            }

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Lato', sans-serif;
                background-color: var(--color-fondo);
                min-height: 100vh;
                display: flex;
                flex-direction: column;
            }

            /* NAVBAR */
            .navbar-sc {
                background-color: #D0B89E;
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
                width: 48px;
                height: 48px;
                border-radius: 50%;
                object-fit: cover;
                border: 2px solid var(--color-beige);
                background: white;
                padding: 2px;
            }

            .brand-text {
                color: #fff;
                line-height: 1.2;
            }

            .brand-text .nombre {
                font-family: 'Playfair Display', serif;
                font-size: 1rem;
                font-weight: 700;
                letter-spacing: 1px;
                color: #3E2417;
            }

            .brand-text .subtitulo {
                font-size: 0.62rem;
                letter-spacing: 2px;
                color: #3E2417;
                text-transform: uppercase;
            }

            .navbar-btns {
                display: flex;
                gap: 10px;
            }

            .btn-registro {
                background: transparent;
                border: 1px solid #3E2417;
                color: #3E2417;
                padding: 6px 20px;
                border-radius: 2px;
                font-size: 0.82rem;
                cursor: pointer;
                text-decoration: none;
                letter-spacing: 1px;
                transition: all 0.3s;
            }

            .btn-registro:hover {
                background: #3E2417;
                color: #fff;
            }

            .btn-ingresar {
                background: #3E2417;
                border: 1px solid #3E2417;
                color: #fff;
                padding: 6px 20px;
                border-radius: 2px;
                font-size: 0.82rem;
                cursor: pointer;
                text-decoration: none;
                letter-spacing: 1px;
            }

            /* LOGIN CONTENIDO */
            .login-wrapper {
                flex: 1;
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 50px 20px;
            }

            .login-container {
                display: flex;
                width: 100%;
                max-width: 850px;
                min-height: 500px;
                border-radius: 6px;
                overflow: hidden;
                box-shadow: 0 20px 50px rgba(0, 0, 0, 0.2);
            }

            .login-imagen {
                flex: 1.1;
                background: url('<%= request.getContextPath() %>/img/vestido8.jpeg') center/cover no-repeat;
                position: relative;
                min-height: 300px;
            }

            .login-imagen::after {
                content: '';
                position: absolute;
                inset: 0;
                background: rgba(30, 15, 5, 0.35);
            }

            .login-form-lado {
                flex: 1;
                background: #fff;
                padding: 55px 45px;
                display: flex;
                flex-direction: column;
                justify-content: center;
            }

            .login-titulo {
                font-family: 'Playfair Display', serif;
                color: var(--color-primario);
                font-size: 1.9rem;
                margin-bottom: 5px;
                font-weight: 700;
            }

            .login-subtitulo {
                color: var(--color-beige);
                font-size: 0.75rem;
                margin-bottom: 35px;
                letter-spacing: 3px;
                text-transform: uppercase;
            }

            .form-label-sc {
                display: block;
                font-size: 0.75rem;
                color: var(--color-texto);
                letter-spacing: 1.5px;
                text-transform: uppercase;
                margin-bottom: 6px;
                font-weight: 700;
            }

            .form-control-sc {
                width: 100%;
                padding: 11px 15px;
                border: 1px solid #D4B896;
                border-radius: 2px;
                font-family: 'Lato', sans-serif;
                font-size: 0.9rem;
                color: var(--color-texto);
                background: #fdfaf7;
                margin-bottom: 22px;
                outline: none;
                transition: border 0.3s;
            }

            .form-control-sc:focus {
                border-color: var(--color-primario);
                background: #fff;
            }

            .btn-login-sc {
                width: 100%;
                padding: 13px;
                background: var(--color-oscuro);
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

            .btn-login-sc:hover {
                background: var(--color-primario);
            }

            .link-registro {
                text-align: center;
                margin-top: 22px;
                font-size: 0.83rem;
                color: #999;
            }

            .link-registro a {
                color: var(--color-primario);
                text-decoration: none;
                font-weight: 700;
            }

            .link-registro a:hover {
                text-decoration: underline;
            }

            .alert-error {
                background: #fdecea;
                border-left: 3px solid #c0392b;
                color: #721c24;
                padding: 10px 15px;
                border-radius: 2px;
                font-size: 0.83rem;
                margin-bottom: 20px;
            }

            /* FOOTER */
            .footer-sc {
                background-color: #9E8C78;
                color: #fff;
                padding: 18px 30px;
                display: flex;
                align-items: center;
                justify-content: space-between;
            }

            .footer-brand .nombre {
                font-family: 'Playfair Display', serif;
                font-size: 0.9rem;
                font-weight: 700;
            }

            .footer-brand .subtitulo {
                font-size: 0.6rem;
                letter-spacing: 2px;
                text-transform: uppercase;
                color: #fcfcfc;
            }

            .footer-copy {
                font-size: 0.72rem;
                color: #fbfaf9;
            }

            .footer-social {
                display: flex;
                gap: 15px;
            }

            .footer-social a {
                color: var(--color-beige);
                font-size: 1rem;
                text-decoration: none;
                transition: opacity 0.3s;
            }

            .footer-social a:hover {
                opacity: 0.7;
            }
        </style>
    </head>

    <body>

        <!-- NAVBAR -->
        <nav class="navbar-sc">
            <a href="<%= request.getContextPath() %>/vistas/auth/login.jsp" class="navbar-brand-sc">
                <img src="<%= request.getContextPath() %>/img/logo.png" alt="Logo" class="logo-img">
                <div class="brand-text">
                    <div class="nombre">SERGIO CALDERÓN</div>
                    <div class="subtitulo">Diseñador de Moda</div>
                </div>
            </a>
            <div class="navbar-btns">
                <a href="<%= request.getContextPath() %>/auth/registro" class="btn-registro">Registrarse</a>
                <a href="#" class="btn-ingresar">Iniciar Sesión</a>
            </div>
        </nav>

        <!-- LOGIN -->
        <div class="login-wrapper">
            <div class="login-container">
                <div class="login-imagen"></div>
                <div class="login-form-lado">

                    <h2 class="login-titulo">Bienvenido</h2>
                    <p class="login-subtitulo">Sergio Calderón Atelier</p>

                    <% if (request.getAttribute("error") !=null) { %>
                        <div class="alert-error">
                            <%= request.getAttribute("error") %>
                        </div>
                        <% } %>

                            <form action="<%= request.getContextPath() %>/auth/login" method="post">
                                <div>
                                    <label class="form-label-sc">Correo electrónico</label>
                                    <input type="email" name="email" class="form-control-sc"
                                        placeholder="correo@ejemplo.com" required>
                                </div>
                                <div>
                                    <label class="form-label-sc">Contraseña</label>
                                    <input type="password" name="contrasena" class="form-control-sc"
                                        placeholder="••••••••" required>
                                </div>
                                <button type="submit" class="btn-login-sc">
                                    Iniciar Sesión
                                </button>
                            </form>

                            <div class="link-registro">
                                ¿No tienes cuenta?
                                <a href="<%= request.getContextPath() %>/auth/registro">
                                    Regístrate aquí
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