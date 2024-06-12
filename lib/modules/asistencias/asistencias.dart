import 'package:flutter/material.dart';

class AsistenciasScreen extends StatelessWidget {
  const AsistenciasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Asistencias'),
      ),
      body: const Center(
        child: Text('Aquí va el contenido del perfil del tutor'),
      ),
    );
  }
}
