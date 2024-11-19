import 'package:flutter/material.dart';
import 'package:lab10/screens/home_screen.dart';
import 'block_provider.dart';
import 'product_bloc.dart';

// Основной виджет приложения
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: ProductBloc(),
      child: MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}
