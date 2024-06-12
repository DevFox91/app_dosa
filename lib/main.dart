import 'package:app_dosa/modules/perfil_tutor/perfil_tutor_design.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart'; 
import 'modules/perfil_participante/perfil_participante.dart'; 
import 'modules/seleccionar_participante/seleccionar_participante.dart'; 
import 'modules/pagos/pagos.dart'; 
import 'modules/actividades/actividades.dart'; 
import 'modules/inscripciones/inscripciones.dart';
import 'modules/sesiones/sesiones.dart';
import 'modules/asistencias/asistencias.dart'; 
import 'modules/documentos/documentos.dart'; 
import 'modules/cambiar_contrasena/cambiar_contrasena.dart'; 
import 'modules/darse_de_baja/darse_de_baja.dart'; 
import 'modules/calendario/calendario.dart'; 
import 'modules/todas_personas/todas_personas.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        '/': (context) => const HomeScreen(), 
        '/perfil_participante': (context) => const PerfilParticipanteScreen(), 
        '/perfil_tutor': (context) => const PerfilTutorScreen(), 
        '/seleccionar_participante': (context) => const SeleccionarParticipanteScreen(),
        '/pagos': (context) => const PagosScreen(), 
        '/actividades': (context) => const ActividadesScreen(), 
        '/inscripciones': (context) => const InscripcionesScreen(), 
        '/sesiones': (context) => const SesionesScreen(), 
        '/asistencias': (context) => const AsistenciasScreen(), 
        '/documentos': (context) => const DocumentosScreen(), 
        '/cambiar_contrasena': (context) => const CambiarContrasenaScreen(), 
        '/darse_de_baja': (context) => const DarseDeBajaScreen(), 
        '/calendario': (context) => const CalendarioScreen(), 
        '/todas_personas': (context) => TodasPersonasScreen(), 
      }, 
    );
  }
}
