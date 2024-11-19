import 'package:flutter/material.dart';
import 'package:lab9/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'models.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ProductProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product App',
      home: HomeScreen(),
    );
  }
}
