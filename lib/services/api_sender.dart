import 'package:googleapis/sheets/v4.dart' as sheets;
import 'package:googleapis_auth/auth_io.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class ApiSender {
  // Función para obtener la lista de usuarios desde Google Sheets
  Future<List<List<String>>> fetchUsuarios() async {
    final credentials =
        await _getCredentials(); // Obtiene las credenciales del archivo JSON
    final client = await clientViaServiceAccount(credentials, [
      sheets.SheetsApi.spreadsheetsReadonlyScope
    ]); // Crea un cliente autenticado

    final sheetsApi = sheets.SheetsApi(client); // Inicializa la API de Sheets
    const spreadsheetId =
        '1VpcRguNoj_5CnLAWRNl0jkC2hQ999AZnSvDcFSMJ0Qg'; // ID del spreadsheet
    const range = 'personas!A1:Z'; // Rango de celdas a leer

    // Obtiene los valores del spreadsheet en el rango especificado
    final response =
        await sheetsApi.spreadsheets.values.get(spreadsheetId, range);
    final values = response.values;

    if (values != null) {
      // Convierte los valores obtenidos en una lista de listas de strings
      return values.map((row) => List<String>.from(row)).toList();
    } else {
      // Retorna una lista vacía si no hay valores
      return [];
    }
  }

  // Nueva función para obtener los datos de un usuario específico
  Future<Map<String, String>> fetchUserData(String userId) async {
    final credentials = await _getCredentials();
    final client = await clientViaServiceAccount(
        credentials, [sheets.SheetsApi.spreadsheetsReadonlyScope]);

    final sheetsApi = sheets.SheetsApi(client);
    const spreadsheetId = '1VpcRguNoj_5CnLAWRNl0jkC2hQ999AZnSvDcFSMJ0Qg';
    const range =
        'personas!A1:P'; // Ajustar el rango para incluir solo las columnas necesarias

    final response =
        await sheetsApi.spreadsheets.values.get(spreadsheetId, range);
    final values = response.values;

    if (values != null) {
      final headers = values.first.map((header) => header.toString()).toList();
      final userRow = values.firstWhere((row) => row[0] == userId, orElse: () => []);

      if (userRow.isNotEmpty) {
        final userRowStrings = userRow.map((element) => element.toString()).toList();
        return Map.fromIterables(headers, userRowStrings);
      }
    }
    return {};
  }

  /// Función para actualizar los datos de un usuario específico
  Future<void> updateUserData(String userId, Map<String, String> newData) async {
    final credentials = await _getCredentials();
    final client = await clientViaServiceAccount(credentials, [
      sheets.SheetsApi.spreadsheetsScope,
      sheets.SheetsApi.driveScope,
    ]);

    final sheetsApi = sheets.SheetsApi(client);
    const spreadsheetId = '1VpcRguNoj_5CnLAWRNl0jkC2hQ999AZnSvDcFSMJ0Qg';
    const range = 'personas!A1:P'; // Rango que incluye todos los datos

    // Obtener los datos actuales
    final response = await sheetsApi.spreadsheets.values.get(spreadsheetId, range);
    final values = response.values;

    // Actualizar los datos del usuario en la lista local
    if (values != null) {
      // Encontrar la fila correspondiente al usuario
      final userRowIndex = values.indexWhere((row) => row.isNotEmpty && row[0] == userId);

      if (userRowIndex != -1) {
        final headers = values[0];
        final userRow = values[userRowIndex];
        final updatedRow = List<String?>.filled(headers.length, null);

        // Transferir los datos antiguos
        for (int i = 0; i < userRow.length; i++) {
          updatedRow[i] = userRow[i] as String?;
        }

        // Actualizar los nuevos datos
        newData.forEach((key, value) {
          final index = headers.indexOf(key);
          if (index != -1) {
            updatedRow[index] = value;
          }
        });

        // Actualizar la fila en la lista local
        values[userRowIndex] = updatedRow;
      }
    }

    // Escribir la lista actualizada en la hoja de cálculo
    await sheetsApi.spreadsheets.values.update(
      sheets.ValueRange.fromJson({
        'majorDimension': 'ROWS',
        'range': range,
        'values': values,
      }),
      spreadsheetId,
      range,
      valueInputOption: 'RAW',
    );
  }

  // Función privada para cargar las credenciales desde un archivo JSON
  Future<ServiceAccountCredentials> _getCredentials() async {
    final jsonString = await rootBundle.loadString(
        'lib/assets/credentials.json'); // Carga el archivo de credenciales
    final jsonMap = json.decode(jsonString); // Decodifica el JSON a un mapa
    return ServiceAccountCredentials.fromJson(
        jsonMap); // Crea las credenciales desde el mapa JSON
  }
}
