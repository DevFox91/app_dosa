import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const UserAccountsDrawerHeader(
              accountName: Text('Nombre de Usuario'),
              accountEmail: Text('usuario@example.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  'U',
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            _createDrawerItem(
              icon: Icons.home,
              text: 'Inicio',
              onTap: () =>
                  Navigator.popUntil(context, ModalRoute.withName('/')),
            ),
            _createDrawerItem(
              icon: Icons.person,
              text: 'Perfil del Participante',
              onTap: () => Navigator.pushNamed(context, '/perfil_participante'),
            ),
            _createDrawerItem(
              icon: Icons.payment,
              text: 'Pagos',
              onTap: () => Navigator.pushNamed(context, '/pagos'),
            ),
            _createDrawerItem(
              icon: Icons.event,
              text: 'Actividades',
              onTap: () => Navigator.pushNamed(context, '/actividades'),
            ),
            _createDrawerItem(
              icon: Icons.how_to_reg,
              text: 'Inscripciones',
              onTap: () => Navigator.pushNamed(context, '/inscripciones'),
            ),
            _createDrawerItem(
              icon: Icons.schedule,
              text: 'Sesiones',
              onTap: () => Navigator.pushNamed(context, '/sesiones'),
            ),
            _createDrawerItem(
              icon: Icons.check,
              text: 'Asistencias',
              onTap: () => Navigator.pushNamed(context, '/asistencias'),
            ),
            _createDrawerItem(
              icon: Icons.insert_drive_file,
              text: 'Documentos',
              onTap: () => Navigator.pushNamed(context, '/documentos'),
            ),
            _createDrawerItem(
              icon: Icons.calendar_today,
              text: 'Calendario',
              onTap: () => Navigator.pushNamed(context, '/calendario'),
            ),
            _createDrawerItem(
              icon: Icons.person_outline,
              text: 'Perfil del Tutor',
              onTap: () => Navigator.pushNamed(context, '/perfil_tutor'),
            ),
            _createDrawerItem(
              icon: Icons.group,
              text: 'Seleccionar Participante',
              onTap: () =>
                  Navigator.pushNamed(context, '/seleccionar_participante'),
            ),
            _createDrawerItem(
              icon: Icons.lock,
              text: 'Cambiar Contraseña',
              onTap: () => Navigator.pushNamed(context, '/cambiar_contrasena'),
            ),
            _createDrawerItem(
              icon: Icons.exit_to_app,
              text: 'Darse de Baja',
              onTap: () => Navigator.pushNamed(context, '/darse_de_baja'),
            ),
            _createDrawerItem(
              icon: Icons.person,
              text: 'Personas',
              onTap: () => Navigator.pushNamed(context, '/todas_personas'),
            ),
            _createDrawerItem(
              icon: Icons.exit_to_app,
              text: 'Cerrar sesión',
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/login', (route) => false);
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text('Bienvenido a la App'),
      ),
    );
  }

  ListTile _createDrawerItem(
      {required IconData icon, required String text, GestureTapCallback? onTap}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      onTap: onTap,
    );
  }
}
