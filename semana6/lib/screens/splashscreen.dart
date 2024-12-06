import 'package:flutter/material.dart';
import 'package:semana6/screens/home.dart'; // Pantalla principal

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double opacity = 1.0; // Opacidad inicial para la animación

  @override
  void initState() {
    super.initState();
    // Inicia la animación
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        opacity = 0.0; // Cambia la opacidad para ocultar el contenido
      });

      // Navega a HomeScreen después de la animación
      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) => const Mantenedor()),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary, // Color del fondo basado en el tema
      body: Center(
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 500), // Duración de la animación
          opacity: opacity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'lib/assets/images/finplus.png', // Ruta del logo
                width: 150, // Tamaño del logo
                height: 150,
              ),
              const SizedBox(height: 20), // Espaciado
              const Text(
                'FinPlus',
                style: TextStyle(
                  fontFamily: 'AfacadFlux-Regular', // Fuente personalizada
                  fontSize: 24, // Tamaño de la fuente
                  color: Colors.white, // Color del texto
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}