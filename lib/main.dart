import 'package:cars/login/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(CarsApp());
}

class CarsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Cars App",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: Colors.white,
      ),
      home: LoginPage(),
    );
  }
}
