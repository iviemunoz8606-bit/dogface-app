import 'package:flutter/material.dart';

class AppTheme {
  // Los colores principales de DogFace
  static const Color primario = Color(0xFF667eea);
  static const Color secundario = Color(0xFF764ba2);
  static const Color fondo = Color(0xFFE0E0E0);

  static ThemeData obtenerTema() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: primario),
      appBarTheme: const AppBarTheme(
        backgroundColor: primario,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: primario,
        unselectedItemColor: Colors.grey,
      ),
      scaffoldBackgroundColor: fondo,
    );
  }
}