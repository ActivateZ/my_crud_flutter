import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/login.dart';
import 'package:flutter_application_1/pages/create.dart';
import 'package:flutter_application_1/pages/alluser.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: const LoginPage(),
      routes: {
        '/login':(context) => const LoginPage(),
        '/createpage':(context) => const CreatePage(),
        '/user':(context) => const AlluserPage()
      },
    );
  }
}