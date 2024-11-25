import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:semana6/screens/home.dart';
import 'package:semana6/screens/splashscreen.dart';
import 'package:semana6/theme/theme.dart'; // Mantengo tu archivo de tema
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.light,   
      darkTheme: AppTheme.dark, 
      themeMode: ThemeMode.system,  // Cambia entre el modo claro y oscuro
      home: const SplashScreen(),  // Pantalla inicial
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Mantenedor(); 
  }
}