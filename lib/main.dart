import 'package:flutter/material.dart';
import 'package:plaza_libre/Components/Auth/plazalibre.dart';
import 'package:plaza_libre/Components/shared/navBar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plaza Libre',
      home: PlazaLibreHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}