import 'package:flutter/material.dart';
import 'package:app_dosa/services/api_receiver.dart';
import 'package:app_dosa/services/api_sender.dart';
import 'perfil_tutor_logic.dart';

class PerfilTutorScreen extends StatefulWidget {
  const PerfilTutorScreen({super.key});

  @override
  _PerfilTutorScreenState createState() => _PerfilTutorScreenState();
}

class _PerfilTutorScreenState extends State<PerfilTutorScreen> {
  // Controladores de texto para los campos de entrada
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
    final ApiReceiver apiReceiver = ApiReceiver(ApiSender());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil del Tutor'),
      ),
      body: FutureBuilder<Map<String, String>>(
        future: apiReceiver.getUserData('1'), // Obtiene los datos del usuario con ID 1
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator()); // Muestra un indicador de carga mientras espera
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}')); // Muestra un mensaje de error si ocurre un error
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay datos disponibles')); // Muestra un mensaje si no hay datos
          } else {
            final userData = snapshot.data!;
            // Rellena los controladores con los datos obtenidos
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
                              _saveUserData(context, apiReceiver.apiSender); // Llama a la función para guardar los datos
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
    await saveUserData(
      context,
      apiSender,
      _nombreController,
      _apellido1Controller,
      _apellido2Controller,
      _tipoDocController,
      _numDocController,
      _sexoController,
      _fechaNacimientoController,
      _correoController,
      _telefonoController,
      _tipoViaController,
      _nombreViaController,
      _poblacionController,
      _provinciaController,
      _codigoPostalController,
    );
  }
}
