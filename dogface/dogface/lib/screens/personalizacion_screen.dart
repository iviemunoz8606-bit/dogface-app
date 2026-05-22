import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/app_theme.dart';

class PersonalizacionScreen extends StatefulWidget {
  const PersonalizacionScreen({super.key});

  @override
  State<PersonalizacionScreen> createState() => _EstadoPersonalizacion();
}

class _EstadoPersonalizacion extends State<PersonalizacionScreen> {
  Color _colorPrimario = AppTheme.primario;
  Color _colorSecundario = AppTheme.secundario;
  Color _colorFondo = AppTheme.fondo;

  @override
  void initState() {
    super.initState();
    _cargarColores();
  }

  Future<void> _cargarColores() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _colorPrimario = Color(prefs.getInt('colorPrimario') ?? AppTheme.primario.value);
      _colorSecundario = Color(prefs.getInt('colorSecundario') ?? AppTheme.secundario.value);
      _colorFondo = Color(prefs.getInt('colorFondo') ?? AppTheme.fondo.value);
    });
  }

  Future<void> _guardarColor(String clave, Color color) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(clave, color.value);
  }

  void _mostrarSelectorColor(String titulo, Color colorActual, Function(Color) alCambiar) {
    Color colorTemporal = colorActual;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(titulo),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: colorActual,
            onColorChanged: (color) => colorTemporal = color,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              alCambiar(colorTemporal);
              Navigator.pop(context);
            },
            child: const Text('Aplicar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personalización'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _itemColor('Color primario', _colorPrimario, (c) {
            setState(() => _colorPrimario = c);
            _guardarColor('colorPrimario', c);
          }),
          _itemColor('Color secundario', _colorSecundario, (c) {
            setState(() => _colorSecundario = c);
            _guardarColor('colorSecundario', c);
          }),
          _itemColor('Color de fondo', _colorFondo, (c) {
            setState(() => _colorFondo = c);
            _guardarColor('colorFondo', c);
          }),
        ],
      ),
    );
  }

  Widget _itemColor(String titulo, Color color, Function(Color) alCambiar) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(titulo),
        trailing: GestureDetector(
          onTap: () => _mostrarSelectorColor(titulo, color, alCambiar),
          child: CircleAvatar(backgroundColor: color, radius: 20),
        ),
      ),
    );
  }
}