import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movel_pint/backend/myHttp.dart';
import 'package:movel_pint/utils/constants.dart';

class ApiService {

  static Future<dynamic> obter(String endpoint, int id, {Map<String, String> headers = const {}}) async {
    final url = '$endpoint/obter/$id';
    try {
      return await myHttp(url: url, method: "GET", headers: headers);
    } catch (e) {
      throw Exception('Failed to connect to server: $e');
    }
  }

  static Future<dynamic> listar(String endpoint, {Map<String, String> headers = const {}, dynamic data}) async {
    final url = '$endpoint/listar';
    try {
      return await myHttp(url: url, method: "POST", headers: headers, data: jsonEncode(data));
    } catch (e) {
      throw Exception('Failed to connect to server: $e');
    }
  }

  static Future<dynamic> criar(String endpoint, {Map<String, String> headers = const {}, dynamic data}) async {
    final url = '$endpoint/criar';
    try {
      return await myHttp(url: url, method: "POST", headers: headers, data: jsonEncode(data));
    } catch (e) {
      throw Exception('Failed to connect to server: $e');
    }
  }


  static Future<dynamic> atualizar(String endpoint, int id, {Map<String, String>? headers, dynamic data}) async {}
  static Future<dynamic> remover(String endpoint, int id, {Map<String, String>? headers}) async {}


    static Future<Map<String, dynamic>?> postData(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/$endpoint'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Falha ao enviar dados para a API');
      }
    } catch (e) {
      throw Exception('Erro na comunicação com a API: $e');
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


 // Método genérico para fazer requisições PUT
  static Future<Map<String, dynamic>?> putData(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/$endpoint'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Erro ao atualizar dados: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro ao atualizar dados: $e');
      throw Exception('Erro ao atualizar dados');
    }
  }

  // Método genérico para fazer requisições DELETE
  static Future<void> deleteData(String endpoint) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/$endpoint'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        print('Dados removidos com sucesso');
      } else {
        throw Exception('Erro ao remover dados: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro ao remover dados: $e');
      throw Exception('Erro ao remover dados');
    }
  }

}
