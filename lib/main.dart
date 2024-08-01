import 'package:flutter/material.dart';
import 'package:todo_app/ui/pages/login_page.dart';
import 'package:todo_app/ui/pages/pages.dart';
import 'package:todo_app/ui/pages/signup_page.dart';
import 'package:todo_app/ui/pages/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Color(0xFF615BE6), background: Colors.white),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
