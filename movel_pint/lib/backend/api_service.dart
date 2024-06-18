import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movel_pint/utils/constants.dart';

class ApiService {
    static const String baseUrl = CONSTANTS.API_BASE_URL;

  static Future<dynamic> fetchData(String endpoint, {Map<String, String>? headers}) async {
    final url = '$baseUrl/$endpoint';
    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to connect to server: $e');
    }
  }

  static Future<void> updateProfile(Map<String, dynamic> profileData) async {
    final String endpoint = 'utilizador/atualizar/${profileData['id']}';
    try {
      // Preparar dados atualizados do perfil
      Map<String, dynamic> updatedProfile = {
        'nome': profileData['nome'],
        'sobrenome': profileData['sobrenome'],
        'email': profileData['email'],
        'linkedin': profileData['linkedin'],
        'facebook': profileData['facebook'],
        'instagram': profileData['instagram'],
        // Se o campo 'centro' for um ID numérico, converta para um formato aceitável na API
        // Exemplo: 'centro': profileData['utilizador_centro']['centro']
      };

      final response = await http.put(
        Uri.parse('$baseUrl/$endpoint'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(updatedProfile),
      );

      if (response.statusCode == 200) {
        print('Perfil atualizado com sucesso');
      } else {
        throw Exception('Falha ao atualizar perfil: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro na conexão com o servidor: $e');
    }
  }
}
