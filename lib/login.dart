// import 'package:flutter/material.dart';
// import 'package:jwt_authentication_test/homepage.dart';
// import 'package:jwt_authentication_test/signup.dart';
// import 'auth_service.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final AuthService _authService = AuthService();

//   void _login() async {
//     try {
//       final response = await _authService.login(
//         _emailController.text,
//         _passwordController.text,
//       );
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => Homepage(),
//         ),
//       );
//       // Handle the response (e.g., navigate to another page)
//       print("Login successful: ${response}");
//     } catch (error) {
//       print("Error: $error");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Login")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _emailController,
//               decoration: InputDecoration(labelText: 'Email'),
//             ),
//             TextField(
//               controller: _passwordController,
//               decoration: InputDecoration(labelText: 'Password'),
//               obscureText: true,
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _login,
//               child: Text("Login"),
//             ),
//             TextButton(
//               onPressed: () {
//                 void _loadUserDetails() async {
//                   await rupamToken();
//                 }

//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => SignupPage()),
//                 );
//               },
//               child: Text("Don't have an account? Sign up"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // void _loginPrint() async {
//   //   try {
//   //     final response = await _authService.login(
//   //       _emailController.text,
//   //       _passwordController.text,
//   //     );
//   //     // Print the entire response to the terminal
//   //     print("Login Response: $response");
//   //   } catch (error) {
//   //     print("Error during login: $error");
//   //   }
//   // }
// }

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final storage = FlutterSecureStorage();

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> login() async {
    final email = emailController.text;
    final password = passwordController.text;
    await loginUser(email, password);
  }

  Future<void> loginUser(String email, String password) async {
    final url = Uri.parse(
        'https://neonlogicsihbackend-production.up.railway.app/api/v1/retailer/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      var token = data['data']['token'];
      print('$token');
      await storage.write(key: 'jwt_token', value: token);
      print('Logged in successfully and token stored.');
    } else {
      print('Failed to login: ${response.statusCode}');
    }
  }

  Future<void> fetchUserDetails() async {
    try {
      String? token = await storage.read(key: 'jwt_token');
      if (token == null) {
        print('No token found');
        return;
      }

      final url = Uri.parse(
          'https://neonlogicsihbackend-production.up.railway.app/api/v1/retailer/detail');
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('User details: $data');
      } else {
        print('Failed to fetch user details: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching user details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: login,
              child: Text('Login'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: fetchUserDetails,
              child: Text('Fetch User Details'),
            ),
          ],
        ),
      ),
    );
  }
}











// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// // import 'package:eosdart/eosdart.dart' as eos;

// import 'package:http/testing.dart';
// import 'package:jwt_authentication_test/homepage.dart';
// // import 'package:your_app/login_page.dart'; // Update with the actual path to your LoginPage

// void main() {
//   // Set up mock initial values for FlutterSecureStorage
//   setUpAll(() {
//     FlutterSecureStorage.setMockInitialValues({});
//   });

//   // Test case for login and fetch user details
//   testWidgets('Login and fetch user details', (WidgetTester tester) async {
//     // Build the LoginPage widget
//     await tester.pumpWidget(MaterialApp(home: Homepage()));

//     // Mock responses for HTTP requests
//     final mockHttpClient = MockClient((request) async {
//       if (request.url.toString() ==
//           'https://neonlogicsihbackend-production.up.railway.app/api/v1/retailer/login') {
//         return http.Response(
//             json.encode({
//               'data': {'token': 'mocked_token'}
//             }),
//             200);
//       } else if (request.url.toString() ==
//           'https://neonlogicsihbackend-production.up.railway.app/api/v1/retailer/detail') {
//         return http.Response(json.encode({'name': 'John Doe'}), 200);
//       } else {
//         return http.Response('Not Found', 404);
//       }
//     });

//     // Replace http with mockHttpClient
//     final oldHttp = http.Client();
//     http.Client = () => mockHttpClient;

//     // Enter email and password
//     await tester.enterText(find.byType(TextField).first, 'test@example.com');
//     await tester.enterText(find.byType(TextField).last, 'password123');

//     // Tap the login button
//     await tester.tap(find.byType(ElevatedButton).first);
//     await tester.pump();

//     // Verify if login was successful and token was stored
//     expect(
//         find.text('Logged in successfully and token stored.'), findsOneWidget);

//     // Tap the fetch user details button
//     await tester.tap(find.byType(ElevatedButton).last);
//     await tester.pump();

//     // Verify if user details were fetched
//     expect(find.text('User details: {name: John Doe}'), findsOneWidget);

//     // Clean up and reset
//     http.Client = oldHttp;
//   });
// }
