<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sergio Calderón - Diseñador de Moda</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400;0,700;1,400&family=Lato:wght@300;400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --navbar: #D0B89E;
            --footer: #9E8C78;
            --fondo: #EBDFD4;
            --oscuro: #3E2417;
            --texto: #3E2723;
            --beige: #C9A97A;
        }
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Lato', sans-serif;
            background-color: var(--fondo);
        }

        /* NAVBAR */
        .navbar-sc {
            background-color: var(--navbar);
            padding: 10px 30px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            position: sticky;
            top: 0;
            z-index: 100;
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
            letter-spacing: 1px;
            color: var(--oscuro);
        }
        .brand-text .subtitulo {
            font-size: 0.62rem;
            letter-spacing: 2px;
            color: var(--oscuro);
            text-transform: uppercase;
        }
        .navbar-centro {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        .select-categorias {
            padding: 7px 15px;
            border: 1px solid var(--oscuro);
            border-radius: 2px;
            background: transparent;
            font-family: 'Lato', sans-serif;
            font-size: 0.85rem;
            color: var(--oscuro);
            cursor: pointer;
        }
        .input-buscar {
            padding: 7px 15px;
            border: 1px solid var(--oscuro);
            border-radius: 2px;
            background: transparent;
            font-family: 'Lato', sans-serif;
            font-size: 0.85rem;
            color: var(--oscuro);
            width: 200px;
            outline: none;
        }
        .input-buscar::placeholder { color: #7a6555; }
        .btn-buscar {
            background: var(--oscuro);
            border: none;
            color: #fff;
            padding: 7px 14px;
            border-radius: 2px;
            cursor: pointer;
            font-size: 0.9rem;
        }
        .navbar-btns { display: flex; gap: 10px; align-items: center; }
        .btn-registro {
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
        .btn-registro:hover { background: var(--oscuro); color: #fff; }
        .btn-ingresar {
            background: var(--oscuro);
            color: #fff;
            padding: 6px 18px;
            border-radius: 2px;
            font-size: 0.82rem;
            text-decoration: none;
            letter-spacing: 1px;
        }

        /* HERO BANNER */
        .hero {
            background: url('<%= request.getContextPath() %>/img/florBD.avif')
                        center/cover no-repeat;
            min-height: 280px;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
        }
        .hero::after {
            content: '';
            position: absolute; inset: 0;
            background: rgba(235, 223, 212, 0.55);
        }
        .hero-texto {
            position: relative;
            z-index: 1;
            text-align: center;
            padding: 20px;
        }
        .hero-texto h1 {
            font-family: 'Playfair Display', serif;
            font-size: 2.4rem;
            color: var(--oscuro);
            font-style: italic;
            line-height: 1.3;
            text-shadow: 1px 1px 3px rgba(255,255,255,0.5);
        }

        /* SECCIÓN CATEGORÍAS */
        .seccion {
            max-width: 1200px;
            margin: 0 auto;
            padding: 40px 20px;
        }
        .seccion-titulo {
            font-family: 'Playfair Display', serif;
            font-size: 1.5rem;
            color: var(--oscuro);
            margin-bottom: 25px;
            font-weight: 700;
        }
        .categorias-grid {
            display: flex;
            gap: 20px;
            flex-wrap: wrap;
            margin-bottom: 50px;
        }
        .categoria-item {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 8px;
            cursor: pointer;
            text-decoration: none;
        }
        .categoria-img {
            width: 100px; height: 100px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid var(--navbar);
            transition: border-color 0.3s, transform 0.3s;
        }
        .categoria-item:hover .categoria-img {
            border-color: var(--oscuro);
            transform: scale(1.05);
        }
        .categoria-nombre {
            font-size: 0.82rem;
            color: var(--oscuro);
            font-weight: 600;
            letter-spacing: 0.5px;
        }

        /* GRID VESTIDOS */
        .vestidos-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 18px;
        }
        .vestido-card {
            background: #fff;
            border-radius: 4px;
            overflow: hidden;
            box-shadow: 0 3px 12px rgba(0,0,0,0.08);
            transition: transform 0.3s, box-shadow 0.3s;
            cursor: pointer;
        }
        .vestido-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.15);
        }
        .vestido-card img {
            width: 100%;
            height: 280px;
            object-fit: cover;
        }
        .vestido-card-body {
            padding: 12px 15px;
        }
        .vestido-nombre {
            font-family: 'Playfair Display', serif;
            font-size: 0.95rem;
            color: var(--oscuro);
            font-weight: 700;
        }
        .vestido-categoria {
            font-size: 0.75rem;
            color: var(--beige);
            letter-spacing: 1px;
            text-transform: uppercase;
            margin-top: 3px;
        }

        /* DIVISOR */
        .divisor {
            border: none;
            border-top: 1px solid #D4B896;
            margin: 10px 0 40px 0;
        }

        /* FOOTER */
        .footer-sc {
            background-color: var(--footer);
            color: #fff;
            padding: 20px 30px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-top: 20px;
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
            opacity: 0.7;
        }
        .footer-copy { font-size: 0.72rem; opacity: 0.7; }
        .footer-social { display: flex; gap: 15px; }
        .footer-social a {
            color: #fff;
            font-size: 1rem;
            text-decoration: none;
            opacity: 0.85;
        }
        .footer-social a:hover { opacity: 1; }

        @media (max-width: 768px) {
            .vestidos-grid { grid-template-columns: repeat(2, 1fr); }
            .navbar-centro { display: none; }
            .hero-texto h1 { font-size: 1.6rem; }
        }
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


    <div class="navbar-btns">
        <a href="<%= request.getContextPath() %>/registro"
           class="btn-registro">Registrarse</a>
        <a href="<%= request.getContextPath() %>/vistas/auth/login.jsp"
           class="btn-ingresar">Iniciar Sesión</a>
    </div>
</nav>

<!-- HERO -->
<div class="hero">
    <div class="hero-texto">
        <h1>"El vestido de tus sueños<br>lo encontrarás con nosotros"</h1>
        <div class="navbar-centro">
        <select class="select-categorias" onchange="filtrarCategoria(this.value)">
            <option value="todos">Categorías</option>
            <option value="novia">Vestido de novia</option>
            <option value="fiesta">Fiesta</option>
            <option value="populares">Populares</option>
            <option value="verano">Verano</option>
            <option value="primavera">Primavera</option>
            <option value="piedras">Piedras</option>
        </select>
        <input type="text" class="input-buscar"
               placeholder="Buscar..." id="inputBuscar"
               onkeyup="buscarVestido()">
        <button class="btn-buscar"><i class="fa-solid fa-magnifying-glass"></i></button>
    </div>
    </div>
</div>

<!-- CONTENIDO PRINCIPAL -->
<div class="seccion">

    <!-- CATEGORÍAS -->
    <h2 class="seccion-titulo">Categorías</h2>
    <hr class="divisor">
    <div class="categorias-grid">
        <a href="#" class="categoria-item" onclick="filtrarCategoria('novia')">
            <img src="<%= request.getContextPath() %>/img/vestido5.jpeg"
                 class="categoria-img" alt="Novia">
            <span class="categoria-nombre">Vestido de novia</span>
        </a>
        <a href="#" class="categoria-item" onclick="filtrarCategoria('fiesta')">
            <img src="<%= request.getContextPath() %>/img/vestido9.jpeg"
                 class="categoria-img" alt="Fiesta">
            <span class="categoria-nombre">Fiesta</span>
        </a>
        <a href="#" class="categoria-item" onclick="filtrarCategoria('populares')">
            <img src="<%= request.getContextPath() %>/img/vestido3.jpeg"
                 class="categoria-img" alt="Populares">
            <span class="categoria-nombre">Populares</span>
        </a>
        <a href="#" class="categoria-item" onclick="filtrarCategoria('verano')">
            <img src="<%= request.getContextPath() %>/img/vestido2.jpeg"
                 class="categoria-img" alt="Verano">
            <span class="categoria-nombre">Verano</span>
        </a>
        <a href="#" class="categoria-item" onclick="filtrarCategoria('primavera')">
            <img src="<%= request.getContextPath() %>/img/vestido4.jpeg"
                 class="categoria-img" alt="Primavera">
            <span class="categoria-nombre">Primavera</span>
        </a>
        <a href="#" class="categoria-item" onclick="filtrarCategoria('piedras')">
            <img src="<%= request.getContextPath() %>/img/piedras.jpeg"
                 class="categoria-img" alt="Piedras">
            <span class="categoria-nombre">Piedras</span>
        </a>
    </div>

    <!-- RECOMENDACIONES -->
    <h2 class="seccion-titulo">Recomendaciones</h2>
    <hr class="divisor">
    <div class="vestidos-grid" id="vestidosGrid">

        <div class="vestido-card" data-categoria="novia">
            <img src="<%= request.getContextPath() %>/img/vestido1.jpeg" alt="Vestido 1">
            <div class="vestido-card-body">
                <div class="vestido-nombre">Elegancia Clásica</div>
                <div class="vestido-categoria">Vestido de novia</div>
            </div>
        </div>

        <div class="vestido-card" data-categoria="fiesta">
            <img src="<%= request.getContextPath() %>/img/vestido2.jpeg" alt="Vestido 2">
            <div class="vestido-card-body">
                <div class="vestido-nombre">Noche Especial</div>
                <div class="vestido-categoria">Fiesta</div>
            </div>
        </div>

        <div class="vestido-card" data-categoria="populares">
            <img src="<%= request.getContextPath() %>/img/vestido3.jpeg" alt="Vestido 3">
            <div class="vestido-card-body">
                <div class="vestido-nombre">Favorito del Atelier</div>
                <div class="vestido-categoria">Populares</div>
            </div>
        </div>

        <div class="vestido-card" data-categoria="primavera">
            <img src="<%= request.getContextPath() %>/img/vestido4.jpeg" alt="Vestido 4">
            <div class="vestido-card-body">
                <div class="vestido-nombre">Brisa Primaveral</div>
                <div class="vestido-categoria">Primavera</div>
            </div>
        </div>

        <div class="vestido-card" data-categoria="novia">
            <img src="<%= request.getContextPath() %>/img/vestido5.jpeg" alt="Vestido 5">
            <div class="vestido-card-body">
                <div class="vestido-nombre">Sueño Blanco</div>
                <div class="vestido-categoria">Vestido de novia</div>
            </div>
        </div>

        <div class="vestido-card" data-categoria="novia">
            <img src="<%= request.getContextPath() %>/img/vestido6.jpeg" alt="Vestido 6">
            <div class="vestido-card-body">
                <div class="vestido-nombre">Princesa Moderna</div>
                <div class="vestido-categoria">Vestido de novia</div>
            </div>
        </div>

        <div class="vestido-card" data-categoria="fiesta">
            <img src="<%= request.getContextPath() %>/img/vestido7.jpeg" alt="Vestido 7">
            <div class="vestido-card-body">
                <div class="vestido-nombre">Glamour Total</div>
                <div class="vestido-categoria">Fiesta</div>
            </div>
        </div>

        <div class="vestido-card" data-categoria="verano">
            <img src="<%= request.getContextPath() %>/img/vestido8.jpeg" alt="Vestido 8">
            <div class="vestido-card-body">
                <div class="vestido-nombre">Tarde de Verano</div>
                <div class="vestido-categoria">Verano</div>
            </div>
        </div>

        <div class="vestido-card" data-categoria="fiesta">
            <img src="<%= request.getContextPath() %>/img/vestido9.jpeg" alt="Vestido 9">
            <div class="vestido-card-body">
                <div class="vestido-nombre">Fucsia Elegante</div>
                <div class="vestido-categoria">Fiesta</div>
            </div>
        </div>

        <div class="vestido-card" data-categoria="populares">
            <img src="<%= request.getContextPath() %>/img/vestido10.jpeg" alt="Vestido 10">
            <div class="vestido-card-body">
                <div class="vestido-nombre">Plata Brillante</div>
                <div class="vestido-categoria">Populares</div>
            </div>
        </div>

        <div class="vestido-card" data-categoria="novia">
            <img src="<%= request.getContextPath() %>/img/vestido11.jpeg" alt="Vestido 11">
            <div class="vestido-card-body">
                <div class="vestido-nombre">Novia Romántica</div>
                <div class="vestido-categoria">Vestido de novia</div>
            </div>
        </div>

        <div class="vestido-card" data-categoria="novia">
            <img src="<%= request.getContextPath() %>/img/vestido12.jpeg" alt="Vestido 12">
            <div class="vestido-card-body">
                <div class="vestido-nombre">Encaje Eterno</div>
                <div class="vestido-categoria">Vestido de novia</div>
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
        <a href="#"><i class="fa-brands fa-instagram"></i></a>
<a href="#"><i class="fa-brands fa-facebook"></i></a>
    </div>
</footer>

<script>
function filtrarCategoria(categoria) {
    const cards = document.querySelectorAll('.vestido-card');
    cards.forEach(card => {
        if (categoria === 'todos' || 
            card.dataset.categoria === categoria) {
            card.style.display = 'block';
        } else {
            card.style.display = 'none';
        }
    });
}

function buscarVestido() {
    const texto = document.getElementById('inputBuscar')
                          .value.toLowerCase();
    const cards = document.querySelectorAll('.vestido-card');
    cards.forEach(card => {
        const nombre = card.querySelector('.vestido-nombre')
                           .textContent.toLowerCase();
        const categoria = card.querySelector('.vestido-categoria')
                              .textContent.toLowerCase();
        if (nombre.includes(texto) || categoria.includes(texto)) {
            card.style.display = 'block';
        } else {
            card.style.display = 'none';
        }
    });
}
</script>

</body>
</html>
