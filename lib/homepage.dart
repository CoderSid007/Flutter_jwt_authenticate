import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    AppBar(
      title: Text('Home Page'),
      foregroundColor: Colors.blue,
    );
    return Container(
      color: Colors.white,
    );
  }
}
