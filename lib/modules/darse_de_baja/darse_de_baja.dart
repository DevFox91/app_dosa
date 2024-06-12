import 'package:flutter/material.dart';

class DarseDeBajaScreen extends StatelessWidget {
  const DarseDeBajaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Darse de Baja'),
      ),
      body: const Center(
        child: Text('Aquí va el contenido del perfil del tutor'),
      ),
    );
  }
}
