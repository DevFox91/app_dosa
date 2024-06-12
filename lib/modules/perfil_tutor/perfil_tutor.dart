import 'package:flutter/material.dart';
import 'package:app_dosa/services/api_receiver.dart';
import 'package:app_dosa/services/api_sender.dart';

// Definición de la clase StatefulWidget para la pantalla de perfil del tutor
class PerfilTutorScreen extends StatefulWidget {
  const PerfilTutorScreen({super.key});

  @override
  _PerfilTutorScreenState createState() => _PerfilTutorScreenState();
}

// Estado de la pantalla de perfil del tutor
class _PerfilTutorScreenState extends State<PerfilTutorScreen> {
  // Controladores de texto para cada campo del formulario
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellido1Controller = TextEditingController();
  final TextEditingController _apellido2Controller = TextEditingController();
  final TextEditingController _tipoDocController = TextEditingController();
  final TextEditingController _numDocController = TextEditingController();
  final TextEditingController _sexoController = TextEditingController();
  final TextEditingController _fechaNacimientoController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _tipoViaController = TextEditingController();
  final TextEditingController _nombreViaController = TextEditingController();
  final TextEditingController _poblacionController = TextEditingController();
  final TextEditingController _provinciaController = TextEditingController();
  final TextEditingController _codigoPostalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Creación de una instancia de ApiReceiver, que utiliza ApiSender
    final ApiReceiver apiReceiver = ApiReceiver(ApiSender());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil del Tutor'),
      ),
      // Uso de FutureBuilder para manejar la obtención de datos del usuario
      body: FutureBuilder<Map<String, String>>(
        future: apiReceiver.getUserData('1'), // ID del usuario
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Muestra un indicador de carga mientras se esperan los datos
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Muestra un mensaje de error si ocurre un problema al obtener los datos
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // Muestra un mensaje si no hay datos disponibles
            return const Center(child: Text('No hay datos disponibles'));
          } else {
            // Si los datos se obtienen correctamente, se rellenan los controladores de texto
            final userData = snapshot.data!;
            _nombreController.text = userData['nombre'] ?? '';
            _apellido1Controller.text = userData['apellido1'] ?? '';
            _apellido2Controller.text = userData['apellido2'] ?? '';
            _tipoDocController.text = userData['tipodoc'] ?? '';
            _numDocController.text = userData['numdoc'] ?? '';
            _sexoController.text = userData['sexo'] ?? '';
            _fechaNacimientoController.text = userData['fechanac'] ?? '';
            _correoController.text = userData['correo'] ?? '';
            _telefonoController.text = userData['telefono'] ?? '';
            _tipoViaController.text = userData['tipovia'] ?? '';
            _nombreViaController.text = userData['nombrevia'] ?? '';
            _poblacionController.text = userData['poblacion'] ?? '';
            _provinciaController.text = userData['provincia'] ?? '';
            _codigoPostalController.text = userData['cpostal'] ?? '';

            // Construcción de la interfaz de usuario
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Datos Personales',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    // Uso de Wrap para organizar los campos de texto
                    Wrap(
                      spacing: 16.0, // Espacio horizontal entre los campos
                      runSpacing: 8.0, // Espacio vertical entre las filas de campos
                      children: <Widget>[
                        _buildTextField('Nombre', _nombreController),
                        _buildTextField('Primer Apellido', _apellido1Controller),
                        _buildTextField('Segundo Apellido', _apellido2Controller),
                        _buildTextField('Tipo de Identificación', _tipoDocController),
                        _buildTextField('Numero de identificación', _numDocController),
                        _buildTextField('Sexo', _sexoController),
                        _buildTextField('Fecha Nacimiento', _fechaNacimientoController),
                        _buildTextField('Email', _correoController),
                        _buildTextField('Teléfono', _telefonoController),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'Dirección',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    Wrap(
                      spacing: 16.0, // Espacio horizontal entre los campos
                      runSpacing: 8.0, // Espacio vertical entre las filas de campos
                      children: <Widget>[
                        _buildTextField('Tipo de vía', _tipoViaController),
                        _buildTextField('Nombre de vía', _nombreViaController),
                        _buildTextField('Población', _poblacionController),
                        _buildTextField('Provincia', _provinciaController),
                        _buildTextField('Código Postal', _codigoPostalController),
                        SizedBox(
                          width: double.infinity, // Botón ocupa el ancho completo
                          child: ElevatedButton(
                            onPressed: () {
                              _saveUserData(context, apiReceiver.apiSender); // Llamada a la función de guardado
                            },
                            child: const Text('Guardar'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  // Método para construir un campo de texto con etiqueta
  Widget _buildTextField(String labelText, TextEditingController controller) {
    return SizedBox(
      width: 300, // Ajusta el ancho de los campos de texto
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            labelText,
            style: const TextStyle(fontSize: 16.0),
          ),
          const SizedBox(height: 4.0),
          TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            controller: controller,
          ),
        ],
      ),
    );
  }

  // Función para guardar los datos del usuario
  Future<void> _saveUserData(BuildContext context, ApiSender apiSender) async {
    print('Guardando datos del usuario...');
    // Creación de un mapa con los nuevos datos del usuario
    final Map<String, String> newData = {
      'nombre': _nombreController.text,
      'apellido1': _apellido1Controller.text,
      'apellido2': _apellido2Controller.text,
      'tipodoc': _tipoDocController.text,
      'numdoc': _numDocController.text,
      'sexo': _sexoController.text,
      'fechanac': _fechaNacimientoController.text,
      'correo': _correoController.text,
      'telefono': _telefonoController.text,
      'tipovia': _tipoViaController.text,
      'nombrevia': _nombreViaController.text,
      'poblacion': _poblacionController.text,
      'provincia': _provinciaController.text,
      'cpostal': _codigoPostalController.text,
    };

    try {
      // Llamada al método para actualizar los datos del usuario
      await apiSender.updateUserData('1', newData); // ID del usuario
      print('Datos del usuario actualizados con éxito.');
      // Muestra una notificación de éxito
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Datos actualizados correctamente')),
      );
    } catch (e) {
      // Manejo de errores al actualizar los datos del usuario
      print('Error al actualizar los datos del usuario: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al actualizar los datos')),
      );
    }
  }
}
