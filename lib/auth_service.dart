import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final String baseUrl =
      "https://neonlogicsihbackend-production.up.railway.app/api/v1/retailer";

  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/login');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to log in');
    }
  }

  Future<Map<String, dynamic>> signup(String name, String phone, String email,
      String password, String pan, String upi) async {
    final url = Uri.parse('$baseUrl/register');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        'name': name,
        'phone': phone,
        'email': email,
        'password': password,
        'pan_number': pan,
        'upi_id': upi,
      }),
    );

    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      // print("Signup error: ${response.body}");
      throw Exception('Failed to sign up');
    }
  }
  //
}
