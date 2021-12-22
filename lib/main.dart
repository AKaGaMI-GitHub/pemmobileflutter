import 'package:flutter/material.dart';
import 'package:latihan/UI/homePage.dart';
import 'package:latihan/UI/loginPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project Pemograman Mobile',
      home: LoginPage(),
      //home: HomePage(),
    );
  }
}
