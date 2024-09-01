// import 'package:flutter_test/flutter_test.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
// import 'package:jwt_authentication_test/login.dart';
// import 'main.dart'; // Import your main app file

// void main() {
//   setUpAll(() {
//     // Set up mock values for FlutterSecureStorage
//     FlutterSecureStorage.setMockInitialValues({});
//   });

//   testWidgets('Login and fetch user details', (WidgetTester tester) async {
//     // Build your widget
//     await tester.pumpWidget(MaterialApp(home: LoginPage()));

//     // Enter email and password
//     await tester.enterText(find.byType(TextField).first, 'test@example.com');
//     await tester.enterText(find.byType(TextField).last, 'password123');

//     // Tap the login button
//     await tester.tap(find.byType(ElevatedButton).first);
//     await tester.pump();

//     // Verify if login was successful and token was stored
//     // You can also check if fetchUserDetails is working as expected

//     // Example: verify if login was successful
//     expect(
//         find.text('Logged in successfully and token stored.'), findsOneWidget);

//     // Further assertions and interactions
//   });
// }
