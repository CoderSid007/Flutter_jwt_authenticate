import 'package:flutter/material.dart';
import 'package:jwt_authentication_test/auth_service.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    AppBar(
      title: Text('Home Page'),
      foregroundColor: Colors.blue,
    );
    return Scaffold(
      body: Center(
        child: ElevatedButton(onPressed: () {}, child: Text('Tap me')),
      ),
    );
  }
}
