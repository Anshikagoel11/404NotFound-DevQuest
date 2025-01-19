import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prana_app/screens/signup.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Removes the debug banner
      title: 'Signup App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignupScreen(), // Set your SignUpScreen as the home screen
    );
  }
}
