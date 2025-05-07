import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/welcome_page.dart';

void main() {
  runApp(EcoShopApp());
}

class EcoShopApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping Platform Demo',
      theme: ThemeData(primarySwatch: Colors.green),
      home: Welcome(),
    );
  }
}
