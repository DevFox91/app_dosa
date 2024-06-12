import 'package:flutter/material.dart';

class PerfilParticipanteScreen extends StatelessWidget {
  const PerfilParticipanteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil del Participante'),
      ),
      body: const Center(
        child: Text('Aquí va el contenido del perfil del participante'),
      ),
    );
  }
}
