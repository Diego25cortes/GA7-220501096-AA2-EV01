package com.sergiocalderon.repository;

import com.sergiocalderon.modelo.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.Optional;

@Repository
public interface UsuarioRepository extends JpaRepository<Usuario, Integer> {
    
    // Buscar usuario por email (para login)
    Optional<Usuario> findByEmail(String email);
    
    // Verificar si existe un email
    boolean existsByEmail(String email);
    
    // Buscar usuario por email y contraseña (para validación)
    Optional<Usuario> findByEmailAndContrasena(String email, String contrasena);
}