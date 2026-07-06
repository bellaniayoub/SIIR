import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  // Replace with local development server IP / localhost.
  // Note: Use '10.0.2.2' for Android emulator to access computer's localhost.
  static const String baseUrl = 'http://127.0.0.1:8000/api/v1';

  final http.Client _client = http.Client();

  Future<Map<String, dynamic>> postGoogleAuth({
    required String idToken,
    required String rolePreference,
  }) async {
    final url = Uri.parse('$baseUrl/auth/google');
    try {
      final response = await _client.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'id_token': idToken,
          'role_preference': rolePreference,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw Exception('Authentication failed: ${response.body}');
      }
    } catch (e) {
      throw Exception('Network error during Google authentication: $e');
    }
  }
}
