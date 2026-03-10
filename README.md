# Sistema de Agendamiento — Sergio Calderón Atelier de Modas

![Java](https://img.shields.io/badge/Java-25-orange?style=flat-square&logo=java)![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.4.3-brightgreen?style=flat-square&logo=spring)![Maven](https://img.shields.io/badge/Maven-3.9.12-red?style=flat-square&logo=apache-maven)![MySQL](https://img.shields.io/badge/MySQL-8.0-blue?style=flat-square&logo=mysql)![Bootstrap](https://img.shields.io/badge/Bootstrap-5.3-purple?style=flat-square&logo=bootstrap)

> **Evidencia:** GA7-220501096-AA3-EV01 / GA7-220501096-AA3-EV02  
> **Actividad:** GA7-220501096-AA3 — Codificar módulos del software
> **Programa:** Análisis y Desarrollo de Software — SENA

---

## Descripción del Proyecto

Sistema web de agendamiento de citas para el **Atelier de Modas Sergio Calderón**, desarrollado con **Spring Boot 3.4.3**. Permite a los clientes explorar el catálogo de vestidos, registrarse, iniciar sesión y gestionar sus citas. El administrador puede configurar horarios disponibles, gestionar citas y administrar usuarios.

### Funcionalidades principales

**Módulo Cliente:**

- Registro e inicio de sesión
- Visualización del catálogo de vestidos con filtros por categoría
- Agendar, modificar y cancelar citas
- Historial de citas propias

**Módulo Administrador:**

- Dashboard con estadísticas
- Gestión completa de horarios disponibles
- Gestión de citas de todos los clientes
- Administración de usuarios

## Tecnologías Utilizadas

- **Java JDK 21** - Lenguaje principal
- **Spring Boot 3.4.3** - Framework principal
- **Spring MVC** - Capa de controladores
- **Spring Data JPA** - Capa de persistencia
- **Hibernate** - ORM para base de datos
- **MySQL 8.0+** - Base de datos relacional
- **Maven 3.9.12** - Gestión de dependencias
- **JSP + JSTL** - Vistas del sistema
- **Bootstrap 5.3** - Framework CSS
- **Font Awesome 6.4** - Iconografía
- **Apache Tomcat (embebido)** - Servidor de aplicaciones

## Requisitos Previos

Antes de ejecutar el proyecto asegúrate de tener instalado:

- **JDK 21 o superior** — [Eclipse Adoptium](https://adoptium.net/)
- **Apache Maven 3.9+** — [maven.apache.org](https://maven.apache.org/)
- **MySQL 8.0+** — [mysql.com](https://www.mysql.com/)
- **MySQL Workbench** (opcional, recomendado)

---

### 1. Clonar el repositorio

```bash
git clone https://github.com/Diego25cortes/GA7-220501096-AA2-EV01.git
```

### 2. Configurar la base de datos

Abrir **MySQL Workbench** y ejecuta el script para la base de datos:

DROP DATABASE IF EXISTS sergiocalderon_db;
CREATE DATABASE sergiocalderon_db
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE sergiocalderon_db;

-- Tabla usuario
CREATE TABLE usuario (
    id_usuario      INT AUTO_INCREMENT PRIMARY KEY,
    nombre          VARCHAR(100) NOT NULL,
    apellido        VARCHAR(100) NOT NULL,
    email           VARCHAR(150) NOT NULL UNIQUE,
    contrasena      VARCHAR(255) NOT NULL,
    telefono        VARCHAR(20),
    tipo_usuario    ENUM('ADMIN', 'CLIENTE') NOT NULL DEFAULT 'CLIENTE',
    fecha_registro  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla cliente
CREATE TABLE cliente (
    id_cliente      INT PRIMARY KEY,
    direccion       VARCHAR(200) DEFAULT '',
    ciudad          VARCHAR(100) DEFAULT '',
    numero_citas    INT DEFAULT 0,
    CONSTRAINT fk_cliente_usuario
        FOREIGN KEY (id_cliente)
        REFERENCES usuario(id_usuario)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Tabla personal_administrativo
CREATE TABLE personal_administrativo (
    id_administrador    INT PRIMARY KEY,
    cargo               VARCHAR(100) NOT NULL,
    permisos            JSON,
    CONSTRAINT fk_admin_usuario
        FOREIGN KEY (id_administrador)
        REFERENCES usuario(id_usuario)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Tabla disponibilidad
CREATE TABLE disponibilidad (
    id_disponibilidad   INT AUTO_INCREMENT PRIMARY KEY,
    fecha               DATE NOT NULL,
    hora_inicio         TIME NOT NULL,
    hora_fin            TIME NOT NULL,
    disponible          TINYINT(1) DEFAULT 1,
    cupos_totales       INT NOT NULL DEFAULT 1,
    cupos_ocupados      INT NOT NULL DEFAULT 0,
    fecha_creacion      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
                        ON UPDATE CURRENT_TIMESTAMP,
    id_administrador    INT NOT NULL,
    CONSTRAINT fk_disp_admin
        FOREIGN KEY (id_administrador)
        REFERENCES personal_administrativo(id_administrador)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Tabla cita
CREATE TABLE cita (
    id_cita                 INT AUTO_INCREMENT PRIMARY KEY,
    fecha_cita              DATE NOT NULL,
    hora_inicio             TIME NOT NULL,
    hora_fin                TIME NOT NULL,
    duracion_minutos        INT DEFAULT 60,
    tipo_evento             ENUM('BODA','FIESTA','QUINCE','OTRO')
                            NOT NULL DEFAULT 'OTRO',
    motivo_cita             TEXT,
    estado                  ENUM('PENDIENTE','CONFIRMADA',
                                 'COMPLETADA','CANCELADA')
                            NOT NULL DEFAULT 'PENDIENTE',
    fecha_creacion          TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
                            ON UPDATE CURRENT_TIMESTAMP,
    id_cliente              INT NOT NULL,
    id_disponibilidad       INT,
    CONSTRAINT fk_cita_cliente
        FOREIGN KEY (id_cliente)
        REFERENCES cliente(id_cliente)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_cita_disponibilidad
        FOREIGN KEY (id_disponibilidad)
        REFERENCES disponibilidad(id_disponibilidad)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

-- Datos iniciales - Usuario administrador
INSERT INTO usuario (
    id_usuario, nombre, apellido, email,
    contrasena, telefono, tipo_usuario
) VALUES (
    1, 'Sergio', 'Calderon',
    'admin@sergiocalderon.com',
    'admin123', '3001234567', 'ADMIN'
);

-- Registro en personal_administrativo
INSERT INTO personal_administrativo (
    id_administrador, cargo, permisos
) VALUES (
    1,
    'Administrador Principal',
    '{"citas": true, "usuarios": true, "horarios": true, "catalogo": true}'
);

SELECT 'BASE DE DATOS CREADA EXITOSAMENTE' AS resultado;
SHOW TABLES;

### 3. Configurar la conexión a la base de datos

Abrir el archivo:

`src/main/resources/application.properties`

Actualizar las credenciales según el entorno de mysql:

```java
# Configuración de la base de datos
spring.datasource.url=jdbc:mysql://localhost:3306/sergiocalderon_db?useSSL=false&serverTimezone=America/Bogota&allowPublicKeyRetrieval=true
spring.datasource.username=root
spring.datasource.password=Tucontraseña
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver
```

### 4. Dependencias del Proyecto (pom.xml)

El archivo `pom.xml` ya incluye todas las dependencias necesarias. Las principales son:

```lenguaje xml
<dependencies>
    <!-- Spring Boot Starter Web -->
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-web</artifactId>
    </dependency>
    
    <!-- Spring Data JPA -->
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-data-jpa</artifactId>
    </dependency>
    
    <!-- MySQL Connector -->
    <dependency>
        <groupId>com.mysql</groupId>
        <artifactId>mysql-connector-j</artifactId>
        <version>8.0.33</version>
    </dependency>
    
    <!-- Soporte para JSP -->
    <dependency>
        <groupId>org.apache.tomcat.embed</groupId>
        <artifactId>tomcat-embed-jasper</artifactId>
        <scope>provided</scope>
    </dependency>
    
    <!-- JSTL -->
    <dependency>
        <groupId>jakarta.servlet.jsp.jstl</groupId>
        <artifactId>jakarta.servlet.jsp.jstl-api</artifactId>
        <version>3.0.0</version>
    </dependency>
    <dependency>
        <groupId>org.glassfish.web</groupId>
        <artifactId>jakarta.servlet.jsp.jstl</artifactId>
        <version>3.0.1</version>
    </dependency>
</dependencies>
```
---

### 5. Ejecutar el Proyecto

Con maven (recomendado)

```bash
## Para compilar
mvn clean compile

## Para ejecutar mediante spring
mvn spring-boot:run
```
Como archivo JAR

```bash
## Para compilar
mvn clean package

## Para ejecutar mediante JAR
java -jar target/agendamiento.war
```

### 6. Acceder al sistema

| Módulo                      | URL                                                |
| --------------------------- | -------------------------------------------------- |
| Página de inicio            | `http://localhost:8080/`                           |
| Login                       | `http://localhost:8080/auth/login`                 |
| Registro de cliente         | `http://localhost:8080/auth/registro`              |
| Dashboard Admin             | `http://localhost:8080/admin/dashboard`            |
| Gestión de Horarios (Admin) | `http://localhost:8080/admin/horarios`             |
| Dashboard Cliente           | `http://localhost:8080/cliente/dashboard`          |
| Agendar Cita (Cliente)      | `http://localhost:8080/cliente/cita`               |
| Mis Citas (Cliente)         | `http://localhost:8080/cliente/miscitas`           |


### 7. Solución de errores comunes

- Error: "Name for argument not specified"
Agregar el nombre explícito en `@RequestParam`

```bash
@RequestParam("email") String email
```
- Error de tipo ENUM en columnas
Asegúrate de usar `columnDefinition` en las entidades:

```bash
@Column(columnDefinition = "ENUM('ADMIN','CLIENTE')")
private String tipoUsuario;
```
- Puerto 8080 ocupado
Cambia el puerto en `application.properties`:

```bash
server.port=8081
```

O cierra el servicio que este usando el puerto 8080

- Error de conexión a MySQL
Verifica que MySQL esté corriendo y que la contraseña en `application.properties` sea correcta.

---

> [!NOTE]
> **Migración a Spring Boot:**  
> Este proyecto ha sido migrado de Servlets/JSP tradicionales a **Spring Boot 3.4.3**, manteniendo las vistas **JSP originales** pero aprovechando toda la potencia del framework **Spring**.

## Aprendices

- Diego Armando Higuita Cortés.
- Gean Carlos Coplas Romero.
- Luis Eduardo Zabaleta Mora.
- Yessica Alejandra Martínez Rincón.

**Institución:** Servicio Nacional de Aprendizaje — SENA
**Programa:** Análisis y Desarrollo de Software
**Ficha:** 3070324
**Año:** 2026

---

> **Credenciales de prueba:**
> Admin: `admin@sergiocalderon.com` / `admin123`
> Cliente: Registrar nueva cuenta en `/registro`
