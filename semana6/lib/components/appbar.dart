import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Asegúrate de tener este paquete para autenticación

// Definir la función buildAppBar
AppBar buildAppBar(BuildContext context) {
  // Obtener el correo electrónico del usuario actual
  String userEmail = FirebaseAuth.instance.currentUser?.email ?? 'No hay usuario';

  return AppBar(
    backgroundColor: Theme.of(context).colorScheme.primary,
    title: const Text(
      'Home', // Título del AppBar
      style: TextStyle(
        fontSize: 20,
        color: Colors.white,
      ),
    ),
    actions: [
      PopupMenuButton<String>(
        onSelected: (value) async {
          if (value == 'logout') {
            // Si el valor seleccionado es 'logout', cerramos sesión
            await FirebaseAuth.instance.signOut();
            // Después de cerrar sesión, redirigimos al usuario a la pantalla de inicio de sesión
            // ignore: use_build_context_synchronously
            Navigator.pushReplacementNamed(context, '/authuser');
          }
        },
        itemBuilder: (BuildContext context) {
          return [
            // Mostrar el correo electrónico del usuario con el icono "person"
            PopupMenuItem<String>(
              value: 'userEmail',
              child: Row(
                children: [
                  const Icon(Icons.person_outline, size: 20), // Icono "person"
                  const SizedBox(width: 8), // Espacio entre el icono y el texto
                  Text(' $userEmail'),
                ],
              ),
            ),
            // Opción para cerrar sesión con el icono "exit_to_app"
            const PopupMenuItem<String>(
              value: 'logout',
              child: Row(
                children: [
                  Icon(Icons.exit_to_app, size: 20), // Icono "cerrar sesión"
                  SizedBox(width: 8), // Espacio entre el icono y el texto
                  Text('Cerrar sesión'),
                ],
              ),
            ),
          ];
        },
        icon: const Icon(Icons.more_vert), // El ícono de los tres puntos
      ),
    ],
  );
}