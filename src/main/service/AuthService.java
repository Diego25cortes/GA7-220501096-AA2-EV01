package com.sergiocalderon.service;

import com.sergiocalderon.modelo.Usuario;
import com.sergiocalderon.repository.UsuarioRepository;
import com.sergiocalderon.modelo.Cliente;
import com.sergiocalderon.repository.ClienteRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.Optional;

@Service
public class AuthService {

    @Autowired
    private UsuarioRepository usuarioRepository;

    @Autowired
    private ClienteRepository clienteRepository;

    public Usuario registrarCliente(String nombre, String apellido,
            String email, String contrasena,
            String telefono) {
        Optional<Usuario> existente = usuarioRepository.findByEmail(email);
        if (existente.isPresent()) {
            throw new RuntimeException("El email ya está registrado");
        }

        Usuario usuario = new Usuario();
        usuario.setNombre(nombre);
        usuario.setApellido(apellido);
        usuario.setEmail(email);
        usuario.setContrasena(contrasena);
        usuario.setTelefono(telefono);
        usuario.setTipoUsuario("CLIENTE"); // String directo

        Usuario usuarioGuardado = usuarioRepository.save(usuario);

        // Crear el registro en tabla cliente
        Cliente cliente = new Cliente();
        cliente.setIdCliente(usuarioGuardado.getIdUsuario());
        cliente.setDireccion("");
        cliente.setCiudad("");
        cliente.setNumeroCitas(0);

        clienteRepository.save(cliente);

        return usuarioGuardado;
    }

    public Optional<Usuario> login(String email, String contrasena) {
        Optional<Usuario> usuario = usuarioRepository.findByEmail(email);

        if (usuario.isPresent() && usuario.get().getContrasena().equals(contrasena)) {
            return usuario;
        }
        return Optional.empty();
    }

    public Optional<Usuario> buscarPorEmail(String email) {
        return usuarioRepository.findByEmail(email);
    }
}
