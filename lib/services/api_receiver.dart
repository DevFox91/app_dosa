import 'api_sender.dart';

// Clase que actúa como receptor para manejar la lógica de obtención de datos
class ApiReceiver {
  final ApiSender apiSender; // Instancia de ApiSender para hacer las solicitudes

  // Constructor que recibe una instancia de ApiSender
  ApiReceiver(this.apiSender);

  // Función para obtener la lista de usuarios
  Future<List<List<String>>> getUsuarios() async {
    final data = await apiSender.fetchUsuarios(); // Llama a fetchUsuarios de ApiSender
    // Aquí puedes transformar los datos si es necesario
    return data;
  }

  // Nueva función para obtener los datos de un usuario específico
  Future<Map<String, String>> getUserData(String userId) async {
    final data = await apiSender.fetchUserData(userId);
    return data;
  }
}

