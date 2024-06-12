import 'package:flutter/material.dart';

class SeleccionarParticipanteScreen extends StatelessWidget {
  const SeleccionarParticipanteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seleccionar participante'),
      ),
      body: const Center(
        child: Text('Aquí va el contenido del perfil del tutor'),
      ),
    );
  }
}
