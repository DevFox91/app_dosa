import 'package:flutter/material.dart';
import 'package:app_dosa/services/api_sender.dart';

// Función para guardar los datos del usuario
Future<void> saveUserData(
  BuildContext context,
  ApiSender apiSender,
  TextEditingController nombreController,
  TextEditingController apellido1Controller,
  TextEditingController apellido2Controller,
  TextEditingController tipoDocController,
  TextEditingController numDocController,
  TextEditingController sexoController,
  TextEditingController fechaNacimientoController,
  TextEditingController correoController,
  TextEditingController telefonoController,
  TextEditingController tipoViaController,
  TextEditingController nombreViaController,
  TextEditingController poblacionController,
  TextEditingController provinciaController,
  TextEditingController codigoPostalController,
) async {
  print('Guardando datos del usuario...');

  // Crear un mapa con los nuevos datos del usuario
  final Map<String, String> newData = {
    'nombre': nombreController.text,
    'apellido1': apellido1Controller.text,
    'apellido2': apellido2Controller.text,
    'tipodoc': tipoDocController.text,
    'numdoc': numDocController.text,
    'sexo': sexoController.text,
    'fechanac': fechaNacimientoController.text,
    'correo': correoController.text,
    'telefono': telefonoController.text,
    'tipovia': tipoViaController.text,
    'nombrevia': nombreViaController.text,
    'poblacion': poblacionController.text,
    'provincia': provinciaController.text,
    'cpostal': codigoPostalController.text,
  };

  try {
    // Actualiza los datos del usuario mediante la API
    await apiSender.updateUserData('1', newData); // ID del usuario
    print('Datos del usuario actualizados con éxito.');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Datos actualizados correctamente')),
    );
  } catch (e) {
    // Maneja el error en caso de que falle la actualización
    print('Error al actualizar los datos del usuario: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Error al actualizar los datos')),
    );
  }
}
