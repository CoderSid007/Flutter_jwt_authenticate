import 'package:flutter/material.dart';
import 'package:jwt_authentication_test/homepage.dart';
import 'auth_service.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _panController = TextEditingController();
  final TextEditingController _upiController = TextEditingController();
  final AuthService _authService = AuthService();

  void _signup() async {
    try {
      final response = await _authService.signup(
        _nameController.text,
        _phoneController.text,
        _emailController.text,
        _passwordController.text,
        _panController.text,
        _upiController.text,
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Homepage(),
        ),
      );
      // Handle the response (e.g., navigate to another page)
      print("Signup successful: ${response}");
    } catch (error) {
      print("Error: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign Up")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: 'Phone'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            TextField(
              controller: _panController,
              decoration: InputDecoration(labelText: 'Pan'),
              obscureText: true,
            ),
            TextField(
              controller: _upiController,
              decoration: InputDecoration(labelText: 'Upi'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _signup,
              child: Text("Sign Up"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Already have an account? Log in"),
            ),
          ],
        ),
      ),
    );
  }

  // void _signupPrint() async {
  //   try {
  //     final response = await _authService.signup(
  //       _nameController.text,
  //       _phoneController.text,
  //       _emailController.text,
  //       _passwordController.text,
  //       _panController.text,
  //       _upiController.text,
  //     );

  //     // Print the entire response to the terminal
  //     print("Signup Response: $response");

  //     // Print specific fields from the response
  //     print("Token: ${response['token']}");
  //     print("User ID: ${response['user']['id']}");
  //   } catch (error) {
  //     print("Error during signup: $error");
  //   }
  // }
}
