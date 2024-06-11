import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://localhost:8000';

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

  static updateProfile(Map<String, dynamic> profileData) {
    // Implementação do método updateProfile
  }
}
