import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:movel_pint/backend/myHttp.dart';
import 'package:movel_pint/utils/constants.dart';

class ApiService {
  // Método para obter um recurso específico
  static Future<dynamic> obter(String endpoint, int id, {Map<String, String> headers = const {}}) async {
    final url = '$endpoint/obter/$id';
    try {
      return await myHttp(url: url, method: "GET", headers: headers);
    } catch (e) {
      throw Exception('Failed to connect to server: $e');
    }
  }

  // Método para listar recursos
  static Future<dynamic> listar(String endpoint, {Map<String, String> headers = const {}, dynamic data}) async {
    final url = '$endpoint/listar';
    try {
      return await myHttp(url: url, method: "POST", headers: headers, data: jsonEncode(data));
    } catch (e) {
      throw Exception('Failed to connect to server: $e');
    }
  }

  static Future<http.Response> criarFormData(String endpoint, {Map<String, dynamic> data = const {}, String fileKey = "", Map<String, dynamic> headers = const {}}) async {
    try {
      var url = Uri.parse('/$endpoint/criar');

      var request = http.MultipartRequest('POST', url);
      
      data.forEach((key, value) {
        if (key != fileKey) {
          request.fields[key] = value.toString();
        }
      });
      
      List<File> files = List<File>.from(data[fileKey]);
      for (var file in files) {
        var stream = http.ByteStream(file.openRead());
        var length = await file.length();
        var multipartFile = http.MultipartFile(fileKey, stream, length, filename: file.path.split('/').last);
        request.files.add(multipartFile);
      }
      
      var response = await http.Response.fromStream(await request.send());
      
      return response;
    } catch (error) {
      throw error;
    }
  }


  // Método para criar um recurso
  static Future<dynamic> criar(String endpoint, {Map<String, String> headers = const {}, dynamic data}) async {
    final url = '$endpoint/criar';
    try {
      return await myHttp(url: url, method: "POST", headers: headers, data: jsonEncode(data));
    } catch (e) {
      throw Exception('Failed to connect to server: $e');
    }
  }

  // Método para atualizar um recurso
  static Future<void> atualizar(String endpoint, int id, {Map<String, String>? headers, dynamic data}) async {
    final url = '$endpoint/atualizar/$id';
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/$url'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          ...?headers,
        },
        body: jsonEncode(data),
      );
      if (response.statusCode == 200) {
        print('Recurso atualizado com sucesso');
      } else {
        throw Exception('Falha ao atualizar recurso: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro na conexão com o servidor: $e');
    }
  }

  // Método para remover um recurso
  static Future<void> remover(String endpoint, int id, {Map<String, String>? headers}) async {
    final url = '$endpoint/remover/$id';
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/$url'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          ...?headers,
        },
      );
      if (response.statusCode == 200) {
        print('Recurso removido com sucesso');
      } else {
        throw Exception('Falha ao remover recurso: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro na conexão com o servidor: $e');
    }
  }

  // Método genérico para fazer requisições POST
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

  // Método para atualizar perfil
  static Future<void> updateProfile(Map<String, dynamic> profileData) async {
    final String endpoint = 'utilizador/atualizar/${profileData['id']}';
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/$endpoint'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(profileData),
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
