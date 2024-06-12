import 'package:flutter/material.dart';

class InscripcionesScreen extends StatelessWidget {
  const InscripcionesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inscripciones'),
      ),
      body: const Center(
        child: Text('Aquí va el contenido del perfil del tutor'),
      ),
    );
  }
}
