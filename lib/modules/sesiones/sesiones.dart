import 'package:flutter/material.dart';

class SesionesScreen extends StatelessWidget {
  const SesionesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sesiones'),
      ),
      body: const Center(
        child: Text('Aquí va el contenido del perfil del tutor'),
      ),
    );
  }
}
