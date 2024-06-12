import 'package:flutter/material.dart';
import 'package:app_dosa/services/api_receiver.dart';
import 'package:app_dosa/services/api_sender.dart';

// Widget que muestra una lista de personas en una tabla.
class TodasPersonasScreen extends StatelessWidget {
  // Instancia de ApiReceiver para manejar la comunicación con la API.
  final ApiReceiver apiReceiver = ApiReceiver(ApiSender());

  // Constructor para TodasPersonasScreen
  TodasPersonasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar con el título de la pantalla
      appBar: AppBar(
        title: const Text('Todas las personas'),
      ),
      // FutureBuilder para manejar la obtención de datos asincrónicamente
      body: FutureBuilder<List<List<String>>>(
        future: apiReceiver.getUsuarios(), // Llama a la función que obtiene los usuarios
        builder: (context, snapshot) {
          // Muestra un indicador de carga mientras se espera la respuesta
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          // Muestra un mensaje de error si ocurre algún problema
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final data = snapshot.data;
            // Muestra un mensaje si no hay datos disponibles
            if (data == null || data.isEmpty) {
              return const Center(child: Text('No hay datos disponibles'));
            } else {
              // Muestra la tabla de datos cuando los datos están disponibles
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: _buildColumns(data.first), // Construye las columnas usando la primera fila (encabezados)
                  rows: _buildRows(data.sublist(1)), // Construye las filas usando las filas restantes
                ),
              );
            }
          }
        },
      ),
    );
  }

  // Función para construir las columnas de la tabla
  List<DataColumn> _buildColumns(List<String> headerRow) {
    return headerRow.map((header) => DataColumn(label: Text(header))).toList();
  }

  // Función para construir las filas de la tabla
  List<DataRow> _buildRows(List<List<String>> data) {
    return data.map((row) {
      return DataRow(
        cells: row.map((cell) => DataCell(Text(cell))).toList(),
      );
    }).toList();
  }
}
